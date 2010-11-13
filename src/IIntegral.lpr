{
  Среда автоматизированного моделирования

   версия 0.1 октябрь 2010 prodg@ya.ru D.Kondakov
}
program IIntegral;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cmem,
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  SysUtils, FileUtil, Forms, WrkspcCfgrtn,
  IIntgrlBaseDefs, InfoObjcts, CalcTypes, CalcObjcts,
  LogSystm, DataMngrSystm, ExctnSystm, PreProcssr,
  StrngParsrs, DataObjcts, ReferenceObjcts, ExcSysObjcts, ScrptObjcts,
  IntgrlMainForm, DataViewFormUnit, GVEditorFormUnit, ExctnSystmFormUnit,
  LogViewFormUnit, ParamsFormUnit, LibViewFormUnit, DataMiner;

{$R *.res}
var
  s: string;
  IIntegralConfig: TIntgrlCfgrtn;
  SystemLog: TSystmLog;
  ReferenceDB: TReferenceDB;
  ProjectDB: TProjectDB;
  ExecutionSystem: TexcSystem;

begin
  // Выводим информацию о параметрах командной строки
  s := ParamStrUTF8(1);
  if (s = '--help')or(s = '-h') then begin
    writeln(StdOut, ' Options:');
    writeln(StdOut, '   -h, --help' + #9  + #9 + #9 + 'This text.');
    writeln(StdOut, '   -d, --default="CONTEXT_NAME"' + #9 + 'Set default context to CONTEXT_NAME.');
    writeln(StdOut, '   -v, --version'+ #9  + #9 + 'Type version information for all modules.');
    writeln(StdOut, '   -l, --log="LOG_OUTPUT"'+ #9 + 'Set way for log.');
    exit;
  end else if (s = '--version')or(s = '-v') then begin
    writeln(StdOut, '  DB ver 0.1');
    writeln(StdOut, '  EXEC ver 0.1');
    writeln(StdOut, '  LIB ver 0.1');
    writeln(StdOut, '  ENV ver 0.1');
    exit;
  end;
  // Читаем настройки и запускаем необходимые модули
  IIntegralConfig := TIntgrlCfgrtn.Create;
  if IIntegralConfig.LOG then SystemLog := TSystmLog.Create(IIntegralConfig);
  if IIntegralConfig.DB then ProjectDB := TProjectDB.Create(IIntegralConfig);
  if IIntegralConfig.LIB then ReferenceDB := TReferenceDB.Create(IIntegralConfig);
  if IIntegralConfig.EXEC then ExecutionSystem := TexcSystem.Create(IIntegralConfig);

  Application.Title := 'InteG®All';
  Application.Initialize;
  Application.CreateForm(TIntegralMainForm, IntegralMainForm);
    IntegralMainForm.IntgrlCfg := IIntegralConfig;
  Application.CreateForm(TLogViewForm, LogViewForm);
    LogViewForm.iLog := SystemLog;
  Application.CreateForm(TLibViewForm, LibViewForm);
    LibViewForm.SetRefDB(ReferenceDB);
  Application.CreateForm(TDataViewForm, DataViewForm);
    DataViewForm.PrjDB := ProjectDB;
  Application.CreateForm(TExctnSystmForm, ExctnSystmForm);
    ExctnSystmForm.ExS := ExecutionSystem;
  Application.CreateForm(TGVeditForm, GVeditForm);
  Application.CreateForm(TParamsForm, ParamsForm);
  Application.Run;
  IIntegralConfig.Free;
end.

