{
  Информационные объекты


   версия 0.1 от 03.02.2010
}
unit InfoObjcts;

{$mode objfpc}{$H+}

interface

{$I calcconfig.inc}

uses
  Classes, SysUtils; 

type
  TsrcTxtID = integer;
  TsrcTxtPstn = integer;

  TGeneralInfo = class
    srcTxtID: TsrcTxtID;
    StartPstn: TsrcTxtPstn;
    EndPstn: TsrcTxtPstn;

  end;

implementation

end.

