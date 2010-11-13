unit IntgrlMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, Menus, ComCtrls, ExtCtrls, StdActns,
  SynHighlighterAny, SynMemo, SynEdit, WrkspcCfgrtn;

type

  { TIntegralMainForm }

  TIntegralMainForm = class(TForm)
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    ShowRefDBAction: TAction;
    ShowLogAction: TAction;
    ShowSchemeAction: TAction;
    ShowPrjDBAction: TAction;
    ShowExeAction: TAction;
    EditParams1: TAction;
    Button1: TButton;
    Button2: TButton;
    ButtonDB: TButton;
    ButtonGV: TButton;
    ButtonTask: TButton;
    ButtonLog: TButton;
    EditUndo1: TEditUndo;
    FileExit1: TFileExit;
    FileOpen1: TFileOpen;
    ImageLogo: TImage;
    imfActionList: TActionList;
    imfImageList: TImageList;
    imfMainMenu: TMainMenu;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelLogo: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListBox1: TListBox;
    ListBox3: TListBox;
    Memo1: TMemo;
    imfStatusBar: TStatusBar;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    miSearch: TMenuItem;
    MenuItem4: TMenuItem;
    miEdit: TMenuItem;
    miFile: TMenuItem;
    SearchFind1: TSearchFind;
    SynAnySyn1: TSynAnySyn;
    SynMemo1: TSynMemo;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure ShowRefDBActionExecute(Sender: TObject);
    procedure ButtonDBClick(Sender: TObject);
    procedure ButtonGVClick(Sender: TObject);
    procedure ButtonTaskClick(Sender: TObject);
    procedure ButtonLogClick(Sender: TObject);
    procedure EditParams1Execute(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure SynMemo1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    MemoChanged, SynEditChanged: boolean;
    procedure SaveMemo;
    procedure SaveSynEdit;
  public
    { public declarations }
    IntgrlCfg: TIntgrlCfgrtn;
  end;

var
  IntegralMainForm: TIntegralMainForm;

implementation

uses
  LibViewFormUnit, DataViewFormUnit, GVEditorFormUnit, LogViewFormUnit,
  ExctnSystmFormUnit, ParamsFormUnit;

{ TIntegralMainForm }

procedure TIntegralMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if MemoChanged then SaveMemo;
  if SynEditChanged then SaveSynEdit;
  CanClose := true;
end;

procedure TIntegralMainForm.ButtonDBClick(Sender: TObject);
begin
  DataViewForm.Show;
end;

procedure TIntegralMainForm.ShowRefDBActionExecute(Sender: TObject);
begin
  LibViewForm.Show;
end;

procedure TIntegralMainForm.ButtonGVClick(Sender: TObject);
begin
  GVeditForm.Show;
end;

procedure TIntegralMainForm.ButtonTaskClick(Sender: TObject);
begin
  ExctnSystmForm.Show;
end;

procedure TIntegralMainForm.ButtonLogClick(Sender: TObject);
begin
  LogViewForm.Show;
end;

procedure TIntegralMainForm.EditParams1Execute(Sender: TObject);
begin
  ParamsForm.UpdateParams(IntgrlCfg);
  ParamsForm.ShowOnTop;
end;

procedure TIntegralMainForm.FileOpen1Accept(Sender: TObject);
begin
  Caption := 'INteG®All - ' + FileOpen1.Dialog.FileName;
end;

procedure TIntegralMainForm.FormCreate(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile('Text1.txt');
  SynMemo1.Lines.LoadFromFile('Text2.txt');
  MemoChanged := false;
  SynEditChanged := false;
end;

procedure TIntegralMainForm.Memo1Change(Sender: TObject);
begin
  MemoChanged := true;
end;

procedure TIntegralMainForm.SynMemo1Change(Sender: TObject);
begin
  SynEditChanged := true;
end;

procedure TIntegralMainForm.Timer1Timer(Sender: TObject);
begin
  ButtonDB.Enabled := IntgrlCfg.DB;
  ButtonTask.Enabled := IntgrlCfg.EXEC;
  ButtonLog.Enabled := IntgrlCfg.LOG;
  ButtonDB.Font.Bold := IntgrlCfg.DB and not DataViewForm.Visible;
  ButtonTask.Font.Bold := IntgrlCfg.EXEC and not ExctnSystmForm.Visible;
  ButtonLog.Font.Bold := IntgrlCfg.LOG and not LogViewForm.Visible;
  ButtonGV.Font.Bold := not GVeditForm.Visible;
end;

procedure TIntegralMainForm.SaveMemo;
begin
  Memo1.Lines.SaveToFile('Text1.txt');
end;

procedure TIntegralMainForm.SaveSynEdit;
begin
  SynMemo1.Lines.SaveToFile('Text2.txt');
end;

initialization
  {$I intgrlmainform.lrs}

end.

