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
unit UnitFormInvent;

interface

uses
  Classes, Controls, StdCtrls, Forms, Graphics, Types, ScrollRoom, XpDOM,
  Windows, Messages, ItemImage, ComCtrls, Buttons, ExtCtrls;

type
  TFormInvent = class(TForm)
    PnFilter: TPanel;
    PnInvent: TPanel;
    TabInvent: TTabControl;
    CharInvent: TScrollRoom;
    LbCharName: TLabel;
    procedure CharInventMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure CharInventMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CharInventMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CharInventClick(Sender: TObject);
    procedure TabInventChange(Sender: TObject);
    procedure CharInventResize(Sender: TObject);
  private
  public
  end;

var
  FormInvent: TFormInvent;

implementation

uses UnitConfig, UnitFormProgress, SysUtils, UnitRyzom, UnitFormGuild,
  UnitFormRoomFilter, UnitFormCharacter;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormInvent.FormCreate(Sender: TObject);
begin
  CharInvent.DoubleBuffered := True;
end;

{*******************************************************************************
Display the form
*******************************************************************************}
procedure TFormInvent.FormShow(Sender: TObject);
begin
  FormRoomFilter.Parent := PnFilter;
  FormRoomFilter.Show;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormInvent.CharInventMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEDOWN, 0) ;
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormInvent.CharInventMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEUP, 0) ;
end;

{*******************************************************************************
Displays the names of items
*******************************************************************************}
procedure TFormInvent.CharInventMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormInvent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormRoomFilter.Close;
end;

{*******************************************************************************
Set the focus on the room
*******************************************************************************}
procedure TFormInvent.CharInventClick(Sender: TObject);
begin
  CharInvent.SetFocus;

  if Sender is TItemImage then begin
    FormRoomFilter.UpdateInfo(TItemImage(Sender));
  end;
end;

{*******************************************************************************
Changes between bag/pet1/pet2/pet3/pet4
*******************************************************************************}
procedure TFormInvent.TabInventChange(Sender: TObject);
var
  wCharID: String;
begin
  wCharID := FormCharacter.GridChar.Cells[4, FormCharacter.GridChar.Row];
  FormProgress.ShowFormInvent(wCharID, CharInvent, TabInvent.TabIndex, GCurrentFilter);
end;

{*******************************************************************************
Adjust items in the scroll box
*******************************************************************************}
procedure TFormInvent.CharInventResize(Sender: TObject);
begin
  CharInvent.Adjust;
end;

end.
