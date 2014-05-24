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
unit UnitFormConfirmation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SevenButton;

type
  TFormConfirm = class(TForm)
    LbMessage: TLabel;
    BtYes: TSevenButton;
    BtNo: TSevenButton;
    BtOK: TSevenButton;
    procedure FormShow(Sender: TObject);
  private
    procedure ShowButtonOK(AVisible: Boolean);
  public
    function ShowConfirmation(AMessage: String): Integer;
    procedure ShowInformation(AMessage: String);
  end;

var
  FormConfirm: TFormConfirm;

implementation

{$R *.dfm}

procedure TFormConfirm.ShowButtonOK(AVisible: Boolean);
begin
  BtOK.Visible := AVisible;
  BtYes.Visible := not AVisible;
  BtNo.Visible := not AVisible;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormConfirm.FormShow(Sender: TObject);
begin
  if BtYes.Visible then
    BtYes.SetFocus
  else
    BtOK.SetFocus;
end;

{*******************************************************************************
Displays the question
*******************************************************************************}
function TFormConfirm.ShowConfirmation(AMessage: String): Integer;
begin
  ShowButtonOK(False);
  LbMessage.Caption := AMessage;
  Result := ShowModal;
end;

{*******************************************************************************
Displays the info
*******************************************************************************}
procedure TFormConfirm.ShowInformation(AMessage: String);
begin
  ShowButtonOK(True);
  LbMessage.Caption := AMessage;
  ShowModal;
end;

end.
