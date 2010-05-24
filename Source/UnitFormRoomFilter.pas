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
  ItemImage, StrUtils, ComCtrls, DateUtils, Gauges;

resourcestring
  RS_SKIN = 'Skin';
  RS_HPB = 'Bonus vie';
  RS_SAB = 'Bonus sève';
  RS_STB = 'Bonus endurance';
  RS_FOB = 'Bonus concentration';
  RS_ALL = 'Tous';
  RS_DAYS = 'jours';
  RS_HOURS = 'heures';
  RS_MINUTES = 'minutes';
  RS_AND = 'et';

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
    TabCraft: TTabSheet;
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
    PnCraftInfo: TPanel;
    LbQuality: TLabel;
    LbColor: TLabel;
    LbRace: TLabel;
    ImgMat: TItemImage;
    PnTitle: TPanel;
    LbEcosys: TLabel;
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
    LbValueQuality: TLabel;
    LbValueColor: TLabel;
    LbValueRace: TLabel;
    LbValueEcosys: TLabel;
    LbClass: TLabel;
    LbValueClass: TLabel;
    PnTitle2: TPanel;
    PnInfo: TPanel;
    LbQuality2: TLabel;
    LbVolume: TLabel;
    LbCraft: TLabel;
    ImgItem: TItemImage;
    LbEcosys2: TLabel;
    LbValueQuality2: TLabel;
    LbValueVolume: TLabel;
    LbValueCraft: TLabel;
    LbValueEcosys2: TLabel;
    LbClass2: TLabel;
    LbValueClass2: TLabel;
    ImgHpb: TImage;
    ImgFob: TImage;
    ImgStb: TImage;
    ImgSab: TImage;
    LbValueHpb: TLabel;
    LbValueSab: TLabel;
    LbValueStb: TLabel;
    LbValueFob: TLabel;
    PnSales: TPanel;
    LbPrice: TLabel;
    ItemImage1: TItemImage;
    LbContinent: TLabel;
    LbValuePrice: TLabel;
    LbValueContinent: TLabel;
    LbTime: TLabel;
    LbValueTime: TLabel;
    LbDura: TLabel;
    LbValueDura: TLabel;
    ImgSkin1: TImage;
    ImgSkin2: TImage;
    ImgSkin3: TImage;
    procedure BtOKClick(Sender: TObject);
    procedure CbTypeAnimalMatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtDefaultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    FCurrentItem: TItemImage;
    FPngObject: TPNGObject;
    
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
  EdCategory.Items.Append(RS_ALL);
  for i := 1 to High(_MAT_CATEGORY) do begin
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
  i: Integer;
begin
  if FCurrentItem = AItemImage then Exit;
  FCurrentItem := AItemImage;
  
  with AItemImage.Data as TItemInfo do begin
    // Information
    if PageControl.TabIndex = 0 then begin
      ImgItem.Assign(AItemImage);
      ImgItem.Visible := True;

      // Name
      PnTitle2.Caption := ItemDesc;

      // Quality
      LbValueQuality2.Caption := IntToStr(ItemQuality);

      // Class
      if ItemClass <> icUnknown then begin
        LbValueClass2.Caption := GetClassName(Ord(ItemClass));
      end else begin
        LbValueClass2.Caption := '-';
      end;

      // Ecosystem
      case ItemEcosys of
        ieCommon: LbValueEcosys2.Caption := CbEcoCommon.Caption;
        iePrime: LbValueEcosys2.Caption := CbEcoPrime.Caption;
        ieDesert: LbValueEcosys2.Caption := CbEcoDesert.Caption;
        ieJungle: LbValueEcosys2.Caption := CbEcoJungle.Caption;
        ieForest: LbValueEcosys2.Caption := CbEcoForest.Caption;
        ieLakes: LbValueEcosys2.Caption := CbEcoLakes.Caption;
        ieUnknown: LbValueEcosys2.Caption := '-';
      end;

      // Volume
      LbValueVolume.Caption := FormatFloat('####0.##', ItemVolume);

      // Durability
      LbValueDura.Caption := '-';
      if ItemHp > 0 then LbValueDura.Caption := Format('%d/%d', [ItemHp, ItemDur]);

      // Craft
      LbValueCraft.Caption := '-';
      if (ItemType = itAnimalMat) or (ItemType = itNaturalMat) then begin
        if Pos('m0312', ItemName) = 1 then begin {larva}
          LbValueCraft.Caption := RS_ALL;
        end else begin
          if ItemCategory1 > 0 then
            LbValueCraft.Caption :=  GetCatName(ItemCategory1) + ', ' + GetCatName(ItemCategory2);
        end;
      end;

      // Bonus
      LbValueHpb.Caption := '';
      ImgHpb.Visible := ItemHpb > 0;
      if ItemHpb > 0 then LbValueHpb.Caption := IntToStr(ItemHpb);

      LbValueSab.Caption := '';
      ImgSab.Visible := ItemSab > 0;
      if ItemSab > 0 then LbValueSab.Caption := IntToStr(ItemSab);

      LbValueStb.Caption := '';
      ImgStb.Visible := ItemStb > 0;
      if ItemStb > 0 then LbValueStb.Caption := IntToStr(ItemStb);

      LbValueFob.Caption := '';
      ImgFob.Visible := ItemFob > 0;
      if ItemFob > 0 then LbValueFob.Caption := IntToStr(ItemFob);

      // Height
      if (ItemHpb + ItemSab + ItemStb + ItemFob) = 0 then
        PnInfo.Height := 100
      else
        PnInfo.Height := 128;

      // Sales
      PnSales.Visible := ItemPrice > 0;
      if ItemPrice > 0 then begin
        LbValueContinent.Caption := ItemContinent;
        LbValuePrice.Caption := Format('%s (%s)', [
          FormatFloat('###,###,###,##0', ItemPrice),
          FormatFloat('###,###,###,##0', ItemPrice*ItemQuantity)]);
        wNow := Now;
        wDays := DaysBetween(wNow, ItemTime);
        wNow := IncDay(wNow, wDays);
        wHours := HoursBetween(wNow, ItemTime);
        wNow := IncHour(wNow, wHours);
        wMinutes := MinutesBetween(wNow, ItemTime);
        if wDays > 0 then begin
          if wHours > 0 then
            LbValueTime.Caption := Format('%d %s, %d %s %s %d %s', [wDays, RS_DAYS, wHours, RS_HOURS, RS_AND, wMinutes, RS_MINUTES])
          else
            LbValueTime.Caption := Format('%d %s %s %d %s', [wDays, RS_DAYS, RS_AND, wMinutes, RS_MINUTES]);
        end else begin
          if wHours > 0 then
            LbValueTime.Caption := Format('%d %s %s %d %s', [wHours, RS_HOURS, RS_AND, wMinutes, RS_MINUTES])
          else
            LbValueTime.Caption := Format('%d %s', [wMinutes, RS_MINUTES]);
        end;
        PnSales.Top := PnInfo.Top + PnInfo.Height + 1;
      end;


      // Skin image
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
    end;

    // Craft
    if PageControl.TabIndex = 1 then begin
      TabCraft.Visible := (ItemType = itAnimalMat) or (ItemType = itNaturalMat);
      if TabCraft.Visible then begin
        PnCat1.Visible := True;
        PnCat2.Visible := True;

        // Image
        ImgMat.Assign(AItemImage);
        ImgMat.Visible := True;

        // Name
        PnTitle.Caption := ItemDesc;

        // Quality
        LbValueQuality.Caption := IntToStr(ItemQuality);

        // Class
        if ItemClass <> icUnknown then begin
          LbValueClass.Caption := GetClassName(Ord(ItemClass));
        end else begin
          LbValueClass.Caption := '-';
        end;

        // Ecosystem
        case ItemEcosys of
          ieCommon: LbValueEcosys.Caption := CbEcoCommon.Caption;
          iePrime: LbValueEcosys.Caption := CbEcoPrime.Caption;
          ieDesert: LbValueEcosys.Caption := CbEcoDesert.Caption;
          ieJungle: LbValueEcosys.Caption := CbEcoJungle.Caption;
          ieForest: LbValueEcosys.Caption := CbEcoForest.Caption;
          ieLakes: LbValueEcosys.Caption := CbEcoLakes.Caption;
          ieUnknown: LbValueEcosys.Caption := '-';
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
        LbValueColor.Caption := GetColorName(wMatColor);

        // Craft
        case ItemEcosys of
          ieCommon, iePrime: LbValueRace.Caption := RS_RACE_ALL;
          ieDesert: LbValueRace.Caption := RS_RACE_FYROS;
          ieJungle: LbValueRace.Caption := RS_RACE_ZORAI;
          ieForest: LbValueRace.Caption := RS_RACE_MATIS;
          ieLakes: LbValueRace.Caption := RS_RACE_TRYKER;
          ieUnknown: LbValueRace.Caption := '-';
        end;

        PnCat1.Visible := (ItemCategory1 > 0);
        PnCat2.Visible := (ItemCategory2 > 0);

        // Category 1
        if PnCat1.Visible then begin
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
        end;

        // Category 2
        if PnCat2.Visible then begin
          wResName := Format('cat_%s', [LowerCase(_MAT_CATEGORY[ItemCategory2])]);
          FPngObject.LoadFromResourceName(HInstance, wResName);
          ImgCat2.Picture.Assign(FPngObject);
          LbCat2.Caption := GetCatName(ItemCategory2);
          for i := 1 to 11 do begin
            TLabel(FindComponent(Format('LbCat2Spec%d', [i]))).Visible := False;
            TGauge(FindComponent(Format('GaugeCat2Spec%d', [i]))).Visible := False;
          end;

          PnCat2.Top := PnCat1.Top + PnCat1.Height + 1;
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
        end;
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
  ImgMat.Visible := False;
  LbValueQuality2.Caption := '';
  LbValueClass2.Caption := '';
  LbValueEcosys2.Caption := '';
  LbValueVolume.Caption := '';
  LbValueDura.Caption := '';
  LbValueCraft.Caption := '';
  LbValuePrice.Caption := '';
  LbValueTime.Caption := '';
  LbValueContinent.Caption := '';
  LbValueQuality.Caption := '';
  LbValueClass.Caption := '';
  LbValueEcosys.Caption := '';
  LbValueColor.Caption := '';
  LbValueRace.Caption := '';
  PnCat1.Visible := False;
  PnCat2.Visible := False;
  PnInfo.Height := 100;
  PnSales.Visible := False;
  ImgSkin1.Visible := False;
  ImgSkin2.Visible := False;
  ImgSkin3.Visible := False;
  PnTitle.Caption := '';
  PnTitle2.Caption := '';
end;

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormRoomFilter.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FPngObject := TPNGObject.Create;
  DoubleBuffered := True;
  PageControl.DoubleBuffered := True;
  TabFilter.DoubleBuffered := True;
  TabInfo.DoubleBuffered := True;
  TabCraft.DoubleBuffered := True;

  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TPanel then TPanel(Components[i]).DoubleBuffered := True;
    if Components[i] is TGroupBox then TGroupBox(Components[i]).DoubleBuffered := True;
    if Components[i] is TCheckBox then TCheckBox(Components[i]).DoubleBuffered := True;
    if Components[i] is TSpinEdit then TSpinEdit(Components[i]).DoubleBuffered := True;
    if Components[i] is TRadioButton then TRadioButton(Components[i]).DoubleBuffered := True;
  end;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormRoomFilter.FormDestroy(Sender: TObject);
begin
  FPngObject.Free;
end;

{*******************************************************************************
Changes the current page
*******************************************************************************}
procedure TFormRoomFilter.PageControlChange(Sender: TObject);
begin
  FCurrentItem := nil;
end;

end.
