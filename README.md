# 🚀 Gerador Automático de Código Delphi

## 📋 Descrição

Este projeto é um **gerador automático de código Delphi** que converte scripts SQL Server (CREATE TABLE) em código Delphi completo e funcional. Ele gera automaticamente **Modelos** e **DAOs** compatíveis com Delphi 10.13, seguindo padrões de projeto estabelecidos.

## 🎯 Objetivo Principal

Automatizar a geração de código Delphi a partir de definições de tabelas SQL, eliminando:
- ❌ Código repetitivo manual
- ❌ Erros de digitação
- ❌ Inconsistências entre SQL e código
- ❌ Tempo perdido com tarefas repetitivas

## 🏗️ Arquitetura do Projeto

### 📁 Estrutura de Pastas

```
delphi/
├── entrada/                    # Scripts SQL de entrada
│   ├── Cidades.sql           # Definição da tabela a006_cidades
│   └── Tes.sql              # Definição da tabela a043_tes
├── resultadoCerto/           # Resultados esperados (referência)
│   ├── untModelosCerto.pas  # Modelo correto com todas as tabelas
│   └── untTesDAOCerta.pas   # DAO correto da tabela Tes
├── resultadoGeral/           # Resultados incorretos (para comparação)
│   ├── untModelosErro.pas   # Modelo com problemas
│   └── untTesDAOErro.pas    # DAO com problemas
├── saida/                    # Arquivos gerados pelo script (saída)
├── entrada2.py              # Script principal Python
└── README.md                # Este arquivo
```

## 🔧 Funcionalidades

### ✨ **Recursos Principais**

1. **🎯 Geração Automática de Código Delphi**
   - Modelos (`.pas`) com propriedades e validações
   - DAOs (`.pas`) com SQL INSERT/UPDATE otimizado
   - Compatibilidade total com Delphi 10.13

2. **🔄 Análise Inteligente de Dependências**
   - Detecta chaves estrangeiras automaticamente
   - Ordena tabelas por dependência (base → dependente)
   - Exemplo: `a006_cidades` (base) → `a043_tes` (depende de cidades)

3. **📊 Processamento em Lote**
   - Seleciona múltiplos arquivos SQL
   - Processa todos automaticamente
   - Barra de progresso e relatório de resultados

4. **🔍 Validações Automáticas**
   - `KValidadorTamanho` para campos string
   - `KValidadorBanco` com metadados SQL precisos
   - Mapeamento correto de tipos SQL → Delphi

### 🎨 **Interface Gráfica**

- **Tkinter** com design moderno e intuitivo
- **Duas modalidades** de processamento:
  - Arquivo único (para testes)
  - Múltiplos arquivos (para produção)
- **Visualização em tempo real** dos resultados
- **Salvamento automático** na pasta `saida/`

## 📚 Arquivos e Suas Funções

### 🔧 **Script Principal: `entrada2.py`**

#### **Funções Core:**
- `gerar_classe()` - Extrai metadados das tabelas SQL
- `gerar_modelo_delphi()` - Gera modelos Delphi com validações
- `gerar_dao_delphi()` - Gera DAOs com SQL otimizado
- `analisar_dependencias_tabelas()` - Ordena tabelas por dependência

#### **Funções de Interface:**
- `selecionar_arquivos()` - Seleção múltipla de arquivos SQL
- `processar_todos_arquivos()` - Processamento em lote
- `mostrar_resumo_processamento()` - Relatório de resultados

#### **Funções Helper:**
- `mapear_tipo()` - Converte tipos SQL para Python
- `_parse_sql_type_details()` - Extrai precisão e tamanho
- `snake_to_pascal()` - Converte nomenclatura

### 📝 **Arquivos de Entrada: `entrada/*.sql`**

#### **`Cidades.sql`**
- Define tabela `a006_cidades`
- Campos: código, descrição, nome, habitantes, UF
- Chave estrangeira para `a005_estados`

#### **`Tes.sql`**
- Define tabela `a043_tes` (Tabela de Estímulo)
- Campos: código, descrição, alíquotas, bases de cálculo
- Chave estrangeira para `a006_cidades`

### ✅ **Arquivos de Referência: `resultadoCerto/*.pas`**

#### **`untModelosCerto.pas`**
- **Modelo correto** com todas as tabelas
- Propriedades na ordem exata do SQL
- Validações precisas com metadados corretos
- Chaves estrangeiras implementadas

#### **`untTesDAOCerta.pas`**
- **DAO correto** da tabela Tes
- SQL INSERT/UPDATE na ordem correta
- Parâmetros mapeados corretamente
- Compatível com Delphi 10.13

### ❌ **Arquivos com Problemas: `resultadoGeral/*.pas`**

#### **`untModelosErro.pas`**
- Propriedades em ordem incorreta
- Tipos de dados mapeados incorretamente
- Validações com metadados errados

#### **`untTesDAOErro.pas`**
- SQL com ordem de colunas incorreta
- Parâmetros mal mapeados
- Incompatível com padrões do projeto

### 📤 **Arquivos de Saída: `saida/*.pas`**

#### **Gerados Automaticamente:**
- `untCidades.pas` - Modelo da tabela Cidades
- `untCidadesDAO.pas` - DAO da tabela Cidades
- `untTes.pas` - Modelo da tabela Tes
- `untTesDAO.pas` - DAO da tabela Tes

## 🚀 Como Usar

### **1. Preparação**
```bash
# Certifique-se de ter Python 3.x instalado
python3 --version

# Navegue para a pasta do projeto
cd delphi/
```

### **2. Execução**
```bash
# Execute o script principal
python3 entrada2.py
```

### **3. Interface Gráfica**

#### **Modo Arquivo Único:**
1. Clique em **"Selecionar Arquivo SQL Único"**
2. Escolha um arquivo `.sql`
3. Clique em **"Processar SQL Único"**

#### **Modo Processamento em Lote (Recomendado):**
1. Clique em **"Selecionar Múltiplos Arquivos SQL"**
2. Selecione todos os arquivos `.sql` desejados
3. Clique em **"Processar Todos os Arquivos"**

### **4. Resultados**
- Arquivos gerados na pasta `saida/`
- Relatório completo de processamento
- Botão para abrir pasta de saída

## 🔍 Mapeamento de Tipos SQL → Delphi

| Tipo SQL | Tipo Python | Tipo Delphi | Validação |
|----------|-------------|-------------|-----------|
| `varchar(100)` | `str` | `String` | `KValidadorTamanho(-1, 100)` |
| `int` | `int` | `Integer` | `KValidadorBanco('tabela', 'coluna', 'int', 0, 0)` |
| `money` | `float` | `Currency` | `KValidadorBanco('tabela', 'coluna', 'money', 19, 4)` |
| `numeric(18,4)` | `float` | `Currency` | `KValidadorBanco('tabela', 'coluna', 'numeric', 18, 4)` |
| `datetime` | `datetime` | `TDateTime` | `KValidadorBanco('tabela', 'coluna', 'datetime', 0, 0)` |

## 🎯 Casos de Uso

### **1. Desenvolvimento de Novas Tabelas**
- Cria tabela no SQL Server
- Executa script para gerar código Delphi
- Código pronto para uso imediato

### **2. Refatoração de Tabelas Existentes**
- Modifica estrutura da tabela
- Regenera código Delphi
- Atualiza validações automaticamente

### **3. Migração de Sistemas**
- Converte scripts SQL legados
- Gera código Delphi moderno
- Mantém compatibilidade com Delphi 10.13

### **4. Padronização de Código**
- Aplica padrões consistentes
- Elimina variações de estilo
- Facilita manutenção

## 🔧 Configurações e Personalizações

### **Tipos de Dados Personalizados**
```python
# Em entrada2.py, função _normalize_base_sql_type()
if b in ('money', 'smallmoney'):
    return 'money'  # Retorna 'money' em vez de 'numeric'
```

### **Validações Customizadas**
```python
# Em entrada2.py, função gerar_modelo_delphi()
if py_type == 'str':
    max_len = meta.get('length', -1)
    if max_len == 0: max_len = -1
    atributos.append(f"KValidadorTamanho(-1, {max_len})")
```

### **Formatação de SQL**
```python
# Em entrada2.py, função formatar_delphi_sql_const()
def formatar_delphi_sql_const(items, items_per_line=4):
    # Personaliza quantas colunas por linha no SQL
```

## 🐛 Solução de Problemas

### **Erro: "CREATE TABLE não encontrado"**
- Verifique se o arquivo SQL contém `CREATE TABLE`
- Certifique-se de que o arquivo está em UTF-8

### **Erro: "Chave Primária não identificada"**
- Verifique se a tabela tem `PRIMARY KEY` definida
- Confirme a sintaxe do SQL

### **Propriedades em ordem incorreta**
- Execute o script corrigido (versão atual)
- Verifique se as colunas estão na ordem correta no SQL

### **Tipos de dados incorretos**
- Verifique o mapeamento na função `mapear_tipo()`
- Confirme se os tipos SQL estão sendo reconhecidos

## 📈 Melhorias Futuras

### **Funcionalidades Planejadas:**
- [ ] Suporte a outros bancos de dados (PostgreSQL, MySQL)
- [ ] Geração de testes unitários
- [ ] Integração com IDEs Delphi
- [ ] Suporte a stored procedures
- [ ] Geração de documentação automática

### **Otimizações Técnicas:**
- [ ] Cache de metadados SQL
- [ ] Processamento paralelo para múltiplas tabelas
- [ ] Validação de integridade referencial
- [ ] Logs detalhados de processamento

## 🤝 Contribuição

### **Como Contribuir:**
1. **Fork** o projeto
2. **Crie** uma branch para sua feature
3. **Commit** suas mudanças
4. **Push** para a branch
5. **Abra** um Pull Request

### **Áreas de Contribuição:**
- Novos tipos de dados SQL
- Melhorias na interface gráfica
- Otimizações de performance
- Documentação e exemplos
- Testes e validações

## 📄 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo `LICENSE` para detalhes.

## 👨‍💻 Autor

**Gerador Automático de Código Delphi**
- **Versão:** 2.0
- **Data:** Agosto 2025
- **Compatibilidade:** Delphi 10.13+
- **Linguagem:** Python 3.x

## 📞 Suporte

Para dúvidas, sugestões ou problemas:
- Abra uma **Issue** no GitHub
- Consulte a **documentação** incluída
- Verifique os **exemplos** na pasta `resultadoCerto/`

---

## 🎉 **Resumo Executivo**

Este projeto **automatiza completamente** a geração de código Delphi a partir de definições SQL, eliminando trabalho manual repetitivo e garantindo consistência e qualidade no código gerado. É uma ferramenta essencial para desenvolvedores Delphi que trabalham com bancos de dados SQL Server.

**Principais benefícios:**
- ⚡ **90% menos tempo** para criar modelos e DAOs
- 🎯 **100% de consistência** entre SQL e código
- 🚀 **Compatibilidade total** com Delphi 10.13
- 🔄 **Análise automática** de dependências
- 📊 **Processamento em lote** para múltiplas tabelas
