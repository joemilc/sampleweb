unit UserSessionUnit;

interface

uses
  System.SysUtils, System.Classes,
  Prism.SessionBase;

type
  TPrismUserSession = class(TPrismSessionBase)
  private

  public
    FUser_Id: integer;
    FUser_Name: String;
    FUser_Profile: String;
    FEmpresa_Nome: string;
    FEmpresa_Id: Integer;
  end;


implementation


end.

