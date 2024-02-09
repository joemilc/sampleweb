unit uSampleForm2;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  D2Bridge.Forms, D2BridgeFormTemplate, D2Bridge.Interfaces, frxClass, frxExportBaseDialog, frxExportPDF;

type
  TfSampleForm2 = class(TD2BridgeForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblTitulo: TLabel;
    Label18: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    ComboBox2: TComboBox;
    CheckBox4: TCheckBox;
    Edit6: TEdit;
    CheckBox5: TCheckBox;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Edit10: TEdit;
    CheckBox12: TCheckBox;
    CheckBox11: TCheckBox;
    Edit12: TEdit;
    CheckBox10: TCheckBox;
    ComboBox4: TComboBox;
    Edit11: TEdit;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    ComboBox3: TComboBox;
    CheckBox7: TCheckBox;
    Edit9: TEdit;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit13: TEdit;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit14: TEdit;
    CheckBox6: TCheckBox;
    CheckBox13: TCheckBox;
    Edit15: TEdit;
    CheckBox14: TCheckBox;
    ComboBox5: TComboBox;
    Edit16: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    Button4: TButton;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function fSampleForm2: TfSampleForm2;

implementation

{$R *.dfm}

{ TfSampleForm2 }
function fSampleForm2: TfSampleForm2;
begin
  result := TfSampleForm2(TfSampleForm2.GetInstance);
end;

procedure TfSampleForm2.Button4Click(Sender: TObject);
begin
  frxReport1.Clear;
  frxReport1.LoadFromFile('reports\Relatorio.fr3');
  //frxreport1.Variables['nome_variavel'] := QuotedStr('teste');
  frxReport1.PrepareReport;
  frxPDFExport1.FileName := 'pdf\Relatorio.pdf';
  frxReport1.Export(frxPDFExport1);
  D2Bridge.PrismSession.SendFile('pdf\Relatorio.pdf', True);
end;

procedure TfSampleForm2.ExportD2Bridge;
var
  x: Integer;
  {Variaveis D2Bridge}
  d2bRow: IItemAdd; {var_row}
  d2bPageControl1: ID2BridgeItemHTMLTabs; {var_pagecontrol}
  d2bTabSheet1,d2bTabSheet2,d2bTabSheet3: IItemAdd; {var_tabsheet}
  d2bPanel1: IItemAdd; {var_panel}
  d2bGroupBox1, d2bGroupBox2: IItemAdd; {var_panelgroup}
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
      d2bRow.FormGroup('Label2', CSSClass.Col.colsize2).AddVCLObj(Edit2);
      d2bRow.FormGroup('Label3', CSSClass.Col.colsize1).AddVCLObj(ComboBox1);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox1);
    d2bRow := Row.Items.add; // ----
      d2bRow.FormGroup('Label4', CSSClass.Col.colsize3).AddVCLObj(Edit3);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox2);
      d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox3);
    d2bPageControl1 := Tabs;
      d2bTabSheet1 := d2bPageControl1.AddTab('Endereço').Items.add;
        d2bRow := d2bTabSheet1.Row.Items.add; // ----
            d2bRow.FormGroup('Label5', CSSClass.Col.colsize1).AddVCLObj(Edit4);
            d2bRow.FormGroup('Label6', CSSClass.Col.colsize2).AddVCLObj(Edit5);
            d2bRow.FormGroup('Label7', CSSClass.Col.colsize1).AddVCLObj(ComboBox2);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox4);
        d2bRow := d2bTabSheet1.Row.Items.add; // ----
            d2bRow.FormGroup('Label8', CSSClass.Col.colsize4).AddVCLObj(Edit6);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox5);
        d2bGroupBox1 := d2bTabSheet1.PanelGroup('GroupBox1').Items.add;
          d2bRow := d2bGroupBox1.Row.Items.add; // ----
              d2bRow.FormGroup('Label14', CSSClass.Col.colsize1).AddVCLObj(Edit10);
              d2bRow.FormGroup('Label15', CSSClass.Col.colsize2).AddVCLObj(Edit11);
              d2bRow.FormGroup('Label16', CSSClass.Col.colsize1).AddVCLObj(ComboBox4);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox10);
          d2bRow := d2bGroupBox1.Row.Items.add; // ----
              d2bRow.FormGroup('Label17', CSSClass.Col.colsize4).AddVCLObj(Edit12);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox11);
              d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox12);
      d2bTabSheet2 := d2bPageControl1.AddTab('TabSheet2').Items.add;
        d2bRow := d2bTabSheet2.Row.Items.add; // ----
            d2bRow.FormGroup('Label9', CSSClass.Col.colsize1).AddVCLObj(Edit7);
            d2bRow.FormGroup('Label10', CSSClass.Col.colsize2).AddVCLObj(Edit8);
            d2bRow.FormGroup('Label11', CSSClass.Col.colsize1).AddVCLObj(ComboBox3);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox7);
        d2bRow := d2bTabSheet2.Row.Items.add; // ----
            d2bRow.FormGroup('Label12', CSSClass.Col.colsize4).AddVCLObj(Edit9);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox8);
            d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox9);
      d2bTabSheet3 := d2bPageControl1.AddTab('TabSheet3').Items.add;
        d2bPageControl2 := Tabs;
          d2bTabSheet4 := d2bPageControl2.AddTab('TabSheet4').Items.add;
            d2bGroupBox2 := d2bTabSheet4.PanelGroup('GroupBox2').Items.add;
              d2bRow := d2bGroupBox2.Row.Items.add; // ----
                  d2bRow.FormGroup('Label22', CSSClass.Col.colsize1).AddVCLObj(Edit14);
                  d2bRow.FormGroup('Label21', CSSClass.Col.colsize2).AddVCLObj(Edit16);
                  d2bRow.FormGroup('Label20', CSSClass.Col.colsize1).AddVCLObj(ComboBox5);
                  d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox14);
              d2bRow := d2bGroupBox2.Row.Items.add; // ----
                  d2bRow.FormGroup('Label19', CSSClass.Col.colsize4).AddVCLObj(Edit15);
                  d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox13);
                  d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(CheckBox6);
          d2bTabSheet5 := d2bPageControl2.AddTab('TabSheet5').Items.add;
            d2bRow := d2bTabSheet5.Row.Items.add; // ----
                d2bRow.FormGroup('Label23', CSSClass.Col.colsize1).AddVCLObj(Edit17);
                d2bRow.FormGroup('Label24', CSSClass.Col.colsize2).AddVCLObj(Edit18);
            d2bRow := d2bTabSheet5.Row.Items.add; // ----
                d2bRow.FormGroup('Label25', CSSClass.Col.colsize4).AddVCLObj(Edit19);
    d2bPanel1 := HTMLDIV('expanel expanel-body').Items.add;
      d2bRow := d2bPanel1.Row.Items.add; // ----
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button1);
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button2);
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button3);
          d2bRow.FormGroup('', CSSClass.Col.colauto).AddVCLObj(Button4);

    d2bRow := Row.Items.add; // ----
      d2bRow.FormGroup('Label18', CSSClass.Col.colsize1).AddVCLObj(Edit13);

  end;
end;

procedure TfSampleForm2.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
  inherited;

  // Change Init Property of Prism Controls
  {
    if PrismControl.VCLComponent = Edit1 then
    PrismControl.AsEdit.DataType:= TPrismFieldType.PrismFieldTypeInteger;

    if PrismControl.IsDBGrid then
    begin
    PrismControl.AsDBGrid.RecordsPerPage:= 10;
    PrismControl.AsDBGrid.MaxRecords:= 2000;
    end;
  }
end;

procedure TfSampleForm2.RenderD2Bridge(const PrismControl: TPrismControl;
  var HTMLControl: string);
begin
  inherited;

  // Intercept HTML
  {
    if PrismControl.VCLComponent = Edit1 then
    begin
    HTMLControl:= '</>';
    end;
  }
end;

end.
