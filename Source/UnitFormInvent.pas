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
  pngimage, Clipbrd, UnitRyzom;

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
    FCharID: String;
    FItemImage: TItemImage;
    FGuardFile: TIniFile;
    FDappers: String;
    FInventTabs: array of TCharInvent; // pour la gestion des onglets
    FInventPos: array of TCharInvent; // pour le chargement des inventaires (position dans le XML)
    procedure AddTab(ATab: TCharInvent; AType: TCharInvent);
  public
    procedure UpdateRoom;
    procedure UpdateLanguage;
    procedure SetTabs(ASheetList: TStringList);
    property Dappers: String read FDappers write FDappers;
  end;

var
  FormInvent: TFormInvent;

implementation

uses
  UnitConfig, UnitFormProgress, SysUtils, UnitFormGuild, UnitFormFilter,
  UnitFormCharacter, UnitFormWatch, Spin;

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
Adjust items in the scroll box
*******************************************************************************}
procedure TFormInvent.CharInventResize(Sender: TObject);
begin
  CharInvent.Adjust;
end;

{*******************************************************************************
Mise à jour des infos selon l'inventaire sélectionné
*******************************************************************************}
procedure TFormInvent.UpdateRoom;
var
  wTabIndex: Integer;
  wMaxVolume: String;
  wInventPos: TCharInvent;
  wInventTab: TCharInvent;
begin
  wTabIndex := TabInvent.TabIndex;
  wInventPos := FInventPos[wTabIndex];
  FCharID := FormCharacter.GridItem.Cells[3, FormCharacter.GridItem.Row];
  FormProgress.ShowFormInvent(FCharID, CharInvent, wInventPos, GCurrentFilter);

  // volume max selon l'inventaire
  wInventTab := FInventTabs[wTabIndex];
  case wInventTab of
    ciBag:
      wMaxVolume := '/300';
    ciRoom:
      wMaxVolume := '/2000';
    ciShop:
      wMaxVolume := '';
    ciMektoub:
      wMaxVolume := '/500';
    ciMount:
      wMaxVolume := '/300';
    ciZig:
      wMaxVolume := '/150';
  end;

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
  wName: String;
  wType: TCharInvent;
  wNum: Integer;
begin
  ImgVolume.Hint := RS_VOLUME;
  ImgDappers.Hint := RS_DAPPERS;

  TabInvent.Tabs.Clear;
  for i := 0 to High(FInventTabs) do begin
    wType := FInventPos[i];
    case FInventTabs[i] of
      ciBag:
        wName := RS_TAB_BAG;
      ciRoom:
        wName := RS_TAB_ROOM;
      ciShop:
        wName := RS_TAB_SHOP;
      ciMektoub:
        begin
          wNum := Ord(wType) - Ord(ciPet1) + 1; // mektoub => ciPet1..ciPet4
          wName := Format('%s %d', [RS_TAB_MEKTOUB, wNum]);
        end;
      ciMount:
        begin
          wNum := Ord(wType) - Ord(ciPet1) + 1; // monture => ciPet1..ciPet4
          wName := Format('%s %d', [RS_TAB_MOUNT, wNum]);
        end;
      ciZig:
        begin
          wNum := Ord(wType) - Ord(ciPet5) + 1; // zig => ciPet5..ciPet7
          wName := Format('%s %d', [RS_TAB_ZIG, wNum]);
        end;
    end;

    TabInvent.Tabs.Append(wName);
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
      // onglet des ventes ?
      if FInventTabs[TabInvent.TabIndex] = ciShop then
        Exit;

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
  wInventPos: TCharInvent;
  wIdx: Integer;
begin
  with FItemImage.Data as TItemInfo do begin
    wGuardFile := GConfig.GetCharPath(FCharID) + 'guard.dat';
    FreeAndNil(FGuardFile);
    FGuardFile := TIniFile.Create(wGuardFile);
    wInventPos := FInventPos[TabInvent.TabIndex];
    case wInventPos of
      ciRoom:
        wSection := _SECTION_ROOM;
      ciBag:
        wSection := _SECTION_BAG;
      ciPet1..ciPet7:
        begin
          wIdx := Ord(wInventPos) - Ord(ciPet1);
          wSection := Format(_SECTION_PET, [wIdx + 1]);
        end;
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

{*==============================================================================
Définit les onglets
@param ASheetList liste des sheets pour les animaux (7 items au 07/03/2025)
===============================================================================}
procedure TFormInvent.SetTabs(ASheetList: TStringList);
var
  i: Integer;
  wSheet: String;
  wPet: TCharInvent;
begin
  SetLength(FInventTabs, 0);
  SetLength(FInventPos, 0);

  // sac en premier
  AddTab(ciBag, ciBag);

  // boucle sur les animaux
  wPet := ciPet1;
  for i := 0 to ASheetList.Count - 1 do begin
    wSheet := ASheetList[i];

    // animal existant ?
    if Length(wSheet) > 0 then begin
      // mektoub ?
      if Pos('chj', wSheet) = 1 then begin
        AddTab(ciMektoub, wPet)
      end
      else begin
        // zig ?
        // les zigs sont toujours retournés aux index 4 à 6
        // ce qui peut servir à mettre une autre condition sur l'index i
        if Pos('zig', wSheet) > 0 then
          AddTab(ciZig, wPet)
        else
          AddTab(ciMount, wPet);
      end;
    end;

    Inc(wPet);
  end;

  AddTab(ciRoom, ciRoom); // pièce d'appartement
  AddTab(ciShop, ciShop); // ventes
end;

{*==============================================================================
Ajoute un onglet
===============================================================================}
procedure TFormInvent.AddTab(ATab: TCharInvent; AType: TCharInvent);
begin
  SetLength(FInventTabs, Length(FInventTabs) + 1);
  FInventTabs[High(FInventTabs)] := ATab;

  SetLength(FInventPos, Length(FInventPos) + 1);
  FInventPos[High(FInventPos)] := AType;
end;

end.

