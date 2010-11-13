unit ParamsFormUnit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, Buttons, ExtCtrls, ButtonPanel, Grids, WrkspcCfgrtn;

type

  { TParamsForm }

  TParamsForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    Splitter1: TSplitter;
    StringGrid1: TStringGrid;
    TreeView1: TTreeView;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1SelectionChanged(Sender: TObject);
  private
    { private declarations }
    IntgrlParams: TIntgrlCfgrtn;
  public
    { public declarations }
    procedure UpdateParams(Params: TIntgrlCfgrtn);
    procedure ResetParams;
    procedure SaveParams;
    procedure UpdateSection;
    procedure SaveSection;
  end; 

var
  ParamsForm: TParamsForm;

implementation

{ TParamsForm }

procedure TParamsForm.CancelButtonClick(Sender: TObject);
begin
  ResetParams;
end;

procedure TParamsForm.OKButtonClick(Sender: TObject);
begin
  SaveParams;
end;

procedure TParamsForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin

end;

procedure TParamsForm.TreeView1SelectionChanged(Sender: TObject);
begin
  if StringGrid1.Modified then SaveSection;
  UpdateSection;
end;

procedure TParamsForm.UpdateParams(Params: TIntgrlCfgrtn);
begin
  IntgrlParams := Params;
  ResetParams;
end;

procedure TParamsForm.ResetParams;
begin

end;

procedure TParamsForm.SaveParams;
begin

end;

procedure TParamsForm.UpdateSection;
begin

end;

procedure TParamsForm.SaveSection;
begin

end;

initialization
  {$I paramsformunit.lrs}

end.

