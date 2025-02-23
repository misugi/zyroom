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
unit UnitFormInvent;

interface

uses
  Classes, Controls, StdCtrls, Forms, Graphics, Types, ScrollRoom, XpDOM,
  Windows, Messages, ItemImage, ComCtrls, Buttons, ExtCtrls, Menus, IniFiles,
  pngimage, Clipbrd;

type
  TFormInvent = class(TForm)
    PnFilter1: TPanel;
    PnInvent: TPanel;
    TabInvent: TTabControl;
    CharInvent: TScrollRoom;
    Panel1: TPanel;
    LbValueCharName: TLabel;
    LbValueVolume: TLabel;
    PopupWatch: TPopupMenu;
    MenuGuard: TMenuItem;
    MenuEdit: TMenuItem;
    ImgVolume: TImage;
    ImgDappers: TImage;
    LbValueDappers: TLabel;
    MenuCopy: TMenuItem;
    procedure CharInventMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure CharInventMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CharInventMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CharInventClick(Sender: TObject);
    procedure TabInventChange(Sender: TObject);
    procedure CharInventResize(Sender: TObject);
    procedure CharInventContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure MenuGuardClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
  private
    FMountID: Integer;
    FCharID: String;
    FItemImage: TItemImage;
    FGuardFile: TIniFile;
    FDappers: String;
    procedure SetFMountID(const Value: Integer);
  public
    procedure UpdateRoom;
    procedure UpdateLanguage;
    property MountID: Integer read FMountID write SetFMountID;
    property Dappers: String read FDappers write FDappers;
  end;

var
  FormInvent: TFormInvent;

implementation

uses
  UnitConfig, UnitFormProgress, SysUtils, UnitRyzom, UnitFormGuild,
  UnitFormFilter, UnitFormCharacter, UnitFormWatch, Spin;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormInvent.FormCreate(Sender: TObject);
begin
  CharInvent.DoubleBuffered := True;
  TabInvent.DoubleBuffered := True;
  DoubleBuffered := True;
  FGuardFile := nil;
  {$IFDEF __DEBUG}
  MenuCopy.Visible := True;
  {$ENDIF}
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormInvent.FormDestroy(Sender: TObject);
begin
  FGuardFile.Free;
end;

{*******************************************************************************
Display the form
*******************************************************************************}
procedure TFormInvent.FormShow(Sender: TObject);
begin
  FormFilter.Parent := PnFilter1;
  FormFilter.Show;
  UpdateLanguage;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormInvent.CharInventMouseWheelDown(Sender: TObject; Shift:
  TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormInvent.CharInventMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(TScrollBox(Sender).Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

{*******************************************************************************
Displays the names of items
*******************************************************************************}
procedure TFormInvent.CharInventMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TItemImage then begin
    FormFilter.UpdateInfo(TItemImage(Sender));
  end;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormInvent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormFilter.Close;
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
  UpdateRoom();
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
  wMaxVolume: String;
begin
  FCharID := FormCharacter.GridItem.Cells[3, FormCharacter.GridItem.Row];
  FormProgress.ShowFormInvent(FCharID, CharInvent, TabInvent.TabIndex, GCurrentFilter);

  if TabInvent.TabIndex = 0 then
    wMaxVolume := '/2000' // room
  else if TabInvent.TabIndex = 1 then
    wMaxVolume := '/300' // bag
  else if TabInvent.TabIndex = 6 then
    wMaxVolume := '' // sales
  else if FMountID < 2 then
    wMaxVolume := '' // mount unfound
  else if TabInvent.TabIndex = FMountID then
    wMaxVolume := '/300' // mount
  else
    wMaxVolume := '/500'; // pack

  LbValueCharName.Caption := FormCharacter.GridItem.Cells[1, FormCharacter.GridItem.Row];
  LbValueVolume.Caption := FormatFloat2('####0.##', FormProgress.TotalVolume) + wMaxVolume;
  LbValueDappers.Caption := FDappers;
end;

{*******************************************************************************
Updates names of tab
*******************************************************************************}
procedure TFormInvent.UpdateLanguage;
var
  i: Integer;
begin
  ImgVolume.Hint := RS_VOLUME;
  ImgDappers.Hint := RS_DAPPERS;

  for i := 2 to 5 do begin // animals
    if i = FMountID then begin
      TabInvent.Tabs.Strings[i] := Format('%s %d', [RS_TAB_MOUNT, i - 1]);
    end
    else begin
      TabInvent.Tabs.Strings[i] := Format('%s %d', [RS_TAB_PET, i - 1]);
    end;
  end;
end;

{*******************************************************************************
Popup menu Watch/Unwatch
*******************************************************************************}
procedure TFormInvent.CharInventContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;

  if Sender is TItemImage then begin
    with TItemImage(Sender).Data as TItemInfo do begin
      if TabInvent.TabIndex > 5 then
        Exit;
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

{*******************************************************************************
Watch item
*******************************************************************************}
procedure TFormInvent.MenuGuardClick(Sender: TObject);
var
  wGuardFile: String;
  wSection: String;
  wIdent: String;
  wValue: Integer;
begin
  with FItemImage.Data as TItemInfo do begin
    wGuardFile := GConfig.GetCharPath(FCharID) + 'guard.dat';
    FreeAndNil(FGuardFile);
    FGuardFile := TIniFile.Create(wGuardFile);
    case TabInvent.TabIndex of
      0:
        wSection := _SECTION_ROOM;
      1:
        wSection := _SECTION_BAG;
      2:
        wSection := _SECTION_PET1;
      3:
        wSection := _SECTION_PET2;
      4:
        wSection := _SECTION_PET3;
      5:
        wSection := _SECTION_PET4;
    end;
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
Copy the item name
*******************************************************************************}
procedure TFormInvent.MenuCopyClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PChar(TItemInfo(FItemImage.Data).ItemName));
end;

end.

