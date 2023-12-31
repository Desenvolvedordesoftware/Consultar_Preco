unit Consultar_Preco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, AdvMetroButton,
  AdvGlowButton, acPNG, Vcl.ExtCtrls, Vcl.StdCtrls, AdvSmoothPanel,
  ZAbstractConnection, ZConnection, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, IniFiles;

type
  TFrmConsultar_Preco = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label6: TLabel;
    Label11: TLabel;
    Image6: TImage;
    Image9: TImage;
    bcancelar: TAdvGlowButton;
    AdvMetroButton1: TAdvMetroButton;
    AdvMetroButton2: TAdvMetroButton;
    Image1: TImage;
    qrproduto: TZQuery;
    Conexao: TZConnection;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    NCaixa: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure AdvMetroButton1Click(Sender: TObject);
    procedure AdvMetroButton2Click(Sender: TObject);
    procedure NCaixaEnter(Sender: TObject);
    procedure NCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure NCaixaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public

//  function LerIni(sArquivo, Secao, Linha: string; Def: string): string;
    { Public declarations }
  end;

var
  FrmConsultar_Preco: TFrmConsultar_Preco;

implementation

{$R *.dfm}

procedure TFrmConsultar_Preco.AdvMetroButton1Click(Sender: TObject);
begin
application.Minimize;
end;

procedure TFrmConsultar_Preco.AdvMetroButton2Click(Sender: TObject);
begin
   Conexao.Connected := false;
   application.Terminate;
end;

procedure TFrmConsultar_Preco.FormCreate(Sender: TObject);
var
  LerINi: TIniFile;
begin
  conexao.Connected := false;
  LerINi := TIniFile.Create( 'C:\GCSISTEM\Server\CFG\cfg.ini');
  conexao.Hostname := LerINi.ReadString('CONFIGURACOES', 'SERVIDOR', '');
  conexao.Database := LerINi.ReadString('CONFIGURACOES', 'BDSERVIDOR', '');
  conexao.Connected := true;
end;

procedure TFrmConsultar_Preco.FormShow(Sender: TObject);
var
  LerINi: TIniFile;
begin
     LerINi := TIniFile.Create( 'C:\GCSISTEM\Server\CFG\cfg.ini');
     Label11.caption := LerINi.ReadString('CONFIGURACOES', 'SERVIDOR', '');
end;

procedure TFrmConsultar_Preco.NCaixaEnter(Sender: TObject);
begin
tedit(Sender).Color := $00A0FAF8;
end;

procedure TFrmConsultar_Preco.NCaixaExit(Sender: TObject);
begin

 Begin

   qrproduto.close;
   qrproduto.sql.clear;
   qrproduto.sql.add('select CODBARRA, PRODUTO, PRECOVENDA');
   qrproduto.sql.add('FROM c000025');
   qrproduto.sql.add('where');
   qrproduto.sql.add('CODBARRA = '''+NCaixa.Text+'''');
   qrproduto.Open;

  if qrproduto.RecordCount = 0 then
  begin
   Label2.caption :='PRODUTO N�O ENCONTRADO...';
   NCaixa.Text := '';
   Label4.caption := '0,00';
   NCaixa.SetFocus;
   exit;
   end;

  Begin
   Label2.caption := qrproduto.fieldbyname('PRODUTO').asstring;
   Label4.caption := qrproduto.fieldbyname('PRECOVENDA').asstring;
   NCaixa.SetFocus;
   exit;
  End;

 end;
end;

procedure TFrmConsultar_Preco.NCaixaKeyPress(Sender: TObject; var Key: Char);
begin

 if Key = #13 then
 Begin

   qrproduto.close;
   qrproduto.sql.clear;
   qrproduto.sql.add('select CODBARRA, PRODUTO, PRECOVENDA');
   qrproduto.sql.add('FROM c000025');
   qrproduto.sql.add('where');
   qrproduto.sql.add('CODBARRA = '''+NCaixa.Text+'''');
   qrproduto.Open;

  if qrproduto.RecordCount = 0 then
  begin
   Label2.caption :='PRODUTO N�O ENCONTRADO...';
   NCaixa.Text := '';
   Label8.caption := '';
   Label4.caption := '0,00';
   NCaixa.SetFocus;
   exit;
   end;

  Begin
   Label2.caption := qrproduto.fieldbyname('PRODUTO').asstring;
   Label4.caption := qrproduto.fieldbyname('PRECOVENDA').asstring;
   Label8.caption := qrproduto.fieldbyname('CODBARRA').asstring;
   NCaixa.Text := '';
   NCaixa.SetFocus;
   exit;
  End;

 end;

end;

end.
