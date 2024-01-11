program WebSample_Web;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
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
  View.ExportForm2Web in '..\..\src\View.ExportForm2Web.pas' {ViewExportForm2Web},
  uSampleForm in '..\..\src\uSampleForm.pas' {fSampleForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Servidor_D2Bridge, Form_Servidor_D2Bridge);
  Application.Run;
end.
