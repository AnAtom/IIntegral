unit ExctnSystmFormUnit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, ComCtrls, ExtCtrls,
  ExctnSystm;

type

  { TExctnSystmForm }

  TExctnSystmForm = class(TForm)
    JobsTreeView: TTreeView;
    ExeTimer: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ExeTimerTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    ExS: TexcSystem;
  end;

var
  ExctnSystmForm: TExctnSystmForm;

implementation

{ TExctnSystmForm }

procedure TExctnSystmForm.ExeTimerTimer(Sender: TObject);
begin
  if assigned(ExS) then with ExS do begin

  end;
end;

initialization
  {$I exctnsystmformunit.lrs}

end.

