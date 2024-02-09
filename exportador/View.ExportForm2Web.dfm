object ViewExportForm2Web: TViewExportForm2Web
  Left = 0
  Top = 0
  Caption = 'ViewExportForm2Web'
  ClientHeight = 827
  ClientWidth = 1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    1077
    827)
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 8
    Top = 37
    Width = 1046
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsmemWinControls
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'name'
        Width = 153
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'left'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'top'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'width'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'label'
        Width = 151
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'taborder'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'parent'
        Width = 182
        Visible = True
      end>
  end
  object MemoCode: TMemo
    Left = 327
    Top = 247
    Width = 727
    Height = 540
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button1: TButton
    Left = 936
    Top = 793
    Width = 137
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Alterar na Unit'
    TabOrder = 2
    OnClick = Button1Click
    ExplicitTop = 784
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 247
    Width = 313
    Height = 540
    Anchors = [akLeft, akBottom]
    Indent = 19
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 194
    Height = 23
    Style = csDropDownList
    TabOrder = 4
    OnChange = ComboBox1Change
  end
  object MemoVars: TMemo
    Left = 128
    Top = 136
    Width = 401
    Height = 281
    Lines.Strings = (
      'MemoVars')
    TabOrder = 5
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Units|*.pas'
    InitialDir = 'D:\Programacao\_Sistemas2\D2Bridge\cfweb\src'
    Left = 136
    Top = 648
  end
  object memWinControls: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 560
    Top = 123
    object memWinControlsname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object memWinControlsleft: TIntegerField
      FieldName = 'left'
    end
    object memWinControlstop: TIntegerField
      FieldName = 'top'
    end
    object memWinControlswidth: TIntegerField
      FieldName = 'width'
    end
    object memWinControlslabel: TStringField
      FieldName = 'label'
      Size = 50
    end
    object memWinControlstaborder: TIntegerField
      FieldName = 'taborder'
    end
    object memWinControlsparent: TStringField
      FieldName = 'parent'
      Size = 250
    end
  end
  object dsmemWinControls: TDataSource
    AutoEdit = False
    DataSet = memWinControls
    Left = 554
    Top = 187
  end
end
