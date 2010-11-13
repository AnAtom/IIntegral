{
  Исполняющая система

 TexcSystem
  Jobs[]  Список задач и процессов (работ)
  NumJobs Общее число работ в списке
    список вычислителей
    список каналов ввода/вывода


    Работа
      состояние (новая, подготовка, старт, решение, ожидание, пауза, прервана, выполнена, завершение)

    Задача

    Процесс


 Выделение и уничтожение памяти под локальные статические данные
 Выделение и уничтожение памяти под динамические данные
 Управление выполнением (старт, стоп, пауза, продолжить, шаг, ошибки)


   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit ExctnSystm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, WrkspcCfgrtn, LogSystm, ExcSysObjcts, ScrptObjcts;

const
  maxJobsPerSystem = 1024;

type
  TexcCPUintfc = class;
  TexcDBintfc = class;
  TexcJob = class;
  TexcMemBlok = class;

  { TexcSystem }

  TexcSystem = class(TIIntegralModule)
  private
    exsCPUcnt : Integer;                  // Количество доступных процессоров
    exsJobCnt : TjbID;                    // Количество задач в очереди
    exsNowActvJobs: Integer;              // Максимальное число активных задач
    exsMaxJobsQueue: Integer;             // Максимальное число задач в очереди
    exsMaxActvJobs: Integer;              // Максимальное число активных задач
    exsCPUs   : array of TexcCPUintfc;    // Информация по доступным процессорам
    exsJobList: TList;                    // Список задач в очереди
    exsDBlist : TList;                    // Отображенные данные из базы
    exsMemBlks: TList;                    // Локальные блоки памяти
    function GetJob(Idx: Integer): TexcJob;
    procedure SetMaxJobsQueue(Value: Integer);
    procedure SetMaxActvJobs(Value: Integer);
  public
    constructor Create(wCfg: TIntgrlCfgrtn);
    destructor Destroy; override;
    function CreateJob(JobInfo: TJobInfo): TjbID;
    procedure ReleaseJob(thisJob: TjbID);
    procedure SaveJob(thisJob: TjbID; toThe: TStream);
    procedure LoadJob(from: TStream);
    procedure StartJob;
    procedure StopJob;
    procedure PrpareJob;
    property Jobs[Index: Integer]: TexcJob read GetJob;
    property NumJobs: TjbID read exsJobCnt;
    property MaxJobsQueue: Integer read exsMaxJobsQueue write SetMaxJobsQueue;
    property MaxActvJobs: Integer read exsMaxActvJobs write SetMaxActvJobs;
    property NowActvJobs: Integer read exsNowActvJobs;
  end;

  { TexcCPUintfc }

  TexcCPUintfc = class
    cpuLoad: Integer;
    cpuActivJob: TexcJob;
    constructor Create;
    destructor Destroy; override;
    procedure RunJob(AJob: TexcJob);
  end;

  TexcJob = class(TThread)
  private
    jbEnv  : TexcSystem;
    jbCPU  : TexcCPUintfc;
    jbOwnr : TexcJob;
    jbState: TjbState;
  public
    property State: TjbState read jbState;
    constructor Create(env: TexcSystem; owner: TexcJob);
    destructor Destroy; override;
    function CreateSubJob(JobInfo: TJobInfo): TjbID;
    procedure PauseJob;
    procedure RunJob;
  end;

  { TexcScript }

  TexcScript = class(TexcJob)
    procedure Execute; override;
  end;

  TexcTask = class(TexcJob)
    procedure Execute; override;
  end;

  TexcProcss = class(TexcJob)
    procedure Execute; override;
  end;

  TexcTimeProcss = class(TexcJob)

  end;

  TexcDBintfc = class
    constructor Create;
    destructor Destroy; override;
    procedure GetDataFromBase;
    procedure PutDataToBase;
  end;

  { TexcMemBlok }

  TexcMemBlok = class
    constructor Create;
    destructor Destroy; override;
  end;

implementation

type
  TmemBlockID = integer;

function GetStaticLocalMemory(stlocMemSize: integer): TmemBlockID;
begin

  result := 0;
end;

function GetDynamicMemory(dynMemSize: integer): TmemBlockID;
begin

  result := 0;
end;

constructor TexcSystem.Create(wCfg: TIntgrlCfgrtn);
var
  s: string;
begin
  inherited Create(wCfg, 'EXEC');
  exsJobList.Create;
  exsDBlist.Create;
  exsMemBlks.Create;
  exsJobCnt := 0;
  exsNowActvJobs := 0;
  if assigned(wCfg) then begin
    wCfg.Set_EXEC_module(Self);
    s := wCfg.GetParamValue('IINTEGRAL_MAX_RUN');

  end;
  Post('+++');
end;

destructor TexcSystem.Destroy;
begin
  FreeAndNil(exsMemBlks);
  FreeAndNil(exsDBlist);
  FreeAndNil(exsJobList);
  inherited Destroy;
end;

function TexcSystem.GetJob(Idx: Integer): TexcJob;
begin

  result := nil;
end;

procedure TexcSystem.SetMaxJobsQueue(Value: Integer);
begin
  exsMaxJobsQueue := Value;
end;

procedure TexcSystem.SetMaxActvJobs(Value: Integer);
begin
  if NowActvJobs>Value then begin

  end;
  exsMaxJobsQueue := Value;
end;

function TexcSystem.CreateJob(JobInfo: TJobInfo): TjbID;
begin
  Post('new job');

  result := 0;
end;

procedure TexcSystem.ReleaseJob(thisJob: TjbID);
begin

end;

procedure TexcSystem.SaveJob(thisJob: TjbID; toThe: TStream);
begin

end;

procedure TexcSystem.LoadJob(from: TStream);
begin

end;

procedure TexcSystem.StartJob;
begin

end;

procedure TexcSystem.StopJob;
begin

end;

procedure TexcSystem.PrpareJob;
begin

end;

constructor TexcJob.Create( env: TexcSystem; owner: TexcJob );
begin
  jbEnv := env;
  jbOwnr := owner;
  jbState := jsNew;
  inherited Create(true);

end;

destructor TexcJob.Destroy;
begin

  inherited;
end;

function TexcJob.CreateSubJob(JobInfo: TJobInfo): TjbID;
begin

  result := 0;
end;

procedure TexcJob.PauseJob;
begin

end;

procedure TexcJob.RunJob;
begin

end;

{ TexcScript }

procedure TexcScript.Execute;
begin

end;

procedure TexcTask.Execute;
begin

end;

procedure TexcProcss.Execute;
begin

end;

constructor TexcDBintfc.Create;
begin
  inherited Create;

end;

destructor TexcDBintfc.Destroy;
begin

  inherited;
end;

procedure TexcDBintfc.GetDataFromBase;
begin

end;

procedure TexcDBintfc.PutDataToBase;
begin

end;

{ TexcCPUintfc }

constructor TexcCPUintfc.Create;
begin

end;

destructor TexcCPUintfc.Destroy;
begin
  inherited Destroy;
end;

procedure TexcCPUintfc.RunJob(AJob: TexcJob);
begin

end;

{ TexcMemBlok }

constructor TexcMemBlok.Create;
begin

end;

destructor TexcMemBlok.Destroy;
begin
  inherited Destroy;
end;

end.

