{----------------------------------------------------}
{                                                    }
{         @ @@@@@@@@@@         @@@@@@@@@@            }
{           @@@@@@@@@@        @@@@@@@@@@             }
{      @@@@ @@@@@@@@@@      @@@@@@@@@@               }
{      @@@@ @@@@@@@@@@     @@@@@@@@@@                }
{           @@@@@@@@@@    @@@@@@@@@@                 }
{    @@@  @ @@@@@@@@@@   @@@@@@@@@@                  }
{           @@@@@@@@@@  @@@@@@@@@@                   }
{    @  @@@ @@@@@@@@@@ @@@@@@@@@@                    }
{ @         @@@@@@@@@@ @@@@@@@@@@@                   }
{     @@  @ @@@@@@@@@@  @@@@@@@@@@@                  }
{  @        @@@@@@@@@@   @@@@@@@@@@@                 }
{    @@ @@@ @@@@@@@@@@    @@@@@@@@@@@                }
{       @@@ @@@@@@@@@@     @@@@@@@@@@@               }
{     @  @@ @@@@@@@@@@      @@@@@@@@@@@              }
{        @@ @@@@@@@@@@       @@@@@@@@@@@             }
{           @@@@@@@@@@        @@@@@@@@@@@            }
{                                                    }
{     @@  @@ @@  @@ @@   @@ @@ @@ @@   @@            }
{     @@ @@  @@  @@ @@@  @@ @@ @@ @@@ @@@            }
{     @@@@   @@@@@@ @@@@ @@ @@ @@ @@@@@@@            }
{     @@@@@  @@  @@ @@ @@@@ @@ @@ @@ @ @@            }
{     @@ @@@ @@  @@ @@  @@@ @@@@@ @@   @@            }
{                                                    }
{----------------------------------------------------}
{ File      : untPedidoVendaItemDAO.pas              }
{ Generated : 12/09/2023 09:28:47                    }
{ User      : rscholant                              }
{----------------------------------------------------}

unit untTesDAO;

interface

uses untKhnumQuery, DB, ADODB, untBaseDAO, untModelos;

type
        TClassTesDAO = BaseDAO<TTes>;

        TesDAO = class(TClassTesDAO)
                public
                        constructor Create(_sEmpresa, _sFilial: String); Override;
                        function getInsertSql: String; Override;
                        function getUpdateSql: String; Override;
                        procedure ObjetoParaQuery(oObjeto: TTes; oQuery: TADOQuery;
                                        bSetarCodSeq: Boolean = true); Override;
                protected
                        function SubLinhaParaObjeto(oFields: TFields): TTes; Override;
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
                        ' [a043_ajuste_credito], [a043_ajuste_debito], [a043_aliq_ret], [a043_aliq_ret_sub], ' +
                        ' [a043_AliqIntST], [a043_AliqST], [a043_aliquota_frete], [a043_atualiza_est], ' +
                        ' [a043_base_calc_icm], [a043_base_calculo_cofins], [a043_base_calculo_frete], [a043_base_calculo_pis], ' +
                        ' [a043_base_cofins_socio], [a043_base_pis_socio], [a043_bc_ipi], [a043_bc_ret], ' +
                        ' [a043_bc_ret_sub], [a043_bc_senar], [a043_cat_pessoa], [a043_cod_aj_apuracao_deducao], ' +
                        ' [a043_cod_aj_icms_ex_icms], [a043_cod_col_mapa], [a043_cod_Enq_ipi], [a043_cod_influencia_recolhimento], ' +
                        ' [a043_cod_obrigacao_a_recolher], [a043_cod_ocorrencia_aj_icms], [a043_cod_origem_tributacao], [a043_cod_pessoa], ' +
                        ' [a043_cod_reflexo_apur_icms], [a043_cod_responsabilidade], [a043_cod_sit_trib], [a043_cod_tes_estorno], ' +
                        ' [a043_cod_tipo_apuracao], [a043_cod_tipo_credito], [a043_cod_tipo_utilizacao_credito], [a043_codigo], ' +
                        ' [a043_codigo_fiscal], [a043_cofins], [a043_cst_ipi], [a043_datetime], ' +
                        ' [a043_depreciacao_anual], [a043_desc_cfop], [a043_descricao], [a043_envia_deposito], ' +
                        ' [a043_escrita], [a043_especie_pessoa], [a043_estado], [a043_exige_nf_prod], ' +
                        ' [a043_finalidade_nfe], [a043_funrural], [a043_funrural_ent_sai], [a043_gera_financeiro], ' +
                        ' [a043_gera_sped], [a043_icm], [a043_ipi], [a043_issqn], ' +
                        ' [a043_margem_subst_tributaria], [a043_mensagem_nf], [a043_mensagem_nf_01], [a043_mod_base_calculo], ' +
                        ' [a043_mod_base_calculo_substituicao], [a043_mot_desoneracao], [a043_mov_cta_capital], [a043_mov_cta_socio], ' +
                        ' [a043_mov_custo], [a043_mov_desp_secagem], [a043_obs], [a043_obs_contribuinte], ' +
                        ' [a043_obs_fiscal], [a043_operacao_tes], [a043_p_fcp_st_ret_opc], [a043_p_fcp_uf_dest_opc], ' +
                        ' [a043_p_icms_efet_opc], [a043_p_icms_inter], [a043_p_icms_inter_part], [a043_p_icms_uf_dest], ' +
                        ' [a043_p_red_bc_efet_opc], [a043_p_senar], [a043_p_st_opc], [a043_pBCFCP], ' +
                        ' [a043_pBCFCPRet], [a043_pBCFCPST], [a043_pCredSN], [a043_pDif], ' +
                        ' [a043_pEntMVAST], [a043_per_cofins_socio], [a043_per_pis_socio], [a043_perc_csll], ' +
                        ' [a043_perc_inss], [a043_perc_irrf], [a043_perc_nret_adic], [a043_perc_nret_princ], ' +
                        ' [a043_perc_red_base_cal_substituicao], [a043_perc_ret_15], [a043_perc_ret_20], [a043_perc_ret_25], ' +
                        ' [a043_percentual_residual], [a043_permite_ibpt], [a043_permite_nf], [a043_pFCP], ' +                        ' [a043_pFCPRet], [a043_pFCPST], [a043_pis], [a043_pMVAST], ' +
                        ' [a043_preco_produto], [a043_pST], [a043_red_bc_csll], [a043_red_bc_inss], ' +
                        ' [a043_red_bc_irrf], [a043_sequencial], [a043_situacao_tributaria_cofins], [a043_situacao_tributaria_pis], ' +
                        ' [a043_tab_cofins], [a043_tab_pis], [a043_tipo_preco], [a043_tipo_tes], ' +
                        ' [a043_tributacao], [a043_usa_cfop], [a043_usa_FCP], [a043_usa_funrural], ' +
                        ' [a043_usa_produtos], [a043_usa_senar], [a043_usa_trib_pis], [a043_usa_trib_serv], '
+
                        ' [a043_usuario], [a043_utiliza_preco_pauta], [a043_v_bc_efet_opc], [a043_v_bc_fcp_st_ret_opc], ' +
                        ' [a043_v_bc_fcp_uf_dest_opc], [a043_v_bc_st_dest_opc], [a043_v_bc_st_ret_opc], [a043_v_bc_uf_dest], ' +
                        ' [a043_v_fcp_st_ret_opc], [a043_v_fcp_uf_dest_opc], [a043_v_icms_efet_opc], [a043_v_icms_st_dest_opc], ' +
                        ' [a043_v_icms_st_ret_opc], [a043_v_icms_substituto_opc], [a043_v_icms_uf_dest], [a043_v_icms_uf_remet], ' +
                        ' [a043_vinculo_doc_fiscal]' +
                        ') VALUES( ' +
                        ' :a043_ajuste_credito, :a043_ajuste_debito, :a043_aliq_ret, :a043_aliq_ret_sub, ' +
                        ' :a043_AliqIntST, :a043_AliqST, :a043_aliquota_frete, :a043_atualiza_est, ' +
                        ' :a043_base_calc_icm, :a043_base_calculo_cofins, :a043_base_calculo_frete, :a043_base_calculo_pis, ' +
                        ' :a043_base_cofins_socio, :a043_base_pis_socio, :a043_bc_ipi, :a043_bc_ret, ' +
                        ' :a043_bc_ret_sub, :a043_bc_senar, :a043_cat_pessoa, :a043_cod_aj_apuracao_deducao, ' +
                        ' :a043_cod_aj_icms_ex_icms, :a043_cod_col_mapa, :a043_cod_Enq_ipi, :a043_cod_influencia_recolhimento, ' +
                        ' :a043_cod_obrigacao_a_recolher, :a043_cod_ocorrencia_aj_icms, :a043_cod_origem_tributacao, :a043_cod_pessoa, ' +
                        ' :a043_cod_reflexo_apur_icms, :a043_cod_responsabilidade, :a043_cod_sit_trib, :a043_cod_tes_estorno, ' +
                        ' :a043_cod_tipo_apuracao, :a043_cod_tipo_credito, :a043_cod_tipo_utilizacao_credito,'+
                        ' :a043_codigo, ' +
                        ' :a043_codigo_fiscal, :a043_cofins, :a043_cst_ipi, :a043_datetime, ' +
                        ' :a043_depreciacao_anual, :a043_desc_cfop, :a043_descricao, :a043_envia_deposito, ' +                        ' :a043_escrita, :a043_especie_pessoa, :a043_estado, :a043_exige_nf_prod, ' +
                        ' :a043_finalidade_nfe, :a043_funrural, :a043_funrural_ent_sai, :a043_gera_financeiro, ' +
                        ' :a043_gera_sped, :a043_icm, :a043_ipi, :a043_issqn, ' +
                        ' :a043_margem_subst_tributaria, :a043_mensagem_nf, :a043_mensagem_nf_01, :a043_mod_base_calculo, ' +
                        ' :a043_mod_base_calculo_substituicao, :a043_mot_desoneracao, :a043_mov_cta_capital, :a043_mov_cta_socio, ' +
                        ' :a043_mov_custo, :a043_mov_desp_secagem, :a043_obs, :a043_obs_contribuinte, ' +
                        ' :a043_obs_fiscal, :a043_operacao_tes, :a043_p_fcp_st_ret_opc, :a043_p_fcp_uf_dest_opc, ' +
                        ' :a043_p_icms_efet_opc, :a043_p_icms_inter, :a043_p_icms_inter_part, :a043_p_icms_uf_dest, ' +
                        ' :a043_p_red_bc_efet_opc, :a043_p_senar, :a043_p_st_opc, :a043_pBCFCP, ' +
                        ' :a043_pBCFCPRet, :a043_pBCFCPST, :a043_pCredSN, :a043_pDif, ' +
                        ' :a043_pEntMVAST, :a043_per_cofins_socio, :a043_per_pis_socio, :a043_perc_csll, ' +
                        ' :a043_perc_inss, :a043_perc_irrf, :a043_perc_nret_adic, :a043_perc_nret_princ, ' +
                        ' :a043_perc_red_base_cal_substituicao, :a043_perc_ret_15, :a043_perc_ret_20, :a043_perc_ret_25, ' +
                        ' :a043_percentual_residual, :a043_permite_ibpt, :a043_permite_nf, :a043_pFCP, ' +
                        ' :a043_pFCPRet, :a043_pFCPST, :a043_pis, :a043_pMVAST, ' +
                        ' :a043_preco_produto, :a043_pST, :a043_red_bc_csll, :a043_red_bc_inss, ' +
                        ' :a043_red_bc_irrf, :a043_sequencial, :a043_situacao_tributaria_cofins, :a043_situacao_tributaria_pis, ' +
                        ' :a043_tab_cofins, :a043_tab_pis, :a043_tipo_preco, :a043_tipo_tes, ' +
                        ' :a043_tributacao, :a043_usa_cfop, :a043_usa_FCP, :a043_usa_funrural, ' +
                        ' :a043_usa_produtos, :a043_usa_senar, :a043_usa_trib_pis, :a043_usa_trib_serv, ' +
                        ' :a043_usuario, :a043_utiliza_preco_pauta, :a043_v_bc_efet_opc, :a043_v_bc_fcp_st_ret_opc, ' +
                        ' :a043_v_bc_fcp_uf_dest_opc, :a043_v_bc_st_dest_opc, :a043_v_bc_st_ret_opc, :a043_v_bc_uf_dest, ' +
                        ' :a043_v_fcp_st_ret_opc, :a043_v_fcp_uf_dest_opc, :a043_v_icms_efet_opc, :a043_v_icms_st_dest_opc, ' +
                        ' :a043_v_icms_st_ret_opc, :a043_v_icms_substituto_opc, :a043_v_icms_uf_dest, :a043_v_icms_uf_remet, ' +
                        ' :a043_vinculo_doc_fiscal)';
begin
        Result := SQL_INSERIR;
end;

function TesDAO.getUpdateSql;
const
        SQL_ATUALIZAR: String =
                        'UPDATE [dbo].[a043_tes] SET ' +
                        ' [a043_ajuste_credito] = :a043_ajuste_credito, ' +
                        ' [a043_ajuste_debito] = :a043_ajuste_debito, ' +
                        ' [a043_aliq_ret] = :a043_aliq_ret, ' +
                        ' [a043_aliq_ret_sub] = :a043_aliq_ret_sub, ' +
                        ' [a043_AliqIntST] = :a043_AliqIntST, ' +
                        ' [a043_AliqST] = :a043_AliqST, ' +
                        ' [a043_aliquota_frete] = :a043_aliquota_frete, ' +
                        ' [a043_atualiza_est] = :a043_atualiza_est, ' +
                        ' [a043_base_calc_icm] = :a043_base_calc_icm, ' +
                        ' [a043_base_calculo_cofins] = :a043_base_calculo_cofins, ' +
                        ' [a043_base_calculo_frete] = :a043_base_calculo_frete, ' +
                        ' [a043_base_calculo_pis] = :a043_base_calculo_pis, ' +
                        ' [a043_base_cofins_socio] = :a043_base_cofins_socio, ' +
                        ' [a043_base_pis_socio] = :a043_base_pis_socio, ' +
                        ' [a043_bc_ipi] = :a043_bc_ipi, ' +
                        ' [a043_bc_ret] = :a043_bc_ret, ' +
                        ' [a043_bc_ret_sub] = :a043_bc_ret_sub, ' +
                        ' [a043_bc_senar] = :a043_bc_senar, ' +
                        ' [a043_cat_pessoa] = :a043_cat_pessoa, ' +
                        ' [a043_cod_aj_apuracao_deducao] = :a043_cod_aj_apuracao_deducao, ' +
                        ' [a043_cod_aj_icms_ex_icms] = :a043_cod_aj_icms_ex_icms, ' +
                        ' [a043_cod_col_mapa] = :a043_cod_col_mapa, ' +
                        ' [a043_cod_Enq_ipi] = :a043_cod_Enq_ipi, ' +
                        ' [a043_cod_influencia_recolhimento] = :a043_cod_influencia_recolhimento, ' +
                        ' [a043_cod_obrigacao_a_recolher] = :a043_cod_obrigacao_a_recolher, ' +
                        ' [a043_cod_ocorrencia_aj_icms] = :a043_cod_ocorrencia_aj_icms, ' +
                        ' [a043_cod_origem_tributacao] = :a043_cod_origem_tributacao, ' +
                        ' [a043_cod_pessoa] = :a043_cod_pessoa, ' +
                        ' [a043_cod_reflexo_apur_icms] = :a043_cod_reflexo_apur_icms, ' +
                        ' [a043_cod_responsabilidade] = :a043_cod_responsabilidade, ' +
                        ' [a043_cod_sit_trib] = :a043_cod_sit_trib, ' +
                        ' [a043_cod_tes_estorno] = :a043_cod_tes_estorno, ' +
                        ' [a043_cod_tipo_apuracao] = :a043_cod_tipo_apuracao, ' +
                        ' [a043_cod_tipo_credito] = :a043_cod_tipo_credito, ' +
                        ' [a043_cod_tipo_utilizacao_credito] = :a043_cod_tipo_utilizacao_credito, ' +
                        ' [a043_codigo_fiscal] = :a043_codigo_fiscal, ' +
                        ' [a043_cofins] = :a043_cofins, ' +
                        ' [a043_cst_ipi] = :a043_cst_ipi, ' +
                        ' [a043_datetime] = :a043_datetime, ' +
                        ' [a043_depreciacao_anual] = :a043_depreciacao_anual, ' +
                        ' [a043_desc_cfop] = :a043_desc_cfop, ' +
                        ' [a043_descricao] = :a043_descricao, ' +
                        ' [a043_envia_deposito] = :a043_envia_deposito, ' +
                        ' [a043_escrita] = :a043_escrita, ' +
                        ' [a043_especie_pessoa] = :a043_especie_pessoa, ' +
                        ' [a043_estado] = :a043_estado, ' +
                        ' [a043_exige_nf_prod] = :a043_exige_nf_prod, ' +
                        ' [a043_finalidade_nfe] = :a043_finalidade_nfe, ' +
                        ' [a043_funrural] = :a043_funrural, ' +
                        ' [a043_funrural_ent_sai] = :a043_funrural_ent_sai, ' +
                        ' [a043_gera_financeiro] = :a043_gera_financeiro, ' +
                        ' [a043_gera_sped] = :a043_gera_sped, ' +
                        ' [a043_icm] = :a043_icm, ' +
                        ' [a043_ipi] = :a043_ipi, ' +
                        ' [a043_issqn] = :a043_issqn, ' +
                        ' [a043_margem_subst_tributaria] = :a043_margem_subst_tributaria, ' +
                        ' [a043_mensagem_nf] = :a043_mensagem_nf, ' +
                        ' [a043_mensagem_nf_01] = :a043_mensagem_nf_01, ' +
                        ' [a043_mod_base_calculo] = :a043_mod_base_calculo, ' +
                        ' [a043_mod_base_calculo_substituicao] = :a043_mod_base_calculo_substituicao, ' +
                        ' [a043_mot_desoneracao] = :a043_mot_desoneracao, ' +
                        ' [a043_mov_cta_capital] = :a043_mov_cta_capital, ' +
                        ' [a043_mov_cta_socio] = :a043_mov_cta_socio, ' +
                        ' [a043_mov_custo] = :a043_mov_custo, ' +
                        ' [a043_mov_desp_secagem] = :a043_mov_desp_secagem, ' +
                        ' [a043_obs] = :a043_obs, ' +
                        ' [a043_obs_contribuinte] = :a043_obs_contribuinte, ' +
                        ' [a043_obs_fiscal] = :a043_obs_fiscal, ' +
                        ' [a043_operacao_tes] = :a043_operacao_tes, ' +
                        ' [a043_p_fcp_st_ret_opc] = :a043_p_fcp_st_ret_opc, ' +
                        ' [a043_p_fcp_uf_dest_opc] = :a043_p_fcp_uf_dest_opc, ' +
                        ' [a043_p_icms_efet_opc] = :a043_p_icms_efet_opc, ' +
                        ' [a043_p_icms_inter] = :a043_p_icms_inter, ' +
                        ' [a043_p_icms_inter_part] = :a043_p_icms_inter_part, ' +
                        ' [a043_p_icms_uf_dest] = :a043_p_icms_uf_dest, ' +
                        ' [a043_p_red_bc_efet_opc] = :a043_p_red_bc_efet_opc, ' +
                        ' [a043_p_senar] = :a043_p_senar, ' +
                        ' [a043_p_st_opc] = :a043_p_st_opc, ' +
                        ' [a043_pBCFCP] = :a043_pBCFCP, ' +
                        ' [a043_pBCFCPRet] = :a043_pBCFCPRet, ' +
                        ' [a043_pBCFCPST] = :a043_pBCFCPST, ' +
                        ' [a043_pCredSN] = :a043_pCredSN, ' +
                        ' [a043_pDif] = :a043_pDif, ' +
                        ' [a043_pEntMVAST] = :a043_pEntMVAST, ' +
                        ' [a043_per_cofins_socio] = :a043_per_cofins_socio, ' +
                        ' [a043_per_pis_socio] = :a043_per_pis_socio, ' +
                        ' [a043_perc_csll] = :a043_perc_csll, ' +
                        ' [a043_perc_inss] = :a043_perc_inss, ' +
                        ' [a043_perc_irrf] = :a043_perc_irrf, ' +
                        ' [a043_perc_nret_adic] = :a043_perc_nret_adic, ' +
                        ' [a043_perc_nret_princ] = :a043_perc_nret_princ, ' +
                        ' [a043_perc_red_base_cal_substituicao] = :a043_perc_red_base_cal_substituicao, ' +
                        ' [a043_perc_ret_15] = :a043_perc_ret_15, ' +
                        ' [a043_perc_ret_20] = :a043_perc_ret_20, ' +
                        ' [a043_perc_ret_25] = :a043_perc_ret_25, ' +
                        ' [a043_percentual_residual] = :a043_percentual_residual, ' +
                        ' [a043_permite_ibpt] = :a043_permite_ibpt, ' +
                        ' [a043_permite_nf] = :a043_permite_nf, ' +
                        ' [a043_pFCP] = :a043_pFCP, ' +
                        ' [a043_pFCPRet] = :a043_pFCPRet, ' +
                        ' [a043_pFCPST] = :a043_pFCPST, ' +
                        ' [a043_pis] = :a043_pis, ' +
                        ' [a043_pMVAST] = :a043_pMVAST, ' +
                        ' [a043_preco_produto] = :a043_preco_produto, ' +
                        ' [a043_pST] = :a043_pST, ' +
                        ' [a043_red_bc_csll] = :a043_red_bc_csll, ' +
                        ' [a043_red_bc_inss] = :a043_red_bc_inss, ' +
                        ' [a043_red_bc_irrf] = :a043_red_bc_irrf, ' +
                        ' [a043_situacao_tributaria_cofins] = :a043_situacao_tributaria_cofins, ' +
                        ' [a043_situacao_tributaria_pis] = :a043_situacao_tributaria_pis, ' +
                        ' [a043_tab_cofins] = :a043_tab_cofins, ' +
                        ' [a043_tab_pis] = :a043_tab_pis, ' +
                        ' [a043_tipo_preco] = :a043_tipo_preco, ' +
                        ' [a043_tipo_tes] = :a043_tipo_tes, ' +
                        ' [a043_tributacao] = :a043_tributacao, ' +
                        ' [a043_usa_cfop] = :a043_usa_cfop, ' +
                        ' [a043_usa_FCP] = :a043_usa_FCP, ' +
                        ' [a043_usa_funrural] = :a043_usa_funrural, ' +
                        ' [a043_usa_produtos] = :a043_usa_produtos, ' +
                        ' [a043_usa_senar] = :a043_usa_senar, ' +
                        ' [a043_usa_trib_pis] = :a043_usa_trib_pis, ' +
                        ' [a043_usa_trib_serv] = :a043_usa_trib_serv, ' +
                        ' [a043_usuario] = :a043_usuario, ' +
                        ' [a043_utiliza_preco_pauta] = :a043_utiliza_preco_pauta, ' +
                        ' [a043_v_bc_efet_opc] = :a043_v_bc_efet_opc, ' +
                        ' [a043_v_bc_fcp_st_ret_opc] = :a043_v_bc_fcp_st_ret_opc, ' +
                        ' [a043_v_bc_fcp_uf_dest_opc] = :a043_v_bc_fcp_uf_dest_opc, ' +
                        ' [a043_v_bc_st_dest_opc] = :a043_v_bc_st_dest_opc, ' +
                        ' [a043_v_bc_st_ret_opc] = :a043_v_bc_st_ret_opc, ' +
                        ' [a043_v_bc_uf_dest] = :a043_v_bc_uf_dest, ' +
                        ' [a043_v_fcp_st_ret_opc] = :a043_v_fcp_st_ret_opc, ' +
                        ' [a043_v_fcp_uf_dest_opc] = :a043_v_fcp_uf_dest_opc, ' +
                        ' [a043_v_icms_efet_opc] = :a043_v_icms_efet_opc, ' +
                        ' [a043_v_icms_st_dest_opc] = :a043_v_icms_st_dest_opc, ' +
                        ' [a043_v_icms_st_ret_opc] = :a043_v_icms_st_ret_opc, ' +
                        ' [a043_v_icms_substituto_opc] = :a043_v_icms_substituto_opc, ' +
                        ' [a043_v_icms_uf_dest] = :a043_v_icms_uf_dest, ' +
                        ' [a043_v_icms_uf_remet] = :a043_v_icms_uf_remet, ' +
                        ' [a043_vinculo_doc_fiscal] = :a043_vinculo_doc_fiscal ' +
                        'WHERE [a043_codigo] = :a043_codigo ';
begin
        Result := SQL_ATUALIZAR;
end;

procedure TesDAO.ObjetoParaQuery;
begin
        oQuery.Parameters.ParamByName('a043_ajuste_credito').Value := oObjeto.sAjusteCredito;
        oQuery.Parameters.ParamByName('a043_ajuste_debito').Value := oObjeto.sAjusteDebito;
        oQuery.Parameters.ParamByName('a043_aliq_ret').Value := oObjeto.cAliqRet;
        oQuery.Parameters.ParamByName('a043_aliq_ret_sub').Value := oObjeto.cAliqRetSub;
        oQuery.Parameters.ParamByName('a043_AliqIntST').Value := oObjeto.cAliqintst;
        oQuery.Parameters.ParamByName('a043_AliqST').Value := oObjeto.cAliqst;
        oQuery.Parameters.ParamByName('a043_aliquota_frete').Value := oObjeto.sAliquotaFrete;
        oQuery.Parameters.ParamByName('a043_atualiza_est').Value := oObjeto.sAtualizaEst;
        oQuery.Parameters.ParamByName('a043_base_calc_icm').Value := oObjeto.cBaseCalcIcm;
        oQuery.Parameters.ParamByName('a043_base_calculo_cofins').Value := oObjeto.cBaseCalculoCofins;
        oQuery.Parameters.ParamByName('a043_base_calculo_frete').Value := oObjeto.sBaseCalculoFrete;
        oQuery.Parameters.ParamByName('a043_base_calculo_pis').Value := oObjeto.cBaseCalculoPis;
        oQuery.Parameters.ParamByName('a043_base_cofins_socio').Value := oObjeto.cBaseCofinsSocio;
        oQuery.Parameters.ParamByName('a043_base_pis_socio').Value := oObjeto.cBasePisSocio;
        oQuery.Parameters.ParamByName('a043_bc_ipi').Value := oObjeto.cBcIpi;
        oQuery.Parameters.ParamByName('a043_bc_ret').Value := oObjeto.cBcRet;
        oQuery.Parameters.ParamByName('a043_bc_ret_sub').Value := oObjeto.cBcRetSub;
        oQuery.Parameters.ParamByName('a043_bc_senar').Value := oObjeto.cBcSenar;
        oQuery.Parameters.ParamByName('a043_cat_pessoa').Value := oObjeto.sCatPessoa;
        oQuery.Parameters.ParamByName('a043_cod_aj_apuracao_deducao').Value := oObjeto.sCodAjApuracaoDeducao;
        oQuery.Parameters.ParamByName('a043_cod_aj_icms_ex_icms').Value := oObjeto.sCodAjIcmsExIcms;
        oQuery.Parameters.ParamByName('a043_cod_col_mapa').Value := oObjeto.sCodColMapa;
        oQuery.Parameters.ParamByName('a043_cod_Enq_ipi').Value := oObjeto.iCodEnqIpi;
        oQuery.Parameters.ParamByName('a043_cod_influencia_recolhimento').Value := oObjeto.sCodInfluenciaRecolhimento;
        oQuery.Parameters.ParamByName('a043_cod_obrigacao_a_recolher').Value := oObjeto.sCodObrigacaoARecolher;
        oQuery.Parameters.ParamByName('a043_cod_ocorrencia_aj_icms').Value := oObjeto.sCodOcorrenciaAjIcms;
        oQuery.Parameters.ParamByName('a043_cod_origem_tributacao').Value := oObjeto.sCodOrigemTributacao;
        oQuery.Parameters.ParamByName('a043_cod_pessoa').Value := oObjeto.sCodPessoa;
        oQuery.Parameters.ParamByName('a043_cod_reflexo_apur_icms').Value := oObjeto.sCodReflexoApurIcms;
        oQuery.Parameters.ParamByName('a043_cod_responsabilidade').Value := oObjeto.sCodResponsabilidade;
        oQuery.Parameters.ParamByName('a043_cod_sit_trib').Value := oObjeto.sCodSitTrib;
        oQuery.Parameters.ParamByName('a043_cod_tes_estorno').Value := oObjeto.sCodTesEstorno;
        oQuery.Parameters.ParamByName('a043_cod_tipo_apuracao').Value := oObjeto.sCodTipoApuracao;
        oQuery.Parameters.ParamByName('a043_cod_tipo_credito').Value := oObjeto.sCodTipoCredito;
        oQuery.Parameters.ParamByName('a043_cod_tipo_utilizacao_credito').Value := oObjeto.sCodTipoUtilizacaoCredito;
        oQuery.Parameters.ParamByName('a043_codigo_fiscal').Value := oObjeto.sCodigoFiscal;
        oQuery.Parameters.ParamByName('a043_cofins').Value := oObjeto.cCofins;
        oQuery.Parameters.ParamByName('a043_cst_ipi').Value := oObjeto.sCstIpi;
        oQuery.Parameters.ParamByName('a043_datetime').Value := oObjeto.dDatetime;
        oQuery.Parameters.ParamByName('a043_depreciacao_anual').Value := oObjeto.cDepreciacaoAnual;
        oQuery.Parameters.ParamByName('a043_desc_cfop').Value := oObjeto.sDescCfop;
        oQuery.Parameters.ParamByName('a043_descricao').Value := oObjeto.sDescricao;
        oQuery.Parameters.ParamByName('a043_envia_deposito').Value := oObjeto.sEnviaDeposito;
        oQuery.Parameters.ParamByName('a043_escrita').Value := oObjeto.sEscrita;
        oQuery.Parameters.ParamByName('a043_especie_pessoa').Value := oObjeto.sEspeciePessoa;
        oQuery.Parameters.ParamByName('a043_estado').Value := oObjeto.sEstado;
        oQuery.Parameters.ParamByName('a043_exige_nf_prod').Value := oObjeto.sExigeNfProd;
        oQuery.Parameters.ParamByName('a043_finalidade_nfe').Value := oObjeto.sFinalidadeNfe;
        oQuery.Parameters.ParamByName('a043_funrural').Value := oObjeto.cFunrural;
        oQuery.Parameters.ParamByName('a043_funrural_ent_sai').Value := oObjeto.sFunruralEntSai;
        oQuery.Parameters.ParamByName('a043_gera_financeiro').Value := oObjeto.sGeraFinanceiro;
        oQuery.Parameters.ParamByName('a043_gera_sped').Value := oObjeto.sGeraSped;
        oQuery.Parameters.ParamByName('a043_icm').Value := oObjeto.cIcm;
        oQuery.Parameters.ParamByName('a043_ipi').Value := oObjeto.cIpi;
        oQuery.Parameters.ParamByName('a043_issqn').Value := oObjeto.cIssqn;
        oQuery.Parameters.ParamByName('a043_margem_subst_tributaria').Value := oObjeto.cMargemSubstTributaria;        oQuery.Parameters.ParamByName('a043_mensagem_nf').Value := oObjeto.sMensagemNf;
        oQuery.Parameters.ParamByName('a043_mensagem_nf_01').Value := oObjeto.sMensagemNf01;
        oQuery.Parameters.ParamByName('a043_mod_base_calculo').Value := oObjeto.sModBaseCalculo;
        oQuery.Parameters.ParamByName('a043_mod_base_calculo_substituicao').Value := oObjeto.sModBaseCalculoSubstituicao;
        oQuery.Parameters.ParamByName('a043_mot_desoneracao').Value := oObjeto.sMotDesoneracao;
        oQuery.Parameters.ParamByName('a043_mov_cta_capital').Value := oObjeto.sMovCtaCapital;
        oQuery.Parameters.ParamByName('a043_mov_cta_socio').Value := oObjeto.sMovCtaSocio;
        oQuery.Parameters.ParamByName('a043_mov_custo').Value := oObjeto.sMovCusto;
        oQuery.Parameters.ParamByName('a043_mov_desp_secagem').Value := oObjeto.sMovDespSecagem;
        oQuery.Parameters.ParamByName('a043_obs').Value := oObjeto.sObs;
        oQuery.Parameters.ParamByName('a043_obs_contribuinte').Value := oObjeto.sObsContribuinte;
        oQuery.Parameters.ParamByName('a043_obs_fiscal').Value := oObjeto.sObsFiscal;
        oQuery.Parameters.ParamByName('a043_operacao_tes').Value := oObjeto.sOperacaoTes;
        oQuery.Parameters.ParamByName('a043_p_fcp_st_ret_opc').Value := oObjeto.cPFcpStRetOpc;
        oQuery.Parameters.ParamByName('a043_p_fcp_uf_dest_opc').Value := oObjeto.cPFcpUfDestOpc;
        oQuery.Parameters.ParamByName('a043_p_icms_efet_opc').Value := oObjeto.cPIcmsEfetOpc;
        oQuery.Parameters.ParamByName('a043_p_icms_inter').Value := oObjeto.cPIcmsInter;
        oQuery.Parameters.ParamByName('a043_p_icms_inter_part').Value := oObjeto.cPIcmsInterPart;
        oQuery.Parameters.ParamByName('a043_p_icms_uf_dest').Value := oObjeto.cPIcmsUfDest;
        oQuery.Parameters.ParamByName('a043_p_red_bc_efet_opc').Value := oObjeto.cPRedBcEfetOpc;
        oQuery.Parameters.ParamByName('a043_p_senar').Value := oObjeto.cPSenar;
        oQuery.Parameters.ParamByName('a043_p_st_opc').Value := oObjeto.cPStOpc;
        oQuery.Parameters.ParamByName('a043_pBCFCP').Value := oObjeto.cPbcfcp;
        oQuery.Parameters.ParamByName('a043_pBCFCPRet').Value := oObjeto.cPbcfcpret;
        oQuery.Parameters.ParamByName('a043_pBCFCPST').Value := oObjeto.cPbcfcpst;
        oQuery.Parameters.ParamByName('a043_pCredSN').Value := oObjeto.cPcredsn;
        oQuery.Parameters.ParamByName('a043_pDif').Value := oObjeto.cPdif;
        oQuery.Parameters.ParamByName('a043_pEntMVAST').Value := oObjeto.cPentmvast;
        oQuery.Parameters.ParamByName('a043_per_cofins_socio').Value := oObjeto.cPerCofinsSocio;
        oQuery.Parameters.ParamByName('a043_per_pis_socio').Value := oObjeto.cPerPisSocio;
        oQuery.Parameters.ParamByName('a043_perc_csll').Value := oObjeto.cPercCsll;
        oQuery.Parameters.ParamByName('a043_perc_inss').Value := oObjeto.cPercInss;
        oQuery.Parameters.ParamByName('a043_perc_irrf').Value := oObjeto.cPercIrrf;
        oQuery.Parameters.ParamByName('a043_perc_nret_adic').Value := oObjeto.cPercNretAdic;
        oQuery.Parameters.ParamByName('a043_perc_nret_princ').Value := oObjeto.cPercNretPrinc;
        oQuery.Parameters.ParamByName('a043_perc_red_base_cal_substituicao').Value := oObjeto.cPercRedBaseCalSubstituicao;
        oQuery.Parameters.ParamByName('a043_perc_ret_15').Value := oObjeto.cPercRet15;
        oQuery.Parameters.ParamByName('a043_perc_ret_20').Value := oObjeto.cPercRet20;
        oQuery.Parameters.ParamByName('a043_perc_ret_25').Value := oObjeto.cPercRet25;
        oQuery.Parameters.ParamByName('a043_percentual_residual').Value := oObjeto.cPercentualResidual;
        oQuery.Parameters.ParamByName('a043_permite_ibpt').Value := oObjeto.sPermiteIbpt;
        oQuery.Parameters.ParamByName('a043_permite_nf').Value := oObjeto.sPermiteNf;
        oQuery.Parameters.ParamByName('a043_pFCP').Value := oObjeto.cPfcp;
        oQuery.Parameters.ParamByName('a043_pFCPRet').Value := oObjeto.cPfcpret;
        oQuery.Parameters.ParamByName('a043_pFCPST').Value := oObjeto.cPfcpst;
        oQuery.Parameters.ParamByName('a043_pis').Value := oObjeto.cPis;
        oQuery.Parameters.ParamByName('a043_pMVAST').Value := oObjeto.cPmvast;
        oQuery.Parameters.ParamByName('a043_preco_produto').Value := oObjeto.sPrecoProduto;
        oQuery.Parameters.ParamByName('a043_pST').Value := oObjeto.cPst;
        oQuery.Parameters.ParamByName('a043_red_bc_csll').Value := oObjeto.cRedBcCsll;
        oQuery.Parameters.ParamByName('a043_red_bc_inss').Value := oObjeto.cRedBcInss;
        oQuery.Parameters.ParamByName('a043_red_bc_irrf').Value := oObjeto.cRedBcIrrf;
        oQuery.Parameters.ParamByName('a043_situacao_tributaria_cofins').Value := oObjeto.sSituacaoTributariaCofins;
        oQuery.Parameters.ParamByName('a043_situacao_tributaria_pis').Value := oObjeto.sSituacaoTributariaPis;        oQuery.Parameters.ParamByName('a043_tab_cofins').Value := oObjeto.sTabCofins;
        oQuery.Parameters.ParamByName('a043_tab_pis').Value := oObjeto.sTabPis;
        oQuery.Parameters.ParamByName('a043_tipo_preco').Value := oObjeto.sTipoPreco;
        oQuery.Parameters.ParamByName('a043_tipo_tes').Value := oObjeto.sTipoTes;
        oQuery.Parameters.ParamByName('a043_tributacao').Value := oObjeto.sTributacao;
        oQuery.Parameters.ParamByName('a043_usa_cfop').Value := oObjeto.sUsaCfop;
        oQuery.Parameters.ParamByName('a043_usa_FCP').Value := oObjeto.sUsaFcp;
        oQuery.Parameters.ParamByName('a043_usa_funrural').Value := oObjeto.sUsaFunrural;
        oQuery.Parameters.ParamByName('a043_usa_produtos').Value := oObjeto.sUsaProdutos;
        oQuery.Parameters.ParamByName('a043_usa_senar').Value := oObjeto.sUsaSenar;
        oQuery.Parameters.ParamByName('a043_usa_trib_pis').Value := oObjeto.sUsaTribPis;
        oQuery.Parameters.ParamByName('a043_usa_trib_serv').Value := oObjeto.sUsaTribServ;
        oQuery.Parameters.ParamByName('a043_usuario').Value := oObjeto.sUsuario;
        oQuery.Parameters.ParamByName('a043_utiliza_preco_pauta').Value := oObjeto.sUtilizaPrecoPauta;
        oQuery.Parameters.ParamByName('a043_v_bc_efet_opc').Value := oObjeto.cVBcEfetOpc;
        oQuery.Parameters.ParamByName('a043_v_bc_fcp_st_ret_opc').Value := oObjeto.cVBcFcpStRetOpc;
        oQuery.Parameters.ParamByName('a043_v_bc_fcp_uf_dest_opc').Value := oObjeto.cVBcFcpUfDestOpc;
        oQuery.Parameters.ParamByName('a043_v_bc_st_dest_opc').Value := oObjeto.cVBcStDestOpc;
        oQuery.Parameters.ParamByName('a043_v_bc_st_ret_opc').Value := oObjeto.cVBcStRetOpc;
        oQuery.Parameters.ParamByName('a043_v_bc_uf_dest').Value := oObjeto.cVBcUfDest;
        oQuery.Parameters.ParamByName('a043_v_fcp_st_ret_opc').Value := oObjeto.cVFcpStRetOpc;
        oQuery.Parameters.ParamByName('a043_v_fcp_uf_dest_opc').Value := oObjeto.cVFcpUfDestOpc;
        oQuery.Parameters.ParamByName('a043_v_icms_efet_opc').Value := oObjeto.cVIcmsEfetOpc;
        oQuery.Parameters.ParamByName('a043_v_icms_st_dest_opc').Value := oObjeto.cVIcmsStDestOpc;
        oQuery.Parameters.ParamByName('a043_v_icms_st_ret_opc').Value := oObjeto.cVIcmsStRetOpc;
        oQuery.Parameters.ParamByName('a043_v_icms_substituto_opc').Value := oObjeto.cVIcmsSubstitutoOpc;
        oQuery.Parameters.ParamByName('a043_v_icms_uf_dest').Value := oObjeto.cVIcmsUfDest;
        oQuery.Parameters.ParamByName('a043_v_icms_uf_remet').Value := oObjeto.cVIcmsUfRemet;
        oQuery.Parameters.ParamByName('a043_vinculo_doc_fiscal').Value := oObjeto.sVinculoDocFiscal;
        if bSetarCodSeq then
        begin
                oQuery.Parameters.ParamByName('a043_codigo').Value := oObjeto.sCodigo;
                oQuery.Parameters.ParamByName('a043_sequencial').Value := oObjeto.iSequencial;
        end
end;

function TesDAO.SubLinhaParaObjeto;
var
        oObjeto: TTes;
begin
        oObjeto := nil;
        try
                oObjeto := TTes.Create();
                oObjeto.sAjusteCredito := oFields.FieldByName('a043_ajuste_credito').AsString;
                oObjeto.sAjusteDebito := oFields.FieldByName('a043_ajuste_debito').AsString;
                oObjeto.cAliqRet := oFields.FieldByName('a043_aliq_ret').AsCurrency;
                oObjeto.cAliqRetSub := oFields.FieldByName('a043_aliq_ret_sub').AsCurrency;
                oObjeto.cAliqintst := oFields.FieldByName('a043_AliqIntST').AsCurrency;
                oObjeto.cAliqst := oFields.FieldByName('a043_AliqST').AsCurrency;
                oObjeto.sAliquotaFrete := oFields.FieldByName('a043_aliquota_frete').AsString;
                oObjeto.sAtualizaEst := oFields.FieldByName('a043_atualiza_est').AsString;
                oObjeto.cBaseCalcIcm := oFields.FieldByName('a043_base_calc_icm').AsCurrency;
                oObjeto.cBaseCalculoCofins := oFields.FieldByName('a043_base_calculo_cofins').AsCurrency;
                oObjeto.sBaseCalculoFrete := oFields.FieldByName('a043_base_calculo_frete').AsString;
                oObjeto.cBaseCalculoPis := oFields.FieldByName('a043_base_calculo_pis').AsCurrency;
                oObjeto.cBaseCofinsSocio := oFields.FieldByName('a043_base_cofins_socio').AsCurrency;
                oObjeto.cBasePisSocio := oFields.FieldByName('a043_base_pis_socio').AsCurrency;
                oObjeto.cBcIpi := oFields.FieldByName('a043_bc_ipi').AsCurrency;
                oObjeto.cBcRet := oFields.FieldByName('a043_bc_ret').AsCurrency;
                oObjeto.cBcRetSub := oFields.FieldByName('a043_bc_ret_sub').AsCurrency;
                oObjeto.cBcSenar := oFields.FieldByName('a043_bc_senar').AsCurrency;
                oObjeto.sCatPessoa := oFields.FieldByName('a043_cat_pessoa').AsString;
                oObjeto.sCodAjApuracaoDeducao := oFields.FieldByName('a043_cod_aj_apuracao_deducao').AsString;                oObjeto.sCodAjIcmsExIcms := oFields.FieldByName('a043_cod_aj_icms_ex_icms').AsString;
                oObjeto.sCodColMapa := oFields.FieldByName('a043_cod_col_mapa').AsString;
                oObjeto.iCodEnqIpi := oFields.FieldByName('a043_cod_Enq_ipi').AsInteger;
                oObjeto.sCodInfluenciaRecolhimento := oFields.FieldByName('a043_cod_influencia_recolhimento').AsString;
                oObjeto.sCodObrigacaoARecolher := oFields.FieldByName('a043_cod_obrigacao_a_recolher').AsString;
                oObjeto.sCodOcorrenciaAjIcms := oFields.FieldByName('a043_cod_ocorrencia_aj_icms').AsString;
                oObjeto.sCodOrigemTributacao := oFields.FieldByName('a043_cod_origem_tributacao').AsString;
                oObjeto.sCodPessoa := oFields.FieldByName('a043_cod_pessoa').AsString;
                oObjeto.sCodReflexoApurIcms := oFields.FieldByName('a043_cod_reflexo_apur_icms').AsString;
                oObjeto.sCodResponsabilidade := oFields.FieldByName('a043_cod_responsabilidade').AsString;
                oObjeto.sCodSitTrib := oFields.FieldByName('a043_cod_sit_trib').AsString;
                oObjeto.sCodTesEstorno := oFields.FieldByName('a043_cod_tes_estorno').AsString;
                oObjeto.sCodTipoApuracao := oFields.FieldByName('a043_cod_tipo_apuracao').AsString;
                oObjeto.sCodTipoCredito := oFields.FieldByName('a043_cod_tipo_credito').AsString;
                oObjeto.sCodTipoUtilizacaoCredito := oFields.FieldByName('a043_cod_tipo_utilizacao_credito').AsString;
                oObjeto.sCodigo := oFields.FieldByName('a043_codigo').AsString;
                oObjeto.sCodigoFiscal := oFields.FieldByName('a043_codigo_fiscal').AsString;
                oObjeto.cCofins := oFields.FieldByName('a043_cofins').AsCurrency;
                oObjeto.sCstIpi := oFields.FieldByName('a043_cst_ipi').AsString;
                oObjeto.dDatetime := oFields.FieldByName('a043_datetime').AsDateTime;
                oObjeto.cDepreciacaoAnual := oFields.FieldByName('a043_depreciacao_anual').AsCurrency;
                oObjeto.sDescCfop := oFields.FieldByName('a043_desc_cfop').AsString;
                oObjeto.sDescricao := oFields.FieldByName('a043_descricao').AsString;
                oObjeto.sEnviaDeposito := oFields.FieldByName('a043_envia_deposito').AsString;
                oObjeto.sEscrita := oFields.FieldByName('a043_escrita').AsString;
                oObjeto.sEspeciePessoa := oFields.FieldByName('a043_especie_pessoa').AsString;
                oObjeto.sEstado := oFields.FieldByName('a043_estado').AsString;
                oObjeto.sExigeNfProd := oFields.FieldByName('a043_exige_nf_prod').AsString;
                oObjeto.sFinalidadeNfe := oFields.FieldByName('a043_finalidade_nfe').AsString;
                oObjeto.cFunrural := oFields.FieldByName('a043_funrural').AsCurrency;
                oObjeto.sFunruralEntSai := oFields.FieldByName('a043_funrural_ent_sai').AsString;
                oObjeto.sGeraFinanceiro := oFields.FieldByName('a043_gera_financeiro').AsString;
                oObjeto.sGeraSped := oFields.FieldByName('a043_gera_sped').AsString;
                oObjeto.cIcm := oFields.FieldByName('a043_icm').AsCurrency;
                oObjeto.cIpi := oFields.FieldByName('a043_ipi').AsCurrency;
                oObjeto.cIssqn := oFields.FieldByName('a043_issqn').AsCurrency;
                oObjeto.cMargemSubstTributaria := oFields.FieldByName('a043_margem_subst_tributaria').AsCurrency;
                oObjeto.sMensagemNf := oFields.FieldByName('a043_mensagem_nf').AsString;
                oObjeto.sMensagemNf01 := oFields.FieldByName('a043_mensagem_nf_01').AsString;
                oObjeto.sModBaseCalculo := oFields.FieldByName('a043_mod_base_calculo').AsString;
                oObjeto.sModBaseCalculoSubstituicao := oFields.FieldByName('a043_mod_base_calculo_substituicao').AsString;
                oObjeto.sMotDesoneracao := oFields.FieldByName('a043_mot_desoneracao').AsString;
                oObjeto.sMovCtaCapital := oFields.FieldByName('a043_mov_cta_capital').AsString;
                oObjeto.sMovCtaSocio := oFields.FieldByName('a043_mov_cta_socio').AsString;
                oObjeto.sMovCusto := oFields.FieldByName('a043_mov_custo').AsString;
                oObjeto.sMovDespSecagem := oFields.FieldByName('a043_mov_desp_secagem').AsString;
                oObjeto.sObs := oFields.FieldByName('a043_obs').AsString;
                oObjeto.sObsContribuinte := oFields.FieldByName('a043_obs_contribuinte').AsString;
                oObjeto.sObsFiscal := oFields.FieldByName('a043_obs_fiscal').AsString;
                oObjeto.sOperacaoTes := oFields.FieldByName('a043_operacao_tes').AsString;
                oObjeto.cPFcpStRetOpc := oFields.FieldByName('a043_p_fcp_st_ret_opc').AsCurrency;
                oObjeto.cPFcpUfDestOpc := oFields.FieldByName('a043_p_fcp_uf_dest_opc').AsCurrency;
                oObjeto.cPIcmsEfetOpc := oFields.FieldByName('a043_p_icms_efet_opc').AsCurrency;
                oObjeto.cPIcmsInter := oFields.FieldByName('a043_p_icms_inter').AsCurrency;
                oObjeto.cPIcmsInterPart := oFields.FieldByName('a043_p_icms_inter_part').AsCurrency;
                oObjeto.cPIcmsUfDest := oFields.FieldByName('a043_p_icms_uf_dest').AsCurrency;
                oObjeto.cPRedBcEfetOpc := oFields.FieldByName('a043_p_red_bc_efet_opc').AsCurrency;
                oObjeto.cPSenar := oFields.FieldByName('a043_p_senar').AsCurrency;
                oObjeto.cPStOpc := oFields.FieldByName('a043_p_st_opc').AsCurrency;
                oObjeto.cPbcfcp := oFields.FieldByName('a043_pBCFCP').AsCurrency;
                oObjeto.cPbcfcpret := oFields.FieldByName('a043_pBCFCPRet').AsCurrency;
                oObjeto.cPbcfcpst := oFields.FieldByName('a043_pBCFCPST').AsCurrency;
                oObjeto.cPcredsn := oFields.FieldByName('a043_pCredSN').AsCurrency;
                oObjeto.cPdif := oFields.FieldByName('a043_pDif').AsCurrency;
                oObjeto.cPentmvast := oFields.FieldByName('a043_pEntMVAST').AsCurrency;
                oObjeto.cPerCofinsSocio := oFields.FieldByName('a043_per_cofins_socio').AsCurrency;
                oObjeto.cPerPisSocio := oFields.FieldByName('a043_per_pis_socio').AsCurrency;
                oObjeto.cPercCsll := oFields.FieldByName('a043_perc_csll').AsCurrency;
                oObjeto.cPercInss := oFields.FieldByName('a043_perc_inss').AsCurrency;
                oObjeto.cPercIrrf := oFields.FieldByName('a043_perc_irrf').AsCurrency;
                oObjeto.cPercNretAdic := oFields.FieldByName('a043_perc_nret_adic').AsCurrency;
                oObjeto.cPercNretPrinc := oFields.FieldByName('a043_perc_nret_princ').AsCurrency;
                oObjeto.cPercRedBaseCalSubstituicao := oFields.FieldByName('a043_perc_red_base_cal_substituicao').AsCurrency;
                oObjeto.cPercRet15 := oFields.FieldByName('a043_perc_ret_15').AsCurrency;
                oObjeto.cPercRet20 := oFields.FieldByName('a043_perc_ret_20').AsCurrency;
                oObjeto.cPercRet25 := oFields.FieldByName('a043_perc_ret_25').AsCurrency;
                oObjeto.cPercentualResidual := oFields.FieldByName('a043_percentual_residual').AsCurrency;
                oObjeto.sPermiteIbpt := oFields.FieldByName('a043_permite_ibpt').AsString;
                oObjeto.sPermiteNf := oFields.FieldByName('a043_permite_nf').AsString;
                oObjeto.cPfcp := oFields.FieldByName('a043_pFCP').AsCurrency;
                oObjeto.cPfcpret := oFields.FieldByName('a043_pFCPRet').AsCurrency;
                oObjeto.cPfcpst := oFields.FieldByName('a043_pFCPST').AsCurrency;
                oObjeto.cPis := oFields.FieldByName('a043_pis').AsCurrency;
                oObjeto.cPmvast := oFields.FieldByName('a043_pMVAST').AsCurrency;
                oObjeto.sPrecoProduto := oFields.FieldByName('a043_preco_produto').AsString;
                oObjeto.cPst := oFields.FieldByName('a043_pST').AsCurrency;
                oObjeto.cRedBcCsll := oFields.FieldByName('a043_red_bc_csll').AsCurrency;
                oObjeto.cRedBcInss := oFields.FieldByName('a043_red_bc_inss').AsCurrency;
                oObjeto.cRedBcIrrf := oFields.FieldByName('a043_red_bc_irrf').AsCurrency;
                oObjeto.iSequencial := oFields.FieldByName('a043_sequencial').AsLargeInt;
                oObjeto.sSituacaoTributariaCofins := oFields.FieldByName('a043_situacao_tributaria_cofins').AsString;
                oObjeto.sSituacaoTributariaPis := oFields.FieldByName('a043_situacao_tributaria_pis').AsString;
                oObjeto.sTabCofins := oFields.FieldByName('a043_tab_cofins').AsString;
                oObjeto.sTabPis := oFields.FieldByName('a043_tab_pis').AsString;
                oObjeto.sTipoPreco := oFields.FieldByName('a043_tipo_preco').AsString;
                oObjeto.sTipoTes := oFields.FieldByName('a043_tipo_tes').AsString;
                oObjeto.sTributacao := oFields.FieldByName('a043_tributacao').AsString;
                oObjeto.sUsaCfop := oFields.FieldByName('a043_usa_cfop').AsString;
                oObjeto.sUsaFcp := oFields.FieldByName('a043_usa_FCP').AsString;
                oObjeto.sUsaFunrural := oFields.FieldByName('a043_usa_funrural').AsString;
                oObjeto.sUsaProdutos := oFields.FieldByName('a043_usa_produtos').AsString;
                oObjeto.sUsaSenar := oFields.FieldByName('a043_usa_senar').AsString;
                oObjeto.sUsaTribPis := oFields.FieldByName('a043_usa_trib_pis').AsString;
                oObjeto.sUsaTribServ := oFields.FieldByName('a043_usa_trib_serv').AsString;
                oObjeto.sUsuario := oFields.FieldByName('a043_usuario').AsString;
                oObjeto.sUtilizaPrecoPauta := oFields.FieldByName('a043_utiliza_preco_pauta').AsString;
                oObjeto.cVBcEfetOpc := oFields.FieldByName('a043_v_bc_efet_opc').AsCurrency;
                oObjeto.cVBcFcpStRetOpc := oFields.FieldByName('a043_v_bc_fcp_st_ret_opc').AsCurrency;
                oObjeto.cVBcFcpUfDestOpc := oFields.FieldByName('a043_v_bc_fcp_uf_dest_opc').AsCurrency;
                oObjeto.cVBcStDestOpc := oFields.FieldByName('a043_v_bc_st_dest_opc').AsCurrency;
                oObjeto.cVBcStRetOpc := oFields.FieldByName('a043_v_bc_st_ret_opc').AsCurrency;
                oObjeto.cVBcUfDest := oFields.FieldByName('a043_v_bc_uf_dest').AsCurrency;
                oObjeto.cVFcpStRetOpc := oFields.FieldByName('a043_v_fcp_st_ret_opc').AsCurrency;
                oObjeto.cVFcpUfDestOpc := oFields.FieldByName('a043_v_fcp_uf_dest_opc').AsCurrency;
                oObjeto.cVIcmsEfetOpc := oFields.FieldByName('a043_v_icms_efet_opc').AsCurrency;
                oObjeto.cVIcmsStDestOpc := oFields.FieldByName('a043_v_icms_st_dest_opc').AsCurrency;
                oObjeto.cVIcmsStRetOpc := oFields.FieldByName('a043_v_icms_st_ret_opc').AsCurrency;
                oObjeto.cVIcmsSubstitutoOpc := oFields.FieldByName('a043_v_icms_substituto_opc').AsCurrency;
                oObjeto.cVIcmsUfDest := oFields.FieldByName('a043_v_icms_uf_dest').AsCurrency;
                oObjeto.cVIcmsUfRemet := oFields.FieldByName('a043_v_icms_uf_remet').AsCurrency;
                oObjeto.sVinculoDocFiscal := oFields.FieldByName('a043_vinculo_doc_fiscal').AsString;
                Result := oObjeto;
        except
                if oObjeto <> nil then
                        oObjeto.free;
                raise;
        end;
end;

end.
