USE [dbTaura]
GO

/****** Object:  Table [dbo].[a043_tes]    Script Date: 26/08/2025 09:02:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[a043_tes](
	[a043_codigo] [nvarchar](12) NOT NULL,
	[a043_sequencial] [numeric](18, 0) NOT NULL,
	[a043_descricao] [nvarchar](50) NOT NULL,
	[a043_codigo_fiscal] [nvarchar](10) NOT NULL,
	[a043_tipo_tes] [nvarchar](10) NOT NULL,
	[a043_atualiza_est] [nvarchar](50) NOT NULL,
	[a043_gera_financeiro] [nvarchar](50) NOT NULL,
	[a043_estado] [nvarchar](50) NOT NULL,
	[a043_obs] [text] NULL,
	[a043_mov_cta_capital] [nvarchar](50) NULL,
	[a043_mov_cta_socio] [nvarchar](50) NULL,
	[a043_mov_desp_secagem] [nvarchar](50) NULL,
	[a043_especie_pessoa] [nvarchar](50) NULL,
	[a043_cat_pessoa] [nvarchar](50) NULL,
	[a043_tributacao] [nvarchar](50) NULL,
	[a043_base_calc_icm] [money] NULL,
	[a043_icm] [money] NULL,
	[a043_cod_sit_trib] [nvarchar](12) NULL,
	[a043_mensagem_nf] [text] NULL,
	[a043_utiliza_preco_pauta] [nvarchar](50) NULL,
	[a043_funrural] [money] NULL,
	[a043_pis] [money] NULL,
	[a043_cofins] [money] NULL,
	[a043_ipi] [money] NULL,
	[a043_desc_cfop] [nvarchar](20) NULL,
	[a043_cod_pessoa] [nvarchar](12) NULL,
	[a043_operacao_tes] [nvarchar](25) NULL,
	[a043_mov_custo] [nvarchar](50) NULL,
	[a043_cod_tes_estorno] [nvarchar](12) NULL,
	[a043_cod_col_mapa] [nvarchar](12) NULL,
	[a043_finalidade_nfe] [nvarchar](50) NULL,
	[a043_mod_base_calculo] [nvarchar](50) NULL,
	[a043_mod_base_calculo_substituicao] [nvarchar](50) NULL,
	[a043_situacao_tributaria_cofins] [nvarchar](100) NULL,
	[a043_situacao_tributaria_pis] [nvarchar](100) NULL,
	[a043_base_calculo_cofins] [money] NULL,
	[a043_base_calculo_frete] [nvarchar](50) NULL,
	[a043_aliquota_frete] [nvarchar](50) NULL,
	[a043_obs_fiscal] [nvarchar](100) NULL,
	[a043_obs_contribuinte] [nvarchar](100) NULL,
	[a043_base_calculo_pis] [money] NULL,
	[a043_margem_subst_tributaria] [money] NULL,
	[a043_perc_red_base_cal_substituicao] [money] NULL,
	[a043_preco_produto] [nvarchar](50) NULL,
	[a043_permite_nf] [nvarchar](10) NULL,
	[a043_issqn] [money] NULL,
	[a043_bc_ipi] [numeric](10, 3) NULL,
	[a043_mot_desoneracao] [nvarchar](50) NULL,
	[a043_exige_nf_prod] [nvarchar](50) NULL,
	[a043_vinculo_doc_fiscal] [nvarchar](50) NULL,
	[a043_funrural_ent_sai] [nvarchar](50) NULL,
	[a043_escrita] [nvarchar](5) NULL,
	[a043_ajuste_credito] [nvarchar](5) NULL,
	[a043_mensagem_nf_01] [nvarchar](max) NULL,
	[a043_tab_pis] [nvarchar](12) NULL,
	[a043_per_pis_socio] [money] NULL,
	[a043_base_pis_socio] [money] NULL,
	[a043_tab_cofins] [nvarchar](12) NULL,
	[a043_per_cofins_socio] [money] NULL,
	[a043_base_cofins_socio] [money] NULL,
	[a043_cod_Enq_ipi] [numeric](5, 0) NULL,
	[a043_cst_ipi] [nvarchar](100) NULL,
	[a043_usa_trib_pis] [nvarchar](100) NULL,
	[a043_p_senar] [money] NULL,
	[a043_bc_senar] [money] NULL,
	[a043_usa_produtos] [nvarchar](20) NULL,
	[a043_cod_aj_apuracao_deducao] [nvarchar](50) NULL,
	[a043_cod_ocorrencia_aj_icms] [nvarchar](50) NULL,
	[a043_cod_reflexo_apur_icms] [nvarchar](50) NULL,
	[a043_cod_tipo_apuracao] [nvarchar](50) NULL,
	[a043_cod_responsabilidade] [nvarchar](50) NULL,
	[a043_cod_influencia_recolhimento] [nvarchar](50) NULL,
	[a043_cod_origem_tributacao] [nvarchar](50) NULL,
	[a043_cod_aj_icms_ex_icms] [nvarchar](50) NULL,
	[a043_cod_obrigacao_a_recolher] [nvarchar](100) NULL,
	[a043_cod_tipo_utilizacao_credito] [nvarchar](50) NULL,
	[a043_ajuste_debito] [nvarchar](5) NULL,
	[a043_cod_tipo_credito] [nvarchar](12) NULL,
	[a043_usa_senar] [nvarchar](50) NULL,
	[a043_usuario] [nvarchar](50) NULL,
	[a043_datetime] [datetime] NULL,
	[a043_pCredSN] [money] NULL,
	[a043_gera_sped] [nvarchar](5) NULL,
	[a043_permite_ibpt] [nvarchar](4) NULL,
	[a043_depreciacao_anual] [money] NULL,
	[a043_percentual_residual] [money] NULL,
	[a043_usa_funrural] [nvarchar](5) NULL,
	[a043_pDif] [money] NULL,
	[a043_pMVAST] [money] NULL,
	[a043_pEntMVAST] [money] NULL,
	[a043_AliqIntST] [money] NULL,
	[a043_AliqST] [money] NULL,
	[a043_envia_deposito] [nvarchar](3) NULL,
	[a043_tipo_preco] [nvarchar](30) NULL,
	[a043_pBCFCP] [numeric](18, 4) NULL,
	[a043_pFCP] [numeric](18, 4) NULL,
	[a043_pBCFCPST] [numeric](18, 4) NULL,
	[a043_pFCPST] [numeric](18, 4) NULL,
	[a043_pBCFCPRet] [numeric](18, 4) NULL,
	[a043_pFCPRet] [numeric](18, 4) NULL,
	[a043_pST] [numeric](18, 4) NULL,
	[a043_usa_FCP] [nvarchar](5) NULL,
	[a043_usa_trib_serv] [nvarchar](5) NULL,
	[a043_red_bc_csll] [numeric](18, 4) NULL,
	[a043_perc_csll] [numeric](18, 4) NULL,
	[a043_red_bc_irrf] [numeric](18, 4) NULL,
	[a043_perc_irrf] [numeric](18, 4) NULL,
	[a043_red_bc_inss] [numeric](18, 4) NULL,
	[a043_perc_inss] [numeric](18, 4) NULL,
	[a043_bc_ret] [numeric](18, 4) NULL,
	[a043_aliq_ret] [numeric](18, 4) NULL,
	[a043_bc_ret_sub] [numeric](18, 4) NULL,
	[a043_aliq_ret_sub] [numeric](18, 4) NULL,
	[a043_perc_nret_princ] [numeric](18, 4) NULL,
	[a043_perc_ret_15] [numeric](18, 4) NULL,
	[a043_perc_ret_20] [numeric](18, 4) NULL,
	[a043_perc_ret_25] [numeric](18, 4) NULL,
	[a043_perc_nret_adic] [numeric](18, 4) NULL,
	[a043_v_bc_st_ret_opc] [numeric](18, 2) NULL,
	[a043_p_st_opc] [numeric](18, 4) NULL,
	[a043_v_icms_substituto_opc] [numeric](18, 2) NULL,
	[a043_v_icms_st_ret_opc] [numeric](18, 2) NULL,
	[a043_v_bc_fcp_st_ret_opc] [numeric](18, 2) NULL,
	[a043_p_fcp_st_ret_opc] [numeric](18, 4) NULL,
	[a043_v_fcp_st_ret_opc] [numeric](18, 2) NULL,
	[a043_p_red_bc_efet_opc] [numeric](18, 4) NULL,
	[a043_v_bc_efet_opc] [numeric](18, 2) NULL,
	[a043_p_icms_efet_opc] [numeric](18, 4) NULL,
	[a043_v_icms_efet_opc] [numeric](18, 2) NULL,
	[a043_v_bc_st_dest_opc] [numeric](18, 2) NULL,
	[a043_v_icms_st_dest_opc] [numeric](18, 2) NULL,
	[a043_v_bc_uf_dest] [numeric](18, 2) NULL,
	[a043_v_bc_fcp_uf_dest_opc] [numeric](18, 2) NULL,
	[a043_p_fcp_uf_dest_opc] [numeric](18, 4) NULL,
	[a043_p_icms_uf_dest] [numeric](18, 4) NULL,
	[a043_p_icms_inter] [numeric](18, 4) NULL,
	[a043_p_icms_inter_part] [numeric](18, 4) NULL,
	[a043_v_fcp_uf_dest_opc] [numeric](18, 2) NULL,
	[a043_v_icms_uf_dest] [numeric](18, 2) NULL,
	[a043_v_icms_uf_remet] [numeric](18, 2) NULL,
	[a043_usa_cfop] [nvarchar](50) NULL,
	[a043_ibs] [nvarchar](20) NULL,
	[a043_ibs_aliquota] [money] NULL,
	[a043_ibs_base_calc] [money] NULL,
	[a043_iss] [nvarchar](20) NULL,
	[a043_iss_aliquota] [money] NULL,
	[a043_iss_base_calc] [money] NULL,
	[a043_cbs] [nvarchar](20) NULL,
	[a043_cbs_aliquota] [money] NULL,
	[a043_cbs_base_calc] [money] NULL,
	[a043_cod_iva] [nvarchar](12) NULL,
	[a043_cod_cidade] [nvarchar](12) NULL,
	[a043_cst_ibs] [nvarchar](10) NULL,
	[a043_cst_iss] [nvarchar](10) NULL,
	[a043_cst_cbs] [nvarchar](10) NULL,
 CONSTRAINT [PK_a043_tes] PRIMARY KEY CLUSTERED 
(
	[a043_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[a043_tes]  WITH CHECK ADD  CONSTRAINT [FK_a043_tes_a054_situacao_tributaria] FOREIGN KEY([a043_cod_sit_trib])
REFERENCES [dbo].[a054_situacao_tributaria] ([a054_codigo])
GO

ALTER TABLE [dbo].[a043_tes] CHECK CONSTRAINT [FK_a043_tes_a054_situacao_tributaria]
GO

ALTER TABLE [dbo].[a043_tes]  WITH CHECK ADD  CONSTRAINT [FK_a043_tes_cod_cidade] FOREIGN KEY([a043_cod_cidade])
REFERENCES [dbo].[a006_cidades] ([a006_codigo])
GO

ALTER TABLE [dbo].[a043_tes] CHECK CONSTRAINT [FK_a043_tes_cod_cidade]
GO

ALTER TABLE [dbo].[a043_tes]  WITH CHECK ADD  CONSTRAINT [FK_a043_tes_cod_iva] FOREIGN KEY([a043_cod_iva])
REFERENCES [dbo].[a617_cst_iva] ([a617_codigo])
GO

ALTER TABLE [dbo].[a043_tes] CHECK CONSTRAINT [FK_a043_tes_cod_iva]
GO

ALTER TABLE [dbo].[a043_tes]  WITH CHECK ADD  CONSTRAINT [FK_auto_referencia] FOREIGN KEY([a043_cod_tes_estorno])
REFERENCES [dbo].[a043_tes] ([a043_codigo])
GO

ALTER TABLE [dbo].[a043_tes] CHECK CONSTRAINT [FK_auto_referencia]
GO

