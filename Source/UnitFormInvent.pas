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
unit UnitFormInvent;

interface

uses
  Classes, Controls, StdCtrls, Forms, Graphics, Types, ScrollRoom, XpDOM,
  Windows, Messages, ItemImage, ComCtrls, Buttons, ExtCtrls;

resourcestring
  RS_TAB_PET = 'Mektoub';
  RS_TAB_MOUNT = 'Monture';

type
  TFormInvent = class(TForm)
    PnFilter: TPanel;
    PnInvent: TPanel;
    TabInvent: TTabControl;
    CharInvent: TScrollRoom;
    Panel1: TPanel;
    LbCharName: TLabel;
    LbVolume: TLabel;
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
    FMountID: Integer;
    procedure SetFMountID(const Value: Integer);
  public
    procedure UpdateRoom;
    procedure UpdateTabNames;
    property MountID: Integer read FMountID write SetFMountID;
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
  UpdateTabNames;
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
  if Sender is TItemImage then begin
    FormRoomFilter.UpdateInfo(TItemImage(Sender));
  end else begin
    FormRoomFilter.PageControl.TabIndex := 1;
  end;
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
end;

{*******************************************************************************
Tab change
*******************************************************************************}
procedure TFormInvent.TabInventChange(Sender: TObject);
begin
  UpdateRoom;
end;

{*******************************************************************************
Mount ID
*******************************************************************************}
procedure TFormInvent.SetFMountID(const Value: Integer);
begin
  FMountID := Value + 2;
end;

{*******************************************************************************
Adjust items in the scroll box
*******************************************************************************}
procedure TFormInvent.CharInventResize(Sender: TObject);
begin
  CharInvent.Adjust;
end;

{*******************************************************************************
room/bag/pet1/pet2/pet3/pet4
*******************************************************************************}
procedure TFormInvent.UpdateRoom;
var
  wCharID: String;
  wMaxVolume: String;
begin
  wCharID := FormCharacter.GridChar.Cells[3, FormCharacter.GridChar.Row];
  FormProgress.ShowFormInvent(wCharID, CharInvent, TabInvent.TabIndex, GCurrentFilter);

  if TabInvent.TabIndex = 0 then
    wMaxVolume := '/2000' // room
  else
    if TabInvent.TabIndex = 1 then
      wMaxVolume := '/300' // bag
    else
      if TabInvent.TabIndex = 6 then
        wMaxVolume := '' // sales
      else
        if FMountID < 2 then
          wMaxVolume := '/?' // mount unfound
        else
          if TabInvent.TabIndex = FMountID then
            wMaxVolume := '/100' // mount
          else
            wMaxVolume := '/500'; // pack

  LbCharName.Caption := FormCharacter.GridChar.Cells[1, FormCharacter.GridChar.Row];
  LbVolume.Caption :=  FormatFloat('####0.##',FormProgress.TotalVolume) + wMaxVolume;
end;

{*******************************************************************************
Updates names of tab
*******************************************************************************}
procedure TFormInvent.UpdateTabNames;
var
  i: Integer;
begin
  for i := 2 to 5 do begin // animals
    if i = FMountID then begin
      TabInvent.Tabs.Strings[i] := Format('%s %d', [RS_TAB_MOUNT, i-1]);
    end else begin
      TabInvent.Tabs.Strings[i] := Format('%s %d', [RS_TAB_PET, i-1]);
    end;
  end;
end;

end.
