# Exportar componentes VCL para D2Bridge
Gerador de código para exportar um form Delphi VCL para D2Bridge

Olá pessoal, fiz este código pra facilitar a exportação de um form VCL para o D2Bridge

Ele irá exportar todos controles que são descendentes de TWinControl, só é necessario verificar se o D2Bridge tem suporte para componentes de terceiros<br><br>

Para usar, basta você adicionar as units **uExportaControls.pas** e **View.ExportForm2Web.pas** que estão na pasta exportador ao seu projeto, adicioná-la no uses do form principal.<br> 
Pra fazer a chamada da procedure, eu usei as teclas **Alt+E**, configuradas no evento *OnShortcut* do *Application.Events*.
Assim, ela irá pegar o form que está ativo no momento

```pascal
procedure TViewMenu.ApplicationEvents1ShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if (Msg.CharCode = Ord('E')) and (HiWord(Msg.KeyData) and KF_ALTDOWN <> 0)
  then begin
    TExportaControls.New
      .SetForm(Screen.ActiveForm)
      .Initialize
      .ListaComponentes
      .ListaLabels
      .GeraCodigo;

    Handled := TRUE;
  end;
end;

```
No form que tem os componentes a serem exportamos temos a procedure *ExportD2Bridge*, que deve ter as seguintes marcações:<br>
*{Variaveis D2Bridge}* - aqui serão adicionadas as variáveis necessárias<br>
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
```pascal
procedure TfSampleForm.ExportD2Bridge;
var
  x: Integer;
  {Variaveis D2Bridge}
  d2bRow: IItemAdd; {var_row}
  d2bPageControl1: ID2BridgeItemHTMLTabs; {var_pagecontrol}
  d2bTabSheet1,d2bTabSheet2,d2bTabSheet3: IItemAdd; {var_tabsheet}
  d2bPanel1: IItemAdd; {var_panel}
  d2bGroupBox1: IItemAdd; {var_panelgroup}
  d2bPageControl2: ID2BridgeItemHTMLTabs; {var_pagecontrol}
  d2bTabSheet4,d2bTabSheet5: IItemAdd; {var_tabsheet}

begin
  inherited;

  Title := 'Sample Form';

  TemplateClassForm := TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile := 'template.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile   := 'itemtemplate.html';

  with D2Bridge.Items.add do
  begin
    Row.Items.add.VCLObj(lblTitulo, CSSClass.Text.Size.fs3 + ' ' + CSSClass.Text.Style.bold);
    {Yours Controls}
    d2bRow := Row.Items.add; // ----
      d2bRow.FormGroup('Label1', CSSClass.Col.colsize1).AddVCLObj(Edit1);
      d2bRow.FormGroup('Label2', CSSClass.Col.colsize3).AddVCLObj(Edit2);
      d2bRow.FormGroup('Label3', CSSClass.Col.colsize1).AddVCLObj(ComboBox1);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox1);
    d2bRow := Row.Items.add; // ----
      d2bRow.FormGroup('Label4', CSSClass.Col.colsize4).AddVCLObj(Edit3);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox2);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox3);
      d2bRow.FormGroup('Label18', CSSClass.Col.colsize1).AddVCLObj(Edit13);
    d2bPageControl1 := Tabs;
      d2bTabSheet1 := d2bPageControl1.AddTab('Endereço').Items.add;
        d2bRow := d2bTabSheet1.Row.Items.add; // ----
            d2bRow.FormGroup('Label5', CSSClass.Col.colsize1).AddVCLObj(Edit4);
            d2bRow.FormGroup('Label6', CSSClass.Col.colsize3).AddVCLObj(Edit5);
            d2bRow.FormGroup('Label7', CSSClass.Col.colsize1).AddVCLObj(ComboBox2);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox4);
        d2bRow := d2bTabSheet1.Row.Items.add; // ----
            d2bRow.FormGroup('Label8', CSSClass.Col.colsize5).AddVCLObj(Edit6);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox5);
        d2bGroupBox1 := d2bTabSheet1.PanelGroup('GroupBox1', false).Items.add;
          d2bRow := d2bGroupBox1.Row.Items.add; // ----
              d2bRow.FormGroup('Label14', CSSClass.Col.colsize1).AddVCLObj(Edit10);
              d2bRow.FormGroup('Label15', CSSClass.Col.colsize3).AddVCLObj(Edit11);
              d2bRow.FormGroup('Label16', CSSClass.Col.colsize1).AddVCLObj(ComboBox4);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox10);
          d2bRow := d2bGroupBox1.Row.Items.add; // ----
              d2bRow.FormGroup('Label17', CSSClass.Col.colsize5).AddVCLObj(Edit12);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox11);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox12);
      d2bTabSheet2 := d2bPageControl1.AddTab('TabSheet2').Items.add;
        d2bRow := d2bTabSheet2.Row.Items.add; // ----
            d2bRow.FormGroup('Label9', CSSClass.Col.colsize1).AddVCLObj(Edit7);
            d2bRow.FormGroup('Label10', CSSClass.Col.colsize3).AddVCLObj(Edit8);
            d2bRow.FormGroup('Label11', CSSClass.Col.colsize1).AddVCLObj(ComboBox3);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox7);
        d2bRow := d2bTabSheet2.Row.Items.add; // ----
            d2bRow.FormGroup('Label12', CSSClass.Col.colsize5).AddVCLObj(Edit9);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox8);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox9);
        {d2bRow := d2bTabSheet2.Row.Items.add; // ----
            d2bRow.FormGroup('Label13', CSSClass.Col.colsize8).AddVCLObj(Memo1);}
      d2bTabSheet3 := d2bPageControl1.AddTab('TabSheet3').Items.add;
        d2bPageControl2 := Tabs;
          d2bTabSheet4 := d2bPageControl2.AddTab('TabSheet4').Items.add;
          d2bTabSheet5 := d2bPageControl2.AddTab('TabSheet5').Items.add;
    d2bPanel1 := HTMLDIV('expanel expanel-body').Items.add;
      d2bRow := d2bPanel1.Row.Items.add; // ----
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button1);
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button2);
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button3);


  end;

end;
```
O projeto usado é o demo Template que vem junto com o D2Bridge. Fiz uma cópia do mesmo, só abrir o projeto. Eu adicionei as pastas do D2Bridge no Library Path do Delphi.<br><br>
Se este código te ajudou, que tal uma contribuiçãozinha 😎?<br><br>
<img src="https://github.com/joemilc/sampleweb/blob/main/pix-websample.jpg"><br>
Chave PIX: joemil.cassio@gmail.com<br>
Nome: Joemil Cássio<br>
Valor: R$ 100,00 (ou qualquer outro valor)<br>
Código da transferência: ExportVLC2D2Bridge<br>
Código QrCode (Copia e Cola): 00020126450014BR.GOV.BCB.PIX0123joemil.cassio@gmail.com5204000053039865406100.005802BR5913Joemil Cassio6008Sinop-MT62220518ExportVLC2D2Bridge6304B0EF
