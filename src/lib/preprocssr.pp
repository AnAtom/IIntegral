{
  Перевод многострочного текста в сплошной

 - включаемые файлы
 - подстановка значений
 - исключение пробелов, переносов строк, коментариев и пр.

   версия 0.1 февраль 2010 prodg@ya.ru D.Kondakov
}
unit PreProcssr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LogSystm, DataObjcts;

procedure ProceedText( srcText: TStrings; var CharBuf: PChar; var CharBufSize: integer);

implementation

function GetSubstByName(subName: String): String;
begin
  result := '';
end;

  // Пропускает все пустое пространство и коментарии,
  // останавливается на первом значимом символе
procedure TrimFreeSpace(var StrPos: PChar);
const
  Empty = [' ', chr($09), chr($0a), chr($0d)];
begin
  while StrPos^ in Empty do inc(StrPos);
  if StrPos^ = '{' then begin
    repeat
      inc(StrPos)
    until StrPos^ = '}';
    inc(StrPos);
    TrimFreeSpace(StrPos);
  end else if (StrPos^ = '/') and ((StrPos+1)^ = '/') then begin
    repeat
      inc(StrPos)
    until StrPos^ = chr($0a);
    TrimFreeSpace(StrPos);
  end;
end;

procedure ProceedText( srcText: TStrings; var CharBuf: PChar; var CharBufSize: integer);
begin

end;

end.

