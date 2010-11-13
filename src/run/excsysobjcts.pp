{
  Описания объектов исполняющей системы

 Задачи

 Процессы

   версия 0.1 сентябрь 2010 prodg@ya.ru D.Kondakov
}
unit ExcSysObjcts;

{$mode objfpc}

interface

uses
  Classes, SysUtils, IIntgrlBaseDefs, LogSystm, DataObjcts;

type
  TjbID = TinlID;
  TjbType = (jtTask, jtProcess);
  TjbState = (jsNew, jsRun, jsStop, jsWait, jsDone, jsError, jsKill);

  TJobInfo = class
    jbType: TjbType;
    jbName: TinlNameType;
    jbUsedData: TList;             // Необходимые данные
    jbUsedProcs: TList;            // Вызываемые библиотечные процедуры
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TJobInfo.Create;
begin
  inherited Create;

end;

destructor TJobInfo.Destroy;
begin

  inherited;
end;

end.

