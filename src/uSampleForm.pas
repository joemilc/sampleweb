unit uSampleForm;

{ Copyright 2024 / 2025 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls,
  D2Bridge.Forms;

type
  TfSampleForm = class(TD2BridgeForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    ComboBox2: TComboBox;
    CheckBox4: TCheckBox;
    Label8: TLabel;
    Edit6: TEdit;
    CheckBox5: TCheckBox;
    GroupBox1: TGroupBox;
    Edit10: TEdit;
    CheckBox12: TCheckBox;
    CheckBox11: TCheckBox;
    Edit12: TEdit;
    Label17: TLabel;
    CheckBox10: TCheckBox;
    ComboBox4: TComboBox;
    Label16: TLabel;
    Edit11: TEdit;
    Label15: TLabel;
    Label14: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lblTitulo: TLabel;
    Label18: TLabel;
    Edit13: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    ComboBox3: TComboBox;
    CheckBox7: TCheckBox;
    Edit9: TEdit;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function fSampleForm: TfSampleForm;

implementation

uses
  D2Bridge.Interfaces, D2BridgeFormTemplate;

{$R *.dfm}

function fSampleForm: TfSampleForm;
begin
  result := TfSampleForm(TfSampleForm.GetInstance);
end;

procedure TfSampleForm.ExportD2Bridge;
var
  x: Integer;
  {Variaveis D2Bridge}
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
  end;

end;

procedure TfSampleForm.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfSampleForm.RenderD2Bridge(const PrismControl: TPrismControl;
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
