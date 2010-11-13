unit DataViewFormUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqlite3ds, sqlite3conn, sqldb, FileUtil, LResources,
  Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls, StdCtrls, ComCtrls,
  PairSplitter, rxdbgrid, DataMngrSystm;

type

  { TDataViewForm }

  TDataViewForm = class(TForm)
    Datasource_prjDB: TDatasource;
    Datasource2: TDatasource;
    ListView1: TListView;
    RightPanel: TPanel;
    Splitter1: TSplitter;
    SQLite3Connection1: TSQLite3Connection;
    Sqlite3Dataset_prjDB: TSqlite3Dataset;
    Sqlite3Dataset_prjDBtDesc: TMemoField;
    Sqlite3Dataset_prjDBtMembers: TMemoField;
    Sqlite3Dataset_prjDBtName: TMemoField;
    Sqlite3Dataset_prjDBtProto: TLongintField;
    Sqlite3Dataset_prjDBuName: TMemoField;
    Sqlite3Dataset_prjDBuNazvan: TMemoField;
    Sqlite3Dataset_prjDBuNazvan234: TMemoField;
    Sqlite3Dataset_prjDBuNazvanM: TMemoField;
    Sqlite3Dataset_prjDBuNotation: TMemoField;
    Sqlite3Dataset_prjDBuObozn: TMemoField;
    Sqlite3Dataset_prjDBuOsnovn: TLongintField;
    Sqlite3Dataset_prjDBuPreobr: TMemoField;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    PrjDB: TProjectDB;
  end; 

var
  DataViewForm: TDataViewForm;

implementation

{ TDataViewForm }

procedure TDataViewForm.Button1Click(Sender: TObject);
begin
  //
end;

initialization
  {$I dataviewformunit.lrs}

end.
{  /home/anatom/IIntegral/bin/prjbase.db3 }