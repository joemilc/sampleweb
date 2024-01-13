unit uExportaControls;

interface

uses
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Forms,
  Vcl.DBCtrls,
  System.SysUtils,
  System.Classes,
  Vcl.Controls;

type

  TTipoVariavel = (tvRow, tvPageControl, tvTabSheet, tvPanel, tvPanelGroup);

  IExportaControls = interface
    ['{2F589FB7-D932-484E-A36C-21B2450A60E3}']
    function ExportaPageControl(APageControl: TPageControl): IExportaControls;
    function ExportaPanel(APanel: TPanel): IExportaControls;
    function ExportaGroupBox(AGroupBox: TGroupBox): IExportaControls;
    function ExportaAny: IExportaControls;
    function SetForm(AForm: TCustomForm): IExportaControls;
    function Initialize: IExportaControls;
    function ListaComponentes: IExportaControls;
    function ListaLabels: IExportaControls;
    function GeraCodigo: IExportaControls;
  end;

  TExportaControls = class(TInterfacedObject, IExportaControls)
  private
    FForm: TCustomForm;
    procedure AddVariavel(ATipoVariavel: TTipoVariavel; AVarName: String);
    function Identa: String;
    procedure LimpaMemo;
    function GetParentVar(AControl: TWinControl): String;
    function FindNode(ATreeView: TTreeView; AText: String): TTreeNode;
  public
    function ExportaPageControl(APageControl: TPageControl): IExportaControls;
    function ExportaPanel(APanel: TPanel): IExportaControls;
    function ExportaGroupBox(AGroupBox: TGroupBox): IExportaControls;
    function ExportaAny: IExportaControls;
    function SetForm(AForm: TCustomForm): IExportaControls;
    function Initialize: IExportaControls;
    function ListaComponentes: IExportaControls;
    function ListaLabels: IExportaControls;
    function GeraCodigo: IExportaControls;

    constructor Create;
    destructor Destroy; override;
    class function New: IExportaControls;
  end;

implementation

{ TExportaControls }

uses View.ExportForm2Web;

procedure TExportaControls.AddVariavel(ATipoVariavel: TTipoVariavel; AVarName: String);
begin
  AVarName := 'd2b'+AVarName;
  case ATipoVariavel of
    tvRow:
      begin
        if Pos(': IItemAdd; {var_row}', ViewExportForm2Web.MemoVars.Text) = 0 then
          ViewExportForm2Web.MemoVars.Lines.Add('  '+AVarName+': IItemAdd; {var_row}')
        else
          ViewExportForm2Web.MemoVars.Text := StringReplace(ViewExportForm2Web.MemoVars.Text, ': IItemAdd; {var_row}', Format(', %s: IItemAdd; {var_row}', [AVarName]), []);
      end;
    tvPageControl:
      begin
        if Pos(': ID2BridgeItemHTMLTabs; {var_pagecontrol}', ViewExportForm2Web.MemoVars.Text) = 0 then
          ViewExportForm2Web.MemoVars.Lines.Add('  '+AVarName+': ID2BridgeItemHTMLTabs; {var_pagecontrol}')
        else
          ViewExportForm2Web.MemoVars.Text := StringReplace(ViewExportForm2Web.MemoVars.Text, ': ID2BridgeItemHTMLTabs; {var_pagecontrol}', Format(', %s: ID2BridgeItemHTMLTabs; {var_pagecontrol}', [AVarName]), []);
      end;
    tvTabSheet:
      begin
        if Pos(': IItemAdd; {var_tabsheet}', ViewExportForm2Web.MemoVars.Text) = 0 then
          ViewExportForm2Web.MemoVars.Lines.Add('  '+AVarName+': IItemAdd; {var_tabsheet}')
        else
          ViewExportForm2Web.MemoVars.Text := StringReplace(ViewExportForm2Web.MemoVars.Text, ': IItemAdd; {var_tabsheet}', Format(', %s: IItemAdd; {var_tabsheet}', [AVarName]), []);
      end;
    tvPanel:
      begin
        if Pos(': IItemAdd; {var_panel}', ViewExportForm2Web.MemoVars.Text) = 0 then
          ViewExportForm2Web.MemoVars.Lines.Add('  '+AVarName+': IItemAdd; {var_panel}')
        else
          ViewExportForm2Web.MemoVars.Text := StringReplace(ViewExportForm2Web.MemoVars.Text, ': IItemAdd; {var_panel}', Format(', %s: IItemAdd; {var_panel}', [AVarName]), []);
      end;
    tvPanelGroup:
      begin
        if Pos(': IItemAdd; {var_panelgroup}', ViewExportForm2Web.MemoVars.Text) = 0 then
          ViewExportForm2Web.MemoVars.Lines.Add('  '+AVarName+': IItemAdd; {var_panelgroup}')
        else
          ViewExportForm2Web.MemoVars.Text := StringReplace(ViewExportForm2Web.MemoVars.Text, ': IItemAdd; {var_panelgroup}', Format(', %s: IItemAdd; {var_panelgroup}', [AVarName]), []);
      end;
  end;

end;

constructor TExportaControls.Create;
begin
  ViewExportForm2Web := TViewExportForm2Web.Create(nil);
end;

destructor TExportaControls.Destroy;
begin
  FreeAndNil(ViewExportForm2Web);
  inherited;
end;

function TExportaControls.Initialize: IExportaControls;
begin
  Result := Self;

  ViewExportForm2Web.ComboBox1.Items.Clear;
  ViewExportForm2Web.ComboBox1.Items.Add('Todos');

  ViewExportForm2Web.MemoCode.Lines.Clear;

  ViewExportForm2Web.MemoVars.Lines.Clear;
  ViewExportForm2Web.MemoVars.Lines.Add('{Variaveis D2Bridge}');

  AddVAriavel(tvRow, 'Row');

end;

function TExportaControls.ExportaAny: IExportaControls;
begin
  Result := Self;
end;

function TExportaControls.ExportaGroupBox(AGroupBox: TGroupBox): IExportaControls;
var
  sl: TStrings;
  s, sName: String;
begin
  Result := Self;
  AddVariavel(tvPanelGroup, ViewExportForm2Web.memWinControlsName.AsString);

  sl := TStringList.Create;
  try
    sName := 'd2b'+AGroupBox.Name;
    sl.Add(Format(Identa + '  ' + sName + ' := d2b'+AGroupBox.Parent.Name+'.PanelGroup(''%s'', false).Items.add;', [AGroupBox.Name]));
    //sl.Add(Format(Identa + '    d2bRow := d2bPanelGroup.Row.Items.add;', []));
    sl.Add(Format('{%s/%s}', [ViewExportForm2Web.memWinControlsParent.AsString, AGroupBox.Name]));

    if AGroupBox.Parent is TCustomForm then
      ViewExportForm2Web.MemoCode.Lines.Add(sl.Text)
    else
    begin
      s := ViewExportForm2Web.memWinControlsParent.AsString;
      sl.Add('');
      ViewExportForm2Web.MemoCode.Lines.Text := StringReplace(ViewExportForm2Web.MemoCode.Lines.Text, '{' + s + '}', sl.Text, []);
    end;
  finally
    sl.Free;
  end;
end;

function TExportaControls.ExportaPageControl(APageControl: TPageControl): IExportaControls;
var
  I: Integer;
  PageCName, TabName: String;
  sl: TStrings;
  sParent, sVars: String;
begin
  Result := Self;
  if Pos(APageControl.Name, ViewExportForm2Web.MemoCode.Lines.Text) > 0 then
    Exit;

  PageCName := 'd2b' + APageControl.Name;
  ViewExportForm2Web.MemoVars.Lines.Add('  ' + PageCName + ': ID2BridgeItemHTMLTabs; {var_pagecontrol}');

  sl := TStringList.Create;
  sl.Add('');
  sl.Add(Identa + '  '+PageCName + ' := Tabs;');

  sVars := '';
  for I := 0 to APageControl.PageCount - 1 do
  begin
    TabName := 'd2b' + APageControl.Pages[I].Name;
    sVars := sVars + TabName + ' ';
    sl.Add(Format(Identa + '    %s := %s.AddTab(%s).Items.add;', [TabName, PageCName, QuotedStr(APageControl.Pages[I].Caption)]));
    sl.Add(Format('{%s/%s/%s}', [ViewExportForm2Web.memWinControlsParent.AsString, APageControl.Name, APageControl.Pages[I].Name]));
  end;

  if APageControl.Parent is TCustomForm then
    ViewExportForm2Web.MemoCode.Lines.Add(sl.Text)
  else
  begin
    sParent := Format('{%s}', [ViewExportForm2Web.memWinControlsParent.AsString]);
    sl.Add(sParent);
    ViewExportForm2Web.MemoCode.Lines.Text := StringReplace(ViewExportForm2Web.MemoCode.Lines.Text, sParent, sl.Text, []);
  end;

  sVars := '  '+StringReplace(Trim(sVars), ' ', ',', [rfReplaceAll])+ ': IItemAdd; {var_tabsheet}';
  ViewExportForm2Web.MemoVars.Lines.Add(sVars);
  sl.Free;
end;

function TExportaControls.ExportaPanel(APanel: TPanel): IExportaControls;
var
  sl: TStrings;
  sName, s: String;
begin
  Result := Self;
  AddVariavel(tvPanel, APanel.Name);
  sl := TStringList.Create;
  try
    sName := 'd2b'+APanel.Name;
    sl.Add(Identa + '  '+Sname+' := HTMLDIV(''expanel expanel-body'').Items.add;');
    //sl.Add(Identa + '    d2bRow := d2bPanel.Row.Items.add;');
    sl.Add(Format('{%s/%s}', [ViewExportForm2Web.memWinControlsParent.AsString, APanel.Name]));
    if APanel.Parent is TCustomForm then
      ViewExportForm2Web.MemoCode.Lines.Add(sl.Text)
    else
    begin
      s := ViewExportForm2Web.memWinControlsParent.AsString;
      sl.Add('');
      ViewExportForm2Web.MemoCode.Lines.Text := StringReplace(ViewExportForm2Web.MemoCode.Lines.Text, '{' + s + '}', sl.Text, []);
    end;
  finally
    sl.Free;
  end;
end;

function TExportaControls.FindNode(ATreeView: TTreeView; AText: String): TTreeNode;
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

function TExportaControls.GeraCodigo: IExportaControls;
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
  Result := Self;
  with ViewExportForm2Web do
  begin
    memWinControls.Filter := '';
    memWinControls.Filtered := False;
    memWinControls.IndexFieldNames := 'parent;taborder';
    memWinControls.First;
    xTop  := TOP_INICIAL;
    MemoCode.Lines.Clear;
    MemoCode.Lines.Add('{Yours Controls}');
    sParent := '{}';
    while not memWinControls.Eof do
    begin

      WinControl := TWinControl(FForm.FindComponent(memWinControlsName.AsString));

      if WinControl is TPageControl then
      begin
        Self.ExportaPageControl(TPageControl(WinControl));
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
        Self.ExportaPanel(TPanel(WinControl));
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else if WinControl is TGroupBox then
      begin
        Self.ExportaGroupBox(TGroupBox(WinControl));
        xTop := TOP_INICIAL;
        memWinControls.Next;
      end
      else
      begin

        if (xTop = TOP_INICIAL) then //(memWinControlsTop.Value > (xTop + 10)) then
        begin
          s := Identa + '  d2bRow := '+GetParentVar(WinControl)+'Row.Items.add; // ----';
          if WinControl.Parent is TCustomForm then
            MemoCode.Lines.Add(s)
          else
          begin
            sParent := Format('{%s}', [memWinControlsParent.AsString]);
            MemoCode.Lines.Text := StringReplace(MemoCode.Lines.Text, sParent, s + #13 + sParent, [])
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
          MemoCode.Lines.Add(s)
        else
          MemoCode.Lines.Text := StringReplace(MemoCode.Lines.Text, sParent, '  ' + s + #13 + sParent, []);

        memWinControls.Next;

        if (memWinControls.Eof) or (memWinControlsTop.Value > (xTop + 10)) or (sParent <> '{'+memWinControlsParent.AsString+'}') then
        begin
          xTop := TOP_INICIAL;
        end;
      end;

    end;
    LimpaMemo;
    ViewExportForm2Web.ShowModal;
  end;
end;

function TExportaControls.GetParentVar(AControl: TWinControl): String;
begin
  Result := '';
  if not (AControl.Parent is TCustomForm) then
    Result := Format('d2b%s.', [AControl.Parent.Name]);

end;

function TExportaControls.Identa: String;
begin
  Result := '  '+StringOfChar(' ', (ViewExportForm2Web.memWinControlsParent.AsString.CountChar('/')*2));
end;

procedure TExportaControls.LimpaMemo;
var I: Integer;
  s: String;
  spc: Integer;
begin
  spc := 0;
  for I := ViewExportForm2Web.MemoCode.Lines.Count-1 downto 1 do
  begin
    s := Trim(ViewExportForm2Web.MemoCode.Lines[i]);

    if s = '' then
      Inc(spc);

    if (Spc = 2) then
    begin
      ViewExportForm2Web.MemoCode.Lines.Delete(i);
      Dec(spc);
    end
    else if s.StartsWith('{') then
      ViewExportForm2Web.MemoCode.Lines.Delete(i);
  end;
end;

function TExportaControls.ListaComponentes: IExportaControls;
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
  Result := Self;
  with ViewExportForm2Web do
  begin
    TreeView1.Items.BeginUpdate;
    TreeView1.Items.Clear;
    memWinControls.Close;
    memWinControls.Open;

    for I := 0 to FForm.ComponentCount - 1 do
    begin
      if FForm.Components[I] is TWinControl then
      begin
        WinControl := TWinControl(FForm.Components[I]);
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
        until (w2.Name = FForm.Name);

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
  end;

end;

function TExportaControls.ListaLabels: IExportaControls;
var I: Integer;
  sLabel: TLabel;
  sParent: String;
  w2: TWinControl;
begin
  Result := Self;
  with ViewExportForm2Web do
  begin
    for I := 0 to FForm.ComponentCount - 1 do
    begin
      if FForm.Components[I] is TLabel then
      begin
        sLabel := TLabel(FForm.Components[I]);
        if sLabel.Name = 'lblTitulo' then
          Continue;
        sParent := '';
        w2 := sLabel.Parent;
        while True do
        begin
          sParent := w2.Name + ' ' + sParent;
          if (w2.Name = FForm.Name) then
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
  end;
end;

class function TExportaControls.New: IExportaControls;
begin
  Result := Self.Create;
end;

function TExportaControls.SetForm(AForm: TCustomForm): IExportaControls;
begin
  Result := Self;
  FForm := AForm;
end;

end.
