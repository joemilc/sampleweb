unit View.ExportForm2Web;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.IOUtils, System.ImageList, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ImgList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,

  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Data.DB,

  uExportaControls;

type


  TViewExportForm2Web = class(TForm)
    DBGrid1: TDBGrid;
    MemoCode: TMemo;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    TreeView1: TTreeView;
    memWinControls: TFDMemTable;
    memWinControlsname: TStringField;
    memWinControlsleft: TIntegerField;
    memWinControlstop: TIntegerField;
    memWinControlswidth: TIntegerField;
    memWinControlslabel: TStringField;
    memWinControlstaborder: TIntegerField;
    memWinControlsparent: TStringField;
    dsmemWinControls: TDataSource;
    ComboBox1: TComboBox;
    MemoVars: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FExportaControls: IExportaControls;
  end;

var
  ViewExportForm2Web: TViewExportForm2Web;

implementation

{$R *.dfm}

uses System.SysUtils, System.StrUtils;


procedure TViewExportForm2Web.Button1Click(Sender: TObject);
var
  s, n: String;
begin
  if OpenDialog1.Execute then
  begin
    s := TFile.ReadAllText(OpenDialog1.FileName);
    s := StringReplace(s, '{Variaveis D2Bridge}', MemoVars.Text, []);
    s := StringReplace(s, '{Yours Controls}', MemoCode.Text, []);
    TFile.WriteAllText(OpenDialog1.FileName, s);
    Application.Terminate;
  end;

end;

procedure TViewExportForm2Web.ComboBox1Change(Sender: TObject);
begin
  memWinControls.Filter   := 'parent like '+QuotedStr('%'+ComboBox1.Text+'%');
  memWinControls.Filtered := ComboBox1.ItemIndex > 0;
end;

end.
