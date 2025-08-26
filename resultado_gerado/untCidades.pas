unit untCidades;

interface

uses
  SysUtils, Classes, untKValidador, untModelos;

type
  TEstados = class;
  TEstados = class;

  TCidades = class(TModeloBase)
		private
			_sNome: String;
			_sUf: String;
			_iNroHabitantes: Integer;
			_sDescricao: String;
			_sCodIbge: String;
			_oUf: TEstados;
			_oUf: TEstados;

			function getOUf: TEstados;
			procedure setOUf(obj: TEstados);
			function getOUf: TEstados;
			procedure setOUf(obj: TEstados);
		public
			destructor Destroy; Override;

			[KValidadorTamanho(-1, 100), KValidadorBanco('a006_cidades', 'a006_nome', 'nvarchar', 100, 0)]
			property sNome: String read _sNome write _sNome;
			[KValidadorTamanho(-1, 12), KValidadorBanco('a006_cidades', 'a006_uf', 'nvarchar', 12, 0)]
			property sUf: String read _sUf write _sUf;
			[KValidadorBanco('a006_cidades', 'a006_nro_habitantes', 'numeric', 18, 0)]
			property iNroHabitantes: Integer read _iNroHabitantes write _iNroHabitantes;
			[KValidadorTamanho(-1, -1), KValidadorBanco('a006_cidades', 'a006_descricao', 'text', 0, 0)]
			property sDescricao: String read _sDescricao write _sDescricao;
			[KValidadorTamanho(-1, 50), KValidadorBanco('a006_cidades', 'a006_cod_ibge', 'nvarchar', 50, 0)]
			property sCodIbge: String read _sCodIbge write _sCodIbge;
			property oUf: TEstados read getOUf write setOUf;
			property oUf: TEstados read getOUf write setOUf;
	end;

implementation

uses untEstados, untCidadesDAO, untEstadosDAO;

//
// IMPLEMENTAÇÃO DE Cidades [dbo].[a006_cidades]
//

function TCidades.getOUf: TEstados;
var
	dao: EstadosDAO;
begin
	if (((_oUf = nil) AND (sUf <> '')) OR ((_oUf <> nil) AND (_oUf.sCodigo <> sUf))) then
	begin
		if _oUf <> nil then
			_oUf.Free;
		dao := nil;
		try
			dao := EstadosDAO.Create(sEmpresaLogada, sFilialLogada);
			_oUf := dao.SelecionaCodigo(sUf);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oUf;
end;

procedure TCidades.setOUf(obj: TEstados);
begin
	if _oUf <> nil then
		_oUf.Free;
	_oUf := obj;
end;

function TCidades.getOUf: TEstados;
var
	dao: EstadosDAO;
begin
	if (((_oUf = nil) AND (sUf <> '')) OR ((_oUf <> nil) AND (_oUf.sCodigo <> sUf))) then
	begin
		if _oUf <> nil then
			_oUf.Free;
		dao := nil;
		try
			dao := EstadosDAO.Create(sEmpresaLogada, sFilialLogada);
			_oUf := dao.SelecionaCodigo(sUf);
			dao.Free;
		except
			if dao <> nil then
				dao.Free;
		end;
	end;
	Result := _oUf;
end;

procedure TCidades.setOUf(obj: TEstados);
begin
	if _oUf <> nil then
		_oUf.Free;
	_oUf := obj;
end;

destructor TCidades.Destroy;
begin
	if _oUf <> nil then
		_oUf.Free;
	if _oUf <> nil then
		_oUf.Free;
	inherited;
end;

end.
