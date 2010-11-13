{
  Перевод текста в объекты


   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit StrngParsrs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CalcObjcts, LogSystm, WrkspcCfgrtn;

procedure ParseStrToAnyExprtn(StrBuf: String; var AnyExprtn: TGeneralExpression);

implementation

const
  powerSign = '^';
  minusSign = '-';
  figures = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  emptySigns = [' ', chr($09), chr($0a), chr($0d)];

procedure TrimFreeSpace(StrBuf: String; var i: integer);
begin
  while StrBuf[i] in emptySigns do inc(i);
end;

procedure ReadNumber(StrBuf: String; var i: integer);
begin

end;

procedure ReadOperand(StrBuf: String; var i: integer);
begin

end;

procedure ReadPower(StrBuf: String; var i: integer);
begin
  repeat inc(i) until not(StrBuf[i] in emptySigns);
  ReadOperand(StrBuf, i);
end;

procedure ReadMultiplier(StrBuf: String; var i: integer);
begin

  if StrBuf[i] = powerSign then ReadPower(StrBuf, i)
  else while StrBuf[i] in emptySigns do inc(i);
end;

procedure ParseStrToAnyExprtn(StrBuf: String; var AnyExprtn: TGeneralExpression);
var
  i: integer;
begin
  i := 1;
  while StrBuf[i] in emptySigns do inc(i);
  if StrBuf[i] in figures then ReadNumber(StrBuf, i);

end;

end.

