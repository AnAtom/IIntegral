{
  Описание справочных данных

  AttrType - описание типа атрибута объекта
   attrName  : название типа атрибута (Рус., Англ.)
   attrNotns : обозначения типа атрибута
   attrUnit  : основная единица измерения атрибута (UnitType)
   attrVals  :

  QuanttType - описание типа величины
   quanName :
   quanUnit :

  UnitType - описание единицы измерения атрибута
   unitNotn : обозначение единицы измерения (Рус., Англ.)
   unitName : название единицы измерения (Рус., Англ.)
   unitQuantt : тип измеряемой величины
   unitBasic : основная единица измерения в СИ (UnitType)
   unitConv : формула пересчета в осноные единицы

  ValueType - описание значений атрибута
   valKind : тип значения (число, элемент множества )
   valName : название

  Attr - Атрибут объекта
  Unit - Единица измерения атрибута

   версия 0.1 сентябрь 2010 prodg@ya.ru D.Kondakov
}
unit ReferenceObjcts;

{$mode objfpc}

interface

uses
  Classes, SysUtils, IIntgrlBaseDefs, WrkspcCfgrtn, DataObjcts;

type
  TrefID = TinlID;

  { TReferenceDB }

  TReferenceDB = class(TDataMngrModule)

  public
    constructor Create(wCfg: TIntgrlCfgrtn);
    destructor Destroy; override;
    procedure GetDataTypes(var typsList: TStringList);
    procedure GetTypeInfo(var fieldsList: TStringList);
    procedure GetItemsInType(var dataList: TStringList);
    procedure GetDataInfo(dataID: TrefID; var fieldsList: TStringList);
    function FindDataByName(dtaName, dtaType: TinlNameType): TrefID;
  end;

implementation

constructor TReferenceDB.Create(wCfg: TIntgrlCfgrtn);
begin
  inherited Create(wCfg, 'LIB', ReferenceDBname);
  if assigned(wCfg) then begin
    wCfg.Set_LIB_module(Self);

  end;
  ConnectDB;
  Post('+++');
end;

destructor TReferenceDB.Destroy;
begin

  inherited Destroy;
end;

procedure TReferenceDB.GetDataTypes(var typsList: TStringList);
begin

end;

procedure TReferenceDB.GetTypeInfo(var fieldsList: TStringList);
begin

end;

procedure TReferenceDB.GetItemsInType(var dataList: TStringList);
begin

end;

procedure TReferenceDB.GetDataInfo(dataID: TrefID; var fieldsList: TStringList);
begin

end;

function TReferenceDB.FindDataByName(dtaName, dtaType: TinlNameType): TrefID;
begin
  result := -1;
end;

end.

