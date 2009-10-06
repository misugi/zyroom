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
unit UnitFormRoomFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, ShellAPI, Spin, UnitRyzom;

type
  TFormRoomFilter = class(TForm)
    BtOK: TButton;
    GbType: TGroupBox;
    CbTypeNaturalMat: TCheckBox;
    CbTypeAnimalMat: TCheckBox;
    CbTypeCata: TCheckBox;
    CbTypeOthers: TCheckBox;
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
    CbTypeEquipment: TCheckBox;
    BtDefault: TButton;
    GbName: TGroupBox;
    EdName: TEdit;
    RbAllWords: TRadioButton;
    RbOneWord: TRadioButton;
    GbEquipment: TGroupBox;
    CbEqHeavyArmors: TCheckBox;
    CbEqWeapons1: TCheckBox;
    CbEqMediumArmors: TCheckBox;
    CbEqLightArmors: TCheckBox;
    CbEqJewels: TCheckBox;
    CbEqWeapons2: TCheckBox;
    procedure BtOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CbTypeAnimalMatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtDefaultClick(Sender: TObject);
  private
    procedure EnabledGroup(AGroup: TGroupBox; AEnabled: Boolean);
    procedure LoadCurrentFilter;
    procedure SaveCurrentFilter;
  public
  end;

var
  FormRoomFilter: TFormRoomFilter;

implementation

uses UnitFormProgress, UnitFormGuild, UnitFormRoom, UnitFormInvent,
  UnitFormCharacter;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormRoomFilter.FormCreate(Sender: TObject);
begin
  // Default position
  Left := (Screen.Width - Self.Width) div 2;
  Top := (Screen.Height - Self.Height) div 2;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormRoomFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormRoom.BtFilter.Down := False;
  FormInvent.BtFilter.Down := False;
end;

{*******************************************************************************
Shows the form
*******************************************************************************}
procedure TFormRoomFilter.FormShow(Sender: TObject);
begin
  LoadCurrentFilter;
end;

{*******************************************************************************
Applies the filter
*******************************************************************************}
procedure TFormRoomFilter.BtOKClick(Sender: TObject);
var
  wGuildID: String;
  wCharID: String;
begin
  SaveCurrentFilter;
  if FormRoom.Visible then begin
    wGuildID := FormGuild.GridGuild.Cells[2, FormGuild.GridGuild.Row];
    FormProgress.ShowFormRoom(wGuildID, FormRoom.GuildRoom, GCurrentFilter);
  end else begin
    wCharID := FormCharacter.GridChar.Cells[2, FormCharacter.GridChar.Row];
    FormProgress.ShowFormInvent(wCharID, FormInvent.CharInvent, FormInvent.TabInvent.TabIndex, GCurrentFilter);
  end;
end;

{*******************************************************************************
Changes the checkbox for natural or animal materials
*******************************************************************************}
procedure TFormRoomFilter.CbTypeAnimalMatClick(Sender: TObject);
begin
  EnabledGroup(GbEcosys, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbClass, CbTypeNaturalMat.Checked or CbTypeAnimalMat.Checked or CbTypeEquipment.Checked);
  EnabledGroup(GbEquipment, CbTypeEquipment.Checked);
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
  CbTypeOthers.Checked := (itOthers in GCurrentFilter.Type_);
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
  CbEqWeapons1.Checked := (iqWeapon1 in GCurrentFilter.Equipment);
  CbEqWeapons2.Checked := (iqWeapon2 in GCurrentFilter.Equipment);
  CbEqJewels.Checked := (iqJewel in GCurrentFilter.Equipment);

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
  if CbTypeOthers.Checked then GCurrentFilter.Type_ := GCurrentFilter.Type_ + [itOthers];

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
  if CbEqWeapons1.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqWeapon1];
  if CbEqWeapons2.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqWeapon2];
  if CbEqJewels.Checked then GCurrentFilter.Equipment := GCurrentFilter.Equipment + [iqJewel];

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
end;

end.
