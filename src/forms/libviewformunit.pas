unit LibViewFormUnit; 

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ActnList, ComCtrls, ExtCtrls, StdCtrls, DbCtrls, RxDBGrid, db, RxDBCtrls,
  Sqlite3DS, ReferenceObjcts, Grids, DBGrids;

type

  { TLibViewForm }

  TLibViewForm = class(TForm)
    Action1: TAction;
    LibViewActionList: TActionList;
    Datasource_refDB: TDatasource;
    LibDBNavigator: TDBNavigator;
    LibDBPageControl: TPageControl;
    RxDBGrid1: TRxDBGrid;
    Sqlite3Dataset_refDB: TSqlite3Dataset;
    LibViewStatusBar: TStatusBar;
    TabSheet: TTabSheet;
    LibViewToolBar: TToolBar;
    ToolButton1: TToolButton;
    procedure LibDBPageControlChange(Sender: TObject);
    procedure RxDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ToolButton1Click(Sender: TObject);
  private
    { private declarations }
    RefDB: TReferenceDB;
    OldDBGrid: TRxDBGrid;
  public
    { public declarations }
    procedure SetRefDB(Ref_DB: TReferenceDB);
  end;

var
  LibViewForm: TLibViewForm;

implementation

{ TLibViewForm }

procedure TLibViewForm.LibDBPageControlChange(Sender: TObject);
begin
  Sqlite3Dataset_refDB.Active := False;
  Sqlite3Dataset_refDB.SQL := '';

  if assigned(OldDBGrid) then begin
    OldDBGrid.Enabled := False;
    OldDBGrid.DataSource := nil;
  end;
  OldDBGrid := LibDBPageControl.ActivePage.Controls[0] as TRxDBGrid;

  Sqlite3Dataset_refDB.FieldDefs.Clear;
  Sqlite3Dataset_refDB.TableName := LibDBPageControl.ActivePage.Caption;
  Datasource_refDB.DataSet := Sqlite3Dataset_refDB;
  Sqlite3Dataset_refDB.Active := True;

  OldDBGrid.DataSource := Datasource_refDB;
  OldDBGrid.Enabled := True;
end;

procedure TLibViewForm.RxDBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Assigned(Column) then
    begin
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).Canvas.TextRect(Rect, Rect.Left, Rect.Top, ' '+Column.Field.AsString);
    end;
end;

procedure TLibViewForm.ToolButton1Click(Sender: TObject);
begin
  //    Select * from test;      /home/anatom/work/refbase.db3
end;

procedure TLibViewForm.SetRefDB(Ref_DB: TReferenceDB);
var
  i, k : integer;
  ts: TTabSheet;
  DBg: TRxDBGrid;
begin
  RefDB := Ref_DB;
  k := RefDB.TablesName.Count-1;
  LibDBPageControl.PageList.Delete(0);
  for i := 0 to k do begin
    ts := TTabSheet.Create(LibDBPageControl);
    DBg := TRxDBGrid.Create(ts);
    ts.InsertControl(DBg);
    ts.Caption := RefDB.TablesName[i];
    LibDBPageControl.PageList.Add(ts);
    DBg.Align := alClient;
    DBg.OnDrawColumnCell := @RxDBGridDrawColumnCell;
    DBg.AutoFillColumns := True;
    DBg.HeaderHotZones := [];
    DBg.HeaderPushZones := [];
    DBg.Options := [dgColumnResize, dgColumnMove, dgTitles, dgIndicator, dgRowLines,
               dgColLines, dgConfirmDelete, dgCancelOnExit, dgTabs, dgEditing,
               dgAlwaysShowSelection, dgAutoSizeColumns];
    DBg.OptionsRx := [rdgDblClickOptimizeColWidth,rdgAllowColumnsForm];
    DBg.TitleButtons := True;
    DBg.DataSource := Datasource_refDB;
  end;
  OldDBGrid := nil;
  Sqlite3Dataset_refDB.TableName := RefDB.TablesName[0];
  Sqlite3Dataset_refDB.Active := True;
  LibDBPageControl.ActivePageIndex := 0;
end;

initialization
  {$I libviewformunit.lrs}

end.



