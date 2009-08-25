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
unit UnitFormRoom;

interface

uses
  Classes, Controls, StdCtrls, Forms, Graphics, Types, ScrollRoom, XpDOM,
  Windows, Messages, ItemImage, ComCtrls, Buttons;

type
  TFormRoom = class(TForm)
    GuildRoom: TScrollRoom;
    LbGuildName: TLabel;
    BtFilter: TSpeedButton;
    BtInfo: TSpeedButton;
    procedure GuildRoomMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GuildRoomMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GuildRoomMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtFilterClick(Sender: TObject);
    procedure GuildRoomClick(Sender: TObject);
  private
  public
  end;

var
  FormRoom: TFormRoom;

implementation

uses UnitConfig, UnitFormProgress, SysUtils, UnitRyzom, UnitFormGuild,
  UnitFormRoomFilter;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormRoom.FormCreate(Sender: TObject);
begin
  GuildRoom.DoubleBuffered := True;
end;

{*******************************************************************************
Display the form
*******************************************************************************}
procedure TFormRoom.FormShow(Sender: TObject);
begin
  LbGuildName.Caption := FormGuild.GridGuild.Cells[1, FormGuild.GridGuild.Row];
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_PAGEDOWN, 0) ;
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_PAGEUP, 0) ;
end;

{*******************************************************************************
Displays the names of items
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TItemImage then begin
    with Sender as TItemImage do begin
      if Hint = '' then
        Hint := GRyzomStringPack.GetString(ItemName);
    end;
  end;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormRoom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormRoomFilter.Close;
end;

{*******************************************************************************
Shows or closes the filter form
*******************************************************************************}
procedure TFormRoom.BtFilterClick(Sender: TObject);
begin
  if TSpeedButton(Sender).Down then FormRoomFilter.Show else FormRoomFilter.Close;
end;

{*******************************************************************************
Set the focus on the room
*******************************************************************************}
procedure TFormRoom.GuildRoomClick(Sender: TObject);
begin
  GuildRoom.SetFocus;
end;

end.
