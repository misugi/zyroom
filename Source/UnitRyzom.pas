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
unit UnitRyzom;

interface

uses
  Classes, SysUtils, RyzomApi, XpDOM, regexpr, UnitConfig, StrUtils, DateUtils;

resourcestring
  RS_SPEC_DURABILITY = 'Durabilité';
  RS_SPEC_LIGHTNESS = 'Légereté';
  RS_SPEC_SAPLOAD = 'Charge en sève';
  RS_SPEC_DAMAGE = 'Dégâts';
  RS_SPEC_SPEED = 'Vitesse';
  RS_SPEC_RANGE = 'Portée';
  RS_SPEC_DODGE_MODIFIER = 'Modif. esquives';
  RS_SPEC_PARRY_MODIFIER = 'Modif. parades';
  RS_SPEC_ADV_DODGE_MODIFIER = 'Modif. esquives adversaire';
  RS_SPEC_ADV_PARRY_MODIFIER = 'Modif. parades adversaire';
  RS_SPEC_PROTEC_FACTOR = 'Facteur de protection';
  RS_SPEC_MAX_SLASH_PROTEC = 'Protect. max/cp tranchant';
  RS_SPEC_MAX_SMASH_PROTEC = 'Protect. max/cp contondant';
  RS_SPEC_MAX_PIERC_PROTEC = 'Protect. max/cp perforant';
  RS_SPEC_ACID_PROTEC = 'Protection acide';
  RS_SPEC_COLD_PROTEC = 'Protection froid';
  RS_SPEC_ROT_PROTEC = 'Protection pourriture';
  RS_SPEC_FIRE_PROTEC = 'Protection feu';
  RS_SPEC_SHOCK_PROTEC = 'Protection ondes de choc';
  RS_SPEC_POISON_PROTEC = 'Protection poison';
  RS_SPEC_ELEC_PROTEC = 'Protection électricité';
  RS_SPEC_ELE_CAST_SPEED = 'Vitesse magie élémentaire';
  RS_SPEC_ELE_POWER = 'Puissance magie élémentaire';
  RS_SPEC_OFFAFF_CAST_SPEED = 'Vitesse magie débilitante';
  RS_SPEC_OFFAFF_POWER = 'Puissance magie débilitante';
  RS_SPEC_DEFAFF_CAST_SPEED = 'Vitesse magie neutralisante';
  RS_SPEC_DEFAFF_POWER = 'Puissance magie neutralisante';
  RS_SPEC_HEAL_CAST_SPEED = 'Vitesse magie curative';
  RS_SPEC_HEAL_POWER = 'Puissance magie curative';
  RS_SPEC_DESERT_RESIST = 'Résistance désert';
  RS_SPEC_FOREST_RESIST = 'Résistance forêt';
  RS_SPEC_LAKES_RESIST = 'Résistance lacs';
  RS_SPEC_JUNGLE_RESIST = 'Résistance jungle';
  RS_SPEC_PRIME_RESIST = 'Résistance primes racines';

  RS_CAT_BLADE = 'Lame';
  RS_CAT_POINT = 'Pointe';
  RS_CAT_HAMMER = 'Marteau';
  RS_CAT_COUNTERWEIGHT = 'Contrepoids';
  RS_CAT_SHAFT = 'Flèche';
  RS_CAT_AMMOBULLET = 'Balle de munitions';
  RS_CAT_BARREL = 'Canon';
  RS_CAT_ARMORSHELL = 'Carapace pour armures';
  RS_CAT_AMMOJACKET = 'Cartouche de munitions';
  RS_CAT_LINING = 'Doublure';
  RS_CAT_EXPLOSIVE = 'Explosif';
  RS_CAT_STUFFING = 'Rembourrage';
  RS_CAT_FIRINGPIN = 'Percuteur';
  RS_CAT_ARMORCLIP = 'Fixation pour armures';
  RS_CAT_TRIGGER = 'Détente';
  RS_CAT_JEWELSETTING = 'Configuration des bijoux';
  RS_CAT_GRIP = 'Prise';
  RS_CAT_CLOTHES = 'Vêtements';
  RS_CAT_JEWEL = 'Bijou';
  RS_CAT_MAGICFOCUS = 'Concentration magique';

  RS_COLOR_BEIGE = 'Beige';
  RS_COLOR_BLACK = 'Noir';
  RS_COLOR_BLUE = 'Bleu';
  RS_COLOR_GREEN = 'Vert';
  RS_COLOR_PURPLE = 'Violet';
  RS_COLOR_RED = 'Rouge';
  RS_COLOR_TURQUOISE = 'Turquoise';
  RS_COLOR_WHITE = 'Blanc';

  RS_CLASS_BASE = 'Base';
  RS_CLASS_FINE = 'Fin';
  RS_CLASS_CHOICE = 'Choix';
  RS_CLASS_EXCELLENT = 'Excellent';
  RS_CLASS_SUPREME = 'Suprême';

  RS_RACE_ALL = 'Toutes les races';
  RS_RACE_FYROS = 'Fyros';
  RS_RACE_ZORAI = 'Zoraï';
  RS_RACE_TRYKER = 'Tryker';
  RS_RACE_MATIS = 'Matis';

  RS_VOLUME = 'Volume';

const
  _MAT_CATEGORY : array [0..20] of String = ('Unknown', 'Blade', 'Point', 'Hammer', 'Counterweight',
    'Shaft', 'AmmoBullet', 'Barrel', 'ArmorShell', 'AmmoJacket', 'Lining', 'Explosive', 'Stuffing',
    'FiringPin', 'ArmorClip', 'Trigger', 'JewelSettings', 'Grip', 'Clothes', 'Jewel', 'MagicFocus');

  _MAT_SPEC : array [0..34] of String =
  ('Unknown', 'Durability', 'Lightness', 'Sap Load', 'Damage', 'Speed', 'Range', 'Dodge Modifier', 'Parry Modifier',
  'Adversary Dodge Modifier', 'Adversary Parry Modifier', 'Protection Factor', 'Max. Slashing Protection',
  'Max. Smashing Protection', 'Max. Piercing Protection', 'Acid Protection', 'Cold Protection',
  'Rot Protection', 'Fire Protection', 'Shockwave Protection', 'Poison Protection', 'Electricity Protection',
  'Elemental Cast Speed', 'Elemental Power', 'Off. Affliction Cast Speed', 'Off. Affliction Power',
  'Def. Affliction Cast Speed', 'Def. Affliction Power', 'Healing Cast Speed', 'Healing Power',
  'Desert Resistance', 'Forest Resistance', 'Lakes Resistance', 'Jungle Resistance', 'Prime Roots Resistance');

  _MAT_COLOR : array [0..8] of String = ('unknown', 'beige', 'black', 'blue', 'green', 'purple', 'red', 'turquoise', 'white');

  _ITEM_CLASS : array [0..4] of String = ('base', 'fine', 'choice', 'excellent', 'supreme');

  _EXPR_NATURAL_MAT = '^m\d{4}dxa([pcdflj])([b-f])01\.sitem';
  _EXPR_ANIMAL_MAT = '^m\d{4}.{3}([pcdflj])([a-e])01\.sitem';
  _EXPR_TOOL = '^(icoka[rm]t|sfxitforage|it).*\.sitem';
  _EXPR_EQUIPMENT = '^ic(.).*(.{2})\.sitem';
  _EXPR_EQUIPMENT_ARMOR = '^ic.a([lmhc]).*';
  _EXPR_EQUIPMENT_ARMOR_DRESS = 'ika[rm]acp_ep';
  _EXPR_EQUIPMENT_SHIELD = '^ic(.|ka[rm])s([bs]).*';
  _EXPR_EQUIPMENT_AMPLIFIER = '^ic.+m2ms.*';
  _EXPR_EQUIPMENT_WEAPON = '^ic.+([rm])([12])(.{2}).*';
  _EXPR_EQUIPMENT_AMMO = '^ic.p([12][ablpr]).*\.sitem';
  _EXPR_EQUIPMENT_JEWEL = '^ic.j.*';
  
type
  TItemType =(itAnimalMat, itNaturalMat, itCata, itEquipment, itTool, itOthers);
  TItemTypes = set of TItemType;
  TItemClass = (icBasic, icFine, icChoice, icExcellent, icSupreme, icUnknown);
  TItemEcosystem = (ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes, ieUnknown);
  TItemEcosystems = set of TItemEcosystem;
  TItemEquip = (iqLightArmor, iqMediumArmor, iqHeavyArmor, iqWeaponMelee, iqWeaponRange, iqAmplifier, iqJewel, iqBuckler, iqShield, iqAmmo, iqOthers);
  TItemWeapon = (iwOneHand, iwTwoHands);
  TItemSkin = (isSkin1, isSkin2, isSkin3, isNoSkin);
  TItemEquips = set of TItemEquip;

  TItemFilter = record
    Enabled: Boolean;
    Type_: TItemTypes;
    QualityMin: Integer;
    QualityMax: Integer;
    ClassMin: TItemClass;
    ClassMax: TItemClass;
    Ecosystem: TItemEcosystems;
    ItemName: String;
    AllWords: Boolean;
    Equipment: TItemEquips;
    CategoryIndex: Integer;
  end;
  
  TItemInfo = class(TObject)
  public
    ItemName: String;
    ItemColor: TItemColor;
    ItemQuality: Integer;
    ItemSize: Integer;
    ItemSap: Integer;
    ItemDestroyed: Boolean;
    ItemFileName: String;
    ItemClass: TItemClass;
    ItemType: TItemType;
    ItemEcosys: TItemEcosystem;
    ItemEquip: TItemEquip;
    ItemCategory1: Integer;
    ItemCategory2: Integer;
    ItemWeapon: TItemWeapon;
    ItemSkin: TItemSkin;
    ItemDesc: String;
    ItemHp: Integer;
    ItemDur: Integer;
    ItemHpb: Integer;
    ItemSab: Integer;
    ItemStb: Integer;
    ItemFob: Integer;
    ItemVolume: Double;
    ItemPrice: Double;
    ItemQuantity: Integer;
    ItemContinent: String;
    ItemTime: TDateTime;
    MatColor1: Integer;
    MatColor2: Integer;
    MatColor3: Integer;
    MatSpec1: array of array [0..1] of Integer;
    MatSpec2: array of array [0..1] of Integer;

    destructor Destroy; override;
  end;

  TRyzom = class(TRyzomApi)
  private
    FXmlDocument: TXpObjModel;
    FCatStrings: TStringList;
    FRegExpr: TRegExpr;

    FAniroStatus: Integer;
    FArispotleStatus: Integer;
    FLeanonStatus: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure UpdateStatus;
    procedure GetItemInfoFromXML(ANode: TXpNode; AItemInfo: TItemInfo);
    function  CheckItem(AItemInfo: TItemInfo; AFilter: TItemFilter): Boolean;
    procedure GetItemInfoFromName(AItemInfo: TItemInfo);
    procedure SetDefaultFilter(var AFilter: TItemFilter);
    
    property AniroStatus: Integer read FAniroStatus;
    property LeanonStatus: Integer read FLeanonStatus;
    property ArispotleStatus: Integer read FArispotleStatus;
  end;

  function GetSpecName(AIndex: Integer): String;
  function GetCatName(AIndex: Integer): String;
  function GetColorName(AIndex: Integer): String;
  function GetClassName(AIndex: Integer): String;

var
  GRyzomApi: TRyzom;
  GRyzomStringPack: TStringClient;
  GRegExpr: TRegExpr;
  GCurrentFilter: TItemFilter;

implementation

uses MisuDevKit, Math;

{*******************************************************************************
Returns the specification name
*******************************************************************************}
function GetSpecName(AIndex: Integer): String;
begin
  case AIndex of
    0: Result := '-';
    1: Result := RS_SPEC_DURABILITY;
    2: Result := RS_SPEC_LIGHTNESS;
    3: Result := RS_SPEC_SAPLOAD;
    4: Result := RS_SPEC_DAMAGE;
    5: Result := RS_SPEC_SPEED;
    6: Result := RS_SPEC_RANGE;
    7: Result := RS_SPEC_DODGE_MODIFIER;
    8: Result := RS_SPEC_PARRY_MODIFIER;
    9: Result := RS_SPEC_ADV_DODGE_MODIFIER;
    10: Result := RS_SPEC_ADV_PARRY_MODIFIER;
    11: Result := RS_SPEC_PROTEC_FACTOR;
    12: Result := RS_SPEC_MAX_SLASH_PROTEC;
    13: Result := RS_SPEC_MAX_SMASH_PROTEC;
    14: Result := RS_SPEC_MAX_PIERC_PROTEC;
    15: Result := RS_SPEC_ACID_PROTEC;
    16: Result := RS_SPEC_COLD_PROTEC;
    17: Result := RS_SPEC_ROT_PROTEC;
    18: Result := RS_SPEC_FIRE_PROTEC;
    19: Result := RS_SPEC_SHOCK_PROTEC;
    20: Result := RS_SPEC_POISON_PROTEC;
    21: Result := RS_SPEC_ELEC_PROTEC;
    22: Result := RS_SPEC_ELE_CAST_SPEED;
    23: Result := RS_SPEC_ELE_POWER;
    24: Result := RS_SPEC_OFFAFF_CAST_SPEED;
    25: Result := RS_SPEC_OFFAFF_POWER;
    26: Result := RS_SPEC_DEFAFF_CAST_SPEED;
    27: Result := RS_SPEC_DEFAFF_POWER;
    28: Result := RS_SPEC_HEAL_CAST_SPEED;
    29: Result := RS_SPEC_HEAL_POWER;
    30: Result := RS_SPEC_DESERT_RESIST;
    31: Result := RS_SPEC_FOREST_RESIST;
    32: Result := RS_SPEC_LAKES_RESIST;
    33: Result := RS_SPEC_JUNGLE_RESIST;
    34: Result := RS_SPEC_PRIME_RESIST;
  end;
end;

{*******************************************************************************
Returns the category name
*******************************************************************************}
function GetCatName(AIndex: Integer): String;
begin
  case AIndex of
    0: Result := '-';
    1: Result := RS_CAT_BLADE;
    2: Result := RS_CAT_POINT;
    3: Result := RS_CAT_HAMMER;
    4: Result := RS_CAT_COUNTERWEIGHT;
    5: Result := RS_CAT_SHAFT;
    6: Result := RS_CAT_AMMOBULLET;
    7: Result := RS_CAT_BARREL;
    8: Result := RS_CAT_ARMORSHELL;
    9: Result := RS_CAT_AMMOJACKET;
    10: Result := RS_CAT_LINING;
    11: Result := RS_CAT_EXPLOSIVE;
    12: Result := RS_CAT_STUFFING;
    13: Result := RS_CAT_FIRINGPIN;
    14: Result := RS_CAT_ARMORCLIP;
    15: Result := RS_CAT_TRIGGER;
    16: Result := RS_CAT_JEWELSETTING;
    17: Result := RS_CAT_GRIP;
    18: Result := RS_CAT_CLOTHES;
    19: Result := RS_CAT_JEWEL;
    20: Result := RS_CAT_MAGICFOCUS;
  end;
end;

{*******************************************************************************
Returns the color name
*******************************************************************************}
function GetColorName(AIndex: Integer): String;
begin
  case AIndex of
    0: Result := '-';
    1: Result := RS_COLOR_BEIGE;
    2: Result := RS_COLOR_BLACK;
    3: Result := RS_COLOR_BLUE;
    4: Result := RS_COLOR_GREEN;
    5: Result := RS_COLOR_PURPLE;
    6: Result := RS_COLOR_RED;
    7: Result := RS_COLOR_TURQUOISE;
    8: Result := RS_COLOR_WHITE;
  end;
end;

{*******************************************************************************
Returns the class name
*******************************************************************************}
function GetClassName(AIndex: Integer): String;
begin
  case AIndex of
    0: Result := RS_CLASS_BASE;
    1: Result := RS_CLASS_FINE;
    2: Result := RS_CLASS_CHOICE;
    3: Result := RS_CLASS_EXCELLENT;
    4: Result := RS_CLASS_SUPREME;
  end;
end;

{ TRyzom }

{*******************************************************************************
Creates the interface object
*******************************************************************************}
constructor TRyzom.Create;
var
  wCatFile: String;
begin
  inherited Create;
  FXmlDocument := TXpObjModel.Create(nil);
  FCatStrings := TStringList.Create;
  wCatFile := GConfig.CurrentPath + 'category.csv';
  if FileExists(wCatFile) then
    FCatStrings.LoadFromFile(wCatFile);
  FRegExpr := TRegExpr.Create;
  FRegExpr.ModifierG := False;
end;

{*******************************************************************************
Destroys the interface object
*******************************************************************************}
destructor TRyzom.Destroy;
begin
  FRegExpr.Free;
  FCatStrings.Free;
  FXmlDocument.Free;
  inherited;
end;

{*******************************************************************************
Returns information of an item
*******************************************************************************}
procedure TRyzom.GetItemInfoFromXML(ANode: TXpNode; AItemInfo: TItemInfo);
var
  wNode: TXpNode;
begin
  // Default values
  AItemInfo.ItemColor := icNone;
  AItemInfo.ItemQuality := -1;
  AItemInfo.ItemSize := -1;
  AItemInfo.ItemSap := -1;
  AItemInfo.ItemDestroyed := False;
  AItemInfo.ItemClass := icUnknown;
  AItemInfo.ItemHp := 0;
  AItemInfo.ItemPrice := 0;
  AItemInfo.ItemQuantity := 1;
  
  // Name
  AItemInfo.ItemName := ANode.Text;

  // Color
  wNode := ANode.Attributes.GetNamedItem('c');
  if Assigned(wNode) then AItemInfo.ItemColor := ToItemColor(wNode.NodeValue);

  // Quality
  wNode := ANode.Attributes.GetNamedItem('q');
  if Assigned(wNode) then AItemInfo.ItemQuality := StrToInt(wNode.NodeValue);

  // Size
  wNode := ANode.Attributes.GetNamedItem('s');
  if Assigned(wNode) then AItemInfo.ItemSize := StrToInt(wNode.NodeValue);

  // Sap load
  wNode := ANode.Attributes.GetNamedItem('sap');
  if Assigned(wNode) then AItemInfo.ItemSap := StrToInt(wNode.NodeValue);

  // Destroyed / HP
  wNode := ANode.Attributes.GetNamedItem('hp');
  if Assigned(wNode) then begin
    AItemInfo.ItemHp := StrToInt(wNode.NodeValue);
    AItemInfo.ItemDestroyed := AItemInfo.ItemHp <= 1;
  end;

  // Durability
  wNode := ANode.Attributes.GetNamedItem('dur');
  if Assigned(wNode) then AItemInfo.ItemDur := StrToInt(wNode.NodeValue);

  // HP Bonus
  wNode := ANode.Attributes.GetNamedItem('hpb');
  if Assigned(wNode) then AItemInfo.ItemHpb := StrToInt(wNode.NodeValue);

  // Sap Bonus
  wNode := ANode.Attributes.GetNamedItem('sab');
  if Assigned(wNode) then AItemInfo.ItemSab := StrToInt(wNode.NodeValue);

  // Stamina Bonus
  wNode := ANode.Attributes.GetNamedItem('stb');
  if Assigned(wNode) then AItemInfo.ItemStb := StrToInt(wNode.NodeValue);

  // Focus Bonus
  wNode := ANode.Attributes.GetNamedItem('fob');
  if Assigned(wNode) then AItemInfo.ItemFob := StrToInt(wNode.NodeValue);

  // Energy
  wNode := ANode.Attributes.GetNamedItem('e');
  if Assigned(wNode) then begin
    case Ord(wNode.NodeValue[1]) of
      98:  AItemInfo.ItemClass := icBasic; {b = base}
      102: AItemInfo.ItemClass := icFine; {f = fine}
      99:  AItemInfo.ItemClass := icChoice; {c = choice}
      101: AItemInfo.ItemClass := icExcellent; {e = excelent}
      115: AItemInfo.ItemClass := icSupreme; {s = supreme}
    end;
  end;

  // Continent
  wNode := ANode.Attributes.GetNamedItem('continent');
  if Assigned(wNode) then AItemInfo.ItemContinent := wNode.NodeValue;
  AItemInfo.ItemContinent := UpperCase(LeftStr(AItemInfo.ItemContinent, 1)) +
    RightStr(AItemInfo.ItemContinent, Length(AItemInfo.ItemContinent)-1);

  // Price
  wNode := ANode.Attributes.GetNamedItem('price');
  if Assigned(wNode) then AItemInfo.ItemPrice := StrToFloat(wNode.NodeValue);

  // Quantity
  wNode := ANode.Attributes.GetNamedItem('quantity');
  if Assigned(wNode) then begin
    AItemInfo.ItemQuantity := StrToInt(wNode.NodeValue);
    AItemInfo.ItemSize := AItemInfo.ItemQuantity;
  end;

  // Since
  wNode := ANode.Attributes.GetNamedItem('in_sell_since');
  if Assigned(wNode) then AItemInfo.ItemTime := IncHour(IncDay(UnixToDateTime(StrToInt64(wNode.NodeValue)), 7), 2);

  // Image filename
  AItemInfo.ItemFileName := Format('%s.c%dq%ds%dd%d%s',
    [AItemInfo.ItemName, Ord(AItemInfo.ItemColor), AItemInfo.ItemQuality, AItemInfo.ItemSize,
    MdkBoolToInteger(AItemInfo.ItemDestroyed), _ICON_FORMAT]);
end;

{*******************************************************************************
Updates status of the servers
*******************************************************************************}
procedure TRyzom.UpdateStatus;
var
  wResponse: TMemoryStream;
  wXpath: String;
begin
  wResponse := TMemoryStream.Create();
  try
    ApiStatus(_FORMAT_XML, wResponse);
    if FXmlDocument.LoadStream(wResponse) then begin
      wXpath := '/shard_status/shard[@shardid=''%s'']';
      FAniroStatus := FXmlDocument.DocumentElement.SelectInteger(Format(wXpath, [_SHARD_ANIRO_ID]));
      FLeanonStatus := FXmlDocument.DocumentElement.SelectInteger(Format(wXpath, [_SHARD_LEANON_ID]));
      FArispotleStatus := FXmlDocument.DocumentElement.SelectInteger(Format(wXpath, [_SHARD_ARIPOTLE_ID]));
    end;
  finally
    wResponse.Free;
  end;
end;

{*******************************************************************************
Sets the default filter for items
*******************************************************************************}
procedure TRyzom.SetDefaultFilter(var AFilter: TItemFilter);
begin
  AFilter.Enabled := True;
  AFilter.Type_ := [itAnimalMat, itNaturalMat, itCata, itEquipment, itTool, itOthers];
  AFilter.QualityMin := _MIN_QUALITY;
  AFilter.QualityMax := _MAX_QUALITY;
  AFilter.ClassMin := icBasic;
  AFilter.ClassMax := icSupreme;
  AFilter.Ecosystem := [ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes];
  AFilter.ItemName := '';
  AFilter.AllWords := True;
  AFilter.Equipment := [iqLightArmor, iqMediumArmor, iqHeavyArmor, iqWeaponMelee, iqWeaponRange, iqJewel, iqAmplifier, iqBuckler, iqShield, iqAmmo, iqOthers];
  AFilter.CategoryIndex := 0;
end;

{*******************************************************************************
Returns information about an item from the item name
*******************************************************************************}
procedure TRyzom.GetItemInfoFromName(AItemInfo: TItemInfo);
var
  wIndex: Integer;
  wCoef: Double;
  wFound: Boolean;
  i: Integer;
begin
  wCoef := 0.0;
  AItemInfo.ItemType := itOthers;
  AItemInfo.ItemEcosys := ieUnknown;
  AItemInfo.ItemSkin := isNoSkin;

  // Catalyzer
  if Pos('ixpca01', AItemInfo.ItemName) = 1 then begin
    AItemInfo.ItemType := itCata;
    wCoef := 0.01;
  end;

  // Tool
  if AItemInfo.ItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_TOOL;
    if GRegExpr.Exec(AItemInfo.ItemName) and (Pos('item_sap_recharge', AItemInfo.ItemName) <> 1) then begin
      AItemInfo.ItemType := itTool;
      wCoef := 10.0;
    end;
  end;
  
  // Equipment
  if AItemInfo.ItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_EQUIPMENT;
    if GRegExpr.Exec(AItemInfo.ItemName) then begin
      AItemInfo.ItemType := itEquipment;
      case Ord(GRegExpr.Match[1][1]) of
        116: AItemInfo.ItemEcosys := ieLakes; {t = tryker}
        102: AItemInfo.ItemEcosys := ieDesert; {f = fyros}
        109: AItemInfo.ItemEcosys := ieForest; {m = matis}
        122: AItemInfo.ItemEcosys := ieJungle; {z = zorai}
      else
        AItemInfo.ItemEcosys := ieCommon;
      end;

      AItemInfo.ItemSkin := isSkin1;
      case Ord(GRegExpr.Match[2][2]) of
        50: AItemInfo.ItemSkin := isSkin2; {2 = skin2}
        51: AItemInfo.ItemSkin := isSkin3; {3 = skin3}
      end;

      AItemInfo.ItemEquip := iqOthers;
    
      // Shield
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_SHIELD;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          case Ord(GRegExpr.Match[2][1]) of
            98: begin {b = buckler}
              AItemInfo.ItemEquip := iqBuckler;
              wCoef := 5.0;
            end;
            115: begin {s = shield}
              AItemInfo.ItemEquip := iqShield;
              wCoef := 10.0;
            end;
          end;
        end;
      end;

      // Armor
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_ARMOR;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          case Ord(GRegExpr.Match[1][1]) of
            108: AItemInfo.ItemEquip := iqLightArmor; {l = light}
            99: AItemInfo.ItemEquip := iqLightArmor; {c = light}
            109: AItemInfo.ItemEquip := iqMediumArmor; {m = medium}
            104: AItemInfo.ItemEquip := iqHeavyArmor; {h = heavy}
          end;
          wCoef := 7.0;
          if Pos('iccah', AItemInfo.ItemName) = 1 then wCoef := 20.0 // boss
        end;
      end;

      // Amplifier
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_AMPLIFIER;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          AItemInfo.ItemEquip := iqAmplifier;
          wCoef := 10;
        end;
      end;

      // Weapon
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_WEAPON;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          case Ord(GRegExpr.Match[1][1]) of
            109: begin {m = melee}
              AItemInfo.ItemEquip := iqWeaponMelee;
              case Ord(GRegExpr.Match[2][1]) of
                // 1 = 1 hand
                49: begin
                  AItemInfo.ItemWeapon := iwOneHand;
                  wCoef := 10.0;
                  if GRegExpr.Match[3] = 'pd' then wCoef := 5.0; // dagger
                end;
                // 2 = 2 hands
                50: begin
                  AItemInfo.ItemWeapon := iwTwoHands; 
                  wCoef := 15.0;
                end;
              end;
            end;
            114: begin {r = range}
              AItemInfo.ItemEquip := iqWeaponRange;
              case Ord(GRegExpr.Match[2][1]) of
                // 1 = 1 hand
                49: begin
                  AItemInfo.ItemWeapon := iwOneHand;
                  wCoef := 10.0;
                end;
                // 2 = 2 hands
                50: begin
                  AItemInfo.ItemWeapon := iwTwoHands;
                  case Ord(GRegExpr.Match[3][1]) of
                    97: wCoef := 30.0; // machine gun
                    98, 114: wCoef := 15.0; // rifles
                    108: wCoef := 30.0; // grenade launcher
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      // Ammo
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_AMMO;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          AItemInfo.ItemEquip := iqAmmo;
          case Ord(GRegExpr.Match[1][1]) of
            49: wCoef := 0.04; // pistols
            50: begin
              case Ord(GRegExpr.Match[1][2]) of
                97: wCoef := 5.0; // machine gun
                98, 114: wCoef := 0.1; // rifles
                108: wCoef := 15.0; // grenade launcher
              end;
            end;
          end;
        end;
      end;

      // Jewel
      if AItemInfo.ItemEquip = iqOthers then begin
        GRegExpr.Expression := _EXPR_EQUIPMENT_JEWEL;
        if GRegExpr.Exec(AItemInfo.ItemName) then begin
          AItemInfo.ItemEquip := iqJewel;
          wCoef := 2.0;
        end;
      end;

      // Others
      if AItemInfo.ItemEquip = iqOthers then begin
        if Pos('icra', AItemInfo.ItemName) = 1 then wCoef := 7.0; // refugee
        if Pos('ic_candy_stick', AItemInfo.ItemName) = 1 then wCoef := 30.0;
      end;
    end;
  end;

  // Natural materials
  if AItemInfo.ItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_NATURAL_MAT;
    if GRegExpr.Exec(AItemInfo.ItemName) then begin
      AItemInfo.ItemType := itNaturalMat;
      wCoef := 0.5;
    end;
  end;

  // Animal materials
  if AItemInfo.ItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_ANIMAL_MAT;
    if GRegExpr.Exec(AItemInfo.ItemName) then begin
      AItemInfo.ItemType := itAnimalMat;
      wCoef := 0.5;
    end;
  end;

  // Natural and Animal
  if (AItemInfo.ItemType = itNaturalMat) or (AItemInfo.ItemType = itAnimalMat) then begin
    // Categories
    AItemInfo.ItemCategory1 := 0;
    AItemInfo.ItemCategory2 := 0;
    AItemInfo.MatColor1 := 0;
    AItemInfo.MatColor2 := 0;
    AItemInfo.MatColor3 := 0;
    wIndex := FCatStrings.IndexOfName(Copy(AItemInfo.ItemName, 1, 5));
    if wIndex >= 0 then begin
      AItemInfo.ItemCategory1 := StrToInt(Copy(FCatStrings.ValueFromIndex[wIndex], 1, 2));
      AItemInfo.ItemCategory2 := StrToInt(Copy(FCatStrings.ValueFromIndex[wIndex+1], 1, 2));
      AItemInfo.MatColor1 := StrToInt(FCatStrings.ValueFromIndex[wIndex][3]);
      AItemInfo.MatColor2 := StrToInt(FCatStrings.ValueFromIndex[wIndex][4]);
      AItemInfo.MatColor3 := StrToInt(FCatStrings.ValueFromIndex[wIndex][5]);

      // Specifications for category 1
      FRegExpr.InputString := FCatStrings.ValueFromIndex[wIndex];
      FRegExpr.Expression := '(\d\d)(\d)';
      i := 0;
      wFound := FRegExpr.Exec(6);
      while wFound do begin
        Inc(i);
        SetLength(AItemInfo.MatSpec1, i);
        AItemInfo.MatSpec1[i-1][0] := StrToInt(FRegExpr.Match[1]);
        AItemInfo.MatSpec1[i-1][1] := StrToInt(FRegExpr.Match[2]);
        wFound := FRegExpr.ExecNext;
      end;

      // Specifications for category 2
      FRegExpr.InputString := FCatStrings.ValueFromIndex[wIndex+1];
      FRegExpr.Expression := '(\d\d)(\d)';
      i := 0;
      wFound := FRegExpr.Exec(6);
      while wFound do begin
        Inc(i);
        SetLength(AItemInfo.MatSpec2, i);
        AItemInfo.MatSpec2[i-1][0] := StrToInt(FRegExpr.Match[1]);
        AItemInfo.MatSpec2[i-1][1] := StrToInt(FRegExpr.Match[2]);
        wFound := FRegExpr.ExecNext;
      end;
    end;

    // Ecosystem
    case Ord(GRegExpr.Match[1][1]) of
      99: AItemInfo.ItemEcosys := ieCommon; {c}
      112: AItemInfo.ItemEcosys := iePrime; {p}
      100: AItemInfo.ItemEcosys := ieDesert; {d}
      102: AItemInfo.ItemEcosys := ieForest; {f}
      108: AItemInfo.ItemEcosys := ieLakes; {l}
      106: AItemInfo.ItemEcosys := ieJungle; {j}
    end;
  end;

  // Natural
  if AItemInfo.ItemType = itNaturalMat then begin
    case Ord(GRegExpr.Match[2][1]) of
      98: AItemInfo.ItemClass := icBasic; {b}
      99: AItemInfo.ItemClass := icFine; {c}
      100: AItemInfo.ItemClass := icChoice; {d}
      101: AItemInfo.ItemClass := icExcellent; {e}
      102: AItemInfo.ItemClass := icSupreme; {f}
    end;
  end;

  // Animal
  if AItemInfo.ItemType = itAnimalMat then begin
    case Ord(GRegExpr.Match[2][1]) of
      97: AItemInfo.ItemClass := icBasic; {a}
      98: AItemInfo.ItemClass := icFine; {b}
      99: AItemInfo.ItemClass := icChoice; {c}
      100: AItemInfo.ItemClass := icExcellent; {d}
      101: AItemInfo.ItemClass := icSupreme; {e}
    end;
  end;

  // Others
  if AItemInfo.ItemType = itOthers then begin
    if Pos('pre_order', AItemInfo.ItemName) = 1 then wCoef := 5.0;
    if Pos('tp_', AItemInfo.ItemName) = 1 then wCoef := 0.2; // teleporter
    if Pos('teddyubo', AItemInfo.ItemName) = 1 then wCoef := 5.0;
    if Pos('louche', AItemInfo.ItemName) = 1 then wCoef := 5.0;
    if Pos('ipoc_', AItemInfo.ItemName) = 1 then wCoef := 1.0; // flower
    if Pos('ipm', AItemInfo.ItemName) = 1 then wCoef := 1.0; // egg
    if Pos('ipk_', AItemInfo.ItemName) = 1 then wCoef := 1.0; // potion
    if Pos('if1', AItemInfo.ItemName) = 1 then wCoef := 50.0; // food basic
    if Pos('if2', AItemInfo.ItemName) = 1 then wCoef := 20.0; // food concentrated
    if Pos('if3', AItemInfo.ItemName) = 1 then wCoef := 30.0; // food small

    // Kara/Kami dress
    GRegExpr.Expression := _EXPR_EQUIPMENT_ARMOR_DRESS;
    if GRegExpr.Exec(AItemInfo.ItemName) then begin
      AItemInfo.ItemType := itEquipment;
      AItemInfo.ItemEquip := iqLightArmor;
      AItemInfo.ItemEcosys := ieCommon;
      wCoef := 7.0;
    end;
  end;

  // Volume
  AItemInfo.ItemVolume := wCoef * Abs(AItemInfo.ItemSize);
end;

{*******************************************************************************
Verifies if the item respects the filter
*******************************************************************************}
function TRyzom.CheckItem(AItemInfo: TItemInfo; AFilter: TItemFilter): Boolean;
var
  wList: TStringList;
  wFound: Boolean;
  wCatIndex1: Integer;
  wCatIndex2: Integer;
  i: Integer;
begin
  Result := False;

  // If not type then Exit
  if AFilter.Type_ = [] then Exit;

  // Quality
  if (AItemInfo.ItemQuality < AFilter.QualityMin) or (AItemInfo.ItemQuality > AFilter.QualityMax) then Exit;

  // If the name does not match
  if AFilter.ItemName <> '' then begin
    wList := TStringList.Create;
    try
      wList.CommaText := MdkRemoveAccents(AFilter.ItemName);
      AItemInfo.ItemDesc := MdkRemoveAccents(AItemInfo.ItemDesc);
      wFound := AFilter.AllWords;
      i := 0;
      while (i < wList.Count) do begin
        if AFilter.AllWords then
          wFound := wFound and (Pos(UpperCase(wList[i]), UpperCase(AItemInfo.ItemDesc)) > 0)
        else
          wFound := wFound or (Pos(UpperCase(wList[i]), UpperCase(AItemInfo.ItemDesc)) > 0);
        Inc(i);
      end;
      if not wFound then Exit;
    finally
      wList.Free;
    end;
  end;

  // Type
  if not (AItemInfo.ItemType in AFilter.Type_) then Exit;

  // Materials and equipment
  if AItemInfo.ItemType in [itAnimalMat, itNaturalMat, itEquipment] then begin
    // Ecosystem
    if not (AItemInfo.ItemEcosys in AFilter.Ecosystem) then Exit;

    // Class
    if (Ord(AItemInfo.ItemClass) < Ord(AFilter.ClassMin)) or (Ord(AItemInfo.ItemClass) > Ord(AFilter.ClassMax)) then Exit;

  end;
  
  // Item category (only materials)
  if AItemInfo.ItemType in [itAnimalMat, itNaturalMat] then begin
    if (AFilter.CategoryIndex > 0) and (Pos('m0312', AItemInfo.ItemName) = 0) {larva} then begin
      wCatIndex1 := AItemInfo.ItemCategory1;
      wCatIndex2 := AItemInfo.ItemCategory2;
      if (wCatIndex1 <> AFilter.CategoryIndex) and (wCatIndex2 <> AFilter.CategoryIndex) then Exit;
    end;
  end;
  
  // Item equipment
  if AItemInfo.ItemType = itEquipment then begin
    if AFilter.Equipment = [] then Exit;
    if not (AItemInfo.ItemEquip in AFilter.Equipment) then Exit;
  end;

  Result := True;
end;

{ TItemInfo }

destructor TItemInfo.Destroy;
begin
  SetLength(MatSpec1, 0);
  SetLength(MatSpec2, 0);
  inherited;
end;

end.
