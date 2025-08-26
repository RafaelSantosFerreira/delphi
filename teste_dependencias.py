#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import os

def analisar_dependencias_tabelas(arquivos_sql):
    """
    Analisa as dependências entre tabelas baseado nas chaves estrangeiras
    e retorna uma lista ordenada por dependência.
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
            
            print(f"Tabela: {nome_tabela}")
            print(f"  Dependências: {foreign_keys}")
            print(f"  Nome base: {nome_tabela.split('_')[0] if '_' in nome_tabela else nome_tabela}")
            print()
            
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
        
        print("Grafo de dependências:")
        for tabela, dependentes in grafo.items():
            print(f"  {tabela} -> {dependentes}")
        print()
        
        print("Grau de entrada:")
        for tabela, grau in grau_entrada.items():
            print(f"  {tabela}: {grau}")
        print()
        
        # Ordenação topológica
        resultado = []
        fila = [t for t in tabelas if grau_entrada[t['nome_tabela']] == 0]
        
        while fila:
            # Ordena por nome base (a006, a043, etc.) para estabilidade
            fila.sort(key=lambda x: x['nome_base'])
            
            atual = fila.pop(0)
            resultado.append(atual)
            
            print(f"Processando: {atual['nome_tabela']}")
            
            for vizinho in grafo[atual['nome_tabela']]:
                grau_entrada[vizinho] -= 1
                print(f"  Reduzindo grau de {vizinho} para {grau_entrada[vizinho]}")
                if grau_entrada[vizinho] == 0:
                    # Encontra a tabela correspondente
                    for t in tabelas:
                        if t['nome_tabela'] == vizinho:
                            fila.append(t)
                            print(f"  Adicionando {vizinho} à fila")
                            break
        
        # Adiciona tabelas restantes (se houver ciclos)
        for tabela in tabelas:
            if tabela not in resultado:
                resultado.append(tabela)
                print(f"Adicionando tabela restante: {tabela['nome_tabela']}")
        
        return resultado
    
    # Ordena por dependência
    tabelas_ordenadas = ordenar_por_dependencia(tabelas_info)
    
    print("Ordem final:")
    for i, tabela in enumerate(tabelas_ordenadas, 1):
        print(f"{i}. {tabela['nome_tabela']}")
    
    # Retorna lista ordenada de arquivos
    return [t['arquivo'] for t in tabelas_ordenadas]

if __name__ == "__main__":
    # Testa com os arquivos SQL disponíveis
    arquivos_sql = ["entrada/Cidades.sql", "entrada/Tes.sql"]
    
    print("=== TESTE DE ANÁLISE DE DEPENDÊNCIAS ===\n")
    
    arquivos_ordenados = analisar_dependencias_tabelas(arquivos_sql)
    
    print("\n=== RESULTADO FINAL ===")
    print("Arquivos ordenados por dependência:")
    for i, arquivo in enumerate(arquivos_ordenados, 1):
        nome_tabela = os.path.splitext(os.path.basename(arquivo))[0]
        print(f"{i}. {nome_tabela}")
