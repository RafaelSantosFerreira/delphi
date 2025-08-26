unit untTes;

interface

uses
  SysUtils, Classes, untKValidador, untModelos;

type
  TSituacaoTributaria = class;
  TCidades = class;
  TCstIva = class;
  TTes = class;

  TTes = class(TModeloBase)
	private
		_sDescricao: String;
			_sCodigoFiscal: String;
			_sTipoTes: String;
			_sAtualizaEst: String;
			_sGeraFinanceiro: String;
			_sEstado: String;
			_sObs: String;
			_sMovCtaCapital: String;
			_sMovCtaSocio: String;
			_sMovDespSecagem: String;
			_sEspeciePessoa: String;
			_sCatPessoa: String;
			_sTributacao: String;
			_cBaseCalcIcm: Currency;
			_cIcm: Currency;
			_sCodSitTrib: String;
			_sMensagemNf: String;
			_sUtilizaPrecoPauta: String;
			_cFunrural: Currency;
			_cPis: Currency;
			_cCofins: Currency;
			_cIpi: Currency;
			_sDescCfop: String;
			_sCodPessoa: String;
			_sOperacaoTes: String;
			_sMovCusto: String;
			_sCodTesEstorno: String;
			_sCodColMapa: String;
			_sFinalidadeNfe: String;
			_sModBaseCalculo: String;
			_sModBaseCalculoSubstituicao: String;
			_sSituacaoTributariaCofins: String;
			_sSituacaoTributariaPis: String;
			_cBaseCalculoCofins: Currency;
			_sBaseCalculoFrete: String;
			_sAliquotaFrete: String;
			_sObsFiscal: String;
			_sObsContribuinte: String;
			_cBaseCalculoPis: Currency;
			_cMargemSubstTributaria: Currency;
			_cPercRedBaseCalSubstituicao: Currency;
			_sPrecoProduto: String;
			_sPermiteNf: String;
			_cIssqn: Currency;
			_cBcIpi: Currency;
			_sMotDesoneracao: String;
			_sExigeNfProd: String;
			_sVinculoDocFiscal: String;
			_sFunruralEntSai: String;
			_sEscrita: String;
			_sAjusteCredito: String;
			_sMensagemNf01: String;
			_sTabPis: String;
			_cPerPisSocio: Currency;
			_cBasePisSocio: Currency;
			_sTabCofins: String;
			_cPerCofinsSocio: Currency;
			_cBaseCofinsSocio: Currency;
			_iCodEnqIpi: Integer;
			_sCstIpi: String;
			_sUsaTribPis: String;
			_cPSenar: Currency;
			_cBcSenar: Currency;
			_sUsaProdutos: String;
			_sCodAjApuracaoDeducao: String;
			_sCodOcorrenciaAjIcms: String;
			_sCodReflexoApurIcms: String;
			_sCodTipoApuracao: String;
			_sCodResponsabilidade: String;
			_sCodInfluenciaRecolhimento: String;
			_sCodOrigemTributacao: String;
			_sCodAjIcmsExIcms: String;
			_sCodObrigacaoARecolher: String;
			_sCodTipoUtilizacaoCredito: String;
			_sAjusteDebito: String;
			_sCodTipoCredito: String;
			_sUsaSenar: String;
			_sUsuario: String;
			_dDatetime: TDateTime;
			_cPcredsn: Currency;
			_sGeraSped: String;
			_sPermiteIbpt: String;
			_cDepreciacaoAnual: Currency;
			_cPercentualResidual: Currency;
			_sUsaFunrural: String;
			_cPdif: Currency;
			_cPmvast: Currency;
			_cPentmvast: Currency;
			_cAliqintst: Currency;
			_cAliqst: Currency;
			_sEnviaDeposito: String;
			_sTipoPreco: String;
			_cPbcfcp: Currency;
			_cPfcp: Currency;
			_cPbcfcpst: Currency;
			_cPfcpst: Currency;
			_cPbcfcpret: Currency;
			_cPfcpret: Currency;
			_cPst: Currency;
			_sUsaFcp: String;
			_sUsaTribServ: String;
			_cRedBcCsll: Currency;
			_cPercCsll: Currency;
			_cRedBcIrrf: Currency;
			_cPercIrrf: Currency;
			_cRedBcInss: Currency;
			_cPercInss: Currency;
			_cBcRet: Currency;
			_cAliqRet: Currency;
			_cBcRetSub: Currency;
			_cAliqRetSub: Currency;
			_cPercNretPrinc: Currency;
			_cPercRet15: Currency;
			_cPercRet20: Currency;
			_cPercRet25: Currency;
			_cPercNretAdic: Currency;
			_cVBcStRetOpc: Currency;
			_cPStOpc: Currency;
			_cVIcmsSubstitutoOpc: Currency;
			_cVIcmsStRetOpc: Currency;
			_cVBcFcpStRetOpc: Currency;
			_cPFcpStRetOpc: Currency;
			_cVFcpStRetOpc: Currency;
			_cPRedBcEfetOpc: Currency;
			_cVBcEfetOpc: Currency;
			_cPIcmsEfetOpc: Currency;
			_cVIcmsEfetOpc: Currency;
			_cVBcStDestOpc: Currency;
			_cVIcmsStDestOpc: Currency;
			_cVBcUfDest: Currency;
			_cVBcFcpUfDestOpc: Currency;
			_cPFcpUfDestOpc: Currency;
			_cPIcmsUfDest: Currency;
			_cPIcmsInter: Currency;
			_cPIcmsInterPart: Currency;
			_cVFcpUfDestOpc: Currency;
			_cVIcmsUfDest: Currency;
			_cVIcmsUfRemet: Currency;
			_sUsaCfop: String;
			_sIbs: String;
			_cIbsAliquota: Currency;
			_cIbsBaseCalc: Currency;
			_sIss: String;
			_cIssAliquota: Currency;
			_cIssBaseCalc: Currency;
			_sCbs: String;
			_cCbsAliquota: Currency;
			_cCbsBaseCalc: Currency;
			_sCodIva: String;
			_sCodCidade: String;
			_sCstIbs: String;
			_sCstIss: String;
			_sCstCbs: String;
			_oCodSitTrib: TSituacaoTributaria;
			_oCodCidade: TCidades;
			_oCodIva: TCstIva;
			_oCodTesEstorno: TTes;

		function getOCodSitTrib: TSituacaoTributaria;
			procedure setOCodSitTrib(obj: TSituacaoTributaria);
			function getOCodCidade: TCidades;
			procedure setOCodCidade(obj: TCidades);
			function getOCodIva: TCstIva;
			procedure setOCodIva(obj: TCstIva);
			function getOCodTesEstorno: TTes;
			procedure setOCodTesEstorno(obj: TTes);
	public
		destructor Destroy; override;

		[KValidadorBanco('a043_tes', 'a043_AliqIntST', 'money', 19, 4)]
			property cAliqintst: Currency read _cAliqintst write _cAliqintst;
			[KValidadorBanco('a043_tes', 'a043_AliqST', 'money', 19, 4)]
			property cAliqst: Currency read _cAliqst write _cAliqst;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_ajuste_credito', 'nvarchar', 5, 0)]
			property sAjusteCredito: String read _sAjusteCredito write _sAjusteCredito;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_ajuste_debito', 'nvarchar', 5, 0)]
			property sAjusteDebito: String read _sAjusteDebito write _sAjusteDebito;
			[KValidadorBanco('a043_tes', 'a043_aliq_ret', 'numeric', 18, 4)]
			property cAliqRet: Currency read _cAliqRet write _cAliqRet;
			[KValidadorBanco('a043_tes', 'a043_aliq_ret_sub', 'numeric', 18, 4)]
			property cAliqRetSub: Currency read _cAliqRetSub write _cAliqRetSub;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_aliquota_frete', 'nvarchar', 50, 0)]
			property sAliquotaFrete: String read _sAliquotaFrete write _sAliquotaFrete;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_atualiza_est', 'nvarchar', 50, 0)]
			property sAtualizaEst: String read _sAtualizaEst write _sAtualizaEst;
			[KValidadorBanco('a043_tes', 'a043_base_calc_icm', 'money', 19, 4)]
			property cBaseCalcIcm: Currency read _cBaseCalcIcm write _cBaseCalcIcm;
			[KValidadorBanco('a043_tes', 'a043_base_calculo_cofins', 'money', 19, 4)]
			property cBaseCalculoCofins: Currency read _cBaseCalculoCofins write _cBaseCalculoCofins;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_base_calculo_frete', 'nvarchar', 50, 0)]
			property sBaseCalculoFrete: String read _sBaseCalculoFrete write _sBaseCalculoFrete;
			[KValidadorBanco('a043_tes', 'a043_base_calculo_pis', 'money', 19, 4)]
			property cBaseCalculoPis: Currency read _cBaseCalculoPis write _cBaseCalculoPis;
			[KValidadorBanco('a043_tes', 'a043_base_cofins_socio', 'money', 19, 4)]
			property cBaseCofinsSocio: Currency read _cBaseCofinsSocio write _cBaseCofinsSocio;
			[KValidadorBanco('a043_tes', 'a043_base_pis_socio', 'money', 19, 4)]
			property cBasePisSocio: Currency read _cBasePisSocio write _cBasePisSocio;
			[KValidadorBanco('a043_tes', 'a043_bc_ipi', 'numeric', 10, 3)]
			property cBcIpi: Currency read _cBcIpi write _cBcIpi;
			[KValidadorBanco('a043_tes', 'a043_bc_ret', 'numeric', 18, 4)]
			property cBcRet: Currency read _cBcRet write _cBcRet;
			[KValidadorBanco('a043_tes', 'a043_bc_ret_sub', 'numeric', 18, 4)]
			property cBcRetSub: Currency read _cBcRetSub write _cBcRetSub;
			[KValidadorBanco('a043_tes', 'a043_bc_senar', 'money', 19, 4)]
			property cBcSenar: Currency read _cBcSenar write _cBcSenar;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cat_pessoa', 'nvarchar', 50, 0)]
			property sCatPessoa: String read _sCatPessoa write _sCatPessoa;
			[KValidadorTamanho(-1, 20), KValidadorBanco('a043_tes', 'a043_cbs', 'nvarchar', 20, 0)]
			property sCbs: String read _sCbs write _sCbs;
			[KValidadorBanco('a043_tes', 'a043_cbs_aliquota', 'money', 19, 4)]
			property cCbsAliquota: Currency read _cCbsAliquota write _cCbsAliquota;
			[KValidadorBanco('a043_tes', 'a043_cbs_base_calc', 'money', 19, 4)]
			property cCbsBaseCalc: Currency read _cCbsBaseCalc write _cCbsBaseCalc;
			[KValidadorBanco('a043_tes', 'a043_cod_Enq_ipi', 'numeric', 5, 0)]
			property iCodEnqIpi: Integer read _iCodEnqIpi write _iCodEnqIpi;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_aj_apuracao_deducao', 'nvarchar', 50, 0)]
			property sCodAjApuracaoDeducao: String read _sCodAjApuracaoDeducao write _sCodAjApuracaoDeducao;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_aj_icms_ex_icms', 'nvarchar', 50, 0)]
			property sCodAjIcmsExIcms: String read _sCodAjIcmsExIcms write _sCodAjIcmsExIcms;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_cidade', 'nvarchar', 12, 0)]
			property sCodCidade: String read _sCodCidade write _sCodCidade;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_col_mapa', 'nvarchar', 12, 0)]
			property sCodColMapa: String read _sCodColMapa write _sCodColMapa;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_influencia_recolhimento', 'nvarchar', 50, 0)]
			property sCodInfluenciaRecolhimento: String read _sCodInfluenciaRecolhimento write _sCodInfluenciaRecolhimento;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_iva', 'nvarchar', 12, 0)]
			property sCodIva: String read _sCodIva write _sCodIva;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_cod_obrigacao_a_recolher', 'nvarchar', 100, 0)]
			property sCodObrigacaoARecolher: String read _sCodObrigacaoARecolher write _sCodObrigacaoARecolher;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_ocorrencia_aj_icms', 'nvarchar', 50, 0)]
			property sCodOcorrenciaAjIcms: String read _sCodOcorrenciaAjIcms write _sCodOcorrenciaAjIcms;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_origem_tributacao', 'nvarchar', 50, 0)]
			property sCodOrigemTributacao: String read _sCodOrigemTributacao write _sCodOrigemTributacao;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_pessoa', 'nvarchar', 12, 0)]
			property sCodPessoa: String read _sCodPessoa write _sCodPessoa;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_reflexo_apur_icms', 'nvarchar', 50, 0)]
			property sCodReflexoApurIcms: String read _sCodReflexoApurIcms write _sCodReflexoApurIcms;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_responsabilidade', 'nvarchar', 50, 0)]
			property sCodResponsabilidade: String read _sCodResponsabilidade write _sCodResponsabilidade;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_sit_trib', 'nvarchar', 12, 0)]
			property sCodSitTrib: String read _sCodSitTrib write _sCodSitTrib;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_tes_estorno', 'nvarchar', 12, 0)]
			property sCodTesEstorno: String read _sCodTesEstorno write _sCodTesEstorno;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_tipo_apuracao', 'nvarchar', 50, 0)]
			property sCodTipoApuracao: String read _sCodTipoApuracao write _sCodTipoApuracao;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_cod_tipo_credito', 'nvarchar', 12, 0)]
			property sCodTipoCredito: String read _sCodTipoCredito write _sCodTipoCredito;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_cod_tipo_utilizacao_credito', 'nvarchar', 50, 0)]
			property sCodTipoUtilizacaoCredito: String read _sCodTipoUtilizacaoCredito write _sCodTipoUtilizacaoCredito;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_codigo_fiscal', 'nvarchar', 10, 0)]
			property sCodigoFiscal: String read _sCodigoFiscal write _sCodigoFiscal;
			[KValidadorBanco('a043_tes', 'a043_cofins', 'money', 19, 4)]
			property cCofins: Currency read _cCofins write _cCofins;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_cst_cbs', 'nvarchar', 10, 0)]
			property sCstCbs: String read _sCstCbs write _sCstCbs;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_cst_ibs', 'nvarchar', 10, 0)]
			property sCstIbs: String read _sCstIbs write _sCstIbs;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_cst_ipi', 'nvarchar', 100, 0)]
			property sCstIpi: String read _sCstIpi write _sCstIpi;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_cst_iss', 'nvarchar', 10, 0)]
			property sCstIss: String read _sCstIss write _sCstIss;
			[KValidadorBanco('a043_tes', 'a043_datetime', 'datetime', 0, 0)]
			property dDatetime: TDateTime read _dDatetime write _dDatetime;
			[KValidadorBanco('a043_tes', 'a043_depreciacao_anual', 'money', 19, 4)]
			property cDepreciacaoAnual: Currency read _cDepreciacaoAnual write _cDepreciacaoAnual;
			[KValidadorTamanho(-1, 20), KValidadorBanco('a043_tes', 'a043_desc_cfop', 'nvarchar', 20, 0)]
			property sDescCfop: String read _sDescCfop write _sDescCfop;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_descricao', 'nvarchar', 50, 0)]
			property sDescricao: String read _sDescricao write _sDescricao;
			[KValidadorTamanho(-1, 3), KValidadorBanco('a043_tes', 'a043_envia_deposito', 'nvarchar', 3, 0)]
			property sEnviaDeposito: String read _sEnviaDeposito write _sEnviaDeposito;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_escrita', 'nvarchar', 5, 0)]
			property sEscrita: String read _sEscrita write _sEscrita;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_especie_pessoa', 'nvarchar', 50, 0)]
			property sEspeciePessoa: String read _sEspeciePessoa write _sEspeciePessoa;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_estado', 'nvarchar', 50, 0)]
			property sEstado: String read _sEstado write _sEstado;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_exige_nf_prod', 'nvarchar', 50, 0)]
			property sExigeNfProd: String read _sExigeNfProd write _sExigeNfProd;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_finalidade_nfe', 'nvarchar', 50, 0)]
			property sFinalidadeNfe: String read _sFinalidadeNfe write _sFinalidadeNfe;
			[KValidadorBanco('a043_tes', 'a043_funrural', 'money', 19, 4)]
			property cFunrural: Currency read _cFunrural write _cFunrural;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_funrural_ent_sai', 'nvarchar', 50, 0)]
			property sFunruralEntSai: String read _sFunruralEntSai write _sFunruralEntSai;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_gera_financeiro', 'nvarchar', 50, 0)]
			property sGeraFinanceiro: String read _sGeraFinanceiro write _sGeraFinanceiro;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_gera_sped', 'nvarchar', 5, 0)]
			property sGeraSped: String read _sGeraSped write _sGeraSped;
			[KValidadorTamanho(-1, 20), KValidadorBanco('a043_tes', 'a043_ibs', 'nvarchar', 20, 0)]
			property sIbs: String read _sIbs write _sIbs;
			[KValidadorBanco('a043_tes', 'a043_ibs_aliquota', 'money', 19, 4)]
			property cIbsAliquota: Currency read _cIbsAliquota write _cIbsAliquota;
			[KValidadorBanco('a043_tes', 'a043_ibs_base_calc', 'money', 19, 4)]
			property cIbsBaseCalc: Currency read _cIbsBaseCalc write _cIbsBaseCalc;
			[KValidadorBanco('a043_tes', 'a043_icm', 'money', 19, 4)]
			property cIcm: Currency read _cIcm write _cIcm;
			[KValidadorBanco('a043_tes', 'a043_ipi', 'money', 19, 4)]
			property cIpi: Currency read _cIpi write _cIpi;
			[KValidadorTamanho(-1, 20), KValidadorBanco('a043_tes', 'a043_iss', 'nvarchar', 20, 0)]
			property sIss: String read _sIss write _sIss;
			[KValidadorBanco('a043_tes', 'a043_iss_aliquota', 'money', 19, 4)]
			property cIssAliquota: Currency read _cIssAliquota write _cIssAliquota;
			[KValidadorBanco('a043_tes', 'a043_iss_base_calc', 'money', 19, 4)]
			property cIssBaseCalc: Currency read _cIssBaseCalc write _cIssBaseCalc;
			[KValidadorBanco('a043_tes', 'a043_issqn', 'money', 19, 4)]
			property cIssqn: Currency read _cIssqn write _cIssqn;
			[KValidadorBanco('a043_tes', 'a043_margem_subst_tributaria', 'money', 19, 4)]
			property cMargemSubstTributaria: Currency read _cMargemSubstTributaria write _cMargemSubstTributaria;
			[KValidadorTamanho(-1, -1), KValidadorBanco('a043_tes', 'a043_mensagem_nf', 'text', 0, 0)]
			property sMensagemNf: String read _sMensagemNf write _sMensagemNf;
			[KValidadorTamanho(-1, -1), KValidadorBanco('a043_tes', 'a043_mensagem_nf_01', 'nvarchar', 0, 0)]
			property sMensagemNf01: String read _sMensagemNf01 write _sMensagemNf01;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mod_base_calculo', 'nvarchar', 50, 0)]
			property sModBaseCalculo: String read _sModBaseCalculo write _sModBaseCalculo;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mod_base_calculo_substituicao', 'nvarchar', 50, 0)]
			property sModBaseCalculoSubstituicao: String read _sModBaseCalculoSubstituicao write _sModBaseCalculoSubstituicao;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mot_desoneracao', 'nvarchar', 50, 0)]
			property sMotDesoneracao: String read _sMotDesoneracao write _sMotDesoneracao;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mov_cta_capital', 'nvarchar', 50, 0)]
			property sMovCtaCapital: String read _sMovCtaCapital write _sMovCtaCapital;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mov_cta_socio', 'nvarchar', 50, 0)]
			property sMovCtaSocio: String read _sMovCtaSocio write _sMovCtaSocio;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mov_custo', 'nvarchar', 50, 0)]
			property sMovCusto: String read _sMovCusto write _sMovCusto;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_mov_desp_secagem', 'nvarchar', 50, 0)]
			property sMovDespSecagem: String read _sMovDespSecagem write _sMovDespSecagem;
			[KValidadorTamanho(-1, -1), KValidadorBanco('a043_tes', 'a043_obs', 'text', 0, 0)]
			property sObs: String read _sObs write _sObs;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_obs_contribuinte', 'nvarchar', 100, 0)]
			property sObsContribuinte: String read _sObsContribuinte write _sObsContribuinte;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_obs_fiscal', 'nvarchar', 100, 0)]
			property sObsFiscal: String read _sObsFiscal write _sObsFiscal;
			[KValidadorTamanho(-1, 25), KValidadorBanco('a043_tes', 'a043_operacao_tes', 'nvarchar', 25, 0)]
			property sOperacaoTes: String read _sOperacaoTes write _sOperacaoTes;
			[KValidadorBanco('a043_tes', 'a043_pBCFCP', 'numeric', 18, 4)]
			property cPbcfcp: Currency read _cPbcfcp write _cPbcfcp;
			[KValidadorBanco('a043_tes', 'a043_pBCFCPRet', 'numeric', 18, 4)]
			property cPbcfcpret: Currency read _cPbcfcpret write _cPbcfcpret;
			[KValidadorBanco('a043_tes', 'a043_pBCFCPST', 'numeric', 18, 4)]
			property cPbcfcpst: Currency read _cPbcfcpst write _cPbcfcpst;
			[KValidadorBanco('a043_tes', 'a043_pCredSN', 'money', 19, 4)]
			property cPcredsn: Currency read _cPcredsn write _cPcredsn;
			[KValidadorBanco('a043_tes', 'a043_pDif', 'money', 19, 4)]
			property cPdif: Currency read _cPdif write _cPdif;
			[KValidadorBanco('a043_tes', 'a043_pEntMVAST', 'money', 19, 4)]
			property cPentmvast: Currency read _cPentmvast write _cPentmvast;
			[KValidadorBanco('a043_tes', 'a043_pFCP', 'numeric', 18, 4)]
			property cPfcp: Currency read _cPfcp write _cPfcp;
			[KValidadorBanco('a043_tes', 'a043_pFCPRet', 'numeric', 18, 4)]
			property cPfcpret: Currency read _cPfcpret write _cPfcpret;
			[KValidadorBanco('a043_tes', 'a043_pFCPST', 'numeric', 18, 4)]
			property cPfcpst: Currency read _cPfcpst write _cPfcpst;
			[KValidadorBanco('a043_tes', 'a043_pMVAST', 'money', 19, 4)]
			property cPmvast: Currency read _cPmvast write _cPmvast;
			[KValidadorBanco('a043_tes', 'a043_pST', 'numeric', 18, 4)]
			property cPst: Currency read _cPst write _cPst;
			[KValidadorBanco('a043_tes', 'a043_p_fcp_st_ret_opc', 'numeric', 18, 4)]
			property cPFcpStRetOpc: Currency read _cPFcpStRetOpc write _cPFcpStRetOpc;
			[KValidadorBanco('a043_tes', 'a043_p_fcp_uf_dest_opc', 'numeric', 18, 4)]
			property cPFcpUfDestOpc: Currency read _cPFcpUfDestOpc write _cPFcpUfDestOpc;
			[KValidadorBanco('a043_tes', 'a043_p_icms_efet_opc', 'numeric', 18, 4)]
			property cPIcmsEfetOpc: Currency read _cPIcmsEfetOpc write _cPIcmsEfetOpc;
			[KValidadorBanco('a043_tes', 'a043_p_icms_inter', 'numeric', 18, 4)]
			property cPIcmsInter: Currency read _cPIcmsInter write _cPIcmsInter;
			[KValidadorBanco('a043_tes', 'a043_p_icms_inter_part', 'numeric', 18, 4)]
			property cPIcmsInterPart: Currency read _cPIcmsInterPart write _cPIcmsInterPart;
			[KValidadorBanco('a043_tes', 'a043_p_icms_uf_dest', 'numeric', 18, 4)]
			property cPIcmsUfDest: Currency read _cPIcmsUfDest write _cPIcmsUfDest;
			[KValidadorBanco('a043_tes', 'a043_p_red_bc_efet_opc', 'numeric', 18, 4)]
			property cPRedBcEfetOpc: Currency read _cPRedBcEfetOpc write _cPRedBcEfetOpc;
			[KValidadorBanco('a043_tes', 'a043_p_senar', 'money', 19, 4)]
			property cPSenar: Currency read _cPSenar write _cPSenar;
			[KValidadorBanco('a043_tes', 'a043_p_st_opc', 'numeric', 18, 4)]
			property cPStOpc: Currency read _cPStOpc write _cPStOpc;
			[KValidadorBanco('a043_tes', 'a043_per_cofins_socio', 'money', 19, 4)]
			property cPerCofinsSocio: Currency read _cPerCofinsSocio write _cPerCofinsSocio;
			[KValidadorBanco('a043_tes', 'a043_per_pis_socio', 'money', 19, 4)]
			property cPerPisSocio: Currency read _cPerPisSocio write _cPerPisSocio;
			[KValidadorBanco('a043_tes', 'a043_perc_csll', 'numeric', 18, 4)]
			property cPercCsll: Currency read _cPercCsll write _cPercCsll;
			[KValidadorBanco('a043_tes', 'a043_perc_inss', 'numeric', 18, 4)]
			property cPercInss: Currency read _cPercInss write _cPercInss;
			[KValidadorBanco('a043_tes', 'a043_perc_irrf', 'numeric', 18, 4)]
			property cPercIrrf: Currency read _cPercIrrf write _cPercIrrf;
			[KValidadorBanco('a043_tes', 'a043_perc_nret_adic', 'numeric', 18, 4)]
			property cPercNretAdic: Currency read _cPercNretAdic write _cPercNretAdic;
			[KValidadorBanco('a043_tes', 'a043_perc_nret_princ', 'numeric', 18, 4)]
			property cPercNretPrinc: Currency read _cPercNretPrinc write _cPercNretPrinc;
			[KValidadorBanco('a043_tes', 'a043_perc_red_base_cal_substituicao', 'money', 19, 4)]
			property cPercRedBaseCalSubstituicao: Currency read _cPercRedBaseCalSubstituicao write _cPercRedBaseCalSubstituicao;
			[KValidadorBanco('a043_tes', 'a043_perc_ret_15', 'numeric', 18, 4)]
			property cPercRet15: Currency read _cPercRet15 write _cPercRet15;
			[KValidadorBanco('a043_tes', 'a043_perc_ret_20', 'numeric', 18, 4)]
			property cPercRet20: Currency read _cPercRet20 write _cPercRet20;
			[KValidadorBanco('a043_tes', 'a043_perc_ret_25', 'numeric', 18, 4)]
			property cPercRet25: Currency read _cPercRet25 write _cPercRet25;
			[KValidadorBanco('a043_tes', 'a043_percentual_residual', 'money', 19, 4)]
			property cPercentualResidual: Currency read _cPercentualResidual write _cPercentualResidual;
			[KValidadorTamanho(-1, 4), KValidadorBanco('a043_tes', 'a043_permite_ibpt', 'nvarchar', 4, 0)]
			property sPermiteIbpt: String read _sPermiteIbpt write _sPermiteIbpt;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_permite_nf', 'nvarchar', 10, 0)]
			property sPermiteNf: String read _sPermiteNf write _sPermiteNf;
			[KValidadorBanco('a043_tes', 'a043_pis', 'money', 19, 4)]
			property cPis: Currency read _cPis write _cPis;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_preco_produto', 'nvarchar', 50, 0)]
			property sPrecoProduto: String read _sPrecoProduto write _sPrecoProduto;
			[KValidadorBanco('a043_tes', 'a043_red_bc_csll', 'numeric', 18, 4)]
			property cRedBcCsll: Currency read _cRedBcCsll write _cRedBcCsll;
			[KValidadorBanco('a043_tes', 'a043_red_bc_inss', 'numeric', 18, 4)]
			property cRedBcInss: Currency read _cRedBcInss write _cRedBcInss;
			[KValidadorBanco('a043_tes', 'a043_red_bc_irrf', 'numeric', 18, 4)]
			property cRedBcIrrf: Currency read _cRedBcIrrf write _cRedBcIrrf;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_situacao_tributaria_cofins', 'nvarchar', 100, 0)]
			property sSituacaoTributariaCofins: String read _sSituacaoTributariaCofins write _sSituacaoTributariaCofins;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_situacao_tributaria_pis', 'nvarchar', 100, 0)]
			property sSituacaoTributariaPis: String read _sSituacaoTributariaPis write _sSituacaoTributariaPis;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_tab_cofins', 'nvarchar', 12, 0)]
			property sTabCofins: String read _sTabCofins write _sTabCofins;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a043_tes', 'a043_tab_pis', 'nvarchar', 12, 0)]
			property sTabPis: String read _sTabPis write _sTabPis;
			[KValidadorTamanho(-1, 30), KValidadorBanco('a043_tes', 'a043_tipo_preco', 'nvarchar', 30, 0)]
			property sTipoPreco: String read _sTipoPreco write _sTipoPreco;
			[KValidadorTamanho(-1, 10), KValidadorBanco('a043_tes', 'a043_tipo_tes', 'nvarchar', 10, 0)]
			property sTipoTes: String read _sTipoTes write _sTipoTes;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_tributacao', 'nvarchar', 50, 0)]
			property sTributacao: String read _sTributacao write _sTributacao;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_usa_FCP', 'nvarchar', 5, 0)]
			property sUsaFcp: String read _sUsaFcp write _sUsaFcp;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_usa_cfop', 'nvarchar', 50, 0)]
			property sUsaCfop: String read _sUsaCfop write _sUsaCfop;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_usa_funrural', 'nvarchar', 5, 0)]
			property sUsaFunrural: String read _sUsaFunrural write _sUsaFunrural;
			[KValidadorTamanho(-1, 20), KValidadorBanco('a043_tes', 'a043_usa_produtos', 'nvarchar', 20, 0)]
			property sUsaProdutos: String read _sUsaProdutos write _sUsaProdutos;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_usa_senar', 'nvarchar', 50, 0)]
			property sUsaSenar: String read _sUsaSenar write _sUsaSenar;
			[KValidadorTamanho(-1, 100), KValidadorBanco('a043_tes', 'a043_usa_trib_pis', 'nvarchar', 100, 0)]
			property sUsaTribPis: String read _sUsaTribPis write _sUsaTribPis;
			[KValidadorTamanho(-1, 5), KValidadorBanco('a043_tes', 'a043_usa_trib_serv', 'nvarchar', 5, 0)]
			property sUsaTribServ: String read _sUsaTribServ write _sUsaTribServ;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_usuario', 'nvarchar', 50, 0)]
			property sUsuario: String read _sUsuario write _sUsuario;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_utiliza_preco_pauta', 'nvarchar', 50, 0)]
			property sUtilizaPrecoPauta: String read _sUtilizaPrecoPauta write _sUtilizaPrecoPauta;
			[KValidadorBanco('a043_tes', 'a043_v_bc_efet_opc', 'numeric', 18, 2)]
			property cVBcEfetOpc: Currency read _cVBcEfetOpc write _cVBcEfetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_bc_fcp_st_ret_opc', 'numeric', 18, 2)]
			property cVBcFcpStRetOpc: Currency read _cVBcFcpStRetOpc write _cVBcFcpStRetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_bc_fcp_uf_dest_opc', 'numeric', 18, 2)]
			property cVBcFcpUfDestOpc: Currency read _cVBcFcpUfDestOpc write _cVBcFcpUfDestOpc;
			[KValidadorBanco('a043_tes', 'a043_v_bc_st_dest_opc', 'numeric', 18, 2)]
			property cVBcStDestOpc: Currency read _cVBcStDestOpc write _cVBcStDestOpc;
			[KValidadorBanco('a043_tes', 'a043_v_bc_st_ret_opc', 'numeric', 18, 2)]
			property cVBcStRetOpc: Currency read _cVBcStRetOpc write _cVBcStRetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_bc_uf_dest', 'numeric', 18, 2)]
			property cVBcUfDest: Currency read _cVBcUfDest write _cVBcUfDest;
			[KValidadorBanco('a043_tes', 'a043_v_fcp_st_ret_opc', 'numeric', 18, 2)]
			property cVFcpStRetOpc: Currency read _cVFcpStRetOpc write _cVFcpStRetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_fcp_uf_dest_opc', 'numeric', 18, 2)]
			property cVFcpUfDestOpc: Currency read _cVFcpUfDestOpc write _cVFcpUfDestOpc;
			[KValidadorBanco('a043_tes', 'a043_v_icms_efet_opc', 'numeric', 18, 2)]
			property cVIcmsEfetOpc: Currency read _cVIcmsEfetOpc write _cVIcmsEfetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_icms_st_dest_opc', 'numeric', 18, 2)]
			property cVIcmsStDestOpc: Currency read _cVIcmsStDestOpc write _cVIcmsStDestOpc;
			[KValidadorBanco('a043_tes', 'a043_v_icms_st_ret_opc', 'numeric', 18, 2)]
			property cVIcmsStRetOpc: Currency read _cVIcmsStRetOpc write _cVIcmsStRetOpc;
			[KValidadorBanco('a043_tes', 'a043_v_icms_substituto_opc', 'numeric', 18, 2)]
			property cVIcmsSubstitutoOpc: Currency read _cVIcmsSubstitutoOpc write _cVIcmsSubstitutoOpc;
			[KValidadorBanco('a043_tes', 'a043_v_icms_uf_dest', 'numeric', 18, 2)]
			property cVIcmsUfDest: Currency read _cVIcmsUfDest write _cVIcmsUfDest;
			[KValidadorBanco('a043_tes', 'a043_v_icms_uf_remet', 'numeric', 18, 2)]
			property cVIcmsUfRemet: Currency read _cVIcmsUfRemet write _cVIcmsUfRemet;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a043_tes', 'a043_vinculo_doc_fiscal', 'nvarchar', 50, 0)]
			property sVinculoDocFiscal: String read _sVinculoDocFiscal write _sVinculoDocFiscal;
			property oCodCidade: TCidades read getOCodCidade write setOCodCidade;
			property oCodIva: TCstIva read getOCodIva write setOCodIva;
			property oCodSitTrib: TSituacaoTributaria read getOCodSitTrib write setOCodSitTrib;
			property oCodTesEstorno: TTes read getOCodTesEstorno write setOCodTesEstorno;
	end;

implementation

uses untTesDAO, untCidades, untTes, untCstIva, untCidadesDAO, untCstIvaDAO, untSituacaoTributariaDAO, untSituacaoTributaria;

//
// IMPLEMENTAÇÃO DE Tes [dbo].[a043_tes]
//

function TTes.getOCodSitTrib: TSituacaoTributaria;
var
	dao: SituacaoTributariaDAO;
begin
	if (((_oCodSitTrib = nil) AND (sCodSitTrib <> '')) OR ((_oCodSitTrib <> nil) AND (_oCodSitTrib.sCodigo <> sCodSitTrib))) then
	begin
		if _oCodSitTrib <> nil then
			_oCodSitTrib.Free;
		dao := nil;
		try
			dao := SituacaoTributariaDAO.Create(sEmpresaLogada, sFilialLogada);
			_oCodSitTrib := dao.SelecionaCodigo(sCodSitTrib);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oCodSitTrib;
end;

procedure TTes.setOCodSitTrib(obj: TSituacaoTributaria);
begin
	if _oCodSitTrib <> nil then
		_oCodSitTrib.Free;
	_oCodSitTrib := obj;
end;

function TTes.getOCodCidade: TCidades;
var
	dao: CidadesDAO;
begin
	if (((_oCodCidade = nil) AND (sCodCidade <> '')) OR ((_oCodCidade <> nil) AND (_oCodCidade.sCodigo <> sCodCidade))) then
	begin
		if _oCodCidade <> nil then
			_oCodCidade.Free;
		dao := nil;
		try
			dao := CidadesDAO.Create(sEmpresaLogada, sFilialLogada);
			_oCodCidade := dao.SelecionaCodigo(sCodCidade);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oCodCidade;
end;

procedure TTes.setOCodCidade(obj: TCidades);
begin
	if _oCodCidade <> nil then
		_oCodCidade.Free;
	_oCodCidade := obj;
end;

function TTes.getOCodIva: TCstIva;
var
	dao: CstIvaDAO;
begin
	if (((_oCodIva = nil) AND (sCodIva <> '')) OR ((_oCodIva <> nil) AND (_oCodIva.sCodigo <> sCodIva))) then
	begin
		if _oCodIva <> nil then
			_oCodIva.Free;
		dao := nil;
		try
			dao := CstIvaDAO.Create(sEmpresaLogada, sFilialLogada);
			_oCodIva := dao.SelecionaCodigo(sCodIva);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oCodIva;
end;

procedure TTes.setOCodIva(obj: TCstIva);
begin
	if _oCodIva <> nil then
		_oCodIva.Free;
	_oCodIva := obj;
end;

function TTes.getOCodTesEstorno: TTes;
var
	dao: TesDAO;
begin
	if (((_oCodTesEstorno = nil) AND (sCodTesEstorno <> '')) OR ((_oCodTesEstorno <> nil) AND (_oCodTesEstorno.sCodigo <> sCodTesEstorno))) then
	begin
		if _oCodTesEstorno <> nil then
			_oCodTesEstorno.Free;
		dao := nil;
		try
			dao := TesDAO.Create(sEmpresaLogada, sFilialLogada);
			_oCodTesEstorno := dao.SelecionaCodigo(sCodTesEstorno);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oCodTesEstorno;
end;

procedure TTes.setOCodTesEstorno(obj: TTes);
begin
	if _oCodTesEstorno <> nil then
		_oCodTesEstorno.Free;
	_oCodTesEstorno := obj;
end;

destructor TTes.Destroy;
begin
	if _oCodSitTrib <> nil then
		_oCodSitTrib.Free;
	if _oCodCidade <> nil then
		_oCodCidade.Free;
	if _oCodIva <> nil then
		_oCodIva.Free;
	if _oCodTesEstorno <> nil then
		_oCodTesEstorno.Free;
	inherited;
end;

end.