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
  ItemImage, StrUtils, ComCtrls, DateUtils, Gauges, Contnrs, RyzomApi,
  SevenButton, IniFiles;

resourcestring
  RS_SKIN = 'Skin';
  RS_HPB = 'Bonus vie';
  RS_SAB = 'Bonus sève';
  RS_STB = 'Bonus endurance';
  RS_FOB = 'Bonus concentration';
  RS_NEEDED_FILE = 'Fichier "string_client.pack" introuvable !';

type
  TFormRoomFilter = class(TForm)
    PageControl: TPageControl;
    TabFilter: TTabSheet;
    TabInfo: TTabSheet;
    GbType: TGroupBox;
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
    GbName: TGroupBox;
    EdName: TEdit;
    RbAllWords: TRadioButton;
    RbOneWord: TRadioButton;
    GbEquipment: TGroupBox;
    GbCategory: TGroupBox;
    EdCategory: TComboBox;
    PnTitle: TPanel;
    PnInfo: TPanel;
    LbQuality: TLabel;
    LbVolume: TLabel;
    LbCraft: TLabel;
    ImgItem: TItemImage;
    LbValueQuality: TLabel;
    LbValueVolume: TLabel;
    LbValueCraft: TLabel;
    LbClass: TLabel;
    LbValueClass: TLabel;
    LbDura: TLabel;
    LbValueDura: TLabel;
    ImgSkin1: TImage;
    ImgSkin2: TImage;
    ImgSkin3: TImage;
    LbColor: TLabel;
    LbValueColor: TLabel;
    LbRace: TLabel;
    LbValueRace: TLabel;
    EdEquipment: TComboBox;
    GbSorting: TGroupBox;
    EdSorting: TComboBox;
    GbSales: TGroupBox;
    LbPriceMin: TLabel;
    LbPriceMax: TLabel;
    EdContinent: TComboBox;
    EdPriceMin: TSpinEdit;
    EdPriceMax: TSpinEdit;
    GbBonus: TGroupBox;
    ImgHpbF: TImage;
    ImgSabF: TImage;
    ImgStbF: TImage;
    ImgFobF: TImage;
    CbHpb: TCheckBox;
    CbSab: TCheckBox;
    CbStb: TCheckBox;
    CbFob: TCheckBox;
    PnInfo2: TPanel;
    LbAutoSpeed: TLabel;
    LbValueSpeed: TLabel;
    LbValueDodge: TLabel;
    LbAutoRange: TLabel;
    LbValueRange: TLabel;
    LbWeight: TLabel;
    LbValueWeight: TLabel;
    LbValueParry: TLabel;
    LbValueAdvDodge: TLabel;
    LbValueAdvParry: TLabel;
    LbAutoSlashingProt: TLabel;
    LbValueSlashingProt: TLabel;
    LbAutoSmashingProt: TLabel;
    LbValueSmashingProt: TLabel;
    LbAutoPiercingProt: TLabel;
    LbValuePiercingProt: TLabel;
    LbEcosys: TLabel;
    LbValueEcosys: TLabel;
    ImgHpb: TImage;
    ImgFob: TImage;
    ImgStb: TImage;
    ImgSab: TImage;
    LbValueHpb: TLabel;
    LbValueSab: TLabel;
    LbValueStb: TLabel;
    LbValueFob: TLabel;
    LbAutoDodge: TLabel;
    LbAutoParry: TLabel;
    LbAutoAdvDodge: TLabel;
    LbAutoAdvParry: TLabel;
    LbAutoFactorProt: TLabel;
    LbValueFactorProt: TLabel;
    TabTemp: TTabSheet;
    PnCat1: TPanel;
    LbCat1Spec1: TLabel;
    LbCat1Spec2: TLabel;
    LbCat1Spec3: TLabel;
    LbCat1Spec4: TLabel;
    LbCat1Spec5: TLabel;
    LbCat1Spec6: TLabel;
    LbCat1Spec7: TLabel;
    LbCat1Spec8: TLabel;
    LbCat1Spec9: TLabel;
    LbCat1Spec10: TLabel;
    LbCat1Spec11: TLabel;
    GaugeCat1Spec1: TGauge;
    GaugeCat1Spec2: TGauge;
    GaugeCat1Spec3: TGauge;
    GaugeCat1Spec4: TGauge;
    GaugeCat1Spec5: TGauge;
    GaugeCat1Spec7: TGauge;
    GaugeCat1Spec6: TGauge;
    GaugeCat1Spec8: TGauge;
    GaugeCat1Spec10: TGauge;
    GaugeCat1Spec11: TGauge;
    GaugeCat1Spec9: TGauge;
    ImgCat1: TImage;
    LbCat1: TLabel;
    PnCat2: TPanel;
    LbCat2Spec1: TLabel;
    LbCat2Spec2: TLabel;
    LbCat2Spec3: TLabel;
    LbCat2Spec4: TLabel;
    LbCat2Spec5: TLabel;
    LbCat2Spec6: TLabel;
    LbCat2Spec7: TLabel;
    LbCat2Spec8: TLabel;
    LbCat2Spec9: TLabel;
    LbCat2Spec10: TLabel;
    LbCat2Spec11: TLabel;
    GaugeCat2Spec1: TGauge;
    GaugeCat2Spec2: TGauge;
    GaugeCat2Spec3: TGauge;
    GaugeCat2Spec4: TGauge;
    GaugeCat2Spec5: TGauge;
    GaugeCat2Spec7: TGauge;
    GaugeCat2Spec6: TGauge;
    GaugeCat2Spec8: TGauge;
    GaugeCat2Spec10: TGauge;
    GaugeCat2Spec11: TGauge;
    GaugeCat2Spec9: TGauge;
    ImgCat2: TImage;
    LbCat2: TLabel;
    PnSales: TPanel;
    LbPrice: TLabel;
    LbContinent: TLabel;
    LbValuePrice: TLabel;
    LbValueContinent: TLabel;
    LbTime: TLabel;
    LbValueTime: TLabel;
    Image1: TImage;
    LbSale: TLabel;
    CbTypeMat: TCheckBox;
    CbTypeCata: TCheckBox;
    CbTypeOthers: TCheckBox;
    CbTypeEquipment: TCheckBox;
    CbTypeTeleporter: TCheckBox;
    LbGuard: TLabel;
    LbValueGuard: TLabel;
    BtDefault: TSevenButton;
    BtOK: TSevenButton;
    procedure BtOKClick(Sender: TObject);
    procedure CbTypeMatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtDefaultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PnTitleClick(Sender: TObject);
  private
    FCurrentItem: TItemImage;
    FPngObject: TPNGObject;
    FLbList: TObjectList;
    FLbList2: TObjectList;

    FComboIndexSorting: Integer;
    FComboIndexClassMin: Integer;
    FComboIndexClassMax: Integer;
    FComboIndexEquipment: Integer;
    FComboIndexCategory: Integer;
    FComboIndexContinent: Integer;
   
    procedure EnabledGroup(AGroup: TGroupBox; AEnabled: Boolean);
    procedure LoadCurrentFilter;
    procedure SaveCurrentFilter;
    procedure ApplyFilter;
  public
    procedure InitInfo;
    procedure UpdateInfo(AItemImage: TItemImage);
    procedure BackupComboIndex;
    procedure RestoreComboIndex;
    procedure UpdateLanguage;
  end;

var
  FormRoomFilter: TFormRoomFilter;

implementation

uses UnitFormProgress, UnitFormGuild, UnitFormRoom, UnitFormInvent,
  UnitFormCharacter, UnitConfig, UnitFormOptions;

{$R *.dfm}

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormRoomFilter.UpdateLanguage;
var
  i: Integer;
  wIndex: Integer;
begin
  ImgSkin1.Hint := RS_SKIN;
  ImgSkin2.Hint := RS_SKIN;
  ImgSkin3.Hint := RS_SKIN;
  ImgHpb.Hint := RS_HPB;
  ImgSab.Hint := RS_SAB;
  ImgStb.Hint := RS_STB;
  ImgFob.Hint := RS_FOB;

  // Category
  wIndex := EdCategory.ItemIndex;
  EdCategory.Clear;
  for i := 0 to High(_MAT_CATEGORY) do begin
    EdCategory.Items.Append(GetCatName(i));
  end;
  EdCategory.ItemIndex := wIndex;

  // Class min
  wIndex := EdClassMin.ItemIndex;
  EdClassMin.Clear;
  for i := 0 to High(_ITEM_CLASS) do begin
    EdClassMin.Items.Append(GetClassName(i));
  end;
  EdClassMin.ItemIndex := wIndex;

  // Class max
  wIndex := EdClassMax.ItemIndex;
  EdClassMax.Clear;
  for i := 0 to High(_ITEM_CLASS) do begin
    EdClassMax.Items.Append(GetClassName(i));
  end;
  EdClassMax.ItemIndex := wIndex;

  // Specifications
  LbAutoSpeed.Caption := RS_SPEC_SPEED;
  LbAutoRange.Caption := RS_SPEC_RANGE;
  LbAutoDodge.Caption := RS_SPEC_DODGE_MODIFIER;
  LbAutoParry.Caption := RS_SPEC_PARRY_MODIFIER;
  LbAutoAdvDodge.Caption := RS_SPEC_ADV_DODGE_MODIFIER;
  LbAutoAdvParry.Caption := RS_SPEC_ADV_PARRY_MODIFIER;
  LbAutoFactorProt.Caption := RS_SPEC_PROTEC_FACTOR;
  LbAutoSlashingProt.Caption := RS_SPEC_MAX_SLASH_PROTEC;
  LbAutoSmashingProt.Caption := RS_SPEC_MAX_SMASH_PROTEC;
  LbAutoPiercingProt.Caption := RS_SPEC_MAX_PIERC_PROTEC;
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
  PageControl.TabIndex := 0; // page by default
  InitInfo;
end;

{*******************************************************************************
Applies the filter
*******************************************************************************}
procedure TFormRoomFilter.BtOKClick(Sender: TObject);
begin
  ApplyFilter;
end;

{*******************************************************************************
Changes the checkbox for natural or animal materials
*******************************************************************************}
procedure TFormRoomFilter.CbTypeMatClick(Sender: TObject);
begin
  EnabledGroup(GbEcosys, CbTypeMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbClass, CbTypeMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbEquipment, CbTypeEquipment.Checked);
  EnabledGroup(GbCategory, CbTypeMat.Checked);
  EnabledGroup(GbBonus, CbTypeEquipment.Checked);
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
  // Sorting
  EdSorting.ItemIndex := Ord(GCurrentFilter.Sorting);
  
  // Type
  CbTypeMat.Checked := (itNaturalMat in GCurrentFilter.Type_) or
                       (itAnimalMat in GCurrentFilter.Type_) or
                       (itSystemMat in GCurrentFilter.Type_);
  CbTypeEquipment.Checked := (itEquipment in GCurrentFilter.Type_);
  CbTypeCata.Checked := (itCata in GCurrentFilter.Type_);
  CbTypeTeleporter.Checked := (itTeleporter in GCurrentFilter.Type_);
  CbTypeOthers.Checked := (itOther in GCurrentFilter.Type_);

  // Ecosystem
  CbEcoPrime.Checked := (iePrime in GCurrentFilter.Ecosystem);
  CbEcoCommon.Checked := (ieCommon in GCurrentFilter.Ecosystem);
  CbEcoDesert.Checked := (ieDesert in GCurrentFilter.Ecosystem);
  CbEcoForest.Checked := (ieForest in GCurrentFilter.Ecosystem);
  CbEcoLakes.Checked := (ieLakes in GCurrentFilter.Ecosystem);
  CbEcoJungle.Checked := (ieJungle in GCurrentFilter.Ecosystem);

  // Class
  EdClassMin.ItemIndex := Ord(GCurrentFilter.ClassMin);
  EdClassMax.ItemIndex := Ord(GCurrentFilter.ClassMax);

  // Quality
  EdQualityMin.Value := GCurrentFilter.QualityMin;
  EdQualityMax.Value := GCurrentFilter.QualityMax;

  // Item equipment
  EdEquipment.ItemIndex := 0;
  if iqLightArmor in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 1;
  if iqMediumArmor in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 2;
  if iqHeavyArmor in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 3;
  if iqWeaponMelee in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 4;
  if iqWeaponRange in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 5;
  if iqAmplifier in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 6;
  if iqJewel in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 7;
  if (iqBuckler in GCurrentFilter.Equipment) or
     (iqShield in GCurrentFilter.Equipment) then EdEquipment.ItemIndex := 8;
  if iqTool in GCurrentFilter.Equipment then EdEquipment.ItemIndex := 9;
  if (iqAmmo in GCurrentFilter.Equipment) or
     (iqOther in GCurrentFilter.Equipment) then EdEquipment.ItemIndex := 10;

  // Item category
  EdCategory.ItemIndex := GCurrentFilter.CategoryIndex;

  // Sales
  EdContinent.ItemIndex := 0;
  if GCurrentFilter.Continent <> '' then
    EdContinent.ItemIndex := EdContinent.Items.IndexOf(GCurrentFilter.Continent);
  EdPriceMin.Value := GCurrentFilter.PriceMin;
  EdPriceMax.Value := GCurrentFilter.PriceMax;

  // Bonus
  CbHpb.Checked := ibHp in GCurrentFilter.Bonus;
  CbSab.Checked := ibSab in GCurrentFilter.Bonus;
  CbStb.Checked := ibStamina in GCurrentFilter.Bonus;
  CbFob.Checked := ibFocus in GCurrentFilter.Bonus;

  // Item name
  EdName.Text := GCurrentFilter.ItemName;
  RbAllWords.Checked := GCurrentFilter.AllWords;

  EnabledGroup(GbEcosys, CbTypeMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbClass, CbTypeMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbEquipment, CbTypeEquipment.Checked);
  EnabledGroup(GbCategory, CbTypeMat.Checked);
  EnabledGroup(GbBonus, CbTypeEquipment.Checked);
end;

{*******************************************************************************
Saves the current filter
*******************************************************************************}
procedure TFormRoomFilter.SaveCurrentFilter;
begin
  // Sorting
  case EdSorting.ItemIndex of
    0: GCurrentFilter.Sorting := ioType;
    1: GCurrentFilter.Sorting := ioEcosys;
    2: GCurrentFilter.Sorting := ioClass;
    3: GCurrentFilter.Sorting := ioQuality;
    4: GCurrentFilter.Sorting := ioVolume;
    5: GCurrentFilter.Sorting := ioPrice;
    6: GCurrentFilter.Sorting := ioTime;
  end;
  
  // Item type
  GCurrentFilter.Type_ := [];
  if CbTypeMat.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itAnimalMat,itNaturalMat,itSystemMat];
  if CbTypeEquipment.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itEquipment];
  if CbTypeCata.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itCata];
  if CbTypeTeleporter.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itTeleporter];
  if CbTypeOthers.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itOther];

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

  // Item quality
  if EdQualityMax.Value < EdQualityMin.Value then EdQualityMax.Value := EdQualityMin.Value;
  GCurrentFilter.QualityMin := EdQualityMin.Value;
  GCurrentFilter.QualityMax := EdQualityMax.Value;

  // Item equipment
  GCurrentFilter.Equipment := [];
  case EdEquipment.ItemIndex of
    1: GCurrentFilter.Equipment := [iqLightArmor];
    2: GCurrentFilter.Equipment := [iqMediumArmor];
    3: GCurrentFilter.Equipment := [iqHeavyArmor];
    4: GCurrentFilter.Equipment := [iqWeaponMelee];
    5: GCurrentFilter.Equipment := [iqWeaponRange];
    6: GCurrentFilter.Equipment := [iqAmplifier];
    7: GCurrentFilter.Equipment := [iqJewel];
    8: GCurrentFilter.Equipment := [iqBuckler, iqShield];
    9: GCurrentFilter.Equipment := [iqTool];
    10: GCurrentFilter.Equipment := [iqAmmo, iqOther];
  end;

  // Item Category
  GCurrentFilter.CategoryIndex := EdCategory.ItemIndex;

  // Sales
  GCurrentFilter.Continent := '';
  if EdContinent.ItemIndex > 0 then
    GCurrentFilter.Continent := EdContinent.Items[EdContinent.ItemIndex];
  GCurrentFilter.PriceMin := EdPriceMin.Value;
  GCurrentFilter.PriceMax := EdPriceMax.Value;

  // Bonus
  GCurrentFilter.Bonus := [];
  if CbHpb.Checked then GCurrentFilter.Bonus := GCurrentFilter.Bonus + [ibHp];
  if CbSab.Checked then GCurrentFilter.Bonus := GCurrentFilter.Bonus + [ibSab];
  if CbStb.Checked then GCurrentFilter.Bonus := GCurrentFilter.Bonus + [ibStamina];
  if CbFob.Checked then GCurrentFilter.Bonus := GCurrentFilter.Bonus + [ibFocus];

  // Item name
  GCurrentFilter.ItemName := Trim(EdName.Text);
  GCurrentFilter.AllWords := RbAllWords.Checked;
end;

{*******************************************************************************
Sets default filter
*******************************************************************************}
procedure TFormRoomFilter.BtDefaultClick(Sender: TObject);
begin
  GRyzomApi.SetDefaultFilter(GCurrentFilter);
  LoadCurrentFilter;
  ApplyFilter;
end;

{*******************************************************************************
Applies filter
*******************************************************************************}
procedure TFormRoomFilter.ApplyFilter;
begin
  SaveCurrentFilter;
  if FormRoom.Visible then begin
    FormRoom.UpdateRoom;
  end else begin
    FormInvent.UpdateRoom;
  end;
end;

{*******************************************************************************
Displays info of the selected item
*******************************************************************************}
procedure TFormRoomFilter.UpdateInfo(AItemImage: TItemImage);
var
  wNow: TDateTime;
  wDays: Integer;
  wHours: Integer;
  wMinutes: Integer;
  wMatColor: Integer;
  wResName: String;
  wTop, wLeft: Integer;
  i: Integer;
begin
  try
    if FCurrentItem = AItemImage then Exit;
    if PageControl.TabIndex <> 0 then Exit;
    FCurrentItem := AItemImage;

    with AItemImage.Data as TItemInfo do begin
      // Name
      if FileExists(GConfig.PackFile) then begin
        PnTitle.OnClick := nil;
        PnTitle.Cursor := crDefault;
        PnTitle.Caption := ItemDesc
      end else begin
        PnTitle.OnClick := PnTitleClick;
        PnTitle.Cursor := crHandPoint;
        PnTitle.Caption := RS_NEEDED_FILE;
      end;

      // Background color
      case ItemEcosys of
        ieCommon, iePrime, ieUnknown: PnTitle.Color := $434B4F;
        ieDesert: PnTitle.Color := $18436F;
        ieJungle: PnTitle.Color := $824B7F;
        ieForest: PnTitle.Color := $2D6053;
        ieLakes: PnTitle.Color := $706237;
      end;

      // Image
      ImgItem.Assign(AItemImage);

      // Skin
      ImgSkin1.Visible := False;
      ImgSkin2.Visible := False;
      ImgSkin3.Visible := False;
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

      // Ecosystem
      if ItemEcosys <> ieUnknown then begin
        LbValueEcosys.Caption := GetEcosysName(Ord(ItemEcosys));
        FLbList.Add(LbEcosys);
        FLbList.Add(LbValueEcosys);
      end;

      // Quality
      if not (ItemQuality < 0) then begin
        LbValueQuality.Caption := IntToStr(ItemQuality);
        FLbList.Add(LbQuality);
        FLbList.Add(LbValueQuality);
      end;

      // Class
      if ItemClass <> icUnknown then begin
        LbValueClass.Caption := GetClassName(Ord(ItemClass));
        FLbList.Add(LbClass);
        FLbList.Add(LbValueClass);
      end;

      // Weight
      if ItemWeight > 0 then begin
        LbValueWeight.Caption := FormatFloat('####0.##', ItemWeight, GConfig.FormatSettings) + ' kg';
        FLbList.Add(LbWeight);
        FLbList.Add(LbValueWeight);
      end;

      // Volume
      LbValueVolume.Caption := FormatFloat('####0.##', ItemVolume, GConfig.FormatSettings);
      FLbList.Add(LbVolume);
      FLbList.Add(LbValueVolume);

      // Durability
      if (ItemHp > 0) and (ItemDur > 0) then begin
        LbValueDura.Caption := Format('%d/%d', [ItemHp, ItemDur]);
        FLbList.Add(LbDura);
        FLbList.Add(LbValueDura);
      end;

      // Color
      if ItemColor <> icNone then begin
        LbValueColor.Caption := GetColorName(ItemColor);
        FLbList.Add(LbColor);
        FLbList.Add(LbValueColor);
      end;

      // Equipements
      if (ItemType = itEquipment) then begin
        if (ItemEquip in [iqWeaponMelee, iqWeaponRange, iqAmplifier]) then begin
          LbValueSpeed.Caption := FloatToStr(CSpeed);
          FLbList2.Add(LbAutoSpeed);
          FLbList2.Add(LbValueSpeed);

          LbValueRange.Caption := FloatToStr(CRange);
          FLbList2.Add(LbAutoRange);
          FLbList2.Add(LbValueRange);
        end;
        
        if (ItemEquip in [iqLightArmor, iqMediumArmor, iqHeavyArmor, iqShield, iqBuckler, iqWeaponMelee, iqWeaponRange, iqAmplifier]) then begin
          LbValueDodge.Caption := IntToStr(CDodgeModifier);
          FLbList2.Add(LbAutoDodge);
          FLbList2.Add(LbValueDodge);

          LbValueParry.Caption := IntToStr(CParryModifier);
          FLbList2.Add(LbAutoParry);
          FLbList2.Add(LbValueParry);
        end;

        if (ItemEquip in [iqWeaponMelee, iqWeaponRange, iqAmplifier]) then begin
          LbValueAdvDodge.Caption := IntToStr(CAdvDodgeModifier);
          FLbList2.Add(LbAutoAdvDodge);
          FLbList2.Add(LbValueAdvDodge);

          LbValueAdvParry.Caption := IntToStr(CAdvParryModifier);
          FLbList2.Add(LbAutoAdvParry);
          FLbList2.Add(LbValueAdvParry);
        end;

        if (ItemEquip in [iqLightArmor, iqMediumArmor, iqHeavyArmor, iqShield, iqBuckler]) then begin
          LbValueFactorProt.Caption := FloatToStr(CFactorProt);
          FLbList2.Add(LbAutoFactorProt);
          FLbList2.Add(LbValueFactorProt);

          LbValueSlashingProt.Caption := IntToStr(CSlashingProt);
          FLbList2.Add(LbAutoSlashingProt);
          FLbList2.Add(LbValueSlashingProt);

          LbValueSmashingProt.Caption := IntToStr(CSmashingProt);
          FLbList2.Add(LbAutoSmashingProt);
          FLbList2.Add(LbValueSmashingProt);

          LbValuePiercingProt.Caption := IntToStr(CPiercingProt);
          FLbList2.Add(LbAutoPiercingProt);
          FLbList2.Add(LbValuePiercingProt);
        end;
      end;

      // Materials
      if (ItemType = itAnimalMat) or (ItemType = itNaturalMat) or (ItemType = itSystemMat) then begin
        // Craft
        if (Pos('m0312', ItemName) = 1) or (ItemType = itSystemMat) then begin
          LbValueCraft.Caption := RS_CAT_ALL;
          FLbList.Add(LbCraft);
          FLbList.Add(LbValueCraft);
        end else begin
          if (ItemCategory1 > 0) and (ItemCategory2 > 0) then begin
            LbValueCraft.Caption :=  GetCatName(ItemCategory1) + ', ' + GetCatName(ItemCategory2);
            FLbList.Add(LbCraft);
            FLbList.Add(LbValueCraft);
          end;
        end;

        // Color
        wMatColor := 0;
        if (ItemEcosys = iePrime) then begin
          wMatColor := MatColor3;
        end else begin
          case ItemClass of
            icBasic, icFine: wMatColor := MatColor1;
            icChoice, icExcellent, icSupreme: wMatColor := MatColor2;
          end;
        end;
      
        if wMatColor > 0 then begin
          LbValueColor.Caption := GetColorName(wMatColor);
          FLbList.Add(LbColor);
          FLbList.Add(LbValueColor);
        end;

        // Race
        if ItemEcosys <> ieUnknown then begin
          LbValueRace.Caption := GetRaceName(Ord(ItemEcosys));
          FLbList.Add(LbRace);
          FLbList.Add(LbValueRace);
        end;

        // Category 1
        if ItemCategory1 >= 0 then begin
          wResName := Format('cat_%s', [LowerCase(_MAT_CATEGORY[ItemCategory1])]);
          FPngObject.LoadFromResourceName(HInstance, wResName);
          ImgCat1.Picture.Assign(FPngObject);
          LbCat1.Caption := GetCatName(ItemCategory1);
          for i := 1 to 11 do begin
            TLabel(FindComponent(Format('LbCat1Spec%d', [i]))).Visible := False;
            TGauge(FindComponent(Format('GaugeCat1Spec%d', [i]))).Visible := False;
          end;

          PnCat1.Height := 35 + Length(MatSpec1)*15;
          for i := 0 to High(MatSpec1) do begin
            with FindComponent(Format('LbCat1Spec%d', [i+1])) as TLabel do begin
              Visible := True;
              Caption := GetSpecName(MatSpec1[i][0]);
            end;
            with FindComponent(Format('GaugeCat1Spec%d', [i+1])) as TGauge do begin
              Visible := True;
              case MatSpec1[i][1] of
                1: Progress := 0 + Ord(ItemClass)*9;
                2: Progress := 12 + Ord(ItemClass)*9;
                3: Progress := 36 + Ord(ItemClass)*9;
              end;
            end;
          end;
        end; // Cat1

        // Category 2
        if ItemCategory2 >= 0 then begin
          wResName := Format('cat_%s', [LowerCase(_MAT_CATEGORY[ItemCategory2])]);
          FPngObject.LoadFromResourceName(HInstance, wResName);
          ImgCat2.Picture.Assign(FPngObject);
          LbCat2.Caption := GetCatName(ItemCategory2);
          for i := 1 to 11 do begin
            TLabel(FindComponent(Format('LbCat2Spec%d', [i]))).Visible := False;
            TGauge(FindComponent(Format('GaugeCat2Spec%d', [i]))).Visible := False;
          end;

          PnCat2.Height := 35 + Length(MatSpec2)*15;
          for i := 0 to High(MatSpec2) do begin
            with FindComponent(Format('LbCat2Spec%d', [i+1])) as TLabel do begin
              Visible := True;
              Caption := GetSpecName(MatSpec2[i][0]);
            end;
            with FindComponent(Format('GaugeCat2Spec%d', [i+1])) as TGauge do begin
              Visible := True;
              case MatSpec2[i][1] of
                1: Progress := 0 + Ord(ItemClass)*9;
                2: Progress := 12 + Ord(ItemClass)*9;
                3: Progress := 36 + Ord(ItemClass)*9;
              end;
            end;
          end;
        end; // Cat2
      end;

      // Guard
      if ItemGuarded then begin
        LbValueGuard.Caption := IntToStr(ItemGuardValue);
        FLbList.Add(LbGuard);
        FLbList.Add(LbValueGuard);
      end;

      // Bonus
      if ItemHpb <> 0 then LbValueHpb.Caption := IntToStr(ItemHpb);
      if ItemSab <> 0 then LbValueSab.Caption := IntToStr(ItemSab);
      if ItemStb <> 0 then LbValueStb.Caption := IntToStr(ItemStb);
      if ItemFob <> 0 then LbValueFob.Caption := IntToStr(ItemFob);

      // Sales
      if ItemPrice > 0 then begin
        LbValueContinent.Caption := ItemContinent;
        LbValuePrice.Caption := Format('%s (%s)', [
          FormatFloat('###,###,###,##0', ItemPrice, GConfig.FormatSettings),
          FormatFloat('###,###,###,##0', ItemPrice*ItemQuantity, GConfig.FormatSettings)]);
        wNow := Now;
        wDays := DaysBetween(wNow, ItemTime);
        wNow := IncDay(wNow, wDays);
        wHours := HoursBetween(wNow, ItemTime);
        wNow := IncHour(wNow, wHours);
        wMinutes := MinutesBetween(wNow, ItemTime);
        LbValueTime.Caption := Format('%d %s, %d %s %s %d %s', [wDays, RS_DAYS, wHours, RS_HOURS, RS_AND, wMinutes, RS_MINUTES]);
      end;

      //-----------------------------------------------

      // Hide all labels
      for i := 0 to PnInfo.ControlCount - 1 do begin
        if PnInfo.Controls[i] is TLabel then TLabel(PnInfo.Controls[i]).Visible := False;
      end;
      for i := 0 to PnInfo2.ControlCount - 1 do begin
        if PnInfo2.Controls[i] is TLabel then TLabel(PnInfo2.Controls[i]).Visible := False;
      end;

      // Height of info panels
      PnInfo.Height := 8 + ((FLbList.Count div 2)*15);
      PnInfo2.Height := 8 + ((FLbList2.Count div 2)*15);
      if ItemBonus then PnInfo2.Height := PnInfo2.Height + 24;

      // Bonus
      ImgHpb.Visible := ItemHpb <> 0;
      ImgSab.Visible := ItemSab <> 0;
      ImgStb.Visible := ItemStb <> 0;
      ImgFob.Visible := ItemFob <> 0;
      LbValueHpb.Visible := ItemHpb <> 0;
      LbValueSab.Visible := ItemSab <> 0;
      LbValueStb.Visible := ItemStb <> 0;
      LbValueFob.Visible := ItemFob <> 0;
      ImgHpb.Top := PnInfo2.Height - 28;
      ImgSab.Top := ImgHpb.Top;
      ImgStb.Top := ImgHpb.Top;
      ImgFob.Top := ImgHpb.Top;
      LbValueHpb.Top := ImgHpb.Top + 6;
      LbValueSab.Top := LbValueHpb.Top;
      LbValueStb.Top := LbValueHpb.Top;
      LbValueFob.Top := LbValueHpb.Top;
      wLeft := 8;
      if ItemHpb <> 0 then begin
        ImgHpb.Left := wLeft;
        LbValueHpb.Left := wLeft + 28;
        wLeft := wLeft + 68;
      end;
      if ItemSab <> 0 then begin
        ImgSab.Left := wLeft;
        LbValueSab.Left := wLeft + 28;
        wLeft := wLeft + 68;
      end;
      if ItemStb <> 0 then begin
        ImgStb.Left := wLeft;
        LbValueStb.Left := wLeft + 28;
        wLeft := wLeft + 68;
      end;
      if ItemFob <> 0 then begin
        ImgFob.Left := wLeft;
        LbValueFob.Left := wLeft + 28;
      end;

      // Show labels used in panel Info
      i := 0;
      wTop := 5;
      while i < FLbList.Count - 1 do begin
        TLabel(FLbList.Items[i]).Visible := True;
        TLabel(FLbList.Items[i+1]).Visible := True;
        TLabel(FLbList.Items[i]).Top := wTop;
        TLabel(FLbList.Items[i+1]).Top := wTop;
        Inc(wTop, 15);
        Inc(i, 2);
      end;

      // Show labels used in panel Info2
      i := 0;
      wTop := 5;
      while i < FLbList2.Count - 1 do begin
        TLabel(FLbList2.Items[i]).Visible := True;
        TLabel(FLbList2.Items[i+1]).Visible := True;
        TLabel(FLbList2.Items[i]).Top := wTop;
        TLabel(FLbList2.Items[i+1]).Top := wTop;
        Inc(wTop, 15);
        Inc(i, 2);
      end;

      // Show panels
      PnTitle.Visible := True;
      PnInfo.Visible := True;
      PnInfo2.Visible := ((FLbList2.Count > 0) or (ItemBonus));
      PnSales.Visible := (ItemPrice > 0);
      PnCat1.Visible := (ItemCategory1 >= 0);
      PnCat2.Visible := (ItemCategory2 >= 0);
      

      // Changes the top
      wTop := PnInfo.Top + PnInfo.Height + 2;

      if PnInfo2.Visible then begin
        PnInfo2.Top := wTop;
        wTop := wTop + PnInfo2.Height + 2;
      end;
      
      if PnSales.Visible then begin
        PnSales.Top := wTop;
        wTop := wTop + PnSales.Height + 2;
      end;

      PnCat1.Top := wTop;
      PnCat2.Top := PnCat1.Top + PnCat1.Height + 2;
    end;
  finally
    FLbList.Clear;
    FLbList2.Clear;
  end;
end;

{*******************************************************************************
Initialize info
*******************************************************************************}
procedure TFormRoomFilter.InitInfo;
begin
  FCurrentItem := nil;
  PnTitle.Visible := False;
  PnInfo.Visible := False;
  PnInfo2.Visible := False;
  PnSales.Visible := False;
  PnCat1.Visible := False;
  PnCat2.Visible := False;
end;

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormRoomFilter.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FPngObject := TPNGObject.Create;
  FLbList := TObjectList.Create(False);
  FLbList2 := TObjectList.Create(False);
  DoubleBuffered := True;
  PageControl.DoubleBuffered := True;
  TabFilter.DoubleBuffered := True;
  TabInfo.DoubleBuffered := True;

  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TPanel then TPanel(Components[i]).DoubleBuffered := True;
    if Components[i] is TGroupBox then TGroupBox(Components[i]).DoubleBuffered := True;
    if Components[i] is TCheckBox then TCheckBox(Components[i]).DoubleBuffered := True;
    if Components[i] is TSpinEdit then TSpinEdit(Components[i]).DoubleBuffered := True;
    if Components[i] is TRadioButton then TRadioButton(Components[i]).DoubleBuffered := True;
  end;

  PnCat1.Parent := TabInfo;
  PnCat2.Parent := TabInfo;
  PnSales.Parent := TabInfo;
  TabTemp.TabVisible := False;

  // min and max values for the quality
  EdQualityMin.MinValue := _MIN_QUALITY;
  EdQualityMin.MaxValue := _MAX_QUALITY;
  EdQualityMax.MinValue := _MIN_QUALITY;
  EdQualityMax.MaxValue := _MAX_QUALITY;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormRoomFilter.FormDestroy(Sender: TObject);
begin
  FPngObject.Free;
  FLbList.Free;
  FLbList2.Free;
end;

{*******************************************************************************
Changes the current page
*******************************************************************************}
procedure TFormRoomFilter.PageControlChange(Sender: TObject);
begin
  FCurrentItem := nil;
end;

procedure TFormRoomFilter.BackupComboIndex;
begin
  FComboIndexSorting := EdSorting.ItemIndex;
  FComboIndexClassMin := EdClassMin.ItemIndex;
  FComboIndexClassMax := EdClassMax.ItemIndex;
  FComboIndexEquipment := EdEquipment.ItemIndex;
  FComboIndexCategory := EdCategory.ItemIndex;
  FComboIndexContinent := EdContinent.ItemIndex;
end;

procedure TFormRoomFilter.RestoreComboIndex;
begin
  EdSorting.ItemIndex := FComboIndexSorting;
  EdClassMin.ItemIndex := FComboIndexClassMin;
  EdClassMax.ItemIndex := FComboIndexClassMax;
  EdEquipment.ItemIndex := FComboIndexEquipment;
  EdCategory.ItemIndex := FComboIndexCategory;
  EdContinent.ItemIndex := FComboIndexContinent;
end;

procedure TFormRoomFilter.PnTitleClick(Sender: TObject);
begin
  FormOptions.ShowModal;
end;

end.
