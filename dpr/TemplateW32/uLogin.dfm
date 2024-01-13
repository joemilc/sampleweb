object ViewLogin: TViewLogin
  Left = 0
  Top = 0
  Caption = 'D2Bridge - Login'
  ClientHeight = 261
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object edtUsuario: TEdit
    Left = 120
    Top = 32
    Width = 150
    Height = 23
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 120
    Top = 80
    Width = 150
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object BUTTON_LOGAR: TButton
    Left = 120
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = BUTTON_LOGARClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 27
    Width = 97
    Height = 31
    Caption = 'Login:'
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 8
    Top = 75
    Width = 97
    Height = 31
    Caption = 'Senha:'
    TabOrder = 4
  end
end
