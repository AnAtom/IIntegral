unit LogViewFormUnit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, StdCtrls, ExtCtrls, Menus,
  Controls, ClipBrd, IIntgrlBaseDefs, LogSystm;

type

  { TLogViewForm }

  TLogViewForm = class(TForm)
    LogList: TListBox;
    LogTimer: TTimer;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure LogTimerTimer(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    iLog: TSystmLog;
    LastMSGid: TMsgGrpID;
  end; 

var
  LogViewForm: TLogViewForm;

implementation

{ TLogViewForm }

procedure TLogViewForm.LogTimerTimer(Sender: TObject);
begin
  if assigned(iLog) then
    iLog.GetLastMessages(LastMSGid,LogList.Items);
  if LogList.Count>3 then
    LogList.TopIndex := LogList.Count-trunc(LogList.Height / LogList.ItemHeight);
end;

procedure TLogViewForm.FormCreate(Sender: TObject);
begin
  LastMSGid := -1;
  LogTimer.Enabled := True;
end;

procedure TLogViewForm.MenuItem1Click(Sender: TObject);
begin
  if MenuItem1.Checked then FormStyle := fsStayOnTop else FormStyle := fsNormal;
end;

procedure TLogViewForm.MenuItem2Click(Sender: TObject);
begin
  LogList.Clear;
end;

procedure TLogViewForm.MenuItem3Click(Sender: TObject);
begin
  Clipboard.SetTextBuf(LogList.Items.GetText);
end;

procedure TLogViewForm.MenuItem4Click(Sender: TObject);
begin
  LogTimer.Enabled := not MenuItem4.Checked;
  LogTimer.Interval := TMenuItem(Sender).Tag;
end;

initialization
  {$I logviewformunit.lrs}

end.

