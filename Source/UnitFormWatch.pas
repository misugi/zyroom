{*******************************************************************************
zyRoom project for Ryzom Summer Coding Contest 2009
Copyright (C) 2009 Misugi
http://zyroom.misulud.fr
http://github.com/misugi/zyroom
contact@misulud.fr

Developed with Delphi 7 Personal,
this application is designed for players to view guild rooms and search items.

zyRoom is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

zyRoom is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with zyRoom.  If not, see http://www.gnu.org/licenses.
*******************************************************************************}
unit UnitFormWatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, ShellAPI, Spin, SevenButton;

resourcestring
  RS_QUANTITY_MIN = 'Quantité minimum :';
  RS_DURABILITY_MIN = 'Durabilité minimum :';

type
  TFormWatch = class(TForm)
    LbAutoValue: TLabel;
    EdValue: TEdit;
    BtOK: TSevenButton;
    BtCancel: TSevenButton;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  FormWatch: TFormWatch;

implementation

{$R *.dfm}

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormWatch.FormShow(Sender: TObject);
begin
  EdValue.SetFocus;
end;

end.
