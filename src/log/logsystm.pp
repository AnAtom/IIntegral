{
  Система записи сообщений и событий

 Типы сообщений: информация, предупреждение, ошибка, отладка
 Все сообщения разбиты по группам
 Наверное сообщения будут разделены по системам

   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit LogSystm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IIntgrlBaseDefs, WrkspcCfgrtn;

const
  idInfo = -11;
  idWrng = -22;
  idError = -33;

type
  TMsgGrpID = TinlID;

  TElmntHist = class
    constructor Create;
    destructor Destroy; override;
    procedure AddChange;
    procedure FindInChanges;
    procedure GetFullHistory;
  end;

  { TGeneralMessage }

  TGeneralMessage = class
    selfID: TMsgGrpID;
    groupID: TMsgGrpID;
    timeStamp: TinlTimeStamp;
    msgData: pointer;
    constructor Create(newID: TMsgGrpID);
    destructor Destroy; override;
  end;

  TErrorMessage = class(TGeneralMessage)

  end;

  TWarningMessage = class(TGeneralMessage)

  end;

  TInfoMessage = class(TGeneralMessage)

  end;

  { TSystmLog }

  TSystmLog = class(TIIntegralModule)
  private
    FLog: TStringList;
    fnoDate: boolean;
    fnoMlSec: boolean;
    procedure createMessage(gID: TMsgGrpID; s: string);
  protected
    procedure postInfo(s: string); override;
    procedure postWarng(s: string); override;
    procedure postError(s: string); override;
  public
    constructor Create(wCfg: TIntgrlCfgrtn);
    destructor Destroy; override;
    procedure AddMessage(msgGrpID: TMsgGrpID; newMsg: TGeneralMessage);
    procedure ResetAllMessages;
    procedure ResetMessagesInGruop(msgGrpID: TMsgGrpID);
    function NumberMessagesInGruop(msgGrpID: TMsgGrpID): TMsgGrpID;
    procedure GetLastMessages(var LastMsg: TMsgGrpID; MsgList: TStrings);
    property noDate: boolean read fnoDate write fnoDate default true;
    property noMlSec: boolean read fnoMlSec write fnoMlSec default false;
  end;

implementation

constructor TElmntHist.Create;
begin
  inherited Create;

end;

destructor TElmntHist.Destroy;
begin

  inherited;
end;

procedure TElmntHist.AddChange;
begin

end;

procedure TElmntHist.FindInChanges;
begin

end;

procedure TElmntHist.GetFullHistory;
begin

end;

constructor TSystmLog.Create(wCfg: TIntgrlCfgrtn);
begin
  inherited Create(wCfg, 'LOG');
  FLog := TStringList.Create;
  if assigned(wCfg) then begin
    wCfg.Set_LOG_module(Self);

  end;

  Post('+++');
end;

destructor TSystmLog.Destroy;
var
  i: integer;
begin
  for i := FLog.Count-1 downto 0 do FLog.Objects[i].Free;
  FLog.Free;
  inherited Destroy;
end;

procedure TSystmLog.createMessage(gID: TMsgGrpID; s: string);
var
  im: TInfoMessage;
begin
  im := TInfoMessage.Create(gID);
  FLog.AddObject(s, im);
  im.selfID := FLog.Count;
  im.msgData := @FLog;
end;

procedure TSystmLog.postInfo(s: string);
begin
  createMessage(idInfo, s);
  WriteRunLog('Info ' + s);
end;

procedure TSystmLog.postWarng(s: string);
begin
  createMessage(idWrng, s);
  WriteRunLog('Warning ' + s);
end;

procedure TSystmLog.postError(s: string);
begin
  createMessage(idError, s);
  WriteRunLog('ERROR ' + s);
end;

procedure TSystmLog.GetLastMessages(var LastMsg: TMsgGrpID; MsgList: TStrings);
var
  i,j: integer;
begin
  j := FLog.Count-1;
  if LastMsg<j then begin
    for i := LastMsg+1 to j do
      MsgList.Add(
        DateTimeToStr(TimeStampToDateTime(TGeneralMessage(FLog.Objects[i]).timeStamp))
        + ' ' + FLog[i]);
    LastMsg := j;
  end;
end;

procedure TSystmLog.ResetAllMessages;
begin

end;

procedure TSystmLog.ResetMessagesInGruop(msgGrpID: TMsgGrpID);
begin

end;

procedure TSystmLog.AddMessage(msgGrpID: TMsgGrpID; newMsg: TGeneralMessage);
begin

end;

function TSystmLog.NumberMessagesInGruop(msgGrpID: TMsgGrpID): integer;
begin

  result := -1;
end;

{ TGeneralMessage }

constructor TGeneralMessage.Create(newID: TMsgGrpID);
begin
  inherited Create;
  selfID := -1;
  groupID := newID;
  timeStamp := NowItIs;
  msgData := nil;
end;

destructor TGeneralMessage.Destroy;
begin

  inherited Destroy;
end;

end.

