{
  Доступные библиотечные элементы в текущей сборке


   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit WrkspcCfgrtn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3db, IIntgrlBaseDefs;

type
  TParametrType = (pEmpty, pText, pLogic, pNumber, pFloat, pFile, pURL, pIP, pDB );

  TIIntegralModule = class;
  TDataMngrModule = class;

  { TIntgrlCfgrtn }

  TIntgrlCfgrtn = class
  private
    FCfgPrfx: string;
    flog: boolean;            // Разрешен ли модуль журналирования
    fexec: boolean;
    fdb: boolean;
    flib: boolean;
    pLOG: TIIntegralModule;   // Ссылка на модуль журналирования
    pEXEC: TIIntegralModule;
    pDB: TDataMngrModule;
    pLIB: TDataMngrModule;
    FCntxName: string;
    FRootPath: string;
    availFunctions: TList;
    procedure KillModules;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Set_LOG_module(module: TIIntegralModule); virtual;
    procedure Set_DB_module(module: TDataMngrModule); virtual;
    procedure Set_LIB_module(module: TDataMngrModule); virtual;
    procedure Set_EXEC_module(module: TIIntegralModule); virtual;
    // Функции доступа к параметрам конфигурации
    function GetParamValue(const pName: string): string;
    function GetParamType(const pName: string): TParametrType;
    // Параметры конфигурации
    property RootPath: string read FRootPath;
    property ContextName: string read FCntxName;
    property LOG: Boolean read flog default true;
    property DB: Boolean read fdb default true;
    property LIB: Boolean read flib default true;
    property EXEC: Boolean read fexec default true;
    property LOG_module: TIIntegralModule read pLOG default nil;
    property DB_module: TDataMngrModule read pDB default nil;
    property LIB_module: TDataMngrModule read pLIB default nil;
    property EXEC_module: TIIntegralModule read pEXEC default nil;
  end;

  { TIIntegralModule }

  TIIntegralModule = class
  private
    FName: string;       // Имя модуля
    FCfg: TIntgrlCfgrtn; // Ссылка на конфигурацию, в составе которой этот модуль
  protected
    procedure postInfo(s: string); virtual;
    procedure postWarng(s: string); virtual;
    procedure postError(s: string); virtual;
  public
    constructor Create(wCfg: TIntgrlCfgrtn; const MName: string);
    destructor Destroy; override;
    procedure Post(s: string);
    procedure Warng(s: string);
    procedure Error(s: string);
  end;

  { TDataMngrModule }

  TDataMngrModule = class(TIIntegralModule)
  private
    FSrcName: string;
    FSrcPath: string;
    FSQLDB: TSQLite;
    FRemote: boolean;
    FMaxNames: integer;
    FConnected: boolean;
    FReaded: boolean;
    FNames: boolean;
    FTables: TStringList;
    FNameFields: TStringList;
    function GetFulSrcPath: string;
    function GetTableFields(i: integer): TStrings;
    function GetTableValNames(i: integer): TStrings;
    procedure SetConnected(Value: boolean);
    procedure ClearFields; virtual;
    function ReadNames: boolean;
    function ReadDB: boolean;
  protected
    procedure ConnectDB; virtual;
    procedure CloseDB; virtual;
  public
    constructor Create(wCfg: TIntgrlCfgrtn; const AName: string; const ASrc: string);
    destructor Destroy; override;
    property FullSrcPath: string read GetFulSrcPath;
    property SrcName: string read FSrcName;
    property Remote: boolean read FRemote default false;
    property Connected: boolean read FConnected default false;
    property TablesName: TStringList read FTables;
    property NameFields: TStringList read FNameFields;  // Имя поля с именами объектов для каждой базы
    property TableFields[Index: integer]: TStrings read GetTableFields;
    property TableValNames[Index: integer]: TStrings read GetTableValNames;
    property MaxNames: integer read FMaxNames write FMaxNames default 1000;
  end;

procedure WriteRunLog(const s: string);
procedure WriteNowLog(const s: string);

function NowItIs: TinlTimeStamp;

implementation

uses
  StrUtils, FileUtil, IniFiles;

const
   iiLogHeader = 'iNteg®@L ver 2.0 © IntepSys, 18.10.2010';
   iiLogFooter = '...bye';
   logErrorOpnFile = 'Error open file: ';
   IIntegralCnfgrtnPrfx = 'IINTEGRAL_';
   IIDISABLE = 'DISABLED';
   newDBsql = 'CREATE TABLE objects ("obID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "obName" TEXT NOT NULL, '
    + '"obType" TEXT NOT NULL DEFAULT (''OBJECT''), "obOwner" INTEGER DEFAULT (1), '
    + '"obState" TEXT NOT NULL DEFAULT (''UNDEF''), "obSource" TEXT NOT NULL DEFAULT (''INPUT''), '
    + '"obVersion" INTEGER NOT NULL DEFAULT (0), "obTime" DATETIME NOT NULL, "obDesc" TEXT);';

var
  LogActive: Boolean;
  RunLog: ^Text;

procedure WriteRunLog(const s: string);
begin
  if Assigned(RunLog) then writeln(RunLog^, s);
end;

procedure WriteNowLog(const s: string);
begin
  if Assigned(RunLog) then writeln(RunLog^, DateTimeToStr(Now) + ' : ' + s);
end;

procedure StartRunLog;
begin
  writeln(StdOut, iiLogHeader);
  RunLog := nil;
  new(RunLog);
  try
    Assign(RunLog^, RunLogName);
    if FileExistsUTF8(RunLogName) then Append(RunLog^)
    else Rewrite(RunLog^);
  except
    Freemem(RunLog);
    RunLog := nil;
    writeln(StdOut, logErrorOpnFile, RunLogName);
  end;
  LogActive := not (RunLog = nil);
  WriteRunLog('FIRST => ' + DateTimeToStr(Now));
end;

procedure StopRunLog;
begin
  if LogActive then begin
    writeln(RunLog^, 'LAST <= ' + DateTimeToStr(Now));
    Close(RunLog^);
    Dispose(RunLog);
    LogActive := false;
  end;
  RunLog := nil;
  writeln(StdOut, iiLogFooter);
end;

function NowItIs: TinlTimeStamp;
begin
  result := DateTimeToTimeStamp(Now);
end;

procedure CreateNewDB;
var
  SQLDB: TSQLite;
begin
  SQLDB := TSQLite.Create(ProjectDBname);
  SQLDB.Query(newDBsql, nil);
  SQLDB.Free;
end;

constructor TIntgrlCfgrtn.Create;
var
  i: Integer;
  s: string;
  IniF: TIniFile;
begin
  inherited Create;
  WriteRunLog('Bgn CFG');
  FCfgPrfx := IIntegralCnfgrtnPrfx;
  availFunctions := TList.Create;
  WriteRunLog('Command ARGS');
  // Разбираем параметры командной строки
  for i:= 1 to Paramcount do begin
    s := copy(ParamStrUTF8(i),1,10);
    if s = '--default ' then begin
      FCntxName := copy(ParamStrUTF8(i),11,20);
    end else if s = '--disable-' then begin
      s := copy(ParamStrUTF8(i),11,4);
      if s = 'db' then fdb := false
      else if s = 'lib' then flib := false
      else if s = 'log' then flog := false
      else if s = 'exec' then fexec := false;
    end else if s = '--create-db' then CreateNewDB;
  end;
  WriteRunLog('Look ENV');
  // Ищем в переменных окружения
  FCntxName := GetEnvironmentVariableUTF8(FCfgPrfx + 'DEFAULT_CONTEXT');
  if FCntxName = '' then begin
    WriteRunLog('No context defined');
    FCntxName := CfgDfltCntxt;
  end;
  WriteRunLog('ACTUAL CONTEXT ' + FCntxName);
  if not fdb then
    fdb := GetEnvironmentVariableUTF8(FCfgPrfx + 'DB') <> IIDISABLE;
  if not flog then
    flog :=  GetEnvironmentVariableUTF8(FCfgPrfx + 'LOG') <> IIDISABLE;
  if not flib then
    flib :=  GetEnvironmentVariableUTF8(FCfgPrfx + 'LIB') <> IIDISABLE;
  if not fexec then
    fexec := GetEnvironmentVariableUTF8(FCfgPrfx + 'EXEC') <> IIDISABLE;
  FRootPath := ExtractFilePath(ParamStrUTF8(0));
  s := ExpandFileNameUTF8(ChangeFileExt(ExtractFileName(ParamStrUTF8(0)),'.ini'));
  // Смотрим INI файл
  if FileExistsUTF8(s) then begin
    WriteRunLog('INI ' + s);
    IniF := TIniFile.Create(s);
    try
      if not fdb then fdb := IniF.ReadString(FCfgPrfx, 'DB', '1') <> IIDISABLE;
      if not flog then flog :=  IniF.ReadString(FCfgPrfx, 'LOG', '1') <> IIDISABLE;
      if not flib then flib :=  IniF.ReadString(FCfgPrfx, 'LIB', '1') <> IIDISABLE;
      if not fexec then fexec := IniF.ReadString(FCfgPrfx, 'EXEC', '1') <> IIDISABLE;
    finally
      IniF.Free;
    end;
  end else WriteRunLog('No INI');
  WriteRunLog('Done CFG');
end;

destructor TIntgrlCfgrtn.Destroy;
begin
  KillModules;
  FreeAndNil(availFunctions);
  WriteRunLog('End CFG');
  inherited Destroy;
end;

procedure TIntgrlCfgrtn.KillModules;
begin
  if fEXEC and assigned(pEXEC) then FreeAndNil(pEXEC);
  if fLIB and assigned(pLIB) then FreeAndNil(pLIB);
  if fDB and assigned(pDB) then FreeAndNil(pDB);
  if fLOG and assigned(pLOG) then FreeAndNil(pLOG);
  WriteRunLog('End all modules');
end;

procedure TIntgrlCfgrtn.Set_LOG_module(module: TIIntegralModule);
begin
  if flog and (pLOG = nil) then pLOG := module;
end;

procedure TIntgrlCfgrtn.Set_DB_module(module: TDataMngrModule);
begin
  if fdb and (pDB = nil) then pDB := module;
end;

procedure TIntgrlCfgrtn.Set_LIB_module(module: TDataMngrModule);
begin
  if flib and (pLIB = nil) then pLIB := module;
end;

procedure TIntgrlCfgrtn.Set_EXEC_module(module: TIIntegralModule);
begin
  if fexec and (pEXEC = nil) then pEXEC := module;
end;

function TIntgrlCfgrtn.GetParamValue(const pName: string): string;
begin
  result := '';
end;

function TIntgrlCfgrtn.GetParamType(const pName: string): TParametrType;
begin
  result := pEmpty;
end;

{ TIIntegralModule }

constructor TIIntegralModule.Create(wCfg: TIntgrlCfgrtn; const MName: string);
begin
  inherited Create;
  WriteRunLog('Begin module ' + MName);
  FCfg := wCfg;
  FName := MName;
  //----
end;

destructor TIIntegralModule.Destroy;
begin
  //----
  WriteRunLog('End module ' + FName);
  inherited Destroy;
end;

procedure TIIntegralModule.postInfo(s: string);
begin
  WriteRunLog('Info.cfg ' + s);
end;

procedure TIIntegralModule.postWarng(s: string);
begin
  WriteRunLog('Warning.cfg ' + s);
end;

procedure TIIntegralModule.postError(s: string);
begin
  WriteRunLog('ERROR.cfg ' + s);
end;

procedure TIIntegralModule.Post(s: string);
begin
  if assigned(FCfg.pLOG) then
    FCfg.pLOG.postInfo(FName + ': ' + s)
  else postInfo(FName + '> ' + s);
end;

procedure TIIntegralModule.Warng(s: string);
begin
  if assigned(FCfg.pLOG) then
    FCfg.pLOG.postWarng(FName + ': ' + s)
  else postWarng(' --- ' + FName + '> ' + s);
end;

procedure TIIntegralModule.Error(s: string);
begin
  if assigned(FCfg.pLOG) then
    FCfg.pLOG.postError(FName + ': ' + s)
  else postError(' *** ' + FName + '> ' + s);
end;

{ TDataMngrModule }

constructor TDataMngrModule.Create(wCfg: TIntgrlCfgrtn; const AName: string; const ASrc: string);
begin
  inherited Create(wCfg, AName);
  FSrcName := ASrc;
  FSrcPath := wCfg.RootPath;
  FTables := TStringList.Create;
  FNameFields := TStringList.Create;
  Post('---');
end;

function TDataMngrModule.GetFulSrcPath: string;
begin
  result := FSrcPath + FSrcName;
end;

procedure TDataMngrModule.SetConnected(Value: boolean);
begin
  if FConnected = Value then exit;
  if Value then ConnectDB else CloseDB;
end;

function TDataMngrModule.GetTableFields(i: integer): TStrings;
begin
  result := nil;
  if FConnected and (i<FTables.Count) then
    if not FReaded and not ReadDB then exit
    else result := TStringList(FTables.Objects[i]);
end;

function TDataMngrModule.GetTableValNames(i: integer): TStrings;
begin
  result := nil;
  if FConnected and (i<FTables.Count) then
    if not FNames and not ReadNames then exit
    else result := TStringList(TStringList(FTables.Objects[i]).Objects[0]);
end;

procedure TDataMngrModule.ClearFields;
var
  i: integer;
begin
  for i := FTables.Count-1 downto 0 do
    with FTables.Objects[i] as TStringList do begin
      Objects[0].Free;
      Free;
    end;
end;

destructor TDataMngrModule.Destroy;
begin
  if FConnected then CloseDB;
  FNameFields.Free;
  FTables.Free;
  inherited Destroy;
end;

procedure TDataMngrModule.ConnectDB;
var
  i: Integer;
begin
  Post('Connect DB ' + FSrcName);
  if FConnected then exit;
  try
    FSQLDB := TSQLite.Create(FullSrcPath);
    FConnected := true;
    FNameFields.Clear;
    FTables.Clear;
    Post('Query tables');
    if FSQLDB.Query('SELECT tbl_name FROM SQLITE_MASTER WHERE type = ''table''', FTables) then begin
      if (FTables.Count=0) then begin
        Error('DB is empty ERROR (no tables found)');
        CloseDB;
      end else begin
        FTables.Delete(0);
        Post('Found ' + inttostr(FTables.Count) + ' tables');
        for i := 0 to FTables.Count-1 do Post(inttostr(i) + ' : ' + FTables[i]);
      end;
    end else begin
      Error('Query tables ERROR');
      CloseDB;
    end;
  finally
    FReaded := false;
    FNames := false;
  end;
end;

procedure TDataMngrModule.CloseDB;
begin
  Post('Close DB ' + FSrcName);
  if not FConnected then exit;
  try
    FSQLDB.Free;
    FConnected := false;
  finally
    if FReaded then ClearFields;
    FNameFields.Clear;
    FTables.Clear;
    FReaded := false;
    FNames := false;
  end;
end;

function TDataMngrModule.ReadDB: boolean;
var
  i, j: integer;
  SL: TStringList;
  s : string;
begin
  Post('Read DB ' + FSrcName);
  if FReaded then exit;
  if not FConnected then ConnectDB;
  if FConnected and (FTables.Count>0) then
    for i := 0 to FTables.Count-1 do begin
      SL := TStringList.Create;
      if FSQLDB.Query('SELECT sql FROM SQLITE_MASTER WHERE type = ''table'' AND name NOT LIKE ''sqlite_%''', SL) then begin
        j := 0;
        repeat
          s := SL[j];
//          ExtractSubstr();
//          ExtractDelimited
          inc(j);
        until j=SL.Count;
      end;
      FTables.Objects[i] := SL;
      SL := TStringList.Create;
      if FSQLDB.Query('SELECT ' + FNameFields[i] + ' FROM ' + FTables[i], SL) then
        TStringList(FTables.Objects[i]).Objects[0] := SL;
    end;
end;

function TDataMngrModule.ReadNames: boolean;
var
  i, j: integer;
  SL: TStringList;
begin
  Post('Read Names from DB ' + FSrcName);
  if FNames then exit;
  if not FConnected then ConnectDB;
  if FConnected and (FTables.Count>0) then begin
    if not FReaded then ReadDB;
    if FReaded then begin
 {     for i := 0 to FTables.Count-1 do begin
        SL := TStringList.Create;
        if FSQLDB.Query('SELECT sql FROM SQLITE_MASTER WHERE type = ''table''', SL) then begin
          j := 0;
          repeat
            s := SL[j];

            inc(j);
          until j=SL.Count;
        end;
        FTables.Objects[i] := SL;
        SL := TStringList.Create;
        if FSQLDB.Query('SELECT ' + FNameFields[i] + ' FROM ' + FTables[i], SL) then begin
          TStringList(FTables.Objects[i]).Objects[0] := SL;
        end;}
      end;
  end;
end;

Initialization
  StartRunLog;
Finalization
  StopRunLog;
end.

