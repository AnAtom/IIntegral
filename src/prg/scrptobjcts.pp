{
  Объекты описания вычислений

 TScriptAction - Базовый класс для всех вычислительных действий
 TScrptCodeBlock - Группа вычислительных действий
 TCndtnScrptActn - Действие, зависящее от условия
 TLoopScrptActn - Циклическое действие

   версия 0.1 от 03.02.2010
}
unit ScrptObjcts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CalcTypes, CalcObjcts, DataObjcts;

type
  TStrngValue = class(TGeneralExpression)

  end;

  TBoolValue = class(TGeneralExpression)

  end;

  TIntgrValue = class(TGeneralExpression)

  end;


  TScriptAction = class
    function saDoIt: TclcActionStatus; virtual; abstract;
    procedure saRaiseDebug(dbgInfo: pointer); virtual; abstract;
    procedure saRaiseWarning(wrnInfo: pointer); virtual; abstract;
    procedure saRaiseError(errInfo: pointer); virtual; abstract;
  end;

  TScrptCodeBlock = class(TScriptAction)
    cbActions: array of TScriptAction;
    function saDoIt: TclcActionStatus; override;
  end;

  TCndtnScrptActn = class(TScriptAction)
    acCondition: TBoolValue;
    acIfTrue: TScriptAction;
    acIfFalse: TScriptAction;
    function saDoIt: TclcActionStatus; override;
  end;

  TLoopScrptActn = class(TScriptAction)
    acEndLoop: TBoolValue;
    acInitLoop: TScriptAction;
    acLoopBody: TScriptAction;
    acAfterLoop: TScriptAction;
    function saDoIt: TclcActionStatus; override;
  end;

  TNameSpace = class

  end;

  TVariablesBlock = class;

  TVariablesBlock = class
  private
    vbOwner: TVariablesBlock;
  public
    function GetLocalVariable(varName: TclcName): TGeneralExpression;
    function GetVariable(varName: TclcName): TGeneralExpression;
  end;

implementation

function TVariablesBlock.GetLocalVariable(varName: TclcName): TGeneralExpression;
begin

  result := nil;
end;

function TVariablesBlock.GetVariable(varName: TclcName): TGeneralExpression;
begin
  result := GetLocalVariable(varName);
  if not assigned(result) and assigned(vbOwner) then vbOwner.GetVariable(varName);
end;

function TCndtnScrptActn.saDoIt: TclcActionStatus;
begin
  if acCondition.valLogic
  then result := acIfTrue.saDoIt
  else result := acIfFalse.saDoIt;
end;

function TLoopScrptActn.saDoIt: TclcActionStatus;
begin
  result := acInitLoop.saDoIt;
  repeat
    result := acLoopBody.saDoIt;
  until acEndLoop.valLogic;
  result := acAfterLoop.saDoIt;
end;

function TScrptCodeBlock.saDoIt: TclcActionStatus;
var
  i: integer;
begin
//  for i := 0 to high(cbActions)-1 do
//    result := cbActions[i].saDoIt;
end;

end.

