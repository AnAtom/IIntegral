{
  Описание объектов хранения данных проекта

 TDataMngrModule - модуль программы для работы с базой данных
  Remote: bool
  Connected: bool
  SrcName: string
  proc ConnectDB
  proc CloseDB

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

   версия 0.1 от 03.02.2010
}
unit DataObjcts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IIntgrlBaseDefs, WrkspcCfgrtn, LogSystm;

type
  TinfoID = TinlID;
  TdataName = TinlNameType;
  TinfoVersn = TinlModifctn;
  TdataTime = TinlTimeStamp;

  TIntgrlNameSpace = class;

  { TIntgrlNameObject }

  TIntgrlNameObject = class
    nmName: TinlNameType;
    nmOwner: TIntgrlNameSpace;
    constructor Create;
    destructor Destroy; override;
    function GetNamePath: TinlNameType;
    function FindSelf(aName: TinlNameType): TIntgrlNameObject; virtual;
    function FindUp(aName: TinlNameType): TIntgrlNameObject;
  end;

  { TIntgrlNameSpace }

  TIntgrlNameSpace = class(TIntgrlNameObject)
    nmItems: array of TIntgrlNameObject;
    constructor Create;
    destructor Destroy; override;
    function FindSelf(aName: TinlNameType): TIntgrlNameObject; override;
    function FindDown(aName: TinlNameType): TIntgrlNameObject;
    function FindLocal(aName: TinlNameType): TIntgrlNameObject;
    function FindLocalAndUp(aName: TinlNameType): TIntgrlNameObject;
    function FindLocalAndDown(aName: TinlNameType): TIntgrlNameObject;
    function IsDownPathExist(aName: TinlNameType): boolean;
    procedure InsertItem(newItem: TIntgrlNameObject);
    procedure RemoveItem(oldItem: TIntgrlNameObject);
  end;

  { TdataInfo }

  TdataInfo = class
  private
    diID        : TinfoID;
    diName      : TdataName;
    diPrtotype  : TdataInfo;
    diPrtpID    : TinfoID;
    diMdfTime   : TdataTime;
    diMdfctn    : TinlModifctn;
  public
    property Name: TdataName read diName;
    constructor Create(idProto: TinfoID; DB: TDataMngrModule);
    constructor Create(Proto: TdataInfo; const AName: TdataName);
    destructor Destroy; override;
  end;

implementation

{ TdataInfo }

constructor TdataInfo.Create(idProto: TinfoID; DB: TDataMngrModule);
begin
  inherited Create;
  diPrtpID := idProto;

end;

constructor TdataInfo.Create(Proto: TdataInfo; const AName: TdataName);
begin
  inherited Create;
  diPrtotype := Proto;
  diName := AName;
  if assigned(Proto) then diPrtpID := Proto.diID else diPrtpID := noID;
  diMdfTime := NowItIs;
  diMdfctn := 1;
end;

destructor TdataInfo.Destroy;
begin

  inherited Destroy;
end;

{ TIntgrlNameObject }

constructor TIntgrlNameObject.Create;
begin
  inherited Create;

end;

destructor TIntgrlNameObject.Destroy;
begin

  inherited Destroy;
end;

function TIntgrlNameObject.GetNamePath: TinlNameType;
begin

end;

function TIntgrlNameObject.FindSelf(aName: TinlNameType): TIntgrlNameObject;
begin

end;

function TIntgrlNameObject.FindUp(aName: TinlNameType): TIntgrlNameObject;
begin

end;

{ TIntgrlNameSpace }

constructor TIntgrlNameSpace.Create;
begin
  inherited Create;

end;

destructor TIntgrlNameSpace.Destroy;
begin

  inherited Destroy;
end;

function TIntgrlNameSpace.FindSelf(aName: TinlNameType): TIntgrlNameObject;
begin
  Result:=inherited FindSelf(aName);

end;

function TIntgrlNameSpace.FindDown(aName: TinlNameType): TIntgrlNameObject;
begin

end;

function TIntgrlNameSpace.FindLocal(aName: TinlNameType): TIntgrlNameObject;
begin

end;

function TIntgrlNameSpace.FindLocalAndUp(aName: TinlNameType): TIntgrlNameObject;
begin

end;

function TIntgrlNameSpace.FindLocalAndDown(aName: TinlNameType): TIntgrlNameObject;
begin

end;

function TIntgrlNameSpace.IsDownPathExist(aName: TinlNameType): boolean;
begin

end;

procedure TIntgrlNameSpace.InsertItem(newItem: TIntgrlNameObject);
begin

end;

procedure TIntgrlNameSpace.RemoveItem(oldItem: TIntgrlNameObject);
begin

end;

end.

