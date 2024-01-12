# sampleweb
Gerador de código para exportar um form Delphi VCL para D2Bridge

Olá pessoal, fiz este código pra facilitar a exportação de um form VCL para o D2Bridge

Ele ira exportar todos controles q são descendentes de TWinControl, só é necessario verificar se o D2Bridge tem suporte para componentes de terceiros

Para usar, basta você adicionar a unit **View.ExportForm2Web** ao seu projeto, adicioná-la no uses do form principal, e chamar a procedure **ExportForm2Web**. 
Pra fazer a chamada da procedure, eu usei as teclas **Ctrl+E**, configuradas no evento *OnShortcut* do *Application.Events*.
Assim, ela irá pegar o form que está ativo no momento

```Pascal
procedure TViewMenu.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if (Msg.CharCode = Ord('E')) and (HiWord(Msg.KeyData) and KF_ALTDOWN <> 0)
  then begin
    ExportForm2Web;
    Handled := TRUE;
  end;
end;
```
