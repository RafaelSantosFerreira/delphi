from typing import List, Any, Union
import logging
from a006_cidades import a006_cidades

class a006_cidadesDAO:
    def __init__(self, conexao):
        self.conexao = conexao
        self.tabela = "a006_cidades"
        self.chave_primaria = "a006_codigo"
        self.logger = logging.getLogger(__name__)

    def _row_to_object(self, row: tuple) -> 'a006_cidades':
        return a006_cidades(
            a006_codigo=row[0],
            a006_sequencial=row[1],
            a006_nome=row[2],
            a006_uf=row[3],
            a006_nro_habitantes=row[4],
            a006_descricao=row[5],
            a006_cod_ibge=row[6],
        )

    def insert(self, modelo: 'a006_cidades') -> 'a006_cidades':
        try:
            cursor = self.conexao.cursor()
            sql = f"""INSERT INTO {self.tabela} (a006_codigo, a006_sequencial, a006_nome, a006_uf, a006_nro_habitantes, a006_descricao, a006_cod_ibge)
                      VALUES (?, ?, ?, ?, ?, ?, ?)"""
            params = (modelo.a006_codigo,
                modelo.a006_sequencial,
                modelo.a006_nome,
                modelo.a006_uf,
                modelo.a006_nro_habitantes,
                modelo.a006_descricao,
                modelo.a006_cod_ibge,)
            cursor.execute(sql, params)
            self.conexao.commit()
            self.logger.info(f"Registro inserido com sucesso em {self.tabela}.")
            return modelo
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao inserir em {self.tabela}: {e}")
            raise Exception(f"Erro ao inserir em {self.tabela}: {e}")

    def update(self, modelo: 'a006_cidades') -> 'a006_cidades':
        try:
            cursor = self.conexao.cursor()
            sql = f"""UPDATE {self.tabela} SET a006_sequencial = ?, a006_nome = ?, a006_uf = ?, a006_nro_habitantes = ?, a006_descricao = ?, a006_cod_ibge = ?
                      WHERE {self.chave_primaria} = ?"""
            params = (modelo.a006_sequencial,
                modelo.a006_nome,
                modelo.a006_uf,
                modelo.a006_nro_habitantes,
                modelo.a006_descricao,
                modelo.a006_cod_ibge,
                modelo.a006_codigo)
            cursor.execute(sql, params)
            self.conexao.commit()
            self.logger.info(f"Registro atualizado com sucesso em {self.tabela}.")
            return modelo
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao atualizar em {self.tabela}: {e}")
            raise Exception(f"Erro ao atualizar em {self.tabela}: {e}")

    def delete(self, id: str) -> None:
        try:
            cursor = self.conexao.cursor()
            sql = f"DELETE FROM {self.tabela} WHERE {self.chave_primaria} = ?"
            cursor.execute(sql, (id,))
            self.conexao.commit()
            self.logger.info(f"Registro deletado com sucesso de {self.tabela}, ID: {id}")
        except Exception as e:
            self.conexao.rollback()
            self.logger.error(f"Erro ao deletar em {self.tabela}: {e}")
            raise Exception(f"Erro ao deletar em {self.tabela}: {e}")

    def get_by_id(self, id: str) -> Union['a006_cidades', None]:
        try:
            cursor = self.conexao.cursor()
            sql = f"SELECT * FROM {self.tabela} WHERE {self.chave_primaria} = ?"
            cursor.execute(sql, (id,))
            row = cursor.fetchone()
            return self._row_to_object(row) if row else None
        except Exception as e:
            self.logger.error(f"Erro ao buscar por ID em {self.tabela}: {e}")
            raise Exception(f"Erro ao buscar por ID em {self.tabela}: {e}")

    def list_all(self) -> List['a006_cidades']:
        try:
            cursor = self.conexao.cursor()
            sql = f"SELECT * FROM {self.tabela}"
            cursor.execute(sql)
            rows = cursor.fetchall()
            return [self._row_to_object(row) for row in rows]
        except Exception as e:
            self.logger.error(f"Erro ao listar todos de {self.tabela}: {e}")
            raise Exception(f"Erro ao listar todos de {self.tabela}: {e}")
