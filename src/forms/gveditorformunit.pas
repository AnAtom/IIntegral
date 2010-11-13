unit GVEditorFormUnit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ActnList, ComCtrls, VislSchemeEditor, VislSchemeView;

type

  { TGVeditForm }

  TGVeditForm = class(TForm)
    ActionList1: TActionList;
    GroupBox1: TGroupBox;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    VislSchemeEditor1: TVislSchemeEditor;
    VislSchemeView1: TVislSchemeView;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  GVeditForm: TGVeditForm;

implementation

initialization
  {$I gveditorformunit.lrs}

end.
