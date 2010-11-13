{
  Определение типов данных для вычислений и констант

 TclcStrng - Строковая величина (также используется для имен данных и функций)
 TclcBool  - Логическая величина
 TclcIntgr - Целая величина
 TclcReal  - Действительная величина
 TclcCmplx - Комплексная величина

 TclcIndex - Индекс массива

   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit CalcTypes;

{$mode objfpc}{$H+}

interface

{$I calcconfig.inc}

uses
  Classes, SysUtils, IIntgrlBaseDefs;

type
  TclcName = TinlNameType;

  TclcValType = (vtReal, vtInteger, vtBoolean, vtComplex, vtString, vtObject, vtData, vtNone);

  TclcStrng = string;   // Строковая величина
  TclcBool = Boolean;   // Логическая величина
  TclcIntgr = Integer;  // Целая величина
  TclcReal = Double;    // Действительная величина
  TclcCmplx = record    // Комплексная величина
    Re : TclcReal;
    Im : TclcReal;
  end;

  TclcCltnItm = record
    ciType: TclcValType;
    ciValue: pointer;
  end;
  TclcCollctn = array of TclcCltnItm;

  TclcIndex = TinlID;                            // Индекс массива
  TclcRealVec = array of TclcReal;               // Вектор действительных чисел
  TclcRealArr = array of array of TclcReal;      // Матрица действительных чисел
  TclcCmplxVec = array of TclcCmplx;             // Вектор комплексных чисел
  TclcCmplxArr = array of array of TclcCmplx;    // Матрица комплексных чисел

  PclcReal = ^TclcReal;
  PclcIntgr = ^TclcIntgr;
  PclcBool = ^TclcBool;
  PclcCmplx = ^TclcCmplx;
  PclcStrng = ^TclcStrng;
  PclcRealVec = ^TclcRealVec;
  PclcRealArr = ^TclcRealArr;
  PclcCmplxVec = ^TclcCmplxVec;
  PclcCmplxArr = ^TclcCmplxArr;

  TclcVarState = (vsUndefined, vsNotCalculated, vsErrorCalc);
  TclcVarClass = (vcConst, vcParametr, vcVariable, vcInput, vcOutput, vcFunction, vcSystem, vcObject);

  TclcCase = (ccEver, ccAfterInit, ccMakeStep, ccStopTime);
  TclcLang = (clC, clPascal, clFortran, clBASIC, clCPP);
  TclcParseError = (erNoError, erVarNotFound, erWrongTypeArgument, erClosingPar);
  TclcActionStatus = (caClear, caError, caWarning, caCancel);

const
  TclcRestrNameChars: set of char = [#0, #9, #10, #13, '.', ',', '=', '+', '-', '*', '/', '^'];
  sTrue = 'true';
  sFalse = 'false';
  sOn = 'on';
  sOff = 'off';
  sYes = 'yes';
  sNo = 'no';
  sEnabled = 'enabled';
  sDisabled = 'disabled';

  function s2n(s: TclcStrng): TclcName; inline;
  function b2s(b: TclcBool): TclcStrng; inline;
  function i2s(i: TclcIntgr): TclcStrng; inline;
  function h2s(i: TclcIntgr): TclcStrng; inline;
  function r2s(r: TclcReal): TclcStrng; inline;
  function c2s(c: TclcCmplx): TclcStrng; inline;
  function i2b(i: TclcIntgr): TclcBool; inline;
  function r2b(r: TclcReal): TclcBool; inline;
  function s2b(s: TclcStrng): TclcBool; inline;
  function int2idx(i: TclcIntgr): TclcIndex; inline;
  function ValdName(s: TclcName): boolean; inline;

implementation

function s2n(s: TclcStrng): TclcName;
begin
  result := s;
end;

function b2s(b: TclcBool): TclcStrng;
begin
  if b then result := sTrue else result := sFalse;
end;

function i2s(i: TclcIntgr): TclcStrng;
begin
  result := IntToStr(i);
end;

function h2s(i: TclcIntgr): TclcStrng;
begin

end;

function r2s(r: TclcReal): TclcStrng;
begin
//  str(
end;

function c2s(c: TclcCmplx): TclcStrng;
begin

end;

function i2b(i: TclcIntgr): TclcBool;
begin
  result := i<>0;
end;

function r2b(r: TclcReal): TclcBool;
begin
  result := r<>0;
end;

function s2b(s: TclcStrng): TclcBool;
begin
  result := (s='1')or(s=sTrue)or(s=sOn)or(s=sYes)or(s=sEnabled);
end;

function int2idx(i: TclcIntgr): TclcIndex; inline;
begin
  if i>0 then result := i;
end;

function ValdName(s: TclcName): boolean;
var
  i: integer;
begin
  result := false;
  i := length(s);
  while i>0 do
    if s[i] in TclcRestrNameChars then exit else dec(i);
  result := true;
end;


end.

