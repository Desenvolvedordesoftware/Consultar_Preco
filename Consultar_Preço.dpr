program Consultar_Preço;

uses
  Vcl.Forms,
  Consultar_Preco in 'Consultar_Preco.pas' {FrmConsultar_Preco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmConsultar_Preco, FrmConsultar_Preco);
  Application.Run;
end.
