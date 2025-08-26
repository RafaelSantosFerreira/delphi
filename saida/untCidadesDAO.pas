{----------------------------------------------------}
{ File      : untCidadesDAO.pas          }
{ Generated : 26/08/2025 15:35:24                    }
{ User      : GeradorAutomatico                      }
{----------------------------------------------------}

unit untCidadesDAO;

interface

uses untKhnumQuery, DB, ADODB, untBaseDAO, untModelos, untCidades;

type
	TClassCidadesDAO = BaseDAO<TCidades>;

	CidadesDAO = class(TClassCidadesDAO)
	public
		constructor Create(_sEmpresa, _sFilial: String); override;
		function getInsertSql: String; override;
		function getUpdateSql: String; override;
		procedure ObjetoParaQuery(oObjeto: TCidades; oQuery: TADOQuery;
				bSetarCodSeq: Boolean = true); override;
	protected
		function SubLinhaParaObjeto(oFields: TFields): TCidades; override;
	end;

implementation

uses SysUtils;

constructor CidadesDAO.Create(_sEmpresa, _sFilial: String);
begin
	inherited createDao('a006_cidades', _sEmpresa, _sFilial, false);
end;

function CidadesDAO.getInsertSql;
const
	SQL_INSERIR: String =
			'INSERT INTO [dbo].[a006_cidades](' + 
				' [a006_codigo], [a006_sequencial], [a006_nome], [a006_uf], ' + 
				' [a006_nro_habitantes], [a006_descricao], [a006_cod_ibge]  ' + 
				') VALUES( ' + 
				' :a006_codigo, :a006_sequencial, :a006_nome, :a006_uf, ' + 
				' :a006_nro_habitantes, :a006_descricao, :a006_cod_ibge  ' + 
				')';
begin
	Result := SQL_INSERIR;
end;

function CidadesDAO.getUpdateSql;
const
	SQL_ATUALIZAR: String =
			'UPDATE [dbo].[a006_cidades] SET ' + 
				' [a006_sequencial] = :a006_sequencial, ' + 
				' [a006_nome] = :a006_nome, ' + 
				' [a006_uf] = :a006_uf, ' + 
				' [a006_nro_habitantes] = :a006_nro_habitantes, ' + 
				' [a006_descricao] = :a006_descricao, ' + 
				' [a006_cod_ibge] = :a006_cod_ibge  ' + 
				'WHERE [a006_codigo] = :a006_codigo ';
begin
	Result := SQL_ATUALIZAR;
end;

procedure CidadesDAO.ObjetoParaQuery;
begin
	oQuery.Parameters.ParamByName('a006_sequencial').Value := oObjeto.iSequencial;
	oQuery.Parameters.ParamByName('a006_nome').Value := oObjeto.sNome;
	oQuery.Parameters.ParamByName('a006_uf').Value := oObjeto.sUf;
	oQuery.Parameters.ParamByName('a006_nro_habitantes').Value := oObjeto.iNroHabitantes;
	oQuery.Parameters.ParamByName('a006_descricao').Value := oObjeto.sDescricao;
	oQuery.Parameters.ParamByName('a006_cod_ibge').Value := oObjeto.sCodIbge;

	if bSetarCodSeq then
	begin
		oQuery.Parameters.ParamByName('a006_codigo').Value := oObjeto.sCodigo;
			oQuery.Parameters.ParamByName('a006_sequencial').Value := oObjeto.iSequencial;
	end;
end;

function CidadesDAO.SubLinhaParaObjeto;
var
	oObjeto: TCidades;
begin
	oObjeto := nil;
	try
		oObjeto := TCidades.Create();
		oObjeto.sCodigo := oFields.FieldByName('a006_codigo').AsString;
		oObjeto.iSequencial := oFields.FieldByName('a006_sequencial').AsLargeInt;
		oObjeto.sNome := oFields.FieldByName('a006_nome').AsString;
		oObjeto.sUf := oFields.FieldByName('a006_uf').AsString;
		oObjeto.iNroHabitantes := oFields.FieldByName('a006_nro_habitantes').AsInteger;
		oObjeto.sDescricao := oFields.FieldByName('a006_descricao').AsString;
		oObjeto.sCodIbge := oFields.FieldByName('a006_cod_ibge').AsString;
		Result := oObjeto;
	except
		if oObjeto <> nil then
			oObjeto.free;
		raise;
	end;
end;

end.