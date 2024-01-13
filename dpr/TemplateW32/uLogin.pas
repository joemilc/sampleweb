unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  D2Bridge.Forms;

type
  TViewLogin = class(TD2BridgeForm)
    edtUsuario: TEdit;
    edtSenha: TEdit;
    BUTTON_LOGAR: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BUTTON_LOGARClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BUTTON_CRIARClick(Sender: TObject);
  private

  protected
    procedure ExportD2Bridge; override;
  public
    destructor Destroy; override;

  end;

Function ViewLogin: TViewLogin;

implementation

Uses
  uMenu,
  Unit_DashBoard,
  D2Bridge.Instance,
  ServerController;

{$R *.dfm}

Function ViewLogin: TViewLogin;
begin
  result := TViewLogin(TViewLogin.GetInstance);
end;

procedure TViewLogin.BUTTON_CRIARClick(Sender: TObject);
begin
  ShowMessage('Criar Conta');
end;

procedure TViewLogin.BUTTON_LOGARClick(Sender: TObject);
begin
    if (edtUsuario.Text = '') or (edtSenha.Text = '') then
    begin
      ShowMessage('Informe o Login');
      edtUsuario.SetFocus;
      abort;
    end;

    {$IFDEF D2BRIDGE}
    // User Vars
    UserSession.FUser_Id      := 1;
    UserSession.FUser_Name    := edtUsuario.Text;
    UserSession.FEmpresa_Nome := 'Empresa';
    UserSession.FEmpresa_Id   := 1;

    // Info User
    D2Bridge.PrismSession.InfoConnection.User := UserSession.FUser_Name;
    D2Bridge.PrismSession.InfoConnection.Identity := 'template';

    if Form_Dashboard = nil then
      TForm_Dashboard.CreateInstance;
    Form_Dashboard.show;
    {$ELSE}
    if ViewMenu= nil then
      D2BridgeInstance.CreateInstance(TViewMenu);
    ViewMenu.showmodal;

    application.Terminate;
    {$ENDIF}
end;

destructor TViewLogin.Destroy;
begin

  inherited;
end;

procedure TViewLogin.ExportD2Bridge;
begin
  inherited;

  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile := 'pages-login.html';

  D2Bridge.Items.Add.VCLObj(edtUsuario);
  D2Bridge.Items.Add.VCLObj(edtSenha);
  D2Bridge.Items.Add.VCLObj(BUTTON_LOGAR);

end;

procedure TViewLogin.FormActivate(Sender: TObject);
begin
  edtUsuario.Text := 'joemilc@gmail.com';
  edtSenha.Text := '123456';
end;

end.
