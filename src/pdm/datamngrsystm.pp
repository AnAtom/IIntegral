{
  Модуль хранения и управления данными проекта

 TGeneralDataItem - любой элемент данных
  diID      : идентификатор
  diName    : название
  diOwner   : выше по иерархии
  diType    : тип
  diState   : состояние готовности
  diStatus  : статус проверки
  diSource  : источник данных
  diMdfctn  : номер ревизии
  diMdfDate : дата изменения
  diChngHist: история изменений

   версия 0.1 от 17.10.2010
}
unit DataMngrSystm;

{$mode objfpc}

interface

uses
  Classes, SysUtils, IIntgrlBaseDefs, WrkspcCfgrtn, LogSystm, DataObjcts;

type

  TdataID = TinlID;
  TdataType = (dtaAny, dtaSys, dtaModule, dtaProc, dtaFunc, dtaVar, dtaTemplate, dtaSection, dtaAttr, dtaUnit);

  { TProjectDB }

  TProjectDB = class(TDataMngrModule)
  public
    constructor Create(wCfg: TIntgrlCfgrtn);
    destructor Destroy; override;
    function FindObject(objName: TdataName): TdataID;
    function FindAtribute(atrName: TdataName): TdataID;
    function FindFunction(funName: TdataName): TdataID;
  end;

//    function CreateObject(objName: TdataName);
//    function AddData(dtaName: TdataName; var dtaType: TdataType): TdataID;
//    function FindDataByName(dtaName: TdataName; var dtaType: TdataType): TdataID;
//    procedure DeleteData(dtaID: TdataID);
//    procedure SaveBaseToFile(fileName: string);
//    procedure RestoreBaseFromFile(fileName: string);
//    procedure ResetBase;

implementation

constructor TProjectDB.Create(wCfg: TIntgrlCfgrtn);
begin
  inherited Create(wCfg, 'DB', ProjectDBname);
  if assigned(wCfg) then begin
    wCfg.Set_DB_module(Self);

  end;
  ConnectDB;
  Post('+++');
end;

destructor TProjectDB.Destroy;
begin

  inherited Destroy;
end;

function TProjectDB.FindObject(objName: TdataName): TdataID;
begin

end;

function TProjectDB.FindAtribute(atrName: TdataName): TdataID;
begin

end;

function TProjectDB.FindFunction(funName: TdataName): TdataID;
begin

end;

{function TProjectDB.AddData(dtaName: TdataName; var dtaType: TdataType): TdataID;
begin
  result := 0;
end;

function TProjectDB.FindDataByName(dtaName: TdataName; var dtaType: TdataType): TdataID;
begin

end;

procedure TProjectDB.DeleteData(dtaID: TdataID);
begin

end;
}{
procedure TProjectDB.SaveBaseToFile(fileName: string);
begin

end;

procedure TProjectDB.RestoreBaseFromFile(fileName: string);
begin

end;

procedure TProjectDB.ResetBase;
begin

end;
}
end.

