unit View.ExportForm2Web;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, System.IOUtils, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type

  TTipoVariavel = (tvRow, tvPageControl, tvTabSheet, tvPanel, tvPanelGroup);

  TViewExportForm2Web = class(TForm)
    DBGrid1: TDBGrid;
    Memo1: TMemo;
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
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    slVariaveis: TStrings;
    procedure AddPageControl(APageControl: TPageControl; AParent: String);
    procedure AddPanel(APanel: TPanel);
    procedure AddGroupBox(AGroupBox: TGroupBox);
    procedure AddVariavel(ATipoVariavel: TTipoVariavel);
    procedure LimpaMemo;

    function GetparentVar(AControl: TWinControl): String;
    function Identa: String;
    function FindNode(ATreeView: TTreeView; AText: String): TTreeNode;
  public
    { Public declarations }
  end;

procedure ExportForm2Web;

var
  ViewExportForm2Web: TViewExportForm2Web;

implementation

{$R *.dfm}

uses System.SysUtils, System.StrUtils;

procedure TViewExportForm2Web.AddGroupBox(AGroupBox: TGroupBox);
var
  sl: TStrings;
  s: String;
begin
  AddVariavel(tvRow);
  AddVariavel(tvPanelGroup);

  sl := TStringList.Create;
  try
    sl.Add(Format(Identa + '  d2bPanelGroup := d2bTabSheet.PanelGroup(''%s'', false).Items.add;', [AGroupBox.Name]));
    //sl.Add(Format(Identa + '    d2bRow := d2bPanelGroup.Row.Items.add;', []));
    sl.Add(Format('{%s/%s}', [memWinControlsParent.AsString, AGroupBox.Name]));

    if AGroupBox.Parent is TCustomForm then
      Memo1.Lines.Add(sl.Text)
    else
    begin
      s := memWinControlsParent.AsString;
      sl.Add('');
      Memo1.Lines.Text := StringReplace(Memo1.Lines.Text, '{' + s + '}', sl.Text, []);
    end;
  finally
    sl.Free;
  end;
end;

procedure TViewExportForm2Web.AddPageControl(APageControl: TPageControl;
  AParent: String);
var
  I: Integer;
begin
  if Pos(APageControl.Name, Memo1.Lines.Text) > 0 then
    Exit;

  AddVariavel(tvRow);
  AddVariavel(tvPageControl);
  AddVariavel(tvTabSheet);

  Memo1.Lines.Add('');
  Memo1.Lines.Add(Identa + '  d2bPageControl := Tabs;');

  for I := 0 to APageControl.PageCount - 1 do
  begin
    Memo1.Lines.Add(Identa + '    d2bTabSheet := d2bPageControl.AddTab('+QuotedStr(APageControl.Pages[I].Caption)+').Items.add;');
    //Memo1.Lines.Add(Identa + '      d2bRow := d2bTabSheet.Row.Items.add;');
    Memo1.Lines.Add(Format('{%s/%s/%s}', [memWinControlsParent.AsString, APageControl.Name, APageControl.Pages[I].Name]));
    Memo1.Lines.Add('');
  end;
end;

procedure TViewExportForm2Web.AddPanel(APanel: TPanel);
var
  sl: TStrings;
  s: String;
begin
  AddVariavel(tvRow);
  AddVariavel(tvPanel);
  sl := TStringList.Create;
  try
    sl.Add(Identa + '  d2bPanel := HTMLDIV(''expanel expanel-body'').Items.add;');
    //sl.Add(Identa + '    d2bRow := d2bPanel.Row.Items.add;');
    sl.Add(Format('{%s/%s}', [memWinControlsParent.AsString, APanel.Name]));
    if APanel.Parent is TCustomForm then
      Memo1.Lines.Add(sl.Text)
    else
    begin
      s := memWinControlsParent.AsString;
      sl.Add('');
      Memo1.Lines.Text := StringReplace(Memo1.Lines.Text, '{' + s + '}', sl.Text, []);
    end;
  finally
    sl.Free;
  end;
end;

procedure TViewExportForm2Web.AddVariavel(ATipoVariavel: TTipoVariavel);
var s: String;
begin
  case ATipoVariavel of
    tvRow:        s := '  d2bRow: IItemAdd;';
    tvPageControl:s := '  d2bPageControl: ID2BridgeItemHTMLTabs;';
    tvTabSheet:   s := '  d2bTabsheet: IItemAdd;';
    tvPanel:      s := '  d2bPanel: IItemAdd;';
    tvPanelGroup: s := '  d2bPanelGroup: IItemAdd;';
  end;

  if slVariaveis.IndexOf(s) = -1 then
    slVariaveis.Add(s);
end;

procedure TViewExportForm2Web.Button1Click(Sender: TObject);
var
  s, n: String;
begin
  if OpenDialog1.Execute then
  begin
    s := TFile.ReadAllText(OpenDialog1.FileName);
    s := StringReplace(s, '{Variaveis D2Bridge}', slVariaveis.Text, []);
    s := StringReplace(s, '{Yours Controls}', Memo1.Text, []);
    TFile.WriteAllText(OpenDialog1.FileName, s);
    Application.Terminate;
  end;

end;

procedure TViewExportForm2Web.ComboBox1Change(Sender: TObject);
begin
  memWinControls.Filter   := 'parent like '+QuotedStr('%'+ComboBox1.Text+'%');
  memWinControls.Filtered := ComboBox1.ItemIndex > 0;
end;

procedure TViewExportForm2Web.FormDestroy(Sender: TObject);
begin
  slVariaveis.Free;
end;

function TViewExportForm2Web.GetparentVar(AControl: TWinControl): String;
begin
  Result := '';
  if AControl.Parent is TPageControl then
    Result := 'd2bPageControl.'
  else if AControl.Parent is TTabSheet then
    Result := 'd2bTabSheet.'
  else if AControl.Parent is TPanel then
    Result := 'd2bPanel.'
  else if AControl.Parent is TGroupBox then
    Result := 'd2bPanelGroup.';
end;

function TViewExportForm2Web.Identa: String;
begin
  Result := '  '+StringOfChar(' ', (memWinControlsParent.AsString.CountChar('/')*2));
end;

procedure TViewExportForm2Web.LimpaMemo;
var I: Integer;
  s: String;
  spc: Integer;
begin
  spc := 0;
  for I := Memo1.Lines.Count-1 downto 1 do
  begin
    s := Trim(Memo1.Lines[i]);

    if s = '' then
      Inc(spc);

    if (Spc = 2) then
    begin
      Memo1.Lines.Delete(i);
      Dec(spc);
    end
    else if s.StartsWith('{') then
      Memo1.Lines.Delete(i);
  end;
end;

procedure ExportForm2Web;
const
  TOP_INICIAL = -100;
var
  f: TForm;
  WinControl, w2: TWinControl;
  sLabel: TLabel;
  I, xTop, xLeft: Integer;
  iWidth: Integer;
  css, sParent, s: String;
  Name: String;
  Node: TTreeNode;
  sl: TStrings;
begin
  ViewExportForm2Web := TViewExportForm2Web.Create(nil);
  ViewExportForm2Web.ComboBox1.Items.Clear;

  if ViewExportForm2Web.slVariaveis <> nil then
    ViewExportForm2Web.slVariaveis.Free;
  ViewExportForm2Web.slVariaveis := TStringList.Create;
  ViewExportForm2Web.slVariaveis.Add('{Variaveis D2Bridge}');
  ViewExportForm2Web.AddVAriavel(tvRow);

  ViewExportForm2Web.ComboBox1.Items.Add('Todos');

  with ViewExportForm2Web do
  begin
    TreeView1.Items.BeginUpdate;
    TreeView1.Items.Clear;
    memWinControls.Close;
    memWinControls.Open;
    f := Screen.ActiveForm;
    for I := 0 to f.ComponentCount - 1 do
    begin
      if f.Components[I] is TWinControl then
      begin
        WinControl := TWinControl(f.Components[I]);
        Name := WinControl.Name;
        if ViewExportForm2Web.ComboBox1.Items.IndexOf(WinControl.Parent.Name) = -1 then
          ViewExportForm2Web.ComboBox1.Items.Add(WinControl.Parent.Name);

        memWinControls.Append;
        memWinControlsname.AsString  := WinControl.Name;
        memWinControlsLeft.Value     := WinControl.Left;
        memWinControlsTop.Value      := WinControl.Top;
        memWinControlsWidth.Value    := WinControl.Width;
        memWinControlsTabOrder.Value := WinControl.TabOrder;

        sParent := '';
        w2 := WinControl;
        repeat
          w2 := w2.Parent;
          sParent := w2.Name + ' ' + sParent;
        until (w2.Name = f.Name);

        memWinControlsParent.Value := StringReplace(Trim(sParent), ' ', '/', [rfReplaceAll]);

        // caption dos componentes q nao tem label associado
        if (WinControl is TCheckBox) then
          memWinControlsLabel.AsString := '' //TCheckBox(WinControl).Caption
        else if (WinControl is TDBCheckBox) then
          memWinControlsLabel.AsString := '' //TDBCheckBox(WinControl).Caption
        else if (WinControl is TRadioButton) then
          memWinControlsLabel.AsString := '' //TDBCheckBox(WinControl).Caption
        else if (WinControl is TTabSheet) then
          memWinControlsLabel.AsString := TTabSheet(WinControl).Caption;

        if (WinControl.Parent is TCustomForm) then
        begin
          Node := TreeView1.Items.Add(nil, Name);
        end
        else
        begin
          sParent := WinControl.Parent.Name;
          Node := FindNode(TreeView1, sParent);
          if Node = nil then
          begin
            Node := TreeView1.Items.Add(Node, Name);
          end
          else
          begin
            Node := TreeView1.Items.AddChild(Node, Name);
          end;

        end;
        memWinControls.Post;

      end;
    end;
    TreeView1.FullExpand;
    TreeView1.Items.EndUpdate;
    TreeView1.Repaint;

    for I := 0 to f.ComponentCount - 1 do
    begin
      if f.Components[I] is TLabel then
      begin
        sLabel := TLabel(f.Components[I]);
        if sLabel.Name = 'lblTitulo' then
          Continue;
        sParent := '';
        w2 := sLabel.Parent;
        while True do
        begin
          sParent := w2.Name + ' ' + sParent;
          if (w2.Name = f.Name) then
            Break;
          w2 := w2.Parent;
        end;
        sParent := StringReplace(Trim(sParent), ' ', '/', [rfReplaceAll]);
        memWinControls.Filter := 'parent = ' + QuotedStr(sParent) +
          Format(' AND (left >= %d AND left <= %d) AND (top >= %d and top <= %d)',
          [sLabel.Left - 5, sLabel.Left + 10, sLabel.Top + 5, sLabel.Top + 30]);
        memWinControls.Filtered := True;
        memWinControls.Edit;
        memWinControlslabel.AsString := sLabel.Name;
        memWinControls.Post;
      end;
    end;

    memWinControls.Filter := '';
    memWinControls.Filtered := False;
    memWinControls.IndexFieldNames := 'parent;taborder';
    memWinControls.First;
    xTop  := TOP_INICIAL;
    Memo1.Lines.Clear;
    Memo1.Lines.Add('{Yours Controls}');
    sParent := '{}';
    while not memWinControls.Eof do
    begin

      WinControl := TWinControl(f.FindComponent(memWinControlsName.AsString));

      if WinControl is TPageControl then
      begin
        AddPageControl(TPageControl(WinControl), memWinControlsparent.AsString);
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else if WinControl is TTabSheet then
      begin
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else if WinControl is TPanel then
      begin
        AddPanel(TPanel(WinControl));
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else if WinControl is TGroupBox then
      begin
        AddGroupBox(TGroupBox(WinControl));
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else
      begin


        if (xTop = TOP_INICIAL) then //(memWinControlsTop.Value > (xTop + 10)) then
        begin
          s := Identa + '  d2bRow := '+GetParentVar(WinControl)+'Row.Items.add; // ----';
          if WinControl.Parent is TCustomForm then
            Memo1.Lines.Add(s)
          else
          begin
            sParent := Format('{%s}', [memWinControlsParent.AsString]);
            Memo1.Lines.Text := StringReplace(Memo1.Lines.Text, sParent, s + #13 + sParent, [])
          end;
        end;
        sParent := Format('{%s}', [memWinControlsParent.AsString]);
        xTop := memWinControlsTop.Value;

        iWidth := (WinControl.Width div 100);
        if iWidth = 0 then
          iWidth := 1;
        css := 'CSSClass.Col.colsize'+ IntToStr(iWidth);
        if WinControl is TButtonControl then
          css := 'CSSClass.Col.colauto';
        s := Format(Identa + '    d2bRow.FormGroup(''%s'', %s).AddVCLObj(%s);', [memWinControlslabel.AsString, css, memWinControlsname.AsString]);

        if WinControl.Parent is TCustomForm then
          Memo1.Lines.Add(s)
        else
          Memo1.Lines.Text := StringReplace(Memo1.Lines.Text, sParent, '  ' + s + #13 + sParent, []);

        memWinControls.Next;

        if (memWinControls.Eof) or (memWinControlsTop.Value > (xTop + 10)) or (sParent <> '{'+memWinControlsParent.AsString+'}') then
        begin
          xTop := TOP_INICIAL;
        end;
      end;

    end;
    LimpaMemo;
    ViewExportForm2Web.ShowModal;
    FreeAndNil(ViewExportForm2Web);
  end;
end;

function TViewExportForm2Web.FindNode(ATreeView: TTreeView; AText: String): TTreeNode;
var
  i: Integer;
  node: TTreeNode;
begin
  Result := nil;
  for i := 0 to ATreeView.Items.Count - 1 do
  begin
    Node := ATreeView.Items.Item[i];
    if Node.Text = AText then
    begin
      Result := Node;
      Break;
    end;
  end;
end;

end.
