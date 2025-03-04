{*******************************************************************************
zyRoom project for Ryzom Summer Coding Contest 2009
Copyright (C) 2009 Misugi
http://github.com/misugi/zyroom

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
  Windows, Messages, ItemImage, ComCtrls, Buttons, ExtCtrls, Menus, IniFiles,
  pngimage, Clipbrd;

type
  TFormRoom = class(TForm)
    PnRoom: TPanel;
    PnFilter: TPanel;
    GuildRoom: TScrollRoom;
    Panel1: TPanel;
    LbValueGuildName: TLabel;
    PopupWatch: TPopupMenu;
    MenuGuard: TMenuItem;
    MenuEdit: TMenuItem;
    LbValueVolume: TLabel;
    ImgVolume: TImage;
    ImgDappers: TImage;
    LbValueDappers: TLabel;
    MenuCopy: TMenuItem;
    procedure GuildRoomMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure GuildRoomMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GuildRoomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GuildRoomClick(Sender: TObject);
    procedure GuildRoomResize(Sender: TObject);
    procedure GuildRoomContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure MenuGuardClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
  private
    FItemImage: TItemImage;
    FGuardFile: TIniFile;
    FGuildID: String;
    FDappers: String;
  public
    procedure UpdateRoom;
    procedure UpdateLanguage;
    property Dappers: String read FDappers write FDappers;
  end;

var
  FormRoom: TFormRoom;

implementation

uses
  UnitConfig, UnitFormProgress, SysUtils, UnitRyzom, UnitFormGuild,
  UnitFormFilter, UnitFormWatch;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormRoom.FormCreate(Sender: TObject);
begin
  GuildRoom.DoubleBuffered := True;
  DoubleBuffered := True;
  FGuardFile := nil;
{$IFDEF __DEBUG}
  MenuCopy.Visible := True;
{$ENDIF}
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormRoom.FormDestroy(Sender: TObject);
begin
  FGuardFile.Free;
end;

{*******************************************************************************
Display the form
*******************************************************************************}
procedure TFormRoom.FormShow(Sender: TObject);
begin
  FormFilter.Parent := PnFilter;
  FormFilter.Show;
  UpdateLanguage;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

{*******************************************************************************
Displays the names of items
*******************************************************************************}
procedure TFormRoom.GuildRoomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TItemImage then begin
    FormFilter.UpdateInfo(TItemImage(Sender));
  end;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormRoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormFilter.Close;
end;

{*******************************************************************************
Set the focus on the room
*******************************************************************************}
procedure TFormRoom.GuildRoomClick(Sender: TObject);
begin
  GuildRoom.SetFocus;
end;

{*******************************************************************************
Adjust items in the scroll box
*******************************************************************************}
procedure TFormRoom.GuildRoomResize(Sender: TObject);
begin
  GuildRoom.Adjust;
end;

{*******************************************************************************
Hall
*******************************************************************************}
procedure TFormRoom.UpdateRoom;
begin
  FGuildID := FormGuild.GridItem.Cells[3, FormGuild.GridItem.Row];
  FormProgress.ShowFormRoom(FGuildID, FormRoom.GuildRoom, GCurrentFilter);
  LbValueGuildName.Caption := FormGuild.GridItem.Cells[1, FormGuild.GridItem.Row];
  LbValueVolume.Caption := FormatFloat2('####0.##', FormProgress.TotalVolume) + '/10000';
  LbValueDappers.Caption := FDappers;
end;

procedure TFormRoom.GuildRoomContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;

  if Sender is TItemImage then begin
    with TItemImage(Sender).Data as TItemInfo do begin
//      if not(ItemType in [itAnimalMat, itNaturalMat, itSystemMat, itEquipment]) then Exit;

      if ItemGuarded then begin
        MenuEdit.Visible := True;
        MenuGuard.Caption := RS_MENU_UNWATCH;
      end
      else begin
        MenuEdit.Visible := False;
        MenuGuard.Caption := RS_MENU_WATCH;
      end;

      FItemImage := TItemImage(Sender);
      PopupWatch.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end;
  end;
end;

procedure TFormRoom.MenuGuardClick(Sender: TObject);
var
  wGuardFile: String;
  wSection: String;
  wIdent: String;
  wValue: Integer;
begin
  with FItemImage.Data as TItemInfo do begin
    wGuardFile := GConfig.GetGuildPath(FGuildID) + 'guard.dat';
    FreeAndNil(FGuardFile);
    FGuardFile := TIniFile.Create(wGuardFile);
    wSection := _SECTION_ROOM;
    wIdent := Format('%d.%d.%s', [ItemSlot, ItemQuality, ItemName]);
    if ItemType = itEquipment then
      FormWatch.LbAutoValue.Caption := RS_DURABILITY_MIN
    else
      FormWatch.LbAutoValue.Caption := RS_QUANTITY_MIN;

    if not ItemGuarded then begin
      FormWatch.EdValue.Text := '999';
      if FormWatch.ShowModal = mrOk then begin
        wValue := StrToIntDef(FormWatch.EdValue.Text, 999);
        if wValue <= 1 then
          wValue := 999;
        FGuardFile.WriteInteger(wSection, wIdent, wValue);
        FItemImage.PngSticker.LoadFromResourceName(HInstance, _RES_EYES);
        ItemGuarded := True;
        ItemGuardValue := wValue;
      end;
    end
    else begin
      if Sender = MenuEdit then begin
        FormWatch.EdValue.Text := IntToStr(ItemGuardValue);
        if FormWatch.ShowModal = mrOk then begin
          wValue := StrToIntDef(FormWatch.EdValue.Text, 999);
          if wValue <= 1 then
            wValue := 999;
          FGuardFile.WriteInteger(wSection, wIdent, wValue);
          ItemGuardValue := wValue;
        end;
      end
      else begin
        FGuardFile.DeleteKey(wSection, wIdent);
        FItemImage.RemoveSticker;
        ItemGuarded := False;
      end;
    end;
  end;

  FItemImage.Refresh;
end;

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormRoom.UpdateLanguage;
begin
  ImgVolume.Hint := RS_VOLUME;
  ImgDappers.Hint := RS_DAPPERS;
end;

{*******************************************************************************
Copy the item name
*******************************************************************************}
procedure TFormRoom.MenuCopyClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PChar(TItemInfo(FItemImage.Data).ItemName));
end;

end.

