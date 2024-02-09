program WebSample_Web;

uses
  Vcl.Forms,
  MidasLib,
  Unit_Server_D2Bridge in 'Unit_Server_D2Bridge.pas' {Form_Servidor_D2Bridge},
  ServerController in 'ServerController.pas',
  UserSessionUnit in 'UserSessionUnit.pas',
  Unit_Cadastro_Cliente in '..\TemplateW32\Unit_Cadastro_Cliente.pas' {Form_Cadastro_Cliente},
  uLogin in '..\TemplateW32\uLogin.pas' {ViewLogin},
  uMenu in '..\TemplateW32\uMenu.pas' {ViewMenu},
  Unit_Dashboard in 'Unit_Dashboard.pas' {Form_Dashboard},
  D2BridgeFormTemplate in '..\..\src\D2BridgeFormTemplate.pas',
  uSampleForm in '..\..\src\uSampleForm.pas' {fSampleForm},
  uExportaControls in '..\..\exportador\uExportaControls.pas',
  View.ExportForm2Web in '..\..\exportador\View.ExportForm2Web.pas' {ViewExportForm2Web},
  uSampleForm2 in '..\..\src\uSampleForm2.pas' {fSampleForm2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Servidor_D2Bridge, Form_Servidor_D2Bridge);
  Application.CreateForm(TViewExportForm2Web, ViewExportForm2Web);
  Application.Run;
end.
