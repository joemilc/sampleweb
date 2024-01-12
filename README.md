# sampleweb
Gerador de código para exportar um form Delphi VCL para D2Bridge

Olá pessoal, fiz este código pra facilitar a exportação de um form VCL para o D2Bridge

Ele ira exportar todos controles q são descendentes de TWinControl, só é necessario verificar se o D2Bridge tem suporte para componentes de terceiros<br><br>

Para usar, basta você adicionar a unit **View.ExportForm2Web** ao seu projeto, adicioná-la no uses do form principal, e chamar a procedure **ExportForm2Web**.<br> 
Pra fazer a chamada da procedure, eu usei as teclas **Ctrl+E**, configuradas no evento *OnShortcut* do *Application.Events*.
Assim, ela irá pegar o form que está ativo no momento

```pascal
procedure TViewMenu.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if (Msg.CharCode = Ord('E')) and (HiWord(Msg.KeyData) and KF_ALTDOWN <> 0) then
  begin
    ExportForm2Web;
    Handled := TRUE;
  end;
end;
```
No form que tem os componentes a serem exportamos temos a procedure *ExportD2Bridge*, que deve ter as seguintes marcações:<br>
*{Variaveis D2Bridge}* - aqui serão adicionadas as variáveis necessários<br>
*{Yours Controls}* - aqui serão adicionados os comandos de exportação dos componentes<br>

```pascal
procedure TfSampleForm.ExportD2Bridge;
var
  x: Integer;
  {Variaveis D2Bridge}
begin
  inherited;

  Title := 'Sample Form';

  TemplateClassForm := TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile := 'template.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'itemtemplate.html';

  with D2Bridge.Items.add do
  begin
    Row.Items.add.VCLObj(lblTitulo, CSSClass.Text.Size.fs3 + ' ' + CSSClass.Text.Style.bold);
    {Yours Controls}
  end;

end;
```
