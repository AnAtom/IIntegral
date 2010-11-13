{
  Определение основных типов данных и констант

 TinlNameType - Тип для имен объектов
 TinlID - Тип для локального идентификатора
 TinlModifctn - Тип для описания версии изменения объекта
 TinlTimeStamp - Время последнего изменения объекта
 TinlUID - Тип для глобального уникального идентификатора

 ReferenceDBname
 ProjectDBname

   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit IIntgrlBaseDefs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

type
  TinlNameType = String;
  TinlID = Integer;
  TinlModifctn = Integer;
  TinlTimeStamp = TTimeStamp; // милисекунд дня + дней от РХ  (1 314 000 секунд в году)
  TinlUID = LongInt;

const
  noID = -1;

  maxQuanttNameSize = 32;
  maxUnitNotnSize = 8;
  maxUnitNameSize = 32;
  maxAttrNotnSize = 8;
  maxAttrNameSize = 32;

resourcestring
  RunLogName = 'iintegral.log';
  ReferenceDBname = 'refbase.db3';
  ProjectDBname = 'prjdata.db3';
  CfgDfltCntxt = 'Absolute';

// Таблицы справочной базы данных
  QuanttTblname = 'Velichin'; // Физические величины
  UnitTblname = 'EdIzmer';    // Единицы измерения
  SubstncTblname = 'Veschestv';  // Вещества и материалы
  AttrTblname = 'Svoystva';  // Свойства объектов

// Поля таблицы величин
  QuanttIDFldName = 'qID';
  QuanttNameFldName = 'qNazvan';
  QuanttEngNameFldName = 'qName';
  QuanttUnitFldName = 'qEdIzm';

// Поля таблицы единиц измерения
  UnitIDFldName = 'uID';
  UnitNotnFldName = 'uObozn';
  UnitNameFldName = 'uNazvan';
  UnitEngNameFldName = 'uName';
  UnitQuanFldName = 'uQuantt';
  UnitBasicFldName = 'uOsnovn';
  UnitConvFldName = 'uPreobr';

// Поля таблицы параметров
  AttrIDFldName = 'aID';
  AttrNotnFldName = 'aObozn';
  AttrNameFldName = 'aNazvan';
  AttrQuanttFldName = 'aQuantt';
  AttrUnitFldName = 'aEdIzm';

// Таблицы базы данных проекта
  ElmntTblname = 'Element';     // Компоненты

  ElmntIDFldName = 'elID';
  ElmntNameFldName = 'elName';
  ElmntOwnerFldName = 'elOwner';
  ElmntTypeFldName = 'elType';
  ElmntStateFldName = 'elState';
  ElmntSourceFldName = 'elSource';
  ElmntMdfctnFldName = 'elVersion';
  ElmntMdfTimeFldName = 'elTime';
  ElmntValueFldName = 'elValueString';

implementation

end.

