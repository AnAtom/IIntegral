{<
  Объекты для вычислений

 TGeneralExpression - Базовый класс для всех вычисляемых выражений

 TRealExprsn  - Действительное выражение
 TIntgrExprsn - Целое выражение
 TBoolExprsn  - Логическое выражение
 TCmplxExprsn - Комплексное выражение
 TStrngExprsn - Строковое выражение

 TVectorVariable  - Переменная с векторным значением
  vSize - Размер вектора
 TArrayVariable   - Переменная с матричным значением
  aCol - Число столбцов матрицы
  aRow - Число строк матрицы

 TGeneralVariable - Базовый класс для всех именованных переменных
  vName - Имя переменной
  vType - Тип значения ( действительное, целое, логическое, комплексное, строковое )
  vState - Состояние готовности ( не определена, не вычислялась, не вычислилась из-за ошибки )
  vClass - Как получается значение ( константа, параметр, внешняя, вычисляемая, интегрируемая )

@author(Дмитрий Кондаков prodg@ya.ru)
@created(03.02.2010)
@lastmod(27.07.2010)

   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit CalcObjcts;

{$mode objfpc}{$H+}

interface

{$I calcconfig.inc}

uses
  Classes, SysUtils, CalcTypes;

type

  { TGeneralExpression }

  TGeneralExpression = class                                // Вычисляемое выражение
  protected
    function GetExprState: TclcVarState; virtual; abstract; // Что тут
    function GetExprClass: TclcVarClass; virtual; abstract; // Откуда
    function GetExprString: string; virtual; abstract;      // Выдать написание
    function thisString: boolean; virtual; abstract;
    function thisLogic: boolean; virtual; abstract;
    function thisInteger: boolean; virtual; abstract;
    function thisReal: boolean; virtual; abstract;
    function GetValueType: TclcValType; virtual; abstract;  // Тип значения
    function GetValString: TclcStrng; virtual; abstract;    // Значение в виде строки
    function GetValLogic: TclcBool; virtual; abstract;      // Значение в виде строки
    function GetValInteger: TclcIntgr; virtual; abstract;   // Значение в виде строки
    function GetValReal: TclcReal; virtual; abstract;       // Значение в виде строки
    function Evaluate: TclcActionStatus; virtual; abstract;
  public
    property exprState: TclcVarState read GetExprState;
    property exprClass: TclcVarClass read GetExprClass;
    property exprString: string read GetExprString;
    property isString: boolean read thisString;
    property isLogic: boolean read thisLogic;
    property isInteger: boolean read thisInteger;
    property isReal: boolean read thisReal;
    property valType: TclcValType read GetValueType;
    property valString: TclcStrng read GetValString;
    property valLogic: TclcBool read GetValLogic;
    property valInteger: TclcIntgr read GetValInteger;
    property valReal: TclcReal read GetValReal;
    function Calculate: TclcActionStatus;
  end;

  TBinOperation = class(TGeneralExpression)
    LeftArg: TGeneralExpression;
    RightArg: TGeneralExpression;
    function CalculateBinOperation(Res: TGeneralExpression;
      Left: TGeneralExpression; Right: TGeneralExpression): TclcActionStatus; virtual; abstract;
  end;

  TGeneralArgumentsList = array of TGeneralExpression;

  TMultiOperation = class(TGeneralExpression)
    Args: TGeneralArgumentsList;
    function CalcFirstArg(Res: TGeneralExpression; First: TGeneralExpression): TclcActionStatus; virtual; abstract;
    function CalcNextArg(Res: TGeneralExpression; Next: TGeneralExpression): TclcActionStatus; virtual; abstract;
    function CalcLastArg(Res: TGeneralExpression; Last: TGeneralExpression): TclcActionStatus; virtual; abstract;
  end;

  PGeneralExpression = ^TGeneralExpression;
  TArgumentsArray = array [1..MaxListSize] of TGeneralExpression;
  PArgumentsArray = ^TArgumentsArray;

  TGeneralProcedure = function(inpArgs: PArgumentsArray; uotVals: PArgumentsArray): TclcActionStatus;

  TGeneralFunction = class(TGeneralExpression)
    Input: TGeneralArgumentsList;
    FunctnProc: TGeneralProcedure;
  end;

implementation

{ TGeneralExpression }

function TGeneralExpression.Calculate: TclcActionStatus;
begin
  result := Evaluate;
end;

end.

  TRealExprsn = class(TGeneralExpression)             // Действительное выражение
    function rEvaluate: TclcReal; virtual; abstract;  // Функция вычисления текущего значения действительного выражения
    property rValue: TclcReal read rEvaluate;         // Текущее значение действительного выражения
  end;

  TIntgrExprsn = class(TGeneralExpression)            // Целое выражение
    function iEvaluate: TclcIntgr; virtual; abstract; // Функция вычисления текущего значения целого выражения
    property iValue: TclcIntgr read iEvaluate;        // Текущее значение целого выражения
  end;

  TBoolExprsn = class(TGeneralExpression)             // Логическое выражение
    function bEvaluate: TclcBool; virtual; abstract;  // Функция вычисления текущего значения логического выражения
    property bValue: TclcBool read bEvaluate;         // Текущее значение логического выражения
  end;

  TCmplxExprsn = class(TGeneralExpression)            // Комплексное выражение
    function cEvaluate: TclcCmplx; virtual; abstract;
    property cValue: TclcCmplx read cEvaluate;
  end;

  TStrngExprsn = class(TGeneralExpression)            // Строковое выражение
    function sEvaluate: TclcStrng; virtual; abstract;
    property sValue: TclcStrng read sEvaluate;
  end;

  TOwnedExpression = class;                           // Часть наборного выражения

  TOwnedExpression = class(TGeneralExpression)
  private
    owxOwner: TOwnedExpression;                       // Выражение-владелец
    function GetBase: pointer; virtual; abstract;
    function GetOffcet: integer; virtual; abstract;
    function GetSelfText: string; virtual; abstract;  // Выдать собственное написание
    function GetFullText(ChildText: string): string; virtual; abstract;
  protected
    property dataBase: pointer read GetBase;          // Адрес базы
    property dataOffset: integer read GetOffcet;      // Смещение относительно базы
  public
    function GetDataPointer: pointer; override;
    function GetText: string; override;
  end;

  TOwnerExpression = class(TOwnedExpression)
  private
    owrData: pointer;
    function GetBase: pointer; override;

  end;

  TGeneralVector = class(TOwnerExpression)       // Вектор однотипных элементов
  private
    vecSize: TclcIndex;                          // Размер вектора
  public
    property vSize: TclcIndex read vecSize;      // Размер вектора
  end;

  TGeneralArray = class(TOwnerExpression)        // Массив однотипных элементов
  private
    arCol: TclcIndex;                            // Число столбцов матрицы
    arRow: TclcIndex;                            // Число строк матрицы
  published
    property aCol: TclcIndex read arCol;         // Число столбцов матрицы
    property aRow: TclcIndex read arRow;         // Число строк матрицы
  end;

  TRealVector = class(TGeneralVector)            // Вектор однотипных элементов
  private
    function rGetVecElement(i: TclcIndex): TclcReal;
  public
    property rvElement[Index: TclcIndex]: TclcReal read rGetVecElement;
  end;

  TRealArray = class(TGeneralArray)
  private
    function rGetArrElement(i, j:TclcIndex): TclcReal;
  public
    property raElement[Index1, Index2: TclcIndex]: TclcReal read rGetArrElement;
  end;

{********************************************************************}
  TNamedData = class(TOwnerExpression)
  private
    dtaName : PclcName;
    function GetDataName: TclcName;
  published
    property dName: TclcName read GetDataName;
  public
    function GetFullDataName(level: byte; ElmntName: TclcName): TclcName; virtual; abstract;
  end;

  TGeneralVariable = class(TNamedData) // Именованная переменная
  private
    valType : TclcValType;             // Тип значения
    varState: TclcVarState;            // Состояние готовности
    varClass: TclcVarClass;            // Как получается значение
    function GetVarName: TclcName;
  published
    property vName : TclcName read GetVarName;   // Имя переменной
    property vType : TclcValType read valType;   // Тип значения
    property vState: TclcVarState read varState; // Состояние готовности
    property vClass: TclcVarClass read varClass; // Как получается значение
  end;
  PGeneralVariable = ^TGeneralVariable;

  TVectorVariable = class( TGeneralVariable )    // Переменная с векторным значением
  private
    vecSize: TclcIntgr; // Размер вектора
  published
    property vSize: TclcIntgr read vecSize;      // Размер вектора
  end;

  TArrayVariable = class( TGeneralVariable )     // Переменная с матричным значением
  private
    arCol: TclcIntgr;   // Число столбцов матрицы
    arRow: TclcIntgr;   // Число строк матрицы
  published
    property aCol: TclcIntgr read arCol;    // Число столбцов матрицы
    property aRow: TclcIntgr read arRow;    // Число строк матрицы
  end;

  TGeneralObject = class(TNamedData)
    oProperties: array of TGeneralVariable;
  end;

  TGeneralvSystem = class(TNamedData)
  private
    varList: array of TGeneralVariable;
    varListByType: array [TclcValType] of array of TGeneralVariable;
  public
    procedure AddVariable(varNew: TGeneralVariable);
    function CheckLocalVariable(varName: PclcName): TclcValType;
    function FindLocalVariable(varName: PclcName): TGeneralVariable; virtual;
    function GetVariable(varName: PclcName): TGeneralVariable; virtual;
    function GetOrCreateVariable(varName: PclcName): TGeneralVariable; virtual;

  end;

  TRootvSystem = class(TGeneralvSystem)

  end;

  TLocalvSystem = class(TGeneralvSystem)

  end;

function TOwnedExpression.GetDataPointer: pointer;
begin
  result := owxOwner.GetDataPointer + GetOffcet;
end;

function TOwnedExpression.GetText: string;
begin
  result := owxOwner.GetFullText(GetSelfText);
end;

function TOwnerExpression.GetBase: pointer;
begin
  result := owrData;
end;

function TRealVector.rGetVecElement(i: TclcIndex): TclcReal;
begin
  result := TclcRealVec(owrData^)[i];
end;

function TRealArray.rGetArrElement(i, j: TclcIndex): TclcReal;
begin
  result := TclcRealArr(owrData^)[i,j];
end;

function TNamedData.GetDataName: TclcName;
begin
  result := dtaName^;
end;

function TGeneralVariable.GetVarName : TclcName;
begin
  result := dtaName^;
end;

procedure TGeneralvSystem.AddVariable(varNew: TGeneralVariable);
begin

end;

function TGeneralvSystem.CheckLocalVariable(varName: PclcName): TclcValType;
begin

end;

function TGeneralvSystem.FindLocalVariable(varName: PclcName): TGeneralVariable;
begin

end;

function TGeneralvSystem.GetVariable(varName: PclcName): TGeneralVariable;
begin

end;

function TGeneralvSystem.GetOrCreateVariable(varName: PclcName): TGeneralVariable;
begin

end;

end.

