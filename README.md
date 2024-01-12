# ExportVCLToD2Bridge
Gerador de código para exportar um form Delphi VCL para D2Bridge

Olá pessoal, fiz este código pra facilitar a exportação de um form VCL para o D2Bridge

Ele ira exportar todos controles q são descendentes de TWinControl, só é necessario verificar se o D2Bridge tem suporte para componentes de terceiros<br><br>

Para usar, basta você adicionar a unit **View.ExportForm2Web** ao seu projeto, adicioná-la no uses do form principal, e chamar a procedure **ExportForm2Web**.<br> 
Pra fazer a chamada da procedure, eu usei as teclas **Alt+E**, configuradas no evento *OnShortcut* do *Application.Events*.
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
E estamos prontos pra realizar a exportação.<br>
Execute sua aplicação em VCL, vá até o form desejado e tecle Alt+E<br>
Clique no button *Alterar na Unit*, selecione a unit desejada e clique abrir.<br>
Volte ao Delphi e confira o código gerado<br>
<br>
Se este código te ajudou, que tal uma contribuiçãozinha 😎?<br><br>
<img src="https://github.com/joemilc/sampleweb/blob/main/pix-websample.jpg"><br>
Chave PIX: joemil.cassio@gmail.com<br>
Nome: Joemil Cássio<br>
Valor: R$ 100,00 (ou qualquer outro valor)<br>
Código da transferência: ExportVLC2D2Bridge<br>
Código QrCode (Copia e Cola): 00020126450014BR.GOV.BCB.PIX0123joemil.cassio@gmail.com5204000053039865406100.005802BR5913Joemil Cassio6008Sinop-MT62220518ExportVLC2D2Bridge6304B0EF
