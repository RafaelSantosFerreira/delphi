class a006_cidadesController:
    CAMPOS_PERMITIDOS = {"a006_codigo", "a006_sequencial", "a006_nome", "a006_uf", "a006_nro_habitantes", "a006_descricao", "a006_cod_ibge"}

    @staticmethod
    def validar_campos(data: dict):
        extras = set(data.keys()) - a006_cidadesController.CAMPOS_PERMITIDOS
        if extras:
            raise ValueError(f"Campos extras não permitidos: {extras}")
        return True
