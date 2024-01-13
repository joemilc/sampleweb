program WebSample_VCL;

uses
  Vcl.Forms,
  D2Bridge.Instance,
  uLogin in 'uLogin.pas' {ViewLogin},
  uMenu in 'uMenu.pas' {ViewMenu},
  Unit_Cadastro_Cliente in 'Unit_Cadastro_Cliente.pas' {Form_Cadastro_Cliente},
  D2BridgeFormTemplate in '..\..\src\D2BridgeFormTemplate.pas',
  Unit_Dashboard in '..\TemplateD2Bridge\Unit_Dashboard.pas' {Form_Dashboard},
  ServerController in '..\TemplateD2Bridge\ServerController.pas',
  UserSessionUnit in '..\TemplateD2Bridge\UserSessionUnit.pas',
  uSampleForm in '..\..\src\uSampleForm.pas' {fSampleForm},
  uExportaControls in '..\..\exportador\uExportaControls.pas',
  View.ExportForm2Web in '..\..\exportador\View.ExportForm2Web.pas' {ViewExportForm2Web};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  TViewLogin.CreateInstance;
  ViewLogin.ShowModal;
  Application.CreateForm(TViewExportForm2Web, ViewExportForm2Web);
  Application.Run;
end.
