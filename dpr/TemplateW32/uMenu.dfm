object ViewMenu: TViewMenu
  Left = 0
  Top = 0
  Caption = 'D2Bridge - Menu'
  ClientHeight = 424
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 56
    Top = 32
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object ContasaReceber1: TMenuItem
        Caption = 'SampleForm'
        Hint = 'bi bi-bar-chart-line'
        OnClick = ContasaReceber1Click
      end
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        Hint = 'bi bi-people'
        OnClick = Cliente1Click
      end
      object Cidade1: TMenuItem
        Caption = 'Cidade'
      end
    end
    object Outros1: TMenuItem
      Caption = 'Outros'
      object Outros2: TMenuItem
        Caption = 'SampleForm2'
        OnClick = Outros2Click
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnShortCut = ApplicationEvents1ShortCut
    Left = 56
    Top = 168
  end
end
