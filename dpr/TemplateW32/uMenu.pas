unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.AppEvnts;

type
  TViewMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    Cidade1: TMenuItem;
    ContasaReceber1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    procedure Cliente1Click(Sender: TObject);
    procedure ApplicationEvents1ShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ContasaReceber1Click(Sender: TObject);
    procedure ContasaReceber2Click(Sender: TObject);
  private

  public
   //destructor Destroy; override;
    { Public declarations }
  end;

Function ViewMenu: TViewMenu;

implementation

Uses
 Unit_Cadastro_Cliente,
 D2Bridge.Instance,
 uSampleForm,
 uExportaControls;

{$R *.dfm}

Function ViewMenu: TViewMenu;
begin
 Result:= TViewMenu(D2BridgeInstance.GetInstance(TViewMenu));
end;

procedure TViewMenu.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
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

procedure TViewMenu.Cliente1Click(Sender: TObject);
begin
 if Form_Cadastro_Cliente = nil then
  TForm_Cadastro_Cliente.CreateInstance;
 Form_Cadastro_Cliente.ShowModal;
end;

procedure TViewMenu.ContasaReceber1Click(Sender: TObject);
begin
  if fSampleForm = nil then
    TfSampleForm.CreateInstance;
  fSampleForm.ShowModal;
end;

procedure TViewMenu.ContasaReceber2Click(Sender: TObject);
begin

end;

//destructor TForm_Menu.Destroy;
//begin
// inherited;
//end;

end.
