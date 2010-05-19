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
unit UnitFormRoomFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, ShellAPI, Spin, UnitRyzom,
  ItemImage, StrUtils, ComCtrls, DateUtils;

resourcestring
  RS_SKIN = 'Skin';
  RS_DURABILITY = 'Durabilité';
  RS_HPB = 'Bonus vie';
  RS_SAB = 'Bonus sève';
  RS_STB = 'Bonus endurance';
  RS_FOB = 'Bonus concentration';
  RS_VOLUME = 'Volume';
  RS_PRICE = 'Prix';
  RS_TIME = 'Temps restant';
  RS_CLASS = 'Classe';
  RS_CONTINENT = 'Continent';
  RS_CRAFT = 'Composant pour l''artisanat';

type
  TFormRoomFilter = class(TForm)
    PageControl: TPageControl;
    TabFilter: TTabSheet;
    TabInfo: TTabSheet;
    BtOK: TButton;
    GbType: TGroupBox;
    CbTypeNaturalMat: TCheckBox;
    CbTypeAnimalMat: TCheckBox;
    CbTypeCata: TCheckBox;
    CbTypeOthers: TCheckBox;
    CbTypeEquipment: TCheckBox;
    GbQuality: TGroupBox;
    LbQualityMin: TLabel;
    LbQualityMax: TLabel;
    EdQualityMin: TSpinEdit;
    EdQualityMax: TSpinEdit;
    GbClass: TGroupBox;
    LbClassMin: TLabel;
    LbClassMax: TLabel;
    EdClassMin: TComboBox;
    EdClassMax: TComboBox;
    GbEcosys: TGroupBox;
    CbEcoPrime: TCheckBox;
    CbEcoCommon: TCheckBox;
    CbEcoDesert: TCheckBox;
    CbEcoForest: TCheckBox;
    CbEcoLakes: TCheckBox;
    CbEcoJungle: TCheckBox;
    BtDefault: TButton;
    GbName: TGroupBox;
    EdName: TEdit;
    RbAllWords: TRadioButton;
    RbOneWord: TRadioButton;
    GbEquipment: TGroupBox;
    CbEqHeavyArmors: TCheckBox;
    CbEqWeaponsMelee: TCheckBox;
    CbEqMediumArmors: TCheckBox;
    CbEqLightArmors: TCheckBox;
    CbEqAmplifier: TCheckBox;
    CbEqWeaponsRange: TCheckBox;
    CbEqOthers: TCheckBox;
    CbEqJewels: TCheckBox;
    GbCategory: TGroupBox;
    EdCategory: TComboBox;
    GroupSale: TGroupBox;
    ImgTime: TImage;
    ImgPrice: TImage;
    ImgContinent: TImage;
    LbTime: TLabel;
    LbPrice: TLabel;
    LbContinent: TLabel;
    GroupGeneral: TGroupBox;
    ImgItem: TItemImage;
    ImgHpb: TImage;
    ImgFob: TImage;
    ImgStb: TImage;
    ImgSab: TImage;
    LbHpb: TLabel;
    LbSab: TLabel;
    LbStb: TLabel;
    LbFob: TLabel;
    ImgDura: TImage;
    LbDura: TLabel;
    LbClass: TLabel;
    ImgVolume: TImage;
    LbVolume: TLabel;
    LbCraft: TLabel;
    LbDesc: TLabel;
    ImgCraft: TImage;
    ImgSkin1: TImage;
    ImgSkin2: TImage;
    ImgSkin3: TImage;
    ImgClass: TImage;
    procedure BtOKClick(Sender: TObject);
    procedure CbTypeAnimalMatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtDefaultClick(Sender: TObject);
  private
    FCurrentItem: TItemImage;
    
    procedure EnabledGroup(AGroup: TGroupBox; AEnabled: Boolean);
    procedure LoadCurrentFilter;
    procedure SaveCurrentFilter;
    procedure ApplyFilter;
  public
    procedure InitInfo;
    procedure UpdateInfo(AItemImage: TItemImage);
    procedure UpdateLanguage;
  end;

var
  FormRoomFilter: TFormRoomFilter;

implementation

uses UnitFormProgress, UnitFormGuild, UnitFormRoom, UnitFormInvent,
  UnitFormCharacter, UnitConfig;

{$R *.dfm}

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormRoomFilter.UpdateLanguage;
begin
  ImgSkin1.Hint := RS_SKIN;
  ImgSkin2.Hint := RS_SKIN;
  ImgSkin3.Hint := RS_SKIN;
  ImgDura.Hint := RS_DURABILITY;
  ImgHpb.Hint := RS_HPB;
  ImgSab.Hint := RS_SAB;
  ImgStb.Hint := RS_STB;
  ImgFob.Hint := RS_FOB;
  ImgVolume.Hint := RS_VOLUME;
  ImgPrice.Hint := RS_PRICE;
  ImgTime.Hint := RS_TIME;
  ImgContinent.Hint := RS_CONTINENT;
  ImgCraft.Hint := RS_CRAFT;
  ImgClass.Hint := RS_CLASS;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormRoomFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
end;

{*******************************************************************************
Shows the form
*******************************************************************************}
procedure TFormRoomFilter.FormShow(Sender: TObject);
begin
  LoadCurrentFilter;
  PageControl.TabIndex := 0; // filter by default
  InitInfo;
end;

{*******************************************************************************
Applies the filter
*******************************************************************************}
procedure TFormRoomFilter.BtOKClick(Sender: TObject);
begin
  ApplyFilter;
  InitInfo;
end;

{*******************************************************************************
Changes the checkbox for natural or animal materials
*******************************************************************************}
procedure TFormRoomFilter.CbTypeAnimalMatClick(Sender: TObject);
begin
  EnabledGroup(GbEcosys, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbClass, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbEquipment, CbTypeEquipment.Checked);
  EnabledGroup(GbCategory, FileExists(GConfig.CurrentPath + 'category.csv') and (CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked));
end;

{*******************************************************************************
Enables or disables all components in a groupbox
*******************************************************************************}
procedure TFormRoomFilter.EnabledGroup(AGroup: TGroupBox; AEnabled: Boolean);
var
  i: Integer;
begin
  for i := 0 to AGroup.ControlCount - 1 do begin
    AGroup.Controls[i].Enabled := AEnabled;
  end;
end;

{*******************************************************************************
Loads the current filter
*******************************************************************************}
procedure TFormRoomFilter.LoadCurrentFilter;
begin
  // Type
  CbTypeNaturalMat.Checked := (itNaturalMat in GCurrentFilter.Type_);
  CbTypeAnimalMat.Checked := (itAnimalMat in GCurrentFilter.Type_);
  CbTypeCata.Checked := (itCata in GCurrentFilter.Type_);
  CbTypeOthers.Checked := (itTool in GCurrentFilter.Type_) or
                          (itOthers in GCurrentFilter.Type_);
  CbTypeEquipment.Checked := (itEquipment in GCurrentFilter.Type_);

  // Quality
  EdQualityMin.Value := GCurrentFilter.QualityMin;
  EdQualityMax.Value := GCurrentFilter.QualityMax;

  // Class
  EdClassMin.ItemIndex := Ord(GCurrentFilter.ClassMin);
  EdClassMax.ItemIndex := Ord(GCurrentFilter.ClassMax);

  // Ecosystem
  CbEcoPrime.Checked := (iePrime in GCurrentFilter.Ecosystem);
  CbEcoCommon.Checked := (ieCommon in GCurrentFilter.Ecosystem);
  CbEcoDesert.Checked := (ieDesert in GCurrentFilter.Ecosystem);
  CbEcoForest.Checked := (ieForest in GCurrentFilter.Ecosystem);
  CbEcoLakes.Checked := (ieLakes in GCurrentFilter.Ecosystem);
  CbEcoJungle.Checked := (ieJungle in GCurrentFilter.Ecosystem);

  // Item name
  EdName.Text := GCurrentFilter.ItemName;
  RbAllWords.Checked := GCurrentFilter.AllWords;

  // Item equipment
  CbEqLightArmors.Checked := (iqLightArmor in GCurrentFilter.Equipment);
  CbEqMediumArmors.Checked := (iqMediumArmor in GCurrentFilter.Equipment);
  CbEqHeavyArmors.Checked := (iqHeavyArmor in GCurrentFilter.Equipment);
  CbEqWeaponsMelee.Checked := (iqWeaponMelee in GCurrentFilter.Equipment);
  CbEqWeaponsRange.Checked := (iqWeaponRange in GCurrentFilter.Equipment);
  CbEqJewels.Checked := (iqJewel in GCurrentFilter.Equipment);
  CbEqOthers.Checked := (iqShield in GCurrentFilter.Equipment) or
                        (iqBuckler in GCurrentFilter.Equipment) or
                        (iqAmmo in GCurrentFilter.Equipment) or
                        (iqOthers in GCurrentFilter.Equipment);
  CbEqAmplifier.Checked := (iqAmplifier in GCurrentFilter.Equipment);

  // Item category
  EdCategory.ItemIndex := GCurrentFilter.CategoryIndex;

  EnabledGroup(GbEcosys, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbClass, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbEquipment, CbTypeEquipment.Checked);
end;

{*******************************************************************************
Saves the current filter
*******************************************************************************}
procedure TFormRoomFilter.SaveCurrentFilter;
begin
  // Item type
  GCurrentFilter.Type_ := [];
  if CbTypeAnimalMat.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itAnimalMat];
  if CbTypeNaturalMat.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itNaturalMat];
  if CbTypeCata.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itCata];
  if CbTypeEquipment.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itEquipment];
  if CbTypeOthers.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itTool, itOthers];

  // Item quality
  if EdQualityMax.Value < EdQualityMin.Value then EdQualityMax.Value := EdQualityMin.Value;
  GCurrentFilter.QualityMin := EdQualityMin.Value;
  GCurrentFilter.QualityMax := EdQualityMax.Value;

  // Item ecosystem
  GCurrentFilter.Ecosystem := [];
  if CbEcoPrime.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [iePrime];
  if CbEcoCommon.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [ieCommon];
  if CbEcoDesert.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [ieDesert];
  if CbEcoForest.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [ieForest];
  if CbEcoLakes.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [ieLakes];
  if CbEcoJungle.Checked then GCurrentFilter.Ecosystem := GCurrentFilter.Ecosystem + [ieJungle];

  // Item class
  if EdClassMax.ItemIndex < EdClassMin.ItemIndex then EdClassMax.ItemIndex := EdClassMin.ItemIndex;
  GCurrentFilter.ClassMin := TItemClass(EdClassMin.ItemIndex);
  GCurrentFilter.ClassMax := TItemClass(EdClassMax.ItemIndex);

  // Item equipment
  GCurrentFilter.Equipment := [];
  if CbEqLightArmors.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqLightArmor];
  if CbEqMediumArmors.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqMediumArmor];
  if CbEqHeavyArmors.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqHeavyArmor];
  if CbEqWeaponsMelee.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqWeaponMelee];
  if CbEqWeaponsRange.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqWeaponRange];
  if CbEqJewels.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqJewel];
  if CbEqOthers.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqAmmo, iqShield, iqBuckler, iqOthers];
  if CbEqAmplifier.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqAmplifier];

  // Item name
  GCurrentFilter.ItemName := Trim(EdName.Text);
  GCurrentFilter.AllWords := RbAllWords.Checked;

  // Item Category
  GCurrentFilter.CategoryIndex := EdCategory.ItemIndex;
end;

{*******************************************************************************
Sets default filter
*******************************************************************************}
procedure TFormRoomFilter.BtDefaultClick(Sender: TObject);
begin
  GRyzomApi.SetDefaultFilter(GCurrentFilter);
  LoadCurrentFilter;
end;

{*******************************************************************************
Applies filter
*******************************************************************************}
procedure TFormRoomFilter.ApplyFilter;
var
  wGuildID: String;
  wCharID: String;
begin
  SaveCurrentFilter;
  if FormRoom.Visible then begin
    wGuildID := FormGuild.GridGuild.Cells[3, FormGuild.GridGuild.Row];
    FormProgress.ShowFormRoom(wGuildID, FormRoom.GuildRoom, GCurrentFilter);
    FormRoom.LbVolume.Caption := Format('%.2f', [FormProgress.TotalVolume]);
  end else begin
    wCharID := FormCharacter.GridChar.Cells[3, FormCharacter.GridChar.Row];
    FormProgress.ShowFormInvent(wCharID, FormInvent.CharInvent, FormInvent.TabInvent.TabIndex, GCurrentFilter);
    FormInvent.LbVolume.Caption := Format('%.2f', [FormProgress.TotalVolume]);
  end;
end;

{*******************************************************************************
Displays info of the selected item
*******************************************************************************}
procedure TFormRoomFilter.UpdateInfo(AItemImage: TItemImage);
var
  wIndex1, wIndex2: Integer;
  wNow: TDateTime;
  wDays: Integer;
  wHours: Integer;
  wMinutes: Integer;
begin
  if FCurrentItem = AItemImage then Exit;
  InitInfo;
  FCurrentItem := AItemImage;
  
  with AItemImage.Data as TItemInfo do begin
    ImgItem.Assign(AItemImage);
    ImgItem.Visible := True;
    LbDesc.Caption := ItemDesc;
//    LbSheet.Caption := Format('(%s)', [ItemName]);
//    LbQuality.Caption := 'Q' + IntToStr(ItemQuality);
    LbVolume.Caption := FormatFloat('####0.##', ItemVolume);
    if (ItemType = itAnimalMat) or (ItemType = itNaturalMat) then begin
      if Pos('m0312', ItemName) = 1 then begin {larva}
        LbCraft.Caption :=  EdCategory.Items[0];
      end else begin
        wIndex1 := AnsiIndexText(ItemCategory1, _ITEM_CATEGORY)+1;
        wIndex2 := AnsiIndexText(ItemCategory2, _ITEM_CATEGORY)+1;
        if wIndex1 < wIndex2 then
          LbCraft.Caption :=  EdCategory.Items[wIndex1] + ', ' + EdCategory.Items[wIndex2]
        else
          LbCraft.Caption :=  EdCategory.Items[wIndex2] + ', ' + EdCategory.Items[wIndex1]
      end;
    end;
    
    if ItemClass <> icUnknown then
      LbClass.Caption := EdClassMin.Items[Ord(ItemClass)];
    if ItemHp > 0 then LbDura.Caption := Format('%d/%d', [ItemHp, ItemDur]);
    if ItemHpb > 0 then LbHpb.Caption := IntToStr(ItemHpb);
    if ItemSab > 0 then LbSab.Caption := IntToStr(ItemSab);
    if ItemStb > 0 then LbStb.Caption := IntToStr(ItemStb);
    if ItemFob > 0 then LbFob.Caption := IntToStr(ItemFob);

    // Sale
    if ItemPrice > 0 then begin
      LbContinent.Caption := ItemContinent;
      LbPrice.Caption := FormatFloat('###,###,###,##0', ItemPrice);
      wNow := Now;
      wDays := DaysBetween(wNow, ItemTime);
      wNow := IncDay(wNow, wDays);
      wHours := HoursBetween(wNow, ItemTime);
      wNow := IncHour(wNow, wHours);
      wMinutes := MinutesBetween(wNow, ItemTime);
      LbTime.Caption := Format('%d''%.2d:%.2d', [wDays, wHours, wMinutes]);
    end;

     // Skin image
     case ItemSkin of
      isSkin1: ImgSkin1.Visible := True;
      isSkin2: begin
        ImgSkin1.Visible := True;
        ImgSkin2.Visible := True;
      end;
      isSkin3: begin
        ImgSkin1.Visible := True;
        ImgSkin2.Visible := True;
        ImgSkin3.Visible := True;
      end;
     end;
  end;
end;

{*******************************************************************************
Initialize info
*******************************************************************************}
procedure TFormRoomFilter.InitInfo;
begin
  FCurrentItem := nil;
  ImgItem.Visible := False;
  ImgSkin1.Visible := False;
  ImgSkin2.Visible := False;
  ImgSkin3.Visible := False;
  LbClass.Caption := '-';
  LbHpb.Caption := '-';
  LbSab.Caption := '-';
  LbStb.Caption := '-';
  LbFob.Caption := '-';
  LbDura.Caption := '-';
  LbDesc.Caption := '-';
  LbCraft.Caption := '-';
  LbVolume.Caption := '-';
  LbPrice.Caption := '-';
  LbTime.Caption := '-';
  LbContinent.Caption := '-';
end;

end.
