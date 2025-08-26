{----------------------------------------------------}
{ File      : untTesDAO.pas          }
{ Generated : 26/08/2025 15:35:24                    }
{ User      : GeradorAutomatico                      }
{----------------------------------------------------}

unit untTesDAO;

interface

uses untKhnumQuery, DB, ADODB, untBaseDAO, untModelos, untTes;

type
	TClassTesDAO = BaseDAO<TTes>;

	TesDAO = class(TClassTesDAO)
	public
		constructor Create(_sEmpresa, _sFilial: String); override;
		function getInsertSql: String; override;
		function getUpdateSql: String; override;
		procedure ObjetoParaQuery(oObjeto: TTes; oQuery: TADOQuery;
				bSetarCodSeq: Boolean = true); override;
	protected
		function SubLinhaParaObjeto(oFields: TFields): TTes; override;
	end;

implementation

uses SysUtils;

constructor TesDAO.Create(_sEmpresa, _sFilial: String);
begin
	inherited createDao('a043_tes', _sEmpresa, _sFilial, false);
end;

function TesDAO.getInsertSql;
const
	SQL_INSERIR: String =
			'INSERT INTO [dbo].[a043_tes](' + 
				' [a043_codigo], [a043_sequencial], [a043_descricao], [a043_codigo_fiscal], ' + 
				' [a043_tipo_tes], [a043_atualiza_est], [a043_gera_financeiro], [a043_estado], ' + 
				' [a043_obs], [a043_mov_cta_capital], [a043_mov_cta_socio], [a043_mov_desp_secagem], ' + 
				' [a043_especie_pessoa], [a043_cat_pessoa], [a043_tributacao], [a043_base_calc_icm], ' + 
				' [a043_icm], [a043_cod_sit_trib], [a043_mensagem_nf], [a043_utiliza_preco_pauta], ' + 
				' [a043_funrural], [a043_pis], [a043_cofins], [a043_ipi], ' + 
				' [a043_desc_cfop], [a043_cod_pessoa], [a043_operacao_tes], [a043_mov_custo], ' + 
				' [a043_cod_tes_estorno], [a043_cod_col_mapa], [a043_finalidade_nfe], [a043_mod_base_calculo], ' + 
				' [a043_mod_base_calculo_substituicao], [a043_situacao_tributaria_cofins], [a043_situacao_tributaria_pis], [a043_base_calculo_cofins], ' + 
				' [a043_base_calculo_frete], [a043_aliquota_frete], [a043_obs_fiscal], [a043_obs_contribuinte], ' + 
				' [a043_base_calculo_pis], [a043_margem_subst_tributaria], [a043_perc_red_base_cal_substituicao], [a043_preco_produto], ' + 
				' [a043_permite_nf], [a043_issqn], [a043_bc_ipi], [a043_mot_desoneracao], ' + 
				' [a043_exige_nf_prod], [a043_vinculo_doc_fiscal], [a043_funrural_ent_sai], [a043_escrita], ' + 
				' [a043_ajuste_credito], [a043_mensagem_nf_01], [a043_tab_pis], [a043_per_pis_socio], ' + 
				' [a043_base_pis_socio], [a043_tab_cofins], [a043_per_cofins_socio], [a043_base_cofins_socio], ' + 
				' [a043_cod_Enq_ipi], [a043_cst_ipi], [a043_usa_trib_pis], [a043_p_senar], ' + 
				' [a043_bc_senar], [a043_usa_produtos], [a043_cod_aj_apuracao_deducao], [a043_cod_ocorrencia_aj_icms], ' + 
				' [a043_cod_reflexo_apur_icms], [a043_cod_tipo_apuracao], [a043_cod_responsabilidade], [a043_cod_influencia_recolhimento], ' + 
				' [a043_cod_origem_tributacao], [a043_cod_aj_icms_ex_icms], [a043_cod_obrigacao_a_recolher], [a043_cod_tipo_utilizacao_credito], ' + 
				' [a043_ajuste_debito], [a043_cod_tipo_credito], [a043_usa_senar], [a043_usuario], ' + 
				' [a043_datetime], [a043_pCredSN], [a043_gera_sped], [a043_permite_ibpt], ' + 
				' [a043_depreciacao_anual], [a043_percentual_residual], [a043_usa_funrural], [a043_pDif], ' + 
				' [a043_pMVAST], [a043_pEntMVAST], [a043_AliqIntST], [a043_AliqST], ' + 
				' [a043_envia_deposito], [a043_tipo_preco], [a043_pBCFCP], [a043_pFCP], ' + 
				' [a043_pBCFCPST], [a043_pFCPST], [a043_pBCFCPRet], [a043_pFCPRet], ' + 
				' [a043_pST], [a043_usa_FCP], [a043_usa_trib_serv], [a043_red_bc_csll], ' + 
				' [a043_perc_csll], [a043_red_bc_irrf], [a043_perc_irrf], [a043_red_bc_inss], ' + 
				' [a043_perc_inss], [a043_bc_ret], [a043_aliq_ret], [a043_bc_ret_sub], ' + 
				' [a043_aliq_ret_sub], [a043_perc_nret_princ], [a043_perc_ret_15], [a043_perc_ret_20], ' + 
				' [a043_perc_ret_25], [a043_perc_nret_adic], [a043_v_bc_st_ret_opc], [a043_p_st_opc], ' + 
				' [a043_v_icms_substituto_opc], [a043_v_icms_st_ret_opc], [a043_v_bc_fcp_st_ret_opc], [a043_p_fcp_st_ret_opc], ' + 
				' [a043_v_fcp_st_ret_opc], [a043_p_red_bc_efet_opc], [a043_v_bc_efet_opc], [a043_p_icms_efet_opc], ' + 
				' [a043_v_icms_efet_opc], [a043_v_bc_st_dest_opc], [a043_v_icms_st_dest_opc], [a043_v_bc_uf_dest], ' + 
				' [a043_v_bc_fcp_uf_dest_opc], [a043_p_fcp_uf_dest_opc], [a043_p_icms_uf_dest], [a043_p_icms_inter], ' + 
				' [a043_p_icms_inter_part], [a043_v_fcp_uf_dest_opc], [a043_v_icms_uf_dest], [a043_v_icms_uf_remet], ' + 
				' [a043_usa_cfop], [a043_ibs], [a043_ibs_aliquota], [a043_ibs_base_calc], ' + 
				' [a043_iss], [a043_iss_aliquota], [a043_iss_base_calc], [a043_cbs], ' + 
				' [a043_cbs_aliquota], [a043_cbs_base_calc], [a043_cod_iva], [a043_cod_cidade], ' + 
				' [a043_cst_ibs], [a043_cst_iss], [a043_cst_cbs]  ' + 
				') VALUES( ' + 
				' :a043_codigo, :a043_sequencial, :a043_descricao, :a043_codigo_fiscal, ' + 
				' :a043_tipo_tes, :a043_atualiza_est, :a043_gera_financeiro, :a043_estado, ' + 
				' :a043_obs, :a043_mov_cta_capital, :a043_mov_cta_socio, :a043_mov_desp_secagem, ' + 
				' :a043_especie_pessoa, :a043_cat_pessoa, :a043_tributacao, :a043_base_calc_icm, ' + 
				' :a043_icm, :a043_cod_sit_trib, :a043_mensagem_nf, :a043_utiliza_preco_pauta, ' + 
				' :a043_funrural, :a043_pis, :a043_cofins, :a043_ipi, ' + 
				' :a043_desc_cfop, :a043_cod_pessoa, :a043_operacao_tes, :a043_mov_custo, ' + 
				' :a043_cod_tes_estorno, :a043_cod_col_mapa, :a043_finalidade_nfe, :a043_mod_base_calculo, ' + 
				' :a043_mod_base_calculo_substituicao, :a043_situacao_tributaria_cofins, :a043_situacao_tributaria_pis, :a043_base_calculo_cofins, ' + 
				' :a043_base_calculo_frete, :a043_aliquota_frete, :a043_obs_fiscal, :a043_obs_contribuinte, ' + 
				' :a043_base_calculo_pis, :a043_margem_subst_tributaria, :a043_perc_red_base_cal_substituicao, :a043_preco_produto, ' + 
				' :a043_permite_nf, :a043_issqn, :a043_bc_ipi, :a043_mot_desoneracao, ' + 
				' :a043_exige_nf_prod, :a043_vinculo_doc_fiscal, :a043_funrural_ent_sai, :a043_escrita, ' + 
				' :a043_ajuste_credito, :a043_mensagem_nf_01, :a043_tab_pis, :a043_per_pis_socio, ' + 
				' :a043_base_pis_socio, :a043_tab_cofins, :a043_per_cofins_socio, :a043_base_cofins_socio, ' + 
				' :a043_cod_Enq_ipi, :a043_cst_ipi, :a043_usa_trib_pis, :a043_p_senar, ' + 
				' :a043_bc_senar, :a043_usa_produtos, :a043_cod_aj_apuracao_deducao, :a043_cod_ocorrencia_aj_icms, ' + 
				' :a043_cod_reflexo_apur_icms, :a043_cod_tipo_apuracao, :a043_cod_responsabilidade, :a043_cod_influencia_recolhimento, ' + 
				' :a043_cod_origem_tributacao, :a043_cod_aj_icms_ex_icms, :a043_cod_obrigacao_a_recolher, :a043_cod_tipo_utilizacao_credito, ' + 
				' :a043_ajuste_debito, :a043_cod_tipo_credito, :a043_usa_senar, :a043_usuario, ' + 
				' :a043_datetime, :a043_pCredSN, :a043_gera_sped, :a043_permite_ibpt, ' + 
				' :a043_depreciacao_anual, :a043_percentual_residual, :a043_usa_funrural, :a043_pDif, ' + 
				' :a043_pMVAST, :a043_pEntMVAST, :a043_AliqIntST, :a043_AliqST, ' + 
				' :a043_envia_deposito, :a043_tipo_preco, :a043_pBCFCP, :a043_pFCP, ' + 
				' :a043_pBCFCPST, :a043_pFCPST, :a043_pBCFCPRet, :a043_pFCPRet, ' + 
				' :a043_pST, :a043_usa_FCP, :a043_usa_trib_serv, :a043_red_bc_csll, ' + 
				' :a043_perc_csll, :a043_red_bc_irrf, :a043_perc_irrf, :a043_red_bc_inss, ' + 
				' :a043_perc_inss, :a043_bc_ret, :a043_aliq_ret, :a043_bc_ret_sub, ' + 
				' :a043_aliq_ret_sub, :a043_perc_nret_princ, :a043_perc_ret_15, :a043_perc_ret_20, ' + 
				' :a043_perc_ret_25, :a043_perc_nret_adic, :a043_v_bc_st_ret_opc, :a043_p_st_opc, ' + 
				' :a043_v_icms_substituto_opc, :a043_v_icms_st_ret_opc, :a043_v_bc_fcp_st_ret_opc, :a043_p_fcp_st_ret_opc, ' + 
				' :a043_v_fcp_st_ret_opc, :a043_p_red_bc_efet_opc, :a043_v_bc_efet_opc, :a043_p_icms_efet_opc, ' + 
				' :a043_v_icms_efet_opc, :a043_v_bc_st_dest_opc, :a043_v_icms_st_dest_opc, :a043_v_bc_uf_dest, ' + 
				' :a043_v_bc_fcp_uf_dest_opc, :a043_p_fcp_uf_dest_opc, :a043_p_icms_uf_dest, :a043_p_icms_inter, ' + 
				' :a043_p_icms_inter_part, :a043_v_fcp_uf_dest_opc, :a043_v_icms_uf_dest, :a043_v_icms_uf_remet, ' + 
				' :a043_usa_cfop, :a043_ibs, :a043_ibs_aliquota, :a043_ibs_base_calc, ' + 
				' :a043_iss, :a043_iss_aliquota, :a043_iss_base_calc, :a043_cbs, ' + 
				' :a043_cbs_aliquota, :a043_cbs_base_calc, :a043_cod_iva, :a043_cod_cidade, ' + 
				' :a043_cst_ibs, :a043_cst_iss, :a043_cst_cbs  ' + 
				')';
begin
	Result := SQL_INSERIR;
end;

function TesDAO.getUpdateSql;
const
	SQL_ATUALIZAR: String =
			'UPDATE [dbo].[a043_tes] SET ' + 
				' [a043_sequencial] = :a043_sequencial, ' + 
				' [a043_descricao] = :a043_descricao, ' + 
				' [a043_codigo_fiscal] = :a043_codigo_fiscal, ' + 
				' [a043_tipo_tes] = :a043_tipo_tes, ' + 
				' [a043_atualiza_est] = :a043_atualiza_est, ' + 
				' [a043_gera_financeiro] = :a043_gera_financeiro, ' + 
				' [a043_estado] = :a043_estado, ' + 
				' [a043_obs] = :a043_obs, ' + 
				' [a043_mov_cta_capital] = :a043_mov_cta_capital, ' + 
				' [a043_mov_cta_socio] = :a043_mov_cta_socio, ' + 
				' [a043_mov_desp_secagem] = :a043_mov_desp_secagem, ' + 
				' [a043_especie_pessoa] = :a043_especie_pessoa, ' + 
				' [a043_cat_pessoa] = :a043_cat_pessoa, ' + 
				' [a043_tributacao] = :a043_tributacao, ' + 
				' [a043_base_calc_icm] = :a043_base_calc_icm, ' + 
				' [a043_icm] = :a043_icm, ' + 
				' [a043_cod_sit_trib] = :a043_cod_sit_trib, ' + 
				' [a043_mensagem_nf] = :a043_mensagem_nf, ' + 
				' [a043_utiliza_preco_pauta] = :a043_utiliza_preco_pauta, ' + 
				' [a043_funrural] = :a043_funrural, ' + 
				' [a043_pis] = :a043_pis, ' + 
				' [a043_cofins] = :a043_cofins, ' + 
				' [a043_ipi] = :a043_ipi, ' + 
				' [a043_desc_cfop] = :a043_desc_cfop, ' + 
				' [a043_cod_pessoa] = :a043_cod_pessoa, ' + 
				' [a043_operacao_tes] = :a043_operacao_tes, ' + 
				' [a043_mov_custo] = :a043_mov_custo, ' + 
				' [a043_cod_tes_estorno] = :a043_cod_tes_estorno, ' + 
				' [a043_cod_col_mapa] = :a043_cod_col_mapa, ' + 
				' [a043_finalidade_nfe] = :a043_finalidade_nfe, ' + 
				' [a043_mod_base_calculo] = :a043_mod_base_calculo, ' + 
				' [a043_mod_base_calculo_substituicao] = :a043_mod_base_calculo_substituicao, ' + 
				' [a043_situacao_tributaria_cofins] = :a043_situacao_tributaria_cofins, ' + 
				' [a043_situacao_tributaria_pis] = :a043_situacao_tributaria_pis, ' + 
				' [a043_base_calculo_cofins] = :a043_base_calculo_cofins, ' + 
				' [a043_base_calculo_frete] = :a043_base_calculo_frete, ' + 
				' [a043_aliquota_frete] = :a043_aliquota_frete, ' + 
				' [a043_obs_fiscal] = :a043_obs_fiscal, ' + 
				' [a043_obs_contribuinte] = :a043_obs_contribuinte, ' + 
				' [a043_base_calculo_pis] = :a043_base_calculo_pis, ' + 
				' [a043_margem_subst_tributaria] = :a043_margem_subst_tributaria, ' + 
				' [a043_perc_red_base_cal_substituicao] = :a043_perc_red_base_cal_substituicao, ' + 
				' [a043_preco_produto] = :a043_preco_produto, ' + 
				' [a043_permite_nf] = :a043_permite_nf, ' + 
				' [a043_issqn] = :a043_issqn, ' + 
				' [a043_bc_ipi] = :a043_bc_ipi, ' + 
				' [a043_mot_desoneracao] = :a043_mot_desoneracao, ' + 
				' [a043_exige_nf_prod] = :a043_exige_nf_prod, ' + 
				' [a043_vinculo_doc_fiscal] = :a043_vinculo_doc_fiscal, ' + 
				' [a043_funrural_ent_sai] = :a043_funrural_ent_sai, ' + 
				' [a043_escrita] = :a043_escrita, ' + 
				' [a043_ajuste_credito] = :a043_ajuste_credito, ' + 
				' [a043_mensagem_nf_01] = :a043_mensagem_nf_01, ' + 
				' [a043_tab_pis] = :a043_tab_pis, ' + 
				' [a043_per_pis_socio] = :a043_per_pis_socio, ' + 
				' [a043_base_pis_socio] = :a043_base_pis_socio, ' + 
				' [a043_tab_cofins] = :a043_tab_cofins, ' + 
				' [a043_per_cofins_socio] = :a043_per_cofins_socio, ' + 
				' [a043_base_cofins_socio] = :a043_base_cofins_socio, ' + 
				' [a043_cod_Enq_ipi] = :a043_cod_Enq_ipi, ' + 
				' [a043_cst_ipi] = :a043_cst_ipi, ' + 
				' [a043_usa_trib_pis] = :a043_usa_trib_pis, ' + 
				' [a043_p_senar] = :a043_p_senar, ' + 
				' [a043_bc_senar] = :a043_bc_senar, ' + 
				' [a043_usa_produtos] = :a043_usa_produtos, ' + 
				' [a043_cod_aj_apuracao_deducao] = :a043_cod_aj_apuracao_deducao, ' + 
				' [a043_cod_ocorrencia_aj_icms] = :a043_cod_ocorrencia_aj_icms, ' + 
				' [a043_cod_reflexo_apur_icms] = :a043_cod_reflexo_apur_icms, ' + 
				' [a043_cod_tipo_apuracao] = :a043_cod_tipo_apuracao, ' + 
				' [a043_cod_responsabilidade] = :a043_cod_responsabilidade, ' + 
				' [a043_cod_influencia_recolhimento] = :a043_cod_influencia_recolhimento, ' + 
				' [a043_cod_origem_tributacao] = :a043_cod_origem_tributacao, ' + 
				' [a043_cod_aj_icms_ex_icms] = :a043_cod_aj_icms_ex_icms, ' + 
				' [a043_cod_obrigacao_a_recolher] = :a043_cod_obrigacao_a_recolher, ' + 
				' [a043_cod_tipo_utilizacao_credito] = :a043_cod_tipo_utilizacao_credito, ' + 
				' [a043_ajuste_debito] = :a043_ajuste_debito, ' + 
				' [a043_cod_tipo_credito] = :a043_cod_tipo_credito, ' + 
				' [a043_usa_senar] = :a043_usa_senar, ' + 
				' [a043_usuario] = :a043_usuario, ' + 
				' [a043_datetime] = :a043_datetime, ' + 
				' [a043_pCredSN] = :a043_pCredSN, ' + 
				' [a043_gera_sped] = :a043_gera_sped, ' + 
				' [a043_permite_ibpt] = :a043_permite_ibpt, ' + 
				' [a043_depreciacao_anual] = :a043_depreciacao_anual, ' + 
				' [a043_percentual_residual] = :a043_percentual_residual, ' + 
				' [a043_usa_funrural] = :a043_usa_funrural, ' + 
				' [a043_pDif] = :a043_pDif, ' + 
				' [a043_pMVAST] = :a043_pMVAST, ' + 
				' [a043_pEntMVAST] = :a043_pEntMVAST, ' + 
				' [a043_AliqIntST] = :a043_AliqIntST, ' + 
				' [a043_AliqST] = :a043_AliqST, ' + 
				' [a043_envia_deposito] = :a043_envia_deposito, ' + 
				' [a043_tipo_preco] = :a043_tipo_preco, ' + 
				' [a043_pBCFCP] = :a043_pBCFCP, ' + 
				' [a043_pFCP] = :a043_pFCP, ' + 
				' [a043_pBCFCPST] = :a043_pBCFCPST, ' + 
				' [a043_pFCPST] = :a043_pFCPST, ' + 
				' [a043_pBCFCPRet] = :a043_pBCFCPRet, ' + 
				' [a043_pFCPRet] = :a043_pFCPRet, ' + 
				' [a043_pST] = :a043_pST, ' + 
				' [a043_usa_FCP] = :a043_usa_FCP, ' + 
				' [a043_usa_trib_serv] = :a043_usa_trib_serv, ' + 
				' [a043_red_bc_csll] = :a043_red_bc_csll, ' + 
				' [a043_perc_csll] = :a043_perc_csll, ' + 
				' [a043_red_bc_irrf] = :a043_red_bc_irrf, ' + 
				' [a043_perc_irrf] = :a043_perc_irrf, ' + 
				' [a043_red_bc_inss] = :a043_red_bc_inss, ' + 
				' [a043_perc_inss] = :a043_perc_inss, ' + 
				' [a043_bc_ret] = :a043_bc_ret, ' + 
				' [a043_aliq_ret] = :a043_aliq_ret, ' + 
				' [a043_bc_ret_sub] = :a043_bc_ret_sub, ' + 
				' [a043_aliq_ret_sub] = :a043_aliq_ret_sub, ' + 
				' [a043_perc_nret_princ] = :a043_perc_nret_princ, ' + 
				' [a043_perc_ret_15] = :a043_perc_ret_15, ' + 
				' [a043_perc_ret_20] = :a043_perc_ret_20, ' + 
				' [a043_perc_ret_25] = :a043_perc_ret_25, ' + 
				' [a043_perc_nret_adic] = :a043_perc_nret_adic, ' + 
				' [a043_v_bc_st_ret_opc] = :a043_v_bc_st_ret_opc, ' + 
				' [a043_p_st_opc] = :a043_p_st_opc, ' + 
				' [a043_v_icms_substituto_opc] = :a043_v_icms_substituto_opc, ' + 
				' [a043_v_icms_st_ret_opc] = :a043_v_icms_st_ret_opc, ' + 
				' [a043_v_bc_fcp_st_ret_opc] = :a043_v_bc_fcp_st_ret_opc, ' + 
				' [a043_p_fcp_st_ret_opc] = :a043_p_fcp_st_ret_opc, ' + 
				' [a043_v_fcp_st_ret_opc] = :a043_v_fcp_st_ret_opc, ' + 
				' [a043_p_red_bc_efet_opc] = :a043_p_red_bc_efet_opc, ' + 
				' [a043_v_bc_efet_opc] = :a043_v_bc_efet_opc, ' + 
				' [a043_p_icms_efet_opc] = :a043_p_icms_efet_opc, ' + 
				' [a043_v_icms_efet_opc] = :a043_v_icms_efet_opc, ' + 
				' [a043_v_bc_st_dest_opc] = :a043_v_bc_st_dest_opc, ' + 
				' [a043_v_icms_st_dest_opc] = :a043_v_icms_st_dest_opc, ' + 
				' [a043_v_bc_uf_dest] = :a043_v_bc_uf_dest, ' + 
				' [a043_v_bc_fcp_uf_dest_opc] = :a043_v_bc_fcp_uf_dest_opc, ' + 
				' [a043_p_fcp_uf_dest_opc] = :a043_p_fcp_uf_dest_opc, ' + 
				' [a043_p_icms_uf_dest] = :a043_p_icms_uf_dest, ' + 
				' [a043_p_icms_inter] = :a043_p_icms_inter, ' + 
				' [a043_p_icms_inter_part] = :a043_p_icms_inter_part, ' + 
				' [a043_v_fcp_uf_dest_opc] = :a043_v_fcp_uf_dest_opc, ' + 
				' [a043_v_icms_uf_dest] = :a043_v_icms_uf_dest, ' + 
				' [a043_v_icms_uf_remet] = :a043_v_icms_uf_remet, ' + 
				' [a043_usa_cfop] = :a043_usa_cfop, ' + 
				' [a043_ibs] = :a043_ibs, ' + 
				' [a043_ibs_aliquota] = :a043_ibs_aliquota, ' + 
				' [a043_ibs_base_calc] = :a043_ibs_base_calc, ' + 
				' [a043_iss] = :a043_iss, ' + 
				' [a043_iss_aliquota] = :a043_iss_aliquota, ' + 
				' [a043_iss_base_calc] = :a043_iss_base_calc, ' + 
				' [a043_cbs] = :a043_cbs, ' + 
				' [a043_cbs_aliquota] = :a043_cbs_aliquota, ' + 
				' [a043_cbs_base_calc] = :a043_cbs_base_calc, ' + 
				' [a043_cod_iva] = :a043_cod_iva, ' + 
				' [a043_cod_cidade] = :a043_cod_cidade, ' + 
				' [a043_cst_ibs] = :a043_cst_ibs, ' + 
				' [a043_cst_iss] = :a043_cst_iss, ' + 
				' [a043_cst_cbs] = :a043_cst_cbs  ' + 
				'WHERE [a043_codigo] = :a043_codigo ';
begin
	Result := SQL_ATUALIZAR;
end;

procedure TesDAO.ObjetoParaQuery;
begin
	oQuery.Parameters.ParamByName('a043_sequencial').Value := oObjeto.iSequencial;
	oQuery.Parameters.ParamByName('a043_descricao').Value := oObjeto.sDescricao;
	oQuery.Parameters.ParamByName('a043_codigo_fiscal').Value := oObjeto.sCodigoFiscal;
	oQuery.Parameters.ParamByName('a043_tipo_tes').Value := oObjeto.sTipoTes;
	oQuery.Parameters.ParamByName('a043_atualiza_est').Value := oObjeto.sAtualizaEst;
	oQuery.Parameters.ParamByName('a043_gera_financeiro').Value := oObjeto.sGeraFinanceiro;
	oQuery.Parameters.ParamByName('a043_estado').Value := oObjeto.sEstado;
	oQuery.Parameters.ParamByName('a043_obs').Value := oObjeto.sObs;
	oQuery.Parameters.ParamByName('a043_mov_cta_capital').Value := oObjeto.sMovCtaCapital;
	oQuery.Parameters.ParamByName('a043_mov_cta_socio').Value := oObjeto.sMovCtaSocio;
	oQuery.Parameters.ParamByName('a043_mov_desp_secagem').Value := oObjeto.sMovDespSecagem;
	oQuery.Parameters.ParamByName('a043_especie_pessoa').Value := oObjeto.sEspeciePessoa;
	oQuery.Parameters.ParamByName('a043_cat_pessoa').Value := oObjeto.sCatPessoa;
	oQuery.Parameters.ParamByName('a043_tributacao').Value := oObjeto.sTributacao;
	oQuery.Parameters.ParamByName('a043_base_calc_icm').Value := oObjeto.cBaseCalcIcm;
	oQuery.Parameters.ParamByName('a043_icm').Value := oObjeto.cIcm;
	oQuery.Parameters.ParamByName('a043_cod_sit_trib').Value := oObjeto.sCodSitTrib;
	oQuery.Parameters.ParamByName('a043_mensagem_nf').Value := oObjeto.sMensagemNf;
	oQuery.Parameters.ParamByName('a043_utiliza_preco_pauta').Value := oObjeto.sUtilizaPrecoPauta;
	oQuery.Parameters.ParamByName('a043_funrural').Value := oObjeto.cFunrural;
	oQuery.Parameters.ParamByName('a043_pis').Value := oObjeto.cPis;
	oQuery.Parameters.ParamByName('a043_cofins').Value := oObjeto.cCofins;
	oQuery.Parameters.ParamByName('a043_ipi').Value := oObjeto.cIpi;
	oQuery.Parameters.ParamByName('a043_desc_cfop').Value := oObjeto.sDescCfop;
	oQuery.Parameters.ParamByName('a043_cod_pessoa').Value := oObjeto.sCodPessoa;
	oQuery.Parameters.ParamByName('a043_operacao_tes').Value := oObjeto.sOperacaoTes;
	oQuery.Parameters.ParamByName('a043_mov_custo').Value := oObjeto.sMovCusto;
	oQuery.Parameters.ParamByName('a043_cod_tes_estorno').Value := oObjeto.sCodTesEstorno;
	oQuery.Parameters.ParamByName('a043_cod_col_mapa').Value := oObjeto.sCodColMapa;
	oQuery.Parameters.ParamByName('a043_finalidade_nfe').Value := oObjeto.sFinalidadeNfe;
	oQuery.Parameters.ParamByName('a043_mod_base_calculo').Value := oObjeto.sModBaseCalculo;
	oQuery.Parameters.ParamByName('a043_mod_base_calculo_substituicao').Value := oObjeto.sModBaseCalculoSubstituicao;
	oQuery.Parameters.ParamByName('a043_situacao_tributaria_cofins').Value := oObjeto.sSituacaoTributariaCofins;
	oQuery.Parameters.ParamByName('a043_situacao_tributaria_pis').Value := oObjeto.sSituacaoTributariaPis;
	oQuery.Parameters.ParamByName('a043_base_calculo_cofins').Value := oObjeto.cBaseCalculoCofins;
	oQuery.Parameters.ParamByName('a043_base_calculo_frete').Value := oObjeto.sBaseCalculoFrete;
	oQuery.Parameters.ParamByName('a043_aliquota_frete').Value := oObjeto.sAliquotaFrete;
	oQuery.Parameters.ParamByName('a043_obs_fiscal').Value := oObjeto.sObsFiscal;
	oQuery.Parameters.ParamByName('a043_obs_contribuinte').Value := oObjeto.sObsContribuinte;
	oQuery.Parameters.ParamByName('a043_base_calculo_pis').Value := oObjeto.cBaseCalculoPis;
	oQuery.Parameters.ParamByName('a043_margem_subst_tributaria').Value := oObjeto.cMargemSubstTributaria;
	oQuery.Parameters.ParamByName('a043_perc_red_base_cal_substituicao').Value := oObjeto.cPercRedBaseCalSubstituicao;
	oQuery.Parameters.ParamByName('a043_preco_produto').Value := oObjeto.sPrecoProduto;
	oQuery.Parameters.ParamByName('a043_permite_nf').Value := oObjeto.sPermiteNf;
	oQuery.Parameters.ParamByName('a043_issqn').Value := oObjeto.cIssqn;
	oQuery.Parameters.ParamByName('a043_bc_ipi').Value := oObjeto.cBcIpi;
	oQuery.Parameters.ParamByName('a043_mot_desoneracao').Value := oObjeto.sMotDesoneracao;
	oQuery.Parameters.ParamByName('a043_exige_nf_prod').Value := oObjeto.sExigeNfProd;
	oQuery.Parameters.ParamByName('a043_vinculo_doc_fiscal').Value := oObjeto.sVinculoDocFiscal;
	oQuery.Parameters.ParamByName('a043_funrural_ent_sai').Value := oObjeto.sFunruralEntSai;
	oQuery.Parameters.ParamByName('a043_escrita').Value := oObjeto.sEscrita;
	oQuery.Parameters.ParamByName('a043_ajuste_credito').Value := oObjeto.sAjusteCredito;
	oQuery.Parameters.ParamByName('a043_mensagem_nf_01').Value := oObjeto.sMensagemNf01;
	oQuery.Parameters.ParamByName('a043_tab_pis').Value := oObjeto.sTabPis;
	oQuery.Parameters.ParamByName('a043_per_pis_socio').Value := oObjeto.cPerPisSocio;
	oQuery.Parameters.ParamByName('a043_base_pis_socio').Value := oObjeto.cBasePisSocio;
	oQuery.Parameters.ParamByName('a043_tab_cofins').Value := oObjeto.sTabCofins;
	oQuery.Parameters.ParamByName('a043_per_cofins_socio').Value := oObjeto.cPerCofinsSocio;
	oQuery.Parameters.ParamByName('a043_base_cofins_socio').Value := oObjeto.cBaseCofinsSocio;
	oQuery.Parameters.ParamByName('a043_cod_Enq_ipi').Value := oObjeto.iCodEnqIpi;
	oQuery.Parameters.ParamByName('a043_cst_ipi').Value := oObjeto.sCstIpi;
	oQuery.Parameters.ParamByName('a043_usa_trib_pis').Value := oObjeto.sUsaTribPis;
	oQuery.Parameters.ParamByName('a043_p_senar').Value := oObjeto.cPSenar;
	oQuery.Parameters.ParamByName('a043_bc_senar').Value := oObjeto.cBcSenar;
	oQuery.Parameters.ParamByName('a043_usa_produtos').Value := oObjeto.sUsaProdutos;
	oQuery.Parameters.ParamByName('a043_cod_aj_apuracao_deducao').Value := oObjeto.sCodAjApuracaoDeducao;
	oQuery.Parameters.ParamByName('a043_cod_ocorrencia_aj_icms').Value := oObjeto.sCodOcorrenciaAjIcms;
	oQuery.Parameters.ParamByName('a043_cod_reflexo_apur_icms').Value := oObjeto.sCodReflexoApurIcms;
	oQuery.Parameters.ParamByName('a043_cod_tipo_apuracao').Value := oObjeto.sCodTipoApuracao;
	oQuery.Parameters.ParamByName('a043_cod_responsabilidade').Value := oObjeto.sCodResponsabilidade;
	oQuery.Parameters.ParamByName('a043_cod_influencia_recolhimento').Value := oObjeto.sCodInfluenciaRecolhimento;
	oQuery.Parameters.ParamByName('a043_cod_origem_tributacao').Value := oObjeto.sCodOrigemTributacao;
	oQuery.Parameters.ParamByName('a043_cod_aj_icms_ex_icms').Value := oObjeto.sCodAjIcmsExIcms;
	oQuery.Parameters.ParamByName('a043_cod_obrigacao_a_recolher').Value := oObjeto.sCodObrigacaoARecolher;
	oQuery.Parameters.ParamByName('a043_cod_tipo_utilizacao_credito').Value := oObjeto.sCodTipoUtilizacaoCredito;
	oQuery.Parameters.ParamByName('a043_ajuste_debito').Value := oObjeto.sAjusteDebito;
	oQuery.Parameters.ParamByName('a043_cod_tipo_credito').Value := oObjeto.sCodTipoCredito;
	oQuery.Parameters.ParamByName('a043_usa_senar').Value := oObjeto.sUsaSenar;
	oQuery.Parameters.ParamByName('a043_usuario').Value := oObjeto.sUsuario;
	oQuery.Parameters.ParamByName('a043_datetime').Value := oObjeto.dDatetime;
	oQuery.Parameters.ParamByName('a043_pCredSN').Value := oObjeto.cPcredsn;
	oQuery.Parameters.ParamByName('a043_gera_sped').Value := oObjeto.sGeraSped;
	oQuery.Parameters.ParamByName('a043_permite_ibpt').Value := oObjeto.sPermiteIbpt;
	oQuery.Parameters.ParamByName('a043_depreciacao_anual').Value := oObjeto.cDepreciacaoAnual;
	oQuery.Parameters.ParamByName('a043_percentual_residual').Value := oObjeto.cPercentualResidual;
	oQuery.Parameters.ParamByName('a043_usa_funrural').Value := oObjeto.sUsaFunrural;
	oQuery.Parameters.ParamByName('a043_pDif').Value := oObjeto.cPdif;
	oQuery.Parameters.ParamByName('a043_pMVAST').Value := oObjeto.cPmvast;
	oQuery.Parameters.ParamByName('a043_pEntMVAST').Value := oObjeto.cPentmvast;
	oQuery.Parameters.ParamByName('a043_AliqIntST').Value := oObjeto.cAliqintst;
	oQuery.Parameters.ParamByName('a043_AliqST').Value := oObjeto.cAliqst;
	oQuery.Parameters.ParamByName('a043_envia_deposito').Value := oObjeto.sEnviaDeposito;
	oQuery.Parameters.ParamByName('a043_tipo_preco').Value := oObjeto.sTipoPreco;
	oQuery.Parameters.ParamByName('a043_pBCFCP').Value := oObjeto.cPbcfcp;
	oQuery.Parameters.ParamByName('a043_pFCP').Value := oObjeto.cPfcp;
	oQuery.Parameters.ParamByName('a043_pBCFCPST').Value := oObjeto.cPbcfcpst;
	oQuery.Parameters.ParamByName('a043_pFCPST').Value := oObjeto.cPfcpst;
	oQuery.Parameters.ParamByName('a043_pBCFCPRet').Value := oObjeto.cPbcfcpret;
	oQuery.Parameters.ParamByName('a043_pFCPRet').Value := oObjeto.cPfcpret;
	oQuery.Parameters.ParamByName('a043_pST').Value := oObjeto.cPst;
	oQuery.Parameters.ParamByName('a043_usa_FCP').Value := oObjeto.sUsaFcp;
	oQuery.Parameters.ParamByName('a043_usa_trib_serv').Value := oObjeto.sUsaTribServ;
	oQuery.Parameters.ParamByName('a043_red_bc_csll').Value := oObjeto.cRedBcCsll;
	oQuery.Parameters.ParamByName('a043_perc_csll').Value := oObjeto.cPercCsll;
	oQuery.Parameters.ParamByName('a043_red_bc_irrf').Value := oObjeto.cRedBcIrrf;
	oQuery.Parameters.ParamByName('a043_perc_irrf').Value := oObjeto.cPercIrrf;
	oQuery.Parameters.ParamByName('a043_red_bc_inss').Value := oObjeto.cRedBcInss;
	oQuery.Parameters.ParamByName('a043_perc_inss').Value := oObjeto.cPercInss;
	oQuery.Parameters.ParamByName('a043_bc_ret').Value := oObjeto.cBcRet;
	oQuery.Parameters.ParamByName('a043_aliq_ret').Value := oObjeto.cAliqRet;
	oQuery.Parameters.ParamByName('a043_bc_ret_sub').Value := oObjeto.cBcRetSub;
	oQuery.Parameters.ParamByName('a043_aliq_ret_sub').Value := oObjeto.cAliqRetSub;
	oQuery.Parameters.ParamByName('a043_perc_nret_princ').Value := oObjeto.cPercNretPrinc;
	oQuery.Parameters.ParamByName('a043_perc_ret_15').Value := oObjeto.cPercRet15;
	oQuery.Parameters.ParamByName('a043_perc_ret_20').Value := oObjeto.cPercRet20;
	oQuery.Parameters.ParamByName('a043_perc_ret_25').Value := oObjeto.cPercRet25;
	oQuery.Parameters.ParamByName('a043_perc_nret_adic').Value := oObjeto.cPercNretAdic;
	oQuery.Parameters.ParamByName('a043_v_bc_st_ret_opc').Value := oObjeto.cVBcStRetOpc;
	oQuery.Parameters.ParamByName('a043_p_st_opc').Value := oObjeto.cPStOpc;
	oQuery.Parameters.ParamByName('a043_v_icms_substituto_opc').Value := oObjeto.cVIcmsSubstitutoOpc;
	oQuery.Parameters.ParamByName('a043_v_icms_st_ret_opc').Value := oObjeto.cVIcmsStRetOpc;
	oQuery.Parameters.ParamByName('a043_v_bc_fcp_st_ret_opc').Value := oObjeto.cVBcFcpStRetOpc;
	oQuery.Parameters.ParamByName('a043_p_fcp_st_ret_opc').Value := oObjeto.cPFcpStRetOpc;
	oQuery.Parameters.ParamByName('a043_v_fcp_st_ret_opc').Value := oObjeto.cVFcpStRetOpc;
	oQuery.Parameters.ParamByName('a043_p_red_bc_efet_opc').Value := oObjeto.cPRedBcEfetOpc;
	oQuery.Parameters.ParamByName('a043_v_bc_efet_opc').Value := oObjeto.cVBcEfetOpc;
	oQuery.Parameters.ParamByName('a043_p_icms_efet_opc').Value := oObjeto.cPIcmsEfetOpc;
	oQuery.Parameters.ParamByName('a043_v_icms_efet_opc').Value := oObjeto.cVIcmsEfetOpc;
	oQuery.Parameters.ParamByName('a043_v_bc_st_dest_opc').Value := oObjeto.cVBcStDestOpc;
	oQuery.Parameters.ParamByName('a043_v_icms_st_dest_opc').Value := oObjeto.cVIcmsStDestOpc;
	oQuery.Parameters.ParamByName('a043_v_bc_uf_dest').Value := oObjeto.cVBcUfDest;
	oQuery.Parameters.ParamByName('a043_v_bc_fcp_uf_dest_opc').Value := oObjeto.cVBcFcpUfDestOpc;
	oQuery.Parameters.ParamByName('a043_p_fcp_uf_dest_opc').Value := oObjeto.cPFcpUfDestOpc;
	oQuery.Parameters.ParamByName('a043_p_icms_uf_dest').Value := oObjeto.cPIcmsUfDest;
	oQuery.Parameters.ParamByName('a043_p_icms_inter').Value := oObjeto.cPIcmsInter;
	oQuery.Parameters.ParamByName('a043_p_icms_inter_part').Value := oObjeto.cPIcmsInterPart;
	oQuery.Parameters.ParamByName('a043_v_fcp_uf_dest_opc').Value := oObjeto.cVFcpUfDestOpc;
	oQuery.Parameters.ParamByName('a043_v_icms_uf_dest').Value := oObjeto.cVIcmsUfDest;
	oQuery.Parameters.ParamByName('a043_v_icms_uf_remet').Value := oObjeto.cVIcmsUfRemet;
	oQuery.Parameters.ParamByName('a043_usa_cfop').Value := oObjeto.sUsaCfop;
	oQuery.Parameters.ParamByName('a043_ibs').Value := oObjeto.sIbs;
	oQuery.Parameters.ParamByName('a043_ibs_aliquota').Value := oObjeto.cIbsAliquota;
	oQuery.Parameters.ParamByName('a043_ibs_base_calc').Value := oObjeto.cIbsBaseCalc;
	oQuery.Parameters.ParamByName('a043_iss').Value := oObjeto.sIss;
	oQuery.Parameters.ParamByName('a043_iss_aliquota').Value := oObjeto.cIssAliquota;
	oQuery.Parameters.ParamByName('a043_iss_base_calc').Value := oObjeto.cIssBaseCalc;
	oQuery.Parameters.ParamByName('a043_cbs').Value := oObjeto.sCbs;
	oQuery.Parameters.ParamByName('a043_cbs_aliquota').Value := oObjeto.cCbsAliquota;
	oQuery.Parameters.ParamByName('a043_cbs_base_calc').Value := oObjeto.cCbsBaseCalc;
	oQuery.Parameters.ParamByName('a043_cod_iva').Value := oObjeto.sCodIva;
	oQuery.Parameters.ParamByName('a043_cod_cidade').Value := oObjeto.sCodCidade;
	oQuery.Parameters.ParamByName('a043_cst_ibs').Value := oObjeto.sCstIbs;
	oQuery.Parameters.ParamByName('a043_cst_iss').Value := oObjeto.sCstIss;
	oQuery.Parameters.ParamByName('a043_cst_cbs').Value := oObjeto.sCstCbs;

	if bSetarCodSeq then
	begin
		oQuery.Parameters.ParamByName('a043_codigo').Value := oObjeto.sCodigo;
			oQuery.Parameters.ParamByName('a043_sequencial').Value := oObjeto.iSequencial;
	end;
end;

function TesDAO.SubLinhaParaObjeto;
var
	oObjeto: TTes;
begin
	oObjeto := nil;
	try
		oObjeto := TTes.Create();
		oObjeto.sCodigo := oFields.FieldByName('a043_codigo').AsString;
		oObjeto.iSequencial := oFields.FieldByName('a043_sequencial').AsLargeInt;
		oObjeto.sDescricao := oFields.FieldByName('a043_descricao').AsString;
		oObjeto.sCodigoFiscal := oFields.FieldByName('a043_codigo_fiscal').AsString;
		oObjeto.sTipoTes := oFields.FieldByName('a043_tipo_tes').AsString;
		oObjeto.sAtualizaEst := oFields.FieldByName('a043_atualiza_est').AsString;
		oObjeto.sGeraFinanceiro := oFields.FieldByName('a043_gera_financeiro').AsString;
		oObjeto.sEstado := oFields.FieldByName('a043_estado').AsString;
		oObjeto.sObs := oFields.FieldByName('a043_obs').AsString;
		oObjeto.sMovCtaCapital := oFields.FieldByName('a043_mov_cta_capital').AsString;
		oObjeto.sMovCtaSocio := oFields.FieldByName('a043_mov_cta_socio').AsString;
		oObjeto.sMovDespSecagem := oFields.FieldByName('a043_mov_desp_secagem').AsString;
		oObjeto.sEspeciePessoa := oFields.FieldByName('a043_especie_pessoa').AsString;
		oObjeto.sCatPessoa := oFields.FieldByName('a043_cat_pessoa').AsString;
		oObjeto.sTributacao := oFields.FieldByName('a043_tributacao').AsString;
		oObjeto.cBaseCalcIcm := oFields.FieldByName('a043_base_calc_icm').AsCurrency;
		oObjeto.cIcm := oFields.FieldByName('a043_icm').AsCurrency;
		oObjeto.sCodSitTrib := oFields.FieldByName('a043_cod_sit_trib').AsString;
		oObjeto.sMensagemNf := oFields.FieldByName('a043_mensagem_nf').AsString;
		oObjeto.sUtilizaPrecoPauta := oFields.FieldByName('a043_utiliza_preco_pauta').AsString;
		oObjeto.cFunrural := oFields.FieldByName('a043_funrural').AsCurrency;
		oObjeto.cPis := oFields.FieldByName('a043_pis').AsCurrency;
		oObjeto.cCofins := oFields.FieldByName('a043_cofins').AsCurrency;
		oObjeto.cIpi := oFields.FieldByName('a043_ipi').AsCurrency;
		oObjeto.sDescCfop := oFields.FieldByName('a043_desc_cfop').AsString;
		oObjeto.sCodPessoa := oFields.FieldByName('a043_cod_pessoa').AsString;
		oObjeto.sOperacaoTes := oFields.FieldByName('a043_operacao_tes').AsString;
		oObjeto.sMovCusto := oFields.FieldByName('a043_mov_custo').AsString;
		oObjeto.sCodTesEstorno := oFields.FieldByName('a043_cod_tes_estorno').AsString;
		oObjeto.sCodColMapa := oFields.FieldByName('a043_cod_col_mapa').AsString;
		oObjeto.sFinalidadeNfe := oFields.FieldByName('a043_finalidade_nfe').AsString;
		oObjeto.sModBaseCalculo := oFields.FieldByName('a043_mod_base_calculo').AsString;
		oObjeto.sModBaseCalculoSubstituicao := oFields.FieldByName('a043_mod_base_calculo_substituicao').AsString;
		oObjeto.sSituacaoTributariaCofins := oFields.FieldByName('a043_situacao_tributaria_cofins').AsString;
		oObjeto.sSituacaoTributariaPis := oFields.FieldByName('a043_situacao_tributaria_pis').AsString;
		oObjeto.cBaseCalculoCofins := oFields.FieldByName('a043_base_calculo_cofins').AsCurrency;
		oObjeto.sBaseCalculoFrete := oFields.FieldByName('a043_base_calculo_frete').AsString;
		oObjeto.sAliquotaFrete := oFields.FieldByName('a043_aliquota_frete').AsString;
		oObjeto.sObsFiscal := oFields.FieldByName('a043_obs_fiscal').AsString;
		oObjeto.sObsContribuinte := oFields.FieldByName('a043_obs_contribuinte').AsString;
		oObjeto.cBaseCalculoPis := oFields.FieldByName('a043_base_calculo_pis').AsCurrency;
		oObjeto.cMargemSubstTributaria := oFields.FieldByName('a043_margem_subst_tributaria').AsCurrency;
		oObjeto.cPercRedBaseCalSubstituicao := oFields.FieldByName('a043_perc_red_base_cal_substituicao').AsCurrency;
		oObjeto.sPrecoProduto := oFields.FieldByName('a043_preco_produto').AsString;
		oObjeto.sPermiteNf := oFields.FieldByName('a043_permite_nf').AsString;
		oObjeto.cIssqn := oFields.FieldByName('a043_issqn').AsCurrency;
		oObjeto.cBcIpi := oFields.FieldByName('a043_bc_ipi').AsCurrency;
		oObjeto.sMotDesoneracao := oFields.FieldByName('a043_mot_desoneracao').AsString;
		oObjeto.sExigeNfProd := oFields.FieldByName('a043_exige_nf_prod').AsString;
		oObjeto.sVinculoDocFiscal := oFields.FieldByName('a043_vinculo_doc_fiscal').AsString;
		oObjeto.sFunruralEntSai := oFields.FieldByName('a043_funrural_ent_sai').AsString;
		oObjeto.sEscrita := oFields.FieldByName('a043_escrita').AsString;
		oObjeto.sAjusteCredito := oFields.FieldByName('a043_ajuste_credito').AsString;
		oObjeto.sMensagemNf01 := oFields.FieldByName('a043_mensagem_nf_01').AsString;
		oObjeto.sTabPis := oFields.FieldByName('a043_tab_pis').AsString;
		oObjeto.cPerPisSocio := oFields.FieldByName('a043_per_pis_socio').AsCurrency;
		oObjeto.cBasePisSocio := oFields.FieldByName('a043_base_pis_socio').AsCurrency;
		oObjeto.sTabCofins := oFields.FieldByName('a043_tab_cofins').AsString;
		oObjeto.cPerCofinsSocio := oFields.FieldByName('a043_per_cofins_socio').AsCurrency;
		oObjeto.cBaseCofinsSocio := oFields.FieldByName('a043_base_cofins_socio').AsCurrency;
		oObjeto.iCodEnqIpi := oFields.FieldByName('a043_cod_Enq_ipi').AsInteger;
		oObjeto.sCstIpi := oFields.FieldByName('a043_cst_ipi').AsString;
		oObjeto.sUsaTribPis := oFields.FieldByName('a043_usa_trib_pis').AsString;
		oObjeto.cPSenar := oFields.FieldByName('a043_p_senar').AsCurrency;
		oObjeto.cBcSenar := oFields.FieldByName('a043_bc_senar').AsCurrency;
		oObjeto.sUsaProdutos := oFields.FieldByName('a043_usa_produtos').AsString;
		oObjeto.sCodAjApuracaoDeducao := oFields.FieldByName('a043_cod_aj_apuracao_deducao').AsString;
		oObjeto.sCodOcorrenciaAjIcms := oFields.FieldByName('a043_cod_ocorrencia_aj_icms').AsString;
		oObjeto.sCodReflexoApurIcms := oFields.FieldByName('a043_cod_reflexo_apur_icms').AsString;
		oObjeto.sCodTipoApuracao := oFields.FieldByName('a043_cod_tipo_apuracao').AsString;
		oObjeto.sCodResponsabilidade := oFields.FieldByName('a043_cod_responsabilidade').AsString;
		oObjeto.sCodInfluenciaRecolhimento := oFields.FieldByName('a043_cod_influencia_recolhimento').AsString;
		oObjeto.sCodOrigemTributacao := oFields.FieldByName('a043_cod_origem_tributacao').AsString;
		oObjeto.sCodAjIcmsExIcms := oFields.FieldByName('a043_cod_aj_icms_ex_icms').AsString;
		oObjeto.sCodObrigacaoARecolher := oFields.FieldByName('a043_cod_obrigacao_a_recolher').AsString;
		oObjeto.sCodTipoUtilizacaoCredito := oFields.FieldByName('a043_cod_tipo_utilizacao_credito').AsString;
		oObjeto.sAjusteDebito := oFields.FieldByName('a043_ajuste_debito').AsString;
		oObjeto.sCodTipoCredito := oFields.FieldByName('a043_cod_tipo_credito').AsString;
		oObjeto.sUsaSenar := oFields.FieldByName('a043_usa_senar').AsString;
		oObjeto.sUsuario := oFields.FieldByName('a043_usuario').AsString;
		oObjeto.dDatetime := oFields.FieldByName('a043_datetime').AsDateTime;
		oObjeto.cPcredsn := oFields.FieldByName('a043_pCredSN').AsCurrency;
		oObjeto.sGeraSped := oFields.FieldByName('a043_gera_sped').AsString;
		oObjeto.sPermiteIbpt := oFields.FieldByName('a043_permite_ibpt').AsString;
		oObjeto.cDepreciacaoAnual := oFields.FieldByName('a043_depreciacao_anual').AsCurrency;
		oObjeto.cPercentualResidual := oFields.FieldByName('a043_percentual_residual').AsCurrency;
		oObjeto.sUsaFunrural := oFields.FieldByName('a043_usa_funrural').AsString;
		oObjeto.cPdif := oFields.FieldByName('a043_pDif').AsCurrency;
		oObjeto.cPmvast := oFields.FieldByName('a043_pMVAST').AsCurrency;
		oObjeto.cPentmvast := oFields.FieldByName('a043_pEntMVAST').AsCurrency;
		oObjeto.cAliqintst := oFields.FieldByName('a043_AliqIntST').AsCurrency;
		oObjeto.cAliqst := oFields.FieldByName('a043_AliqST').AsCurrency;
		oObjeto.sEnviaDeposito := oFields.FieldByName('a043_envia_deposito').AsString;
		oObjeto.sTipoPreco := oFields.FieldByName('a043_tipo_preco').AsString;
		oObjeto.cPbcfcp := oFields.FieldByName('a043_pBCFCP').AsCurrency;
		oObjeto.cPfcp := oFields.FieldByName('a043_pFCP').AsCurrency;
		oObjeto.cPbcfcpst := oFields.FieldByName('a043_pBCFCPST').AsCurrency;
		oObjeto.cPfcpst := oFields.FieldByName('a043_pFCPST').AsCurrency;
		oObjeto.cPbcfcpret := oFields.FieldByName('a043_pBCFCPRet').AsCurrency;
		oObjeto.cPfcpret := oFields.FieldByName('a043_pFCPRet').AsCurrency;
		oObjeto.cPst := oFields.FieldByName('a043_pST').AsCurrency;
		oObjeto.sUsaFcp := oFields.FieldByName('a043_usa_FCP').AsString;
		oObjeto.sUsaTribServ := oFields.FieldByName('a043_usa_trib_serv').AsString;
		oObjeto.cRedBcCsll := oFields.FieldByName('a043_red_bc_csll').AsCurrency;
		oObjeto.cPercCsll := oFields.FieldByName('a043_perc_csll').AsCurrency;
		oObjeto.cRedBcIrrf := oFields.FieldByName('a043_red_bc_irrf').AsCurrency;
		oObjeto.cPercIrrf := oFields.FieldByName('a043_perc_irrf').AsCurrency;
		oObjeto.cRedBcInss := oFields.FieldByName('a043_red_bc_inss').AsCurrency;
		oObjeto.cPercInss := oFields.FieldByName('a043_perc_inss').AsCurrency;
		oObjeto.cBcRet := oFields.FieldByName('a043_bc_ret').AsCurrency;
		oObjeto.cAliqRet := oFields.FieldByName('a043_aliq_ret').AsCurrency;
		oObjeto.cBcRetSub := oFields.FieldByName('a043_bc_ret_sub').AsCurrency;
		oObjeto.cAliqRetSub := oFields.FieldByName('a043_aliq_ret_sub').AsCurrency;
		oObjeto.cPercNretPrinc := oFields.FieldByName('a043_perc_nret_princ').AsCurrency;
		oObjeto.cPercRet15 := oFields.FieldByName('a043_perc_ret_15').AsCurrency;
		oObjeto.cPercRet20 := oFields.FieldByName('a043_perc_ret_20').AsCurrency;
		oObjeto.cPercRet25 := oFields.FieldByName('a043_perc_ret_25').AsCurrency;
		oObjeto.cPercNretAdic := oFields.FieldByName('a043_perc_nret_adic').AsCurrency;
		oObjeto.cVBcStRetOpc := oFields.FieldByName('a043_v_bc_st_ret_opc').AsCurrency;
		oObjeto.cPStOpc := oFields.FieldByName('a043_p_st_opc').AsCurrency;
		oObjeto.cVIcmsSubstitutoOpc := oFields.FieldByName('a043_v_icms_substituto_opc').AsCurrency;
		oObjeto.cVIcmsStRetOpc := oFields.FieldByName('a043_v_icms_st_ret_opc').AsCurrency;
		oObjeto.cVBcFcpStRetOpc := oFields.FieldByName('a043_v_bc_fcp_st_ret_opc').AsCurrency;
		oObjeto.cPFcpStRetOpc := oFields.FieldByName('a043_p_fcp_st_ret_opc').AsCurrency;
		oObjeto.cVFcpStRetOpc := oFields.FieldByName('a043_v_fcp_st_ret_opc').AsCurrency;
		oObjeto.cPRedBcEfetOpc := oFields.FieldByName('a043_p_red_bc_efet_opc').AsCurrency;
		oObjeto.cVBcEfetOpc := oFields.FieldByName('a043_v_bc_efet_opc').AsCurrency;
		oObjeto.cPIcmsEfetOpc := oFields.FieldByName('a043_p_icms_efet_opc').AsCurrency;
		oObjeto.cVIcmsEfetOpc := oFields.FieldByName('a043_v_icms_efet_opc').AsCurrency;
		oObjeto.cVBcStDestOpc := oFields.FieldByName('a043_v_bc_st_dest_opc').AsCurrency;
		oObjeto.cVIcmsStDestOpc := oFields.FieldByName('a043_v_icms_st_dest_opc').AsCurrency;
		oObjeto.cVBcUfDest := oFields.FieldByName('a043_v_bc_uf_dest').AsCurrency;
		oObjeto.cVBcFcpUfDestOpc := oFields.FieldByName('a043_v_bc_fcp_uf_dest_opc').AsCurrency;
		oObjeto.cPFcpUfDestOpc := oFields.FieldByName('a043_p_fcp_uf_dest_opc').AsCurrency;
		oObjeto.cPIcmsUfDest := oFields.FieldByName('a043_p_icms_uf_dest').AsCurrency;
		oObjeto.cPIcmsInter := oFields.FieldByName('a043_p_icms_inter').AsCurrency;
		oObjeto.cPIcmsInterPart := oFields.FieldByName('a043_p_icms_inter_part').AsCurrency;
		oObjeto.cVFcpUfDestOpc := oFields.FieldByName('a043_v_fcp_uf_dest_opc').AsCurrency;
		oObjeto.cVIcmsUfDest := oFields.FieldByName('a043_v_icms_uf_dest').AsCurrency;
		oObjeto.cVIcmsUfRemet := oFields.FieldByName('a043_v_icms_uf_remet').AsCurrency;
		oObjeto.sUsaCfop := oFields.FieldByName('a043_usa_cfop').AsString;
		oObjeto.sIbs := oFields.FieldByName('a043_ibs').AsString;
		oObjeto.cIbsAliquota := oFields.FieldByName('a043_ibs_aliquota').AsCurrency;
		oObjeto.cIbsBaseCalc := oFields.FieldByName('a043_ibs_base_calc').AsCurrency;
		oObjeto.sIss := oFields.FieldByName('a043_iss').AsString;
		oObjeto.cIssAliquota := oFields.FieldByName('a043_iss_aliquota').AsCurrency;
		oObjeto.cIssBaseCalc := oFields.FieldByName('a043_iss_base_calc').AsCurrency;
		oObjeto.sCbs := oFields.FieldByName('a043_cbs').AsString;
		oObjeto.cCbsAliquota := oFields.FieldByName('a043_cbs_aliquota').AsCurrency;
		oObjeto.cCbsBaseCalc := oFields.FieldByName('a043_cbs_base_calc').AsCurrency;
		oObjeto.sCodIva := oFields.FieldByName('a043_cod_iva').AsString;
		oObjeto.sCodCidade := oFields.FieldByName('a043_cod_cidade').AsString;
		oObjeto.sCstIbs := oFields.FieldByName('a043_cst_ibs').AsString;
		oObjeto.sCstIss := oFields.FieldByName('a043_cst_iss').AsString;
		oObjeto.sCstCbs := oFields.FieldByName('a043_cst_cbs').AsString;
		Result := oObjeto;
	except
		if oObjeto <> nil then
			oObjeto.free;
		raise;
	end;
end;

end.