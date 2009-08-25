{*******************************************************************************
zyRoom project for Ryzom Summer Coding Contest 2009
Copyright (C) 2009 Misugi
http://zyroom.misulud.fr
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
unit UnitFormConfirmation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormConfirm = class(TForm)
    LbMessage: TLabel;
    BtYes: TButton;
    BtNo: TButton;
    procedure FormShow(Sender: TObject);
  private
  public
    function ShowConfirmation(AMessage: String): Integer;
  end;

var
  FormConfirm: TFormConfirm;

implementation

{$R *.dfm}

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormConfirm.FormShow(Sender: TObject);
begin
  BtYes.SetFocus;
end;

{*******************************************************************************
Displays the question
*******************************************************************************}
function TFormConfirm.ShowConfirmation(AMessage: String): Integer;
begin
  LbMessage.Caption := AMessage;
  Result := ShowModal;
end;

end.
