import re
import tkinter as tk
from tkinter import messagebox, filedialog, PanedWindow, BOTH, HORIZONTAL, ttk
from datetime import datetime
import locale
import os # Adicionado para manipulação de arquivos

# Tenta configurar o locale para português para o nome do mês, se necessário.
try:
    locale.setlocale(locale.LC_TIME, 'pt_BR.UTF-8')
except locale.Error:
    print("Locale pt_BR não disponível, usando o padrão do sistema.")

# --- INÍCIO: FUNÇÕES HELPER E MAPEAMENTOS PARA DELPHI ---

PYTHON_TO_DELPHI_TYPE = {
    'str': 'String',
    'int': 'Integer',
    'float': 'Currency',
    'datetime': 'TDateTime',
    'bool': 'Boolean'
}

def snake_to_pascal(snake_str):
    """Converte uma string snake_case (ex: a002_nome_fantasia) para PascalCase (ex: NomeFantasia)."""
    parts = snake_str.split('_')
    # Ignora o prefixo (ex: a002) e capitaliza o resto
    return ''.join(word.capitalize() for word in parts[1:])

def get_delphi_property_name_with_suffix(col_name, py_type):
    """Retorna o nome da propriedade Delphi com prefixo de tipo (ex: sNomeFantasia)."""
    base_name = snake_to_pascal(col_name)
    # Reutiliza a lógica existente para obter o prefixo do tipo ('s', 'i', 'c', 'd', 'b')
    prop_prefix, _ = get_delphi_property_info(py_type)
    # Adiciona o prefixo no início. O sufixo foi removido.
    return prop_prefix + base_name

def get_delphi_property_info(python_type):
    """Mapeia o tipo Python para um prefixo de propriedade Delphi e um método de conversão AsType."""
    if python_type == 'str':
        return 's', 'AsString'
    if python_type == 'int':
        return 'i', 'AsInteger'
    if python_type == 'float':
        return 'c', 'AsCurrency'
    if python_type == 'datetime':
        return 'd', 'AsDateTime'
    if python_type == 'bool':
        return 'b', 'AsBoolean'
    # Fallback
    return 's', 'AsString'

# --- FIM: FUNÇÕES HELPER E MAPEAMENTOS PARA DELPHI ---


# Mapa global para armazenar metadados SQL da última tabela parseada,
# utilizado para gerar atributos de validação nos modelos Delphi
ULTIMO_MAPA_SQL_META = {
    'tabela': None,
    'colunas': {}  # nome_coluna -> { base: str, length: int, precision: int }
}


def _normalize_base_sql_type(base: str) -> str:
    """Normaliza o tipo base SQL para os esperados pelo KValidadorBanco.
    Possíveis retornos: 'int', 'datetime', 'text', 'numeric', 'nvarchar'.
    """
    b = base.lower()
    if b in ('int', 'bigint', 'smallint', 'tinyint'):
        return 'int'
    if b in ('datetime', 'smalldatetime', 'datetime2', 'datetimeoffset', 'date', 'time', 'timestamp'):
        return 'datetime'
    if b in ('text', 'ntext'):
        return 'text'
    if b in ('numeric', 'decimal', 'money', 'smallmoney', 'float', 'real', 'double'):
        # Para tipos monetários, retorna 'money' em vez de 'numeric' para melhor compatibilidade
        if b in ('money', 'smallmoney'):
            return 'money'
        return 'numeric'
    # varchar, nvarchar, char, nchar, etc
    return 'nvarchar'


def _parse_sql_type_details(tipo_col: str):
    """Extrai (base_type_normalizado, length, precision) de um tipo SQL cru.
    Ex.: 'nvarchar(100)' -> ('nvarchar', 100, 0)
         'numeric(10,2)' -> ('numeric', 10, 2)
         'int' -> ('int', 0, 0)
         'varchar(max)' -> ('nvarchar', 0, 0)
         'money' -> ('money', 19, 4)
    """
    raw = tipo_col.strip()
    m = re.match(r'([a-zA-Z0-9_]+)', raw)
    base = m.group(1).lower() if m else raw.lower()
    length = 0
    precision = 0
    
    # Para tipos money, define valores padrão do SQL Server
    if base in ('money', 'smallmoney'):
        return 'money', 19, 4
    
    mpar = re.search(r'\(([^)]+)\)', raw)
    if mpar:
        inside = mpar.group(1).strip().lower()
        parts = [p.strip() for p in inside.split(',')]
        if len(parts) == 1:
            if parts[0] == 'max':
                length = 0  # 0 denota MAX para nossa geração
            else:
                try:
                    length = int(parts[0])
                except ValueError:
                    length = 0
        elif len(parts) >= 2:
            try:
                length = int(parts[0]) if parts[0] != 'max' else 0
            except ValueError:
                length = 0
            try:
                precision = int(parts[1])
            except ValueError:
                precision = 0
    
    base_norm = _normalize_base_sql_type(base)
    
    # Para tipos numeric/decimal, preserva a precisão original
    if base_norm == 'numeric':
        return base_norm, length, precision
    
    return base_norm, length, precision


def mapear_tipo(tipo_sql):
    tipo_sql = tipo_sql.lower().strip()

    # REGRA 1: Prioridade para tipos que devem ser FLOAT (Currency)
    # Ex: numeric(18, 4), decimal(10, 2), money
    if re.search(r'(numeric|decimal)\s*\(\s*\d+\s*,\s*[1-9]\d*\s*\)', tipo_sql):
        return 'float'
    if re.search(r'^(float|real|money|smallmoney|double)', tipo_sql):
        return 'float'

    # REGRA 2: Tipos que devem ser INT (Integer)
    # Ex: int, bigint, numeric(5, 0), numeric(10)
    if re.search(r'^(int|integer|bigint|smallint|tinyint)', tipo_sql):
        return 'int'
    if re.search(r'^(numeric|decimal)', tipo_sql):
        # Verifica se tem casas decimais
        match = re.search(r'\(\s*(\d+)\s*,\s*(\d+)\s*\)', tipo_sql)
        if match:
            precision = int(match.group(2))
            if precision == 0:
                return 'int'
            else:
                return 'float'
        return 'int' # Qualquer outro numeric/decimal sem casas decimais vira int

    # REGRA 3: Outros tipos
    mapeamento = {
        r'^(char|varchar|nchar|nvarchar|text|ntext|string)': 'str',
        r'^(bit|bool|boolean)': 'bool',
        r'^(date|time|datetime|timestamp|datetime2|smalldatetime)': 'datetime',
    }
    for padrao, tipo_py in mapeamento.items():
        if re.search(padrao, tipo_sql):
            return tipo_py

    return 'Any' # Fallback


def gerar_classe(sql):
    match_create = re.search(r'CREATE\s+TABLE\s+([\[\]\w\.]+)\s*\(', sql, re.IGNORECASE)
    if not match_create:
        return None, None, [], None, []

    nome_tabela_full = match_create.group(1).replace('[','').replace(']','')
    nome_tabela = nome_tabela_full.split('.')[-1]
    class_name = nome_tabela
    start = match_create.end() - 1
    count = 1
    end = -1
    for i, c in enumerate(sql[start+1:], start=start+1):
        if c == '(': count += 1
        elif c == ')': count -= 1
        if count == 0:
            end = i
            break

    if end == -1: return None, None, [], None, []

    colunas_raw = sql[start+1:end]

    # --- LÓGICA DE FOREIGN KEY CORRIGIDA ---
    foreign_keys = []

    # 1. Padrão para FKs DENTRO do CREATE TABLE
    fk_pattern_inline = r'FOREIGN\s+KEY\s*\(\s*\[?(\w+)\]?\s*\)\s*REFERENCES\s*\[?\w+\]?\.\[?(\w+)\]?'
    fk_matches_inline = re.findall(fk_pattern_inline, colunas_raw, re.IGNORECASE)
    for match in fk_matches_inline:
        foreign_keys.append({
            'coluna_local': match[0],
            'tabela_ref': match[1]
        })

    # 2. Novo padrão para FKs em ALTER TABLE (no script INTEIRO)
    fk_pattern_alter = r'ALTER\s+TABLE\s+.*?FOREIGN\s+KEY\s*\(\s*\[?(\w+)\]?\s*\)\s*REFERENCES\s+\[?[\w\.]+\]?\.\[?(\w+)\]?'
    fk_matches_alter = re.findall(fk_pattern_alter, sql, re.IGNORECASE | re.DOTALL)
    for match in fk_matches_alter:
        foreign_keys.append({
            'coluna_local': match[0],
            'tabela_ref': match[1]
        })

    # --- EXTRAÇÃO CORRETA DAS COLUNAS MANTENDO ORDEM ORIGINAL ---
    linhas = [l.strip() for l in colunas_raw.split('\n') if l.strip() and not l.strip().startswith('--')]
    
    colunas_ordem_original = []  # Lista para manter a ordem EXATA
    colunas_sql_meta = {}

    chave_primaria_nome = None
    
    # Primeiro, procura pela chave primária
    pk_match = re.search(r'PRIMARY\s+KEY\s*[\w\s]*\(([^)]+)\)', colunas_raw, re.IGNORECASE)
    if pk_match:
        nome_pk_bruto = pk_match.group(1).strip()
        chave_primaria_nome = re.match(r'\[?([\w_]+)\]?', nome_pk_bruto).group(1)

    # Processa cada linha mantendo a ordem EXATA
    for linha in linhas:
        linha_limpa = linha.rstrip(',')
        
        # Pula linhas que não são definições de coluna
        if linha_limpa.upper().startswith(('CONSTRAINT', 'PRIMARY', 'UNIQUE', 'KEY', ')', 'FOREIGN')):
            continue
            
        # Verifica se é uma linha de chave primária inline
        if not chave_primaria_nome and 'PRIMARY KEY' in linha_limpa.upper():
            pk_col_match = re.match(r'\[?([\w_]+)\]?', linha_limpa)
            if pk_col_match:
                chave_primaria_nome = pk_col_match.group(1)
            continue

        # Padrão para extrair nome da coluna e tipo
        # Suporta: [nome_coluna] tipo(parâmetros) ou nome_coluna tipo(parâmetros)
        m = re.match(r'\[?([\w_]+)\]?\s+\[?([a-zA-Z0-9_]+)\]?\s*(\(([^)]+)\))?', linha_limpa)
        if m:
            nome_col = m.group(1)
            tipo_base = m.group(2)
            params_full = m.group(3) or ''
            tipo_col_reconstruido = f"{tipo_base}{params_full}".strip()
            
            # Mapeia o tipo SQL para Python
            tipo_py = mapear_tipo(tipo_col_reconstruido)
            
            # Adiciona à lista mantendo a ordem EXATA
            colunas_ordem_original.append((nome_col, tipo_py))
            
            # Extrai metadados SQL para validações
            base_norm, length, precision = _parse_sql_type_details(tipo_col_reconstruido)
            colunas_sql_meta[nome_col] = { 'base': base_norm, 'length': length, 'precision': precision }

    # Remove duplicatas mantendo a ordem original
    colunas = []
    nomes_vistos = set()
    chave_primaria = None

    for col in colunas_ordem_original:
        nome_coluna, tipo_py = col
        if nome_coluna not in nomes_vistos:
            colunas.append(col)
            nomes_vistos.add(nome_coluna)
            if nome_coluna == chave_primaria_nome:
                chave_primaria = col

    if not colunas:
        return nome_tabela, None, [], None, []

    # Gera código Python (mantido para compatibilidade)
    parametros = ', '.join(f'{c[0]}: {c[1]}' for c in colunas)
    inits = '\n        '.join(f'self.{c[0]} = {c[0]}' for c in colunas)

    imports = ['from datetime import datetime']
    if any(c[1] == 'Any' for c in colunas): imports.append('from typing import Any')

    global ULTIMO_MAPA_SQL_META
    ULTIMO_MAPA_SQL_META = { 'tabela': nome_tabela, 'colunas': colunas_sql_meta }

    classe_code = '\n'.join(imports) + f'''\n\nclass {class_name}:
    def __init__(self, {parametros}):
        {inits}
'''
    return class_name, classe_code, colunas, chave_primaria, foreign_keys

def gerar_dao(class_name, nome_tabela, colunas, chave_primaria):
    dao_nome = class_name + 'DAO'
    pk_nome = chave_primaria[0]
    pk_tipo = chave_primaria[1]

    nomes_colunas = [col[0] for col in colunas]
    colunas_sql = ', '.join(nomes_colunas)
    placeholders_sql = ', '.join(['?'] * len(colunas))
    params_insert_str = '\n                '.join(f'modelo.{nome},' for nome in nomes_colunas)
    colunas_para_update = [nome for nome in nomes_colunas if nome != pk_nome]
    colunas_update_sql = ', '.join(f"{col} = ?" for col in colunas_para_update)
    params_update_list = [f'modelo.{nome}' for nome in colunas_para_update]
    params_update_list.append(f'modelo.{pk_nome}')
    params_update_str = ',\n                '.join(params_update_list)
    row_to_object_params = '\n            '.join(f'{col[0]}=row[{i}],' for i, col in enumerate(colunas))

    dao_codigo = f'''from typing import List, Any, Union
import logging
from {class_name.lower()} import {class_name}

class {dao_nome}:
    def __init__(self, conexao):
        self.conexao = conexao
        self.tabela = "{nome_tabela}"
        self.chave_primaria = "{pk_nome}"
        self.logger = logging.getLogger(__name__)

    def _row_to_object(self, row: tuple) -> '{class_name}':
        return {class_name}(
            {row_to_object_params}
        )

    def insert(self, modelo: '{class_name}') -> '{class_name}':
        try:
            cursor = self.conexao.cursor()
            sql = f"""INSERT INTO {{self.tabela}} ({colunas_sql})
                      VALUES ({placeholders_sql})"""
            params = ({params_insert_str})
            cursor.execute(sql, params)
            self.conexao.commit()
            self.logger.info(f"Registro inserido com sucesso em {{self.tabela}}.")
            return modelo
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao inserir em {{self.tabela}}: {{e}}")
            raise Exception(f"Erro ao inserir em {{self.tabela}}: {{e}}")

    def update(self, modelo: '{class_name}') -> '{class_name}':
        try:
            cursor = self.conexao.cursor()
            sql = f"""UPDATE {{self.tabela}} SET {colunas_update_sql}
                      WHERE {{self.chave_primaria}} = ?"""
            params = ({params_update_str})
            cursor.execute(sql, params)
            self.conexao.commit()
            self.logger.info(f"Registro atualizado com sucesso em {{self.tabela}}.")
            return modelo
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao atualizar em {{self.tabela}}: {{e}}")
            raise Exception(f"Erro ao atualizar em {{self.tabela}}: {{e}}")

    def delete(self, id: {pk_tipo}) -> None:
        try:
            cursor = self.conexao.cursor()
            sql = f"DELETE FROM {{self.tabela}} WHERE {{self.chave_primaria}} = ?"
            cursor.execute(sql, (id,))
            self.conexao.commit()
            self.logger.info(f"Registro deletado com sucesso de {{self.tabela}}, ID: {{id}}")
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao deletar em {{self.tabela}}: {{e}}")
            raise Exception(f"Erro ao deletar em {{self.tabela}}: {{e}}")

    def get_by_id(self, id: {pk_tipo}) -> Union['{class_name}', None]:
        try:
            cursor = self.conexao.cursor()
            sql = f"SELECT * FROM {{self.tabela}} WHERE {{self.chave_primaria}} = ?"
            cursor.execute(sql, (id,))
            row = cursor.fetchone()
            return self._row_to_object(row) if row else None
        except Exception as e:
            self.logger.error(f"Erro ao buscar por ID em {{self.tabela}}: {{e}}")
            raise Exception(f"Erro ao buscar por ID em {{self.tabela}}: {{e}}")

    def list_all(self) -> List['{class_name}']:
        try:
            cursor = self.conexao.cursor()
            sql = f"SELECT * FROM {{self.tabela}}"
            cursor.execute(sql)
            rows = cursor.fetchall()
            return [self._row_to_object(row) for row in rows]
        except Exception as e:
            self.logger.error(f"Erro ao listar todos de {{self.tabela}}: {{e}}")
            raise Exception(f"Erro ao listar todos de {{self.tabela}}: {{e}}")
'''
    return dao_codigo

# --- INÍCIO: FUNÇÕES DE GERAÇÃO PARA DELPHI ---

def gerar_modelo_delphi(class_name, colunas, chave_primaria, foreign_keys):
    """Gera a unit do modelo de dados em Delphi (ex: untFilial.pas) seguindo o estilo do projeto e compatível com Delphi 10.13."""
    delphi_model_name = ''.join(word.capitalize() for word in class_name.split('_')[1:])
    if not delphi_model_name:
        delphi_model_name = class_name.capitalize()

    delphi_class_type = f"T{delphi_model_name}"

    # --- PREPARAÇÃO DAS LISTAS ---
    private_fields = []
    public_properties_temp = []
    forward_declarations = []
    fk_units_impl = set()
    private_fk_get_set = []
    implementation_fk_methods = []
    destructor_lines = []

    # --- PROCESSA COLUNAS NORMAIS ---
    chave_primaria_nome = chave_primaria[0] if chave_primaria else None
    seq_col_name = next((col[0] for col in colunas if 'sequencial' in col[0].lower()), None)
    colunas_para_modelo = [c for c in colunas if c[0] not in [chave_primaria_nome, seq_col_name]]
    
    # Mantém a ordem EXATA das colunas conforme aparecem no SQL
    colunas_para_modelo_original = colunas_para_modelo

    nome_tabela_sql = ULTIMO_MAPA_SQL_META.get('tabela', class_name)
    meta_por_coluna = ULTIMO_MAPA_SQL_META.get('colunas', {})

    # Set para evitar duplicações
    campos_processados = set()

    for col_name, py_type in colunas_para_modelo_original:
        if col_name in campos_processados:
            continue
        campos_processados.add(col_name)
        
        prop_prefix, _ = get_delphi_property_info(py_type)
        prop_name = prop_prefix + snake_to_pascal(col_name)
        field_name = "_" + prop_name
        delphi_type = PYTHON_TO_DELPHI_TYPE.get(py_type, 'String')

        private_fields.append(f"{field_name}: {delphi_type};")

        meta = meta_por_coluna.get(col_name, {'base': 'nvarchar', 'length': 0, 'precision': 0})
        atributos = []
        
        # Adiciona validação de tamanho para campos string
        if py_type == 'str':
            max_len = meta.get('length', -1)
            if max_len == 0: max_len = -1
            atributos.append(f"KValidadorTamanho(-1, {max_len})")
        
        # Adiciona validação de banco com tipo correto
        atributos.append(f"KValidadorBanco('{nome_tabela_sql}', '{col_name}', '{meta.get('base', 'nvarchar')}', {meta.get('length', 0)}, {meta.get('precision', 0)})")
        
        atributos_str = '[' + ', '.join(atributos) + ']'
        prop_text = f"{atributos_str}\n\t\t\tproperty {prop_name}: {delphi_type} read {field_name} write {field_name};"
        public_properties_temp.append((col_name, prop_text))  # Usa col_name como chave para manter ordem

    # --- PROCESSA CHAVES ESTRANGEIRAS (FK) ---
    fks_processadas = set()
    for fk in foreign_keys:
        local_col = fk['coluna_local']
        ref_table = fk['tabela_ref']
        
        if local_col in fks_processadas:
            continue
        fks_processadas.add(local_col)

        pascal_case_name = snake_to_pascal(local_col)
        obj_prop_name = "o" + pascal_case_name
        method_prop_name = "O" + pascal_case_name
        obj_field_name = "_" + obj_prop_name
        # Corrige o nome da tabela referenciada para o formato correto
        ref_model_name = snake_to_pascal(ref_table)
        ref_class_type = "T" + ref_model_name
        ref_unit_name = "unt" + ref_model_name
        ref_dao_name = ref_model_name + "DAO"

        fk_units_impl.add(ref_unit_name)
        fk_units_impl.add(f"unt{ref_dao_name}")
        forward_declarations.append(f"  {ref_class_type} = class;")

        private_fields.append(f"{obj_field_name}: {ref_class_type};")

        private_fk_get_set.append(f"function get{method_prop_name}: {ref_class_type};")
        private_fk_get_set.append(f"procedure set{method_prop_name}(obj: {ref_class_type});")

        prop_text = f"property {obj_prop_name}: {ref_class_type} read get{method_prop_name} write set{method_prop_name};"
        public_properties_temp.append((obj_prop_name, prop_text))

        fk_id_prop_name = get_delphi_property_name_with_suffix(local_col, 'str')

        destructor_lines.append(f"if {obj_field_name} <> nil then\n\t\t{obj_field_name}.Free;")

        getter_code = f"""function {delphi_class_type}.get{method_prop_name}: {ref_class_type};
var
	dao: {ref_dao_name};
begin
	if (((_o{pascal_case_name} = nil) AND ({fk_id_prop_name} <> '')) OR ((_o{pascal_case_name} <> nil) AND (_o{pascal_case_name}.sCodigo <> {fk_id_prop_name}))) then
	begin
		if _o{pascal_case_name} <> nil then
			_o{pascal_case_name}.Free;
		dao := nil;
		try
			dao := {ref_dao_name}.Create(sEmpresaLogada, sFilialLogada);
			_o{pascal_case_name} := dao.SelecionaCodigo({fk_id_prop_name});
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _o{pascal_case_name};
end;"""

        setter_code = f"""procedure {delphi_class_type}.set{method_prop_name}(obj: {ref_class_type});
begin
	if _o{pascal_case_name} <> nil then
		_o{pascal_case_name}.Free;
	_o{pascal_case_name} := obj;
end;"""
        implementation_fk_methods.append(getter_code)
        implementation_fk_methods.append(setter_code)

    # --- MONTAGEM FINAL DO CÓDIGO ---
    forward_declarations_str = '\n'.join(forward_declarations)
    private_fields_str = '\n\t\t\t'.join(private_fields)
    get_set_str = '\n\t\t\t'.join(private_fk_get_set)
    
    # Mantém a ordem EXATA das propriedades conforme aparecem no SQL
    # Ordena por col_name (ordem original) e depois extrai o texto da propriedade
    public_properties_temp.sort(key=lambda x: x[0])  # Ordena por col_name (ordem original)
    public_properties_str = '\n\t\t\t'.join([prop[1] for prop in public_properties_temp])

    destructor_str = '\n\t'.join(destructor_lines)
    implementation_header = f"//\n// IMPLEMENTAÇÃO DE {delphi_model_name} [dbo].[{nome_tabela_sql.lower()}]\n//"
    fk_methods_str = '\n\n'.join(implementation_fk_methods)

    uses_clause_interface = "SysUtils, Classes, untKValidador, untModelos"

    fk_units_impl.add(f"unt{delphi_model_name}DAO")
    uses_clause_implementation = ', '.join(fk_units_impl)

    modelo_delphi_code = f"""unit unt{delphi_model_name};

interface

uses
  {uses_clause_interface};

type
{forward_declarations_str}

  {delphi_class_type} = class(TModeloBase)
	private
		{private_fields_str}

		{get_set_str}
	public
		destructor Destroy; override;

		{public_properties_str}
	end;

implementation

uses {uses_clause_implementation};

{implementation_header}

{fk_methods_str}

destructor {delphi_class_type}.Destroy;
begin
	{destructor_str}
	inherited;
end;

end."""
    return modelo_delphi_code, delphi_model_name

def gerar_dao_delphi(class_name, nome_tabela, colunas, chave_primaria):
    """Gera a unit do DAO em Delphi (ex: untFilialDAO.pas) compatível com Delphi 10.13."""
    delphi_model_name = ''.join(word.capitalize() for word in class_name.split('_')[1:])
    if not delphi_model_name:
        delphi_model_name = class_name.capitalize()

    delphi_dao_name = f"{delphi_model_name}DAO"
    delphi_model_type = f"T{delphi_model_name}"

    # Mantém a ordem EXATA das colunas conforme aparecem no SQL
    colunas_original_order = [c for c in colunas]
    pk_col_name = chave_primaria[0]

    # --- FUNÇÃO AUXILIAR PARA FORMATAR O SQL COMO O EXEMPLO LEGADO ---
    def formatar_delphi_sql_const(items, items_per_line=4):
        """Formata uma lista de itens (colunas, params) no estilo 'item', + 'item2'"""
        if not items:
            return "''"
        
        lines = []
        # Agrupa os itens em "chunks" (pedaços) para cada linha
        for i in range(0, len(items), items_per_line):
            chunk = items[i:i + items_per_line]
            # Formata a linha: ' [item1], [item2], [item3], [item4], '
            line_content = ', '.join(chunk)
            lines.append(f"' {line_content}, '")

        # Junta as linhas com ' +' e remove a vírgula e o espaço extra da última linha
        full_string = ' + \n\t\t\t\t'.join(lines)
        
        # Encontra a última vírgula para substituí-la
        last_comma_pos = full_string.rfind(',')
        if last_comma_pos != -1:
            full_string = full_string[:last_comma_pos] + ' ' + full_string[last_comma_pos+1:]

        return full_string

    # --- INÍCIO DA GERAÇÃO DE SQL (LÓGICA CORRIGIDA) ---
    colunas_para_insert = colunas_original_order
    colunas_para_update = [c for c in colunas_original_order if c[0] != pk_col_name]

    # Geração do SQL de INSERT
    insert_cols_list = [f"[{c[0]}]" for c in colunas_para_insert]
    insert_params_list = [f":{c[0]}" for c in colunas_para_insert]
    
    sql_insert_cols_formatted = formatar_delphi_sql_const(insert_cols_list, 4)
    sql_insert_params_formatted = formatar_delphi_sql_const(insert_params_list, 4)

    sql_insert = (f"'INSERT INTO [dbo].[{nome_tabela}](' + \n\t\t\t\t"
                  f"{sql_insert_cols_formatted} + \n\t\t\t\t"
                  f"') VALUES( ' + \n\t\t\t\t"
                  f"{sql_insert_params_formatted} + \n\t\t\t\t"
                  f"')'")

    # Geração do SQL de UPDATE
    update_setters_list = [f"[{c[0]}] = :{c[0]}" for c in colunas_para_update]
    sql_update_setters_formatted = formatar_delphi_sql_const(update_setters_list, 1)

    sql_update = (f"'UPDATE [dbo].[{nome_tabela}] SET ' + \n\t\t\t\t"
                  f"{sql_update_setters_formatted} + \n\t\t\t\t"
                  f"'WHERE [{pk_col_name}] = :{pk_col_name} '")

    # --- Geração dos blocos de código para os métodos ---
    obj_para_query_lines = []
    for col_name, py_type in colunas_para_update: # Itera sobre colunas normais (sem PK)
        prop_prefix, _ = get_delphi_property_info(py_type)
        prop_name = prop_prefix + snake_to_pascal(col_name)
        line = f"oQuery.Parameters.ParamByName('{col_name}').Value := oObjeto.{prop_name};"
        obj_para_query_lines.append(line)

    sub_linha_para_obj_lines = []
    for col_name, py_type in colunas_original_order:
        prop_prefix, as_type = get_delphi_property_info(py_type)
        prop_name = prop_prefix + snake_to_pascal(col_name)
        # Adiciona tratamento para AsLargeInt em campos 'sequencial'
        if 'sequencial' in col_name.lower() and as_type == 'AsInteger':
            as_type = 'AsLargeInt'
        line = f"oObjeto.{prop_name} := oFields.FieldByName('{col_name}').{as_type};"
        sub_linha_para_obj_lines.append(line)

    now = datetime.now()
    data_geracao = now.strftime('%d/%m/%Y %H:%M:%S')

    pk_prop_prefix, _ = get_delphi_property_info(chave_primaria[1])
    pk_prop_name = pk_prop_prefix + snake_to_pascal(pk_col_name)
    bsetarcodseq_block = f"oQuery.Parameters.ParamByName('{pk_col_name}').Value := oObjeto.{pk_prop_name};"

    seq_col = next((c for c in colunas if 'sequencial' in c[0].lower()), None)
    if seq_col:
        seq_col_name, seq_py_type = seq_col
        seq_prop_prefix, _ = get_delphi_property_info(seq_py_type)
        seq_prop_name = seq_prop_prefix + snake_to_pascal(seq_col_name)
        bsetarcodseq_block += f"\n\t\t\toQuery.Parameters.ParamByName('{seq_col_name}').Value := oObjeto.{seq_prop_name};"

    obj_para_query_str = '\n\t'.join(obj_para_query_lines)
    sub_linha_para_obj_str = '\n\t\t'.join(sub_linha_para_obj_lines)

    delphi_dao_code = f"""{{----------------------------------------------------}}
{{ File      : unt{delphi_model_name}DAO.pas          }}
{{ Generated : {data_geracao}                    }}
{{ User      : GeradorAutomatico                      }}
{{----------------------------------------------------}}

unit unt{delphi_model_name}DAO;

interface

uses untKhnumQuery, DB, ADODB, untBaseDAO, untModelos, unt{delphi_model_name};

type
	TClass{delphi_model_name}DAO = BaseDAO<{delphi_model_type}>;

	{delphi_dao_name} = class(TClass{delphi_model_name}DAO)
	public
		constructor Create(_sEmpresa, _sFilial: String); override;
		function getInsertSql: String; override;
		function getUpdateSql: String; override;
		procedure ObjetoParaQuery(oObjeto: {delphi_model_type}; oQuery: TADOQuery;
				bSetarCodSeq: Boolean = true); override;
	protected
		function SubLinhaParaObjeto(oFields: TFields): {delphi_model_type}; override;
	end;

implementation

uses SysUtils;

constructor {delphi_dao_name}.Create(_sEmpresa, _sFilial: String);
begin
	inherited createDao('{nome_tabela}', _sEmpresa, _sFilial, false);
end;

function {delphi_dao_name}.getInsertSql;
const
	SQL_INSERIR: String =
			{sql_insert};
begin
	Result := SQL_INSERIR;
end;

function {delphi_dao_name}.getUpdateSql;
const
	SQL_ATUALIZAR: String =
			{sql_update};
begin
	Result := SQL_ATUALIZAR;
end;

procedure {delphi_dao_name}.ObjetoParaQuery;
begin
	{obj_para_query_str}

	if bSetarCodSeq then
	begin
		{bsetarcodseq_block}
	end;
end;

function {delphi_dao_name}.SubLinhaParaObjeto;
var
	oObjeto: {delphi_model_type};
begin
	oObjeto := nil;
	try
		oObjeto := {delphi_model_type}.Create();
		{sub_linha_para_obj_str}
		Result := oObjeto;
	except
		if oObjeto <> nil then
			oObjeto.free;
		raise;
	end;
end;

end."""
    return delphi_dao_code, delphi_model_name

# --- FIM: FUNÇÕES DE GERAÇÃO PARA DELPHI ---

def gerar_controller(class_name, colunas):
    nomes_colunas = [col[0] for col in colunas]
    campos_str = ', '.join(f'"{c}"' for c in nomes_colunas)
    return f'''class {class_name}Controller:
    CAMPOS_PERMITIDOS = {{{campos_str}}}

    @staticmethod
    def validar_campos(data: dict):
        extras = set(data.keys()) - {class_name}Controller.CAMPOS_PERMITIDOS
        if extras:
            raise ValueError(f"Campos extras não permitidos: {{extras}}")
        return True
'''

def processar_sql():
    sql = entrada_sql.get("1.0", tk.END)
    if not sql.strip():
        messagebox.showwarning("Entrada vazia", "Por favor, insira um comando SQL ou selecione um arquivo.")
        return

    match = re.search(r'CREATE\s+TABLE', sql, re.IGNORECASE)
    if match:
        inicio = match.start()
        sql_create = sql[inicio:]

        class_name, classe_code, colunas, chave_primaria, foreign_keys = gerar_classe(sql_create)

        if not classe_code:
            messagebox.showerror("Erro ao gerar classe", "Não foi possível extrair nome da tabela e colunas.")
            return

        if not chave_primaria:
            messagebox.showerror("Erro Crítico", "Não foi possível identificar a Chave Primária da tabela. O DAO não pode ser gerado sem ela.")
            return

        # Gera APENAS os códigos Delphi
        dao_code_delphi, delphi_name = gerar_dao_delphi(class_name, class_name, colunas, chave_primaria)
        modelo_code_delphi, _ = gerar_modelo_delphi(class_name, colunas, chave_primaria, foreign_keys)

        # Mostra apenas os resultados Delphi
        mostrar_resultados_delphi(modelo_code_delphi, dao_code_delphi, delphi_name)
    else:
        messagebox.showwarning("Comando inválido", "Comando CREATE TABLE não encontrado.")

def mostrar_resultados_delphi(modelo_delphi_code, dao_delphi_code, base_name_delphi):
    janela_resultados = tk.Toplevel(janela)
    janela_resultados.title("Códigos Delphi Gerados")
    janela_resultados.geometry("1200x800")

    notebook = ttk.Notebook(janela_resultados)
    notebook.pack(pady=10, padx=10, fill="both", expand=True)

    def criar_aba(parent, titulo, conteudo, nome_arquivo_sugerido, extensao):
        frame = ttk.Frame(parent, width=400, height=280)
        parent.add(frame, text=titulo)

        text_widget = tk.Text(frame, wrap=tk.WORD, font=("Courier New", 10))
        text_widget.pack(pady=5, padx=5, fill=BOTH, expand=1)
        text_widget.insert(tk.END, conteudo)

        btn_salvar = tk.Button(frame, text=f"Salvar {titulo}", command=lambda: salvar_arquivo(conteudo, nome_arquivo_sugerido + extensao, extensao))
        btn_salvar.pack(pady=5)

    # Criar apenas as abas Delphi
    criar_aba(notebook, "Modelo Delphi", modelo_delphi_code, f"unt{base_name_delphi}", ".pas")
    criar_aba(notebook, "DAO Delphi", dao_delphi_code, f"unt{base_name_delphi}DAO", ".pas")


def salvar_arquivo(conteudo, nome_sugerido, extensao):
    file_types = [("Todos os Arquivos", "*.*")]
    if extensao == ".py":
        file_types.insert(0, ("Python Files", "*.py"))
    elif extensao == ".pas":
        file_types.insert(0, ("Pascal Files", "*.pas"))

    caminho = filedialog.asksaveasfilename(
        defaultextension=extensao,
        initialfile=nome_sugerido,
        filetypes=file_types,
        title="Salvar arquivo como..."
    )
    if caminho:
        try:
            with open(caminho, 'w', encoding='utf-8') as f:
                f.write(conteudo)
            messagebox.showinfo("Salvo", f"Arquivo salvo com sucesso em: {caminho}")
        except Exception as e:
            messagebox.showerror("Erro ao Salvar", f"Não foi possível salvar o arquivo.\nErro: {e}")

def selecionar_arquivo():
    caminho_arquivo = filedialog.askopenfilename(
        title="Selecione um arquivo SQL",
        filetypes=[("Arquivos SQL", "*.sql"), ("Todos os arquivos", "*.*")]
    )
    if caminho_arquivo:
        try:
            with open(caminho_arquivo, 'r', encoding='utf-8') as f:
                conteudo = f.read()
            entrada_sql.delete("1.0", tk.END)
            entrada_sql.insert(tk.END, conteudo)
        except Exception as e:
            messagebox.showerror("Erro ao Ler Arquivo", f"Não foi possível ler o arquivo.\nVerifique a codificação (deve ser UTF-8).\nErro: {e}")

def selecionar_arquivos():
    """Seleciona múltiplos arquivos SQL para processamento em lote."""
    caminhos_arquivos = filedialog.askopenfilenames(
        title="Selecione arquivos SQL para processar",
        filetypes=[("Arquivos SQL", "*.sql"), ("Todos os arquivos", "*.*")]
    )
    if caminhos_arquivos:
        # Limpa a entrada atual
        entrada_sql.delete("1.0", tk.END)
        
        # Mostra os arquivos selecionados
        arquivos_info = f"Arquivos selecionados ({len(caminhos_arquivos)}):\n"
        arquivos_info += "\n".join([f"• {os.path.basename(f)}" for f in caminhos_arquivos])
        arquivos_info += "\n\nClique em 'Processar Todos' para gerar os códigos."
        
        entrada_sql.insert(tk.END, arquivos_info)
        
        # Armazena os caminhos dos arquivos para processamento posterior
        global ARQUIVOS_SELECIONADOS
        ARQUIVOS_SELECIONADOS = list(caminhos_arquivos)
        
        # Habilita o botão de processamento em lote
        botao_processar_todos.config(state=tk.NORMAL)
        botao_processar_todos.pack(pady=5)

def analisar_dependencias_tabelas(arquivos_sql):
    """
    Analisa as dependências entre tabelas baseado nas chaves estrangeiras
    e retorna uma lista ordenada por dependência.
    
    Retorna: [(arquivo, dependencias), ...] ordenado por dependência
    """
    tabelas_info = []
    
    # Primeira passada: extrair informações básicas de cada tabela
    for arquivo in arquivos_sql:
        try:
            with open(arquivo, 'r', encoding='utf-8') as f:
                sql = f.read()
            
            # Extrai nome da tabela
            match_create = re.search(r'CREATE\s+TABLE\s+([\[\]\w\.]+)\s*\(', sql, re.IGNORECASE)
            if not match_create:
                continue
                
            nome_tabela_full = match_create.group(1).replace('[','').replace(']','')
            nome_tabela = nome_tabela_full.split('.')[-1]
            
            # Extrai chaves estrangeiras
            foreign_keys = []
            
            # FKs dentro do CREATE TABLE
            fk_pattern_inline = r'FOREIGN\s+KEY\s*\(\s*\[?(\w+)\]?\s*\)\s*REFERENCES\s*\[?\w+\]?\.\[?(\w+)\]?'
            fk_matches_inline = re.findall(fk_pattern_inline, sql, re.IGNORECASE)
            for match in fk_matches_inline:
                foreign_keys.append(match[1])  # nome da tabela referenciada
            
            # FKs em ALTER TABLE
            fk_pattern_alter = r'ALTER\s+TABLE\s+.*?FOREIGN\s+KEY\s*\(\s*\[?(\w+)\]?\s*\)\s*REFERENCES\s+\[?[\w\.]+\]?\.\[?(\w+)\]?'
            fk_matches_alter = re.findall(fk_pattern_alter, sql, re.IGNORECASE | re.DOTALL)
            for match in fk_matches_alter:
                foreign_keys.append(match[1])  # nome da tabela referenciada
            
            tabelas_info.append({
                'arquivo': arquivo,
                'nome_tabela': nome_tabela,
                'dependencias': foreign_keys,
                'nome_base': nome_tabela.split('_')[0] if '_' in nome_tabela else nome_tabela
            })
            
        except Exception as e:
            print(f"Erro ao analisar {arquivo}: {e}")
            continue
    
    # Segunda passada: ordenar por dependência usando ordenação topológica
    def ordenar_por_dependencia(tabelas):
        """Ordena tabelas por dependência usando ordenação topológica."""
        # Cria um grafo de dependências
        grafo = {}
        grau_entrada = {}
        
        for tabela in tabelas:
            nome = tabela['nome_tabela']
            grafo[nome] = []
            grau_entrada[nome] = 0
        
        # Constrói o grafo
        for tabela in tabelas:
            nome = tabela['nome_tabela']
            for dep in tabela['dependencias']:
                if dep in grafo:
                    grafo[dep].append(nome)
                    grau_entrada[nome] += 1
        
        # Ordenação topológica
        resultado = []
        fila = [t for t in tabelas if grau_entrada[t['nome_tabela']] == 0]
        
        while fila:
            # Ordena por nome base (a006, a043, etc.) para estabilidade
            fila.sort(key=lambda x: x['nome_base'])
            
            atual = fila.pop(0)
            resultado.append(atual)
            
            for vizinho in grafo[atual['nome_tabela']]:
                grau_entrada[vizinho] -= 1
                if grau_entrada[vizinho] == 0:
                    # Encontra a tabela correspondente
                    for t in tabelas:
                        if t['nome_tabela'] == vizinho:
                            fila.append(t)
                            break
        
        # Adiciona tabelas restantes (se houver ciclos)
        for tabela in tabelas:
            if tabela not in resultado:
                resultado.append(tabela)
        
        return resultado
    
    # Ordena por dependência
    tabelas_ordenadas = ordenar_por_dependencia(tabelas_info)
    
    # Retorna lista ordenada de arquivos
    return [t['arquivo'] for t in tabelas_ordenadas]

def processar_todos_arquivos():
    """Processa todos os arquivos SQL selecionados e gera APENAS os códigos Delphi."""
    if not ARQUIVOS_SELECIONADOS:
        messagebox.showwarning("Nenhum arquivo", "Nenhum arquivo foi selecionado.")
        return
    
    # Cria pasta de saída
    pasta_saida = "saida"
    if not os.path.exists(pasta_saida):
        os.makedirs(pasta_saida)
    
    # Analisa dependências e ordena as tabelas
    arquivos_ordenados = analisar_dependencias_tabelas(ARQUIVOS_SELECIONADOS)
    
    # Mostra a ordem de processamento
    ordem_info = "Ordem de processamento (por dependência):\n"
    for i, arquivo in enumerate(arquivos_ordenados, 1):
        nome_tabela = os.path.splitext(os.path.basename(arquivo))[0]
        ordem_info += f"{i}. {nome_tabela}\n"
    
    messagebox.showinfo("Ordem de Processamento", ordem_info)
    
    resultados = []
    erros = []
    
    # Barra de progresso
    janela_progresso = tk.Toplevel(janela)
    janela_progresso.title("Processando arquivos...")
    janela_progresso.geometry("400x150")
    janela_progresso.transient(janela)
    janela_progresso.grab_set()
    
    label_progresso = tk.Label(janela_progresso, text="Processando arquivos...")
    label_progresso.pack(pady=10)
    
    progresso = ttk.Progressbar(janela_progresso, length=300, mode='determinate')
    progresso.pack(pady=10)
    
    progresso['maximum'] = len(arquivos_ordenados)
    
    for i, arquivo in enumerate(arquivos_ordenados):
        try:
            label_progresso.config(text=f"Processando: {os.path.basename(arquivo)}")
            janela_progresso.update()
            
            # Lê o arquivo SQL
            with open(arquivo, 'r', encoding='utf-8') as f:
                sql = f.read()
            
            # Processa o SQL
            match = re.search(r'CREATE\s+TABLE', sql, re.IGNORECASE)
            if match:
                inicio = match.start()
                sql_create = sql[inicio:]
                
                class_name, classe_code, colunas, chave_primaria, foreign_keys = gerar_classe(sql_create)
                
                if classe_code and chave_primaria:
                    # Gera APENAS os códigos Delphi
                    dao_code_delphi, delphi_name = gerar_dao_delphi(class_name, class_name, colunas, chave_primaria)
                    modelo_code_delphi, _ = gerar_modelo_delphi(class_name, colunas, chave_primaria, foreign_keys)
                    
                    # Salva APENAS os arquivos Delphi
                    nome_base = os.path.splitext(os.path.basename(arquivo))[0]
                    
                    # Delphi - Modelo
                    with open(os.path.join(pasta_saida, f"unt{delphi_name}.pas"), 'w', encoding='utf-8') as f:
                        f.write(modelo_code_delphi)
                    
                    # Delphi - DAO
                    with open(os.path.join(pasta_saida, f"unt{delphi_name}DAO.pas"), 'w', encoding='utf-8') as f:
                        f.write(dao_code_delphi)
                    
                    resultados.append(f"✅ {os.path.basename(arquivo)} -> {delphi_name} (Modelo + DAO)")
                else:
                    erros.append(f"❌ {os.path.basename(arquivo)} -> Erro na geração")
            else:
                erros.append(f"❌ {os.path.basename(arquivo)} -> CREATE TABLE não encontrado")
            
            progresso['value'] = i + 1
            janela_progresso.update()
            
        except Exception as e:
            erros.append(f"❌ {os.path.basename(arquivo)} -> Erro: {str(e)}")
            progresso['value'] = i + 1
            janela_progresso.update()
    
    janela_progresso.destroy()
    
    # Mostra resumo dos resultados
    mostrar_resumo_processamento(resultados, erros, pasta_saida)

def mostrar_resumo_processamento(resultados, erros, pasta_saida):
    """Mostra um resumo do processamento em lote."""
    janela_resumo = tk.Toplevel(janela)
    janela_resumo.title("Resumo do Processamento")
    janela_resumo.geometry("600x500")
    
    # Frame principal
    frame_principal = ttk.Frame(janela_resumo)
    frame_principal.pack(pady=10, padx=10, fill="both", expand=True)
    
    # Título
    titulo = tk.Label(frame_principal, text="Processamento Concluído!", font=("Arial", 14, "bold"))
    titulo.pack(pady=10)
    
    # Pasta de saída
    pasta_info = tk.Label(frame_principal, text=f"Arquivos salvos em: {pasta_saida}", font=("Arial", 10))
    pasta_info.pack(pady=5)
    
    # Notebook para organizar os resultados
    notebook = ttk.Notebook(frame_principal)
    notebook.pack(pady=10, fill="both", expand=True)
    
    # Aba de sucessos
    if resultados:
        frame_sucessos = ttk.Frame(notebook)
        notebook.add(frame_sucessos, text=f"Sucessos ({len(resultados)})")
        
        text_sucessos = tk.Text(frame_sucessos, wrap=tk.WORD, font=("Courier New", 10))
        text_sucessos.pack(pady=5, padx=5, fill="both", expand=True)
        text_sucessos.insert(tk.END, "\n".join(resultados))
        text_sucessos.config(state=tk.DISABLED)
    
    # Aba de erros
    if erros:
        frame_erros = ttk.Frame(notebook)
        notebook.add(frame_erros, text=f"Erros ({len(erros)})")
        
        text_erros = tk.Text(frame_erros, wrap=tk.WORD, font=("Courier New", 10))
        text_erros.pack(pady=5, padx=5, fill="both", expand=True)
        text_erros.insert(tk.END, "\n".join(erros))
        text_erros.config(state=tk.DISABLED)
    
    # Botões de ação
    frame_botoes = ttk.Frame(frame_principal)
    frame_botoes.pack(pady=10)
    
    btn_abrir_pasta = tk.Button(frame_botoes, text="Abrir Pasta de Saída", 
                               command=lambda: abrir_pasta_saida(pasta_saida))
    btn_abrir_pasta.pack(side=tk.LEFT, padx=5)
    
    btn_fechar = tk.Button(frame_botoes, text="Fechar", command=janela_resumo.destroy)
    btn_fechar.pack(side=tk.LEFT, padx=5)

def abrir_pasta_saida(pasta):
    """Abre a pasta de saída no explorador de arquivos."""
    import subprocess
    import platform
    
    try:
        if platform.system() == "Windows":
            subprocess.run(["explorer", pasta])
        elif platform.system() == "Darwin":  # macOS
            subprocess.run(["open", pasta])
        else:  # Linux
            subprocess.run(["xdg-open", pasta])
    except Exception as e:
        messagebox.showerror("Erro", f"Não foi possível abrir a pasta: {e}")

# Variável global para armazenar arquivos selecionados
ARQUIVOS_SELECIONADOS = []

# --- UI Principal ---
janela = tk.Tk()
janela.title("Gerador de Classe e DAO a partir de SQL - Processamento em Lote")
janela.geometry("800x600")

# Frame principal
frame_principal = ttk.Frame(janela)
frame_principal.pack(pady=20, padx=20, fill="both", expand=True)

# Título
titulo = tk.Label(frame_principal, text="Gerador de Código Delphi/Python", font=("Arial", 16, "bold"))
titulo.pack(pady=10)

# Frame dos botões
frame_botoes = ttk.Frame(frame_principal)
frame_botoes.pack(pady=10)

botao_arquivo_unico = tk.Button(frame_botoes, text="Selecionar Arquivo SQL Único", command=selecionar_arquivo)
botao_arquivo_unico.pack(side=tk.LEFT, padx=5)

botao_multiplos = tk.Button(frame_botoes, text="Selecionar Múltiplos Arquivos SQL", command=selecionar_arquivos)
botao_multiplos.pack(side=tk.LEFT, padx=5)

# Frame da área de texto
frame_texto = ttk.Frame(frame_principal)
frame_texto.pack(pady=10, fill="both", expand=True)

# Label explicativo
label_explicativo = tk.Label(frame_texto, text="Arquivos selecionados ou SQL para processar:")
label_explicativo.pack(pady=5)

# Área de texto
entrada_sql = tk.Text(frame_texto, height=20, width=80, wrap=tk.WORD, font=("Courier New", 10))
scrollbar = tk.Scrollbar(frame_texto, command=entrada_sql.yview)
entrada_sql['yscrollcommand'] = scrollbar.set
entrada_sql.pack(side=tk.LEFT, fill="both", expand=True)
scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

# Frame dos botões de processamento
frame_processamento = ttk.Frame(frame_principal)
frame_processamento.pack(pady=10)

botao = tk.Button(frame_processamento, text="Processar SQL Único", command=processar_sql)
botao.pack(side=tk.LEFT, padx=5)

botao_processar_todos = tk.Button(frame_processamento, text="Processar Todos os Arquivos", 
                                 command=processar_todos_arquivos, state=tk.DISABLED)
botao_processar_todos.pack(side=tk.LEFT, padx=5)

# Instruções
frame_instrucoes = ttk.LabelFrame(frame_principal, text="Instruções")
frame_instrucoes.pack(pady=10, fill="x")

instrucoes = """
1. Para processar um arquivo único: Use 'Selecionar Arquivo SQL Único' e depois 'Processar SQL Único'
2. Para processar múltiplos arquivos: Use 'Selecionar Múltiplos Arquivos SQL' e depois 'Processar Todos os Arquivos'
3. Os arquivos gerados serão salvos na pasta 'saida'
4. Formato gerado: APENAS arquivos Delphi (.pas) compatíveis com Delphi 10.13
5. Para cada tabela SQL: gera Modelo (untNome.pas) + DAO (untNomeDAO.pas)
6. NOVO: Análise automática de dependências - tabelas base são geradas primeiro
7. Exemplo: a006_cidades (base) → a043_tes (depende de cidades)
"""
label_instrucoes = tk.Label(frame_instrucoes, text=instrucoes, justify=tk.LEFT, font=("Arial", 9))
label_instrucoes.pack(pady=5, padx=10, anchor="w")

janela.mainloop()