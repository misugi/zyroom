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
unit UnitRyzom;

interface

uses
  Classes, SysUtils, RyzomApi, XpDOM, regexpr, UnitConfig, StrUtils, DateUtils,
  Contnrs;

resourcestring
  RS_SPEC_DURABILITY = 'Durabilit�';
  RS_SPEC_LIGHTNESS = 'L�geret�';
  RS_SPEC_SAPLOAD = 'Charge en s�ve';
  RS_SPEC_DAMAGE = 'D�g�ts';
  RS_SPEC_SPEED = 'Vitesse';
  RS_SPEC_RANGE = 'Port�e';
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
  RS_SPEC_ELEC_PROTEC = 'Protection �lectricit�';
  RS_SPEC_ELE_CAST_SPEED = 'Vitesse magie �l�mentaire';
  RS_SPEC_ELE_POWER = 'Puissance magie �l�mentaire';
  RS_SPEC_OFFAFF_CAST_SPEED = 'Vitesse magie d�bilitante';
  RS_SPEC_OFFAFF_POWER = 'Puissance magie d�bilitante';
  RS_SPEC_DEFAFF_CAST_SPEED = 'Vitesse magie neutralisante';
  RS_SPEC_DEFAFF_POWER = 'Puissance magie neutralisante';
  RS_SPEC_HEAL_CAST_SPEED = 'Vitesse magie curative';
  RS_SPEC_HEAL_POWER = 'Puissance magie curative';
  RS_SPEC_DESERT_RESIST = 'R�sistance d�sert';
  RS_SPEC_FOREST_RESIST = 'R�sistance for�t';
  RS_SPEC_LAKES_RESIST = 'R�sistance lacs';
  RS_SPEC_JUNGLE_RESIST = 'R�sistance jungle';
  RS_SPEC_PRIME_RESIST = 'R�sistance primes racines';
  RS_SPEC_ALL = 'Toute caract�ristique';
  RS_CAT_BLADE = 'Lame';
  RS_CAT_POINT = 'Pointe';
  RS_CAT_HAMMER = 'Marteau';
  RS_CAT_COUNTERWEIGHT = 'Contrepoids';
  RS_CAT_SHAFT = 'Fl�che';
  RS_CAT_AMMOBULLET = 'Balle de munitions';
  RS_CAT_BARREL = 'Canon';
  RS_CAT_ARMORSHELL = 'Carapace pour armures';
  RS_CAT_AMMOJACKET = 'Cartouche de munitions';
  RS_CAT_LINING = 'Doublure';
  RS_CAT_EXPLOSIVE = 'Explosif';
  RS_CAT_STUFFING = 'Rembourrage';
  RS_CAT_FIRINGPIN = 'Percuteur';
  RS_CAT_ARMORCLIP = 'Fixation pour armures';
  RS_CAT_TRIGGER = 'D�tente';
  RS_CAT_JEWELSETTING = 'Configuration des bijoux';
  RS_CAT_GRIP = 'Prise';
  RS_CAT_CLOTHES = 'V�tements';
  RS_CAT_JEWEL = 'Bijou';
  RS_CAT_MAGICFOCUS = 'Concentration magique';
  RS_CAT_ALL = 'Toute cat�gorie';
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
  RS_CLASS_SUPREME = 'Supr�me';
  RS_RACE_ALL = 'Toute race';
  RS_RACE_FYROS = 'Fyros';
  RS_RACE_ZORAI = 'Zora�';
  RS_RACE_TRYKER = 'Tryker';
  RS_RACE_MATIS = 'Matis';
  RS_ECOSYS_COMMON = 'Commun';
  RS_ECOSYS_PRIME = 'Primes racines';
  RS_ECOSYS_DESERT = 'D�sert';
  RS_ECOSYS_JUNGLE = 'Jungle';
  RS_ECOSYS_FOREST = 'For�t';
  RS_ECOSYS_LAKES = 'Lacs';
  RS_VOLUME = 'Volume';
  RS_DAPPERS = 'Dappers';
  RS_MENU_WATCH = 'Surveiller';
  RS_MENU_UNWATCH = 'Ne plus surveiller';
  RS_TAB_ROOM = 'Pi�ce';
  RS_TAB_BAG = 'Sac';
  RS_TAB_MEKTOUB = 'Mektoub';
  RS_TAB_MOUNT = 'Monture';
  RS_TAB_ZIG = 'Zig';
  RS_TAB_SHOP = 'Ventes';
  RS_DAYS = 'jours';
  RS_HOURS = 'heures';
  RS_MINUTES = 'minutes';
  RS_AND = 'et';

const
  _MAT_CATEGORY: array[0..20] of String = ('All', 'Blade', 'Point', 'Hammer', 'Counterweight',
    'Shaft', 'AmmoBullet', 'Barrel', 'ArmorShell', 'AmmoJacket', 'Lining', 'Explosive', 'Stuffing',
    'FiringPin', 'ArmorClip', 'Trigger', 'JewelSettings', 'Grip', 'Clothes', 'Jewel', 'MagicFocus');
  _MAT_SPEC: array[0..34] of String = ('All', 'Durability', 'Lightness',
    'Sap Load', 'Damage', 'Speed', 'Range', 'Dodge Modifier', 'Parry Modifier',
    'Adversary Dodge Modifier', 'Adversary Parry Modifier', 'Protection Factor', 'Max. Slashing Protection',
    'Max. Smashing Protection', 'Max. Piercing Protection', 'Acid Protection', 'Cold Protection',
    'Rot Protection', 'Fire Protection', 'Shockwave Protection', 'Poison Protection', 'Electricity Protection',
    'Elemental Cast Speed', 'Elemental Power', 'Off. Affliction Cast Speed', 'Off. Affliction Power',
    'Def. Affliction Cast Speed', 'Def. Affliction Power', 'Healing Cast Speed', 'Healing Power',
    'Desert Resistance', 'Forest Resistance', 'Lakes Resistance', 'Jungle Resistance', 'Prime Roots Resistance');
  _MAT_COLOR: array[0..8] of String = ('unknown', 'beige', 'black', 'blue',
    'green', 'purple', 'red', 'turquoise', 'white');
  _ITEM_CLASS: array[0..4] of String = ('base', 'fine', 'choice', 'excellent', 'supreme');
  _ITEM_PROTECTIONS: array[0..6] of String = ('acid', 'cold', 'fire', 'rot', 'shockwave', 'poison', 'electricity');
  _ITEM_RESISTANCES: array[0..4] of String = ('desert', 'forest', 'lacustre', 'jungle', 'primaryroot');
  _MAT_GUILD_CHEST: array[0..4] of String = ('mp_hard.sitem', 'mp_soft.sitem',
    'mp_colonne.sitem', 'mp_ornement.sitem', 'mp_revetement.sitem');
  _MAT_JOBS: array[0..3] of String = ('lucky_flower.sitem',
    'protect_amber.sitem', 'water_barrel.sitem', 'tools_ticket.sitem');
  _EXPR_NATURAL_MAT = '^m\d{4}dxa([pcdfljg])([a-f])01\.sitem';
  _EXPR_ANIMAL_MAT = '^m\d{4}.{3}([pcdfljg])([a-f])01\.sitem';
  _EXPR_SYSTEM_MAT = '(system_mp_?|mp_kami_ep2_|mp_karavan_ep2_)(\w*)\.sitem';
  _EXPR_TOOL = '^(ico(kar|kam|mar|gen)t|sfxitforage|it).*\.sitem';
  _EXPR_EQUIPMENT = '^ic(.).*(.{2})\.sitem';
  _EXPR_EQUIPMENT_ARMOR = '^ic.a([lmhcbgpsv]).*';
  _EXPR_EQUIPMENT_SHIELD = '^ic(.|ka[rm])s([bs]).*';
  _EXPR_EQUIPMENT_AMPLIFIER = '^ic.+m2ms.*';
  _EXPR_EQUIPMENT_WEAPON = '^ic.+([rm])([12])(.{2}).*';
  _EXPR_EQUIPMENT_AMMO = '^ic.p([12][ablpr]).*\.sitem';
  _EXPR_EQUIPMENT_JEWEL = '^ic.j.*';
  _EXPR_BANDIT_CHEST = 'compo_.*mark\d\.sitem';

type
  TItemType = (itAnimalMat, itNaturalMat, itSystemMat, itCata, itEquipment, itTeleporter, itOther);

  TItemTypeSet = set of TItemType;

  TItemClass = (icBasic, icFine, icChoice, icExcellent, icSupreme, icUnknown);

  TItemEcosystem = (ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes, ieUnknown);

  TItemEcosystemSet = set of TItemEcosystem;

  TItemEquip = (iqLightArmor, iqMediumArmor, iqHeavyArmor, iqWeaponMelee,
    iqWeaponRange, iqAmplifier, iqJewel, iqBuckler, iqShield, iqTool, iqAmmo, iqOther);

  TItemWeapon = (iwOneHand, iwTwoHands);

  TItemSkin = (isSkin1, isSkin2, isSkin3, isUnknown);

  TItemEquipSet = set of TItemEquip;

  TItemSorting = (ioType, ioEcosys, ioClass, ioQuality, ioVolume, ioQuantity, ioPrice, ioTime);

  TItemBonus = (ibHp, ibSab, ibStamina, ibFocus);

  TItemBonusSet = set of TItemBonus;

  TItemProtection = (ipAcid, ipCold, ipFire, ipRot, ipShockwave, ipPoison, ipElectricity, ipNone);

  TItemResistance = (irDesert, irForest, irLakes, irJungle, irPrime, irNone);

  TCharInvent = (ciBag, ciRoom, ciShop, ciMektoub, ciMount, ciZig, ciPet1,
    ciPet2, ciPet3, ciPet4, ciPet5, ciPet6, ciPet7);

  TGuildChest = (gcChest1, gcChest2, gcChest3, gcChest4, gcChest5, gcChest6,
    gcChest7, gcChest8, gcChest9, gcChest10, gcChest11, gcChest12, gcChest13,
    gcChest14, gcChest15, gcChest16, gcChest17, gcChest18, gcChest19, gcChest20);

  TItemFilter = record
    Enabled: Boolean;
    Type_: TItemTypeSet;
    QualityMin: Integer;
    QualityMax: Integer;
    ClassMin: TItemClass;
    ClassMax: TItemClass;
    Ecosystem: TItemEcosystemSet;
    ItemName: String;
    AllWords: Boolean;
    Equipment: TItemEquipSet;
    CategoryIndex: Integer;
    Continent: String;
    PriceMin: Integer;
    PriceMax: Integer;
    Bonus: TItemBonusSet;
    Sorting: TItemSorting;
    QuantityMin: Integer;
    QuantityMax: Integer;
  end;
  
  //DONE: 5.1 Rajouter l'info locked sur un item et dans ApiItemIcon (anticipation sur l'API item_icon.php qui pourrait bien le supporter)
  TItemInfo = class(TObject)
  public
    ItemSlot: Integer;
    ItemName: String;
    ItemColor: TItemColor;
    ItemQuality: Integer;
    ItemSize: Integer;
    ItemSap: Boolean;
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
    ItemHpb: Integer;
    ItemSab: Integer;
    ItemStb: Integer;
    ItemFob: Integer;
    ItemBonus: Boolean;
    ItemWeight: Double;
    ItemVolume: Double;
    ItemPrice: Double;
    ItemQuantity: Integer;
    ItemContinent: String;
    ItemTime: TDateTime;
    ItemGuarded: Boolean;
    ItemGuardValue: Integer;
    ItemLocked: Boolean;
    MatColor1: Integer;
    MatColor2: Integer;
    MatColor3: Integer;
    MatSpec1: array of array[0..1] of Integer;
    MatSpec2: array of array[0..1] of Integer;
    CDmg: Integer;
    CSpeed: Integer;
    CRange: Integer;
    CDodgeModifier: Integer;
    CParryModifier: Integer;
    CAdvDodgeModifier: Integer;
    CAdvParryModifier: Integer;
    CFactorProt: Double;
    CSlashingProt: Integer;
    CBluntProt: Integer;
    CPiercingProt: Integer;
    BProtect: array[1..3] of TItemProtection;
    BProtectValue: array[1..3] of Integer;
    BResist: array[1..3] of TItemResistance;
    BResistValue: array[1..3] of Double;
    AElementalSpeed: Integer;
    AElementalPower: Integer;
    AOffensiveSpeed: Integer;
    AOffensivePower: Integer;
    AHealSpeed: Integer;
    AHealPower: Integer;
    ADefensiveSpeed: Integer;
    ADefensivePower: Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  TItemList = class(TObjectList)
  public
    function IndexOf(AItemName: String): Integer; overload;
    function IndexOf(AItemSlot: Integer; AItemQuality: Integer; AItemName: String): Integer; overload;
    function GetItem(AItemIndex: Integer): TItemInfo;
  end;

  TRyzom = class(TRyzomApi)
  private
    FXmlDocument: TXpObjModel;
    FCatStrings: TStringList;
    FSheetId: TStringList;
    FServerStatus: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetItemInfoFromXML(ANode: TXpNode; AItemInfo: TItemInfo);
    function CheckItem(AItemInfo: TItemInfo; AFilter: TItemFilter): Boolean;
    procedure GetItemInfoFromName(AItemInfo: TItemInfo);
    function GetSystemMatColor(AItemInfo: TItemInfo): Integer;
    procedure SetDefaultFilter(var AFilter: TItemFilter);
    function GetSheetName(ASheetId: String): String;
    property ServerStatus: Integer read FServerStatus;
  end;

function GetSpecName(AIndex: Integer): String;

function GetCatName(AIndex: Integer): String;

function GetColorName(AIndex: Integer): String; overload;

function GetColorName(AColor: TItemColor): String; overload;

function GetClassName(AIndex: Integer): String;

function GetEcosysName(AIndex: Integer): String;

function GetRaceName(AIndex: Integer): String;

function GetProtectName(AProtect: TItemProtection): String;

function GetResistName(AResist: TItemResistance): String;

var
  GRyzomApi: TRyzom;
  GRyzomStringPack: TStringClient;
  GCurrentFilter: TItemFilter;

implementation

uses
  MisuDevKit, Math;

{*******************************************************************************
Retourne le nom de la protection d'un bijou
*******************************************************************************}
function GetProtectName(AProtect: TItemProtection): String;
begin
  case AProtect of
    ipNone:
      Result := '-';
    ipAcid:
      Result := RS_SPEC_ACID_PROTEC;
    ipCold:
      Result := RS_SPEC_COLD_PROTEC;
    ipFire:
      Result := RS_SPEC_FIRE_PROTEC;
    ipRot:
      Result := RS_SPEC_ROT_PROTEC;
    ipShockwave:
      Result := RS_SPEC_SHOCK_PROTEC;
    ipPoison:
      Result := RS_SPEC_POISON_PROTEC;
    ipElectricity:
      Result := RS_SPEC_ELEC_PROTEC;
  end;
end;

{*******************************************************************************
Retourne le nom de la r�sistance d'un bijou
*******************************************************************************}
function GetResistName(AResist: TItemResistance): String;
begin
  case AResist of
    irNone:
      Result := '-';
    irDesert:
      Result := RS_SPEC_DESERT_RESIST;
    irForest:
      Result := RS_SPEC_FOREST_RESIST;
    irLakes:
      Result := RS_SPEC_LAKES_RESIST;
    irJungle:
      Result := RS_SPEC_JUNGLE_RESIST;
    irPrime:
      Result := RS_SPEC_PRIME_RESIST;
  end;
end;

{*******************************************************************************
Returns the specification name
*******************************************************************************}
function GetSpecName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := RS_SPEC_ALL;
    1:
      Result := RS_SPEC_DURABILITY;
    2:
      Result := RS_SPEC_LIGHTNESS;
    3:
      Result := RS_SPEC_SAPLOAD;
    4:
      Result := RS_SPEC_DAMAGE;
    5:
      Result := RS_SPEC_SPEED;
    6:
      Result := RS_SPEC_RANGE;
    7:
      Result := RS_SPEC_DODGE_MODIFIER;
    8:
      Result := RS_SPEC_PARRY_MODIFIER;
    9:
      Result := RS_SPEC_ADV_DODGE_MODIFIER;
    10:
      Result := RS_SPEC_ADV_PARRY_MODIFIER;
    11:
      Result := RS_SPEC_PROTEC_FACTOR;
    12:
      Result := RS_SPEC_MAX_SLASH_PROTEC;
    13:
      Result := RS_SPEC_MAX_SMASH_PROTEC;
    14:
      Result := RS_SPEC_MAX_PIERC_PROTEC;
    15:
      Result := RS_SPEC_ACID_PROTEC;
    16:
      Result := RS_SPEC_COLD_PROTEC;
    17:
      Result := RS_SPEC_ROT_PROTEC;
    18:
      Result := RS_SPEC_FIRE_PROTEC;
    19:
      Result := RS_SPEC_SHOCK_PROTEC;
    20:
      Result := RS_SPEC_POISON_PROTEC;
    21:
      Result := RS_SPEC_ELEC_PROTEC;
    22:
      Result := RS_SPEC_ELE_CAST_SPEED;
    23:
      Result := RS_SPEC_ELE_POWER;
    24:
      Result := RS_SPEC_OFFAFF_CAST_SPEED;
    25:
      Result := RS_SPEC_OFFAFF_POWER;
    26:
      Result := RS_SPEC_DEFAFF_CAST_SPEED;
    27:
      Result := RS_SPEC_DEFAFF_POWER;
    28:
      Result := RS_SPEC_HEAL_CAST_SPEED;
    29:
      Result := RS_SPEC_HEAL_POWER;
    30:
      Result := RS_SPEC_DESERT_RESIST;
    31:
      Result := RS_SPEC_FOREST_RESIST;
    32:
      Result := RS_SPEC_LAKES_RESIST;
    33:
      Result := RS_SPEC_JUNGLE_RESIST;
    34:
      Result := RS_SPEC_PRIME_RESIST;
  end;
end;

{*******************************************************************************
Returns the category name
*******************************************************************************}
function GetCatName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := RS_CAT_ALL;
    1:
      Result := RS_CAT_BLADE;
    2:
      Result := RS_CAT_POINT;
    3:
      Result := RS_CAT_HAMMER;
    4:
      Result := RS_CAT_COUNTERWEIGHT;
    5:
      Result := RS_CAT_SHAFT;
    6:
      Result := RS_CAT_AMMOBULLET;
    7:
      Result := RS_CAT_BARREL;
    8:
      Result := RS_CAT_ARMORSHELL;
    9:
      Result := RS_CAT_AMMOJACKET;
    10:
      Result := RS_CAT_LINING;
    11:
      Result := RS_CAT_EXPLOSIVE;
    12:
      Result := RS_CAT_STUFFING;
    13:
      Result := RS_CAT_FIRINGPIN;
    14:
      Result := RS_CAT_ARMORCLIP;
    15:
      Result := RS_CAT_TRIGGER;
    16:
      Result := RS_CAT_JEWELSETTING;
    17:
      Result := RS_CAT_GRIP;
    18:
      Result := RS_CAT_CLOTHES;
    19:
      Result := RS_CAT_JEWEL;
    20:
      Result := RS_CAT_MAGICFOCUS;
  end;
end;

{*******************************************************************************
Returns the color name
*******************************************************************************}
function GetColorName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := '-';
    1:
      Result := RS_COLOR_BEIGE;
    2:
      Result := RS_COLOR_BLACK;
    3:
      Result := RS_COLOR_BLUE;
    4:
      Result := RS_COLOR_GREEN;
    5:
      Result := RS_COLOR_PURPLE;
    6:
      Result := RS_COLOR_RED;
    7:
      Result := RS_COLOR_TURQUOISE;
    8:
      Result := RS_COLOR_WHITE;
  end;
end;

{*******************************************************************************
Returns the color name
*******************************************************************************}
function GetColorName(AColor: TItemColor): String;
begin
  case AColor of
    icNone:
      Result := '-';
    icBeige:
      Result := RS_COLOR_BEIGE;
    icBlack:
      Result := RS_COLOR_BLACK;
    icBlue:
      Result := RS_COLOR_BLUE;
    icGreen:
      Result := RS_COLOR_GREEN;
    icPurple:
      Result := RS_COLOR_PURPLE;
    icRed:
      Result := RS_COLOR_RED;
    icTurquoise:
      Result := RS_COLOR_TURQUOISE;
    icWhite:
      Result := RS_COLOR_WHITE;
  end;
end;

{*******************************************************************************
Returns the class name
*******************************************************************************}
function GetClassName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := RS_CLASS_BASE;
    1:
      Result := RS_CLASS_FINE;
    2:
      Result := RS_CLASS_CHOICE;
    3:
      Result := RS_CLASS_EXCELLENT;
    4:
      Result := RS_CLASS_SUPREME;
  end;
end;

{*******************************************************************************
Returns the ecosystem name
*******************************************************************************}
function GetEcosysName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := RS_ECOSYS_COMMON;
    1:
      Result := RS_ECOSYS_PRIME;
    2:
      Result := RS_ECOSYS_DESERT;
    3:
      Result := RS_ECOSYS_JUNGLE;
    4:
      Result := RS_ECOSYS_FOREST;
    5:
      Result := RS_ECOSYS_LAKES;
  end;
end;

{*******************************************************************************
Returns the race name
*******************************************************************************}
function GetRaceName(AIndex: Integer): String;
begin
  case AIndex of
    0:
      Result := RS_RACE_ALL;
    1:
      Result := RS_RACE_ALL;
    2:
      Result := RS_RACE_FYROS;
    3:
      Result := RS_RACE_ZORAI;
    4:
      Result := RS_RACE_MATIS;
    5:
      Result := RS_RACE_TRYKER;
  end;
end;

{ TRyzom }

{*******************************************************************************
Creates the interface object
*******************************************************************************}
constructor TRyzom.Create;
var
  wCatFile: String;
  wIdFile: String;
begin
  inherited Create;
  FXmlDocument := TXpObjModel.Create(nil);
  FCatStrings := TStringList.Create;
  wCatFile := GConfig.CurrentPath + 'category.csv';
  if FileExists(wCatFile) then
    FCatStrings.LoadFromFile(wCatFile);

  FSheetId := TStringList.Create;
  wIdFile := GConfig.CurrentPath + 'sheetid.csv';
  if FileExists(wIdFile) then
    FSheetId.LoadFromFile(wIdFile);
end;

{*******************************************************************************
Destroys the interface object
*******************************************************************************}
destructor TRyzom.Destroy;
begin
  FCatStrings.Free;
  FSheetId.Free;
  FXmlDocument.Free;
  inherited;
end;

{*******************************************************************************
Returns sheet name from sheet id
*******************************************************************************}
function TRyzom.GetSheetName(ASheetId: String): String;
begin
  Result := FSheetId.Values[ASheetId] + '.sitem';
end;

{*******************************************************************************
Returns information of an item
*******************************************************************************}
procedure TRyzom.GetItemInfoFromXML(ANode: TXpNode; AItemInfo: TItemInfo);
var
  wNodeValue: String;
  wEnergy: Double;
  wQuality: Integer;

  // lecture des 3 protections sur les bijoux

  procedure SetProtection;
  var
    wValue: Integer;
    wRealValue: Double;
    wIndex: Integer;
    wProtect: String;
    i: Integer;
  begin
    for i := 1 to 3 do begin
      wProtect := ANode.SelectString(Format('.//craftparameters/protection%d', [i]));
      wIndex := AnsiIndexText(wProtect, _ITEM_PROTECTIONS);
      if wIndex < 0 then
        Continue;

      // ATTENTION la valeur peut �tre stock�e de 2 mani�res diff�rentes
      // <protection2factor value="6">0.815375</protection2factor> // avec la propri�t� value => valeur enti�re
      wNodeValue := ANode.SelectString(Format('.//craftparameters/protection%dfactor/@value', [i]));
      if Length(wNodeValue) > 0 then begin
        wValue := StrToInt(wNodeValue);
        AItemInfo.BProtect[i] := TItemProtection(wIndex);
        AItemInfo.BProtectValue[i] := wValue;
        Continue;
      end;

      // <protection2factor>0.933091</protection2factor> // sans la propri�t� value => calcul requis
      wNodeValue := ANode.SelectString(Format('.//craftparameters/protection%dfactor', [i]));
      if Length(wNodeValue) > 0 then begin
        wRealValue := StrToFloat2(wNodeValue);
        SetRoundMode(rmDown);
        wValue := Round(wRealValue * 8);
        AItemInfo.BProtect[i] := TItemProtection(wIndex);
        AItemInfo.BProtectValue[i] := wValue;
        Continue;
      end;
    end;
  end;

  // lecture des 3 r�sistances sur les bijoux
  procedure SetResistance;
  const
    _NODE_RESISTANCE = 'resistancefactor';
  var
    wNodes: TXpNodeList;
    wValue: Double;
    i, j: Integer;
  begin
    wNodes := ANode.SelectNodes(Format('.//craftparameters/*[contains(name(),''%s'')]', [_NODE_RESISTANCE]));
    try
      // item avec des r�sistances ?
      if wNodes.Length <= 0 then
        Exit;

      // pour chaque r�sistance
      j := 0;
      for i := Low(_ITEM_RESISTANCES) to High(_ITEM_RESISTANCES) do begin
        wNodeValue := ANode.SelectString(Format('.//craftparameters/%sresistancefactor/@value',
          [_ITEM_RESISTANCES[i]]));

        // valeur de r�sistance trouv�e ?
        if Length(wNodeValue) > 0 then begin
          wValue := StrToFloat2(wNodeValue);
          // valeur positive ?
          if wValue > 0 then begin
            Inc(j);
            AItemInfo.BResist[j] := TItemResistance(i);
            AItemInfo.BResistValue[j] := wValue;
          end;
        end;
      end;
    finally
      wNodes.Free;
    end;
  end;

begin
  try
    { ATTENTION
    Certaines informations sont r�cup�r�es avec ".//" car, dans le cas des items en vente (/ryzomapi/character/shop),
    on a un noeud shopitem ET un sous-noeud item (alors que pour les autres on a un seul noeud item avec toutes les infos)
    Cette technique permet d'avoir un seul XPath (commun)
    }
    // Name
    AItemInfo.ItemName := ANode.SelectString('.//sheet');
    if Pos('#', AItemInfo.ItemName) = 1 then
      AItemInfo.ItemName := GetSheetName(AItemInfo.ItemName);

    // Slot
    wNodeValue := ANode.SelectString('@slot');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemSlot := StrToInt(wNodeValue);

    // Color
    wNodeValue := ANode.SelectString('.//craftparameters/color');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemColor := ToItemColor(wNodeValue);

    // pas de couleur dans le XML ?
    if AItemInfo.ItemColor = icNone then begin
      // cas particulier avec l'armure de r�fugi� => couleur selon la 6�me lettre
      if Pos('icra', AItemInfo.ItemName) = 1 then begin
        case Ord(AItemInfo.ItemName[6]) of
          97:
            AItemInfo.ItemColor := icBlack; // a
            101:
            AItemInfo.ItemColor := icBeige; // e
            103:
            AItemInfo.ItemColor := icGreen; // g
            114:
            AItemInfo.ItemColor := icRed; // r
            116:
            AItemInfo.ItemColor := icTurquoise; // t
            117:
            AItemInfo.ItemColor := icBlue; // u
            118:
            AItemInfo.ItemColor := icPurple; // v
            119:
            AItemInfo.ItemColor := icWhite; // w
        end;
      end;
    end;

    // Quality
    wNodeValue := ANode.SelectString('.//quality');
    if Length(wNodeValue) > 0 then begin
      wQuality := StrToInt(wNodeValue);
      // pour �viter d'avoir un "1" inutile sur l'ic�ne de nombreux items (tp par ex.)
      if wQuality = 1 then
        wQuality := 0;
      AItemInfo.ItemQuality := wQuality;
    end;

    // Weight
    wNodeValue := ANode.SelectString('.//craftparameters/weight/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemWeight := StrToFloat2(wNodeValue);

    // Size
    wNodeValue := ANode.SelectString('stack');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemSize := StrToInt(wNodeValue);

    // Locked
    wNodeValue := ANode.SelectString('.//locked');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemLocked := StrToInt(wNodeValue) > 0;

    // Sap load
    // Attention, 2 noeuds sapload:
    // dans craftparameters = max charge de s�ve
    // noeud courant = charge actuelle
    // => mais �a nous indique toujours pas combien de sorts on peut lancer ! (pour r�cup�rer l'icone correspondante)
    // DONC utilisation d'un bool�en juste pour mettre (ou pas) l'icone de charge sans nombre !
    wNodeValue := ANode.SelectString('sapload');
    if (Length(wNodeValue) > 0) then
      // sauf pour les sorts cristallis�s
      if (CompareText(AItemInfo.ItemName, 'crystalized_spell.sitem') <> 0) then
        AItemInfo.ItemSap := True;

    // Destroyed / HP
    wNodeValue := ANode.SelectString('.//hp');
    if Length(wNodeValue) > 0 then begin
      AItemInfo.ItemHp := StrToInt(wNodeValue);
      AItemInfo.ItemDestroyed := AItemInfo.ItemHp = 1;
    end;

    // HP Bonus
    wNodeValue := ANode.SelectString('.//craftparameters/hpbuff');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemHpb := StrToInt(wNodeValue);

    // Sap Bonus
    wNodeValue := ANode.SelectString('.//craftparameters/sapbuff');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemSab := StrToInt(wNodeValue);

    // Stamina Bonus
    wNodeValue := ANode.SelectString('.//craftparameters/stabuff');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemStb := StrToInt(wNodeValue);

    // Focus Bonus
    wNodeValue := ANode.SelectString('.//craftparameters/focusbuff');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemFob := StrToInt(wNodeValue);

    AItemInfo.ItemBonus := (AItemInfo.ItemHpb <> 0) or (AItemInfo.ItemSab <> 0)
      or (AItemInfo.ItemStb <> 0) or (AItemInfo.ItemFob <> 0);

    // Energy
    //DONE : API trouver l'info dans le nouveau XML ? => noeud "statenergy"
    wNodeValue := ANode.SelectString('.//craftparameters/statenergy');
    if Length(wNodeValue) > 0 then begin
      wEnergy := StrToFloat2(wNodeValue);
      wEnergy := RoundTo(wEnergy, -2); // full xl = 0.650001
      if IsLowerOrEqual(wEnergy, 0.2) then
        AItemInfo.ItemClass := icBasic;
      if IsGreater(wEnergy, 0.2) and IsLowerOrEqual(wEnergy, 0.35) then
        AItemInfo.ItemClass := icFine;
      if IsGreater(wEnergy, 0.35) and IsLowerOrEqual(wEnergy, 0.5) then
        AItemInfo.ItemClass := icChoice;
      if IsGreater(wEnergy, 0.5) and IsLowerOrEqual(wEnergy, 0.65) then
        AItemInfo.ItemClass := icExcellent;
      if IsGreater(wEnergy, 0.65) then
        AItemInfo.ItemClass := icSupreme;
    end;

    // Continent
    wNodeValue := ANode.SelectString('continent');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemContinent := wNodeValue;
    AItemInfo.ItemContinent := UpperCase(LeftStr(AItemInfo.ItemContinent, 1)) +
      LowerCase(RightStr(AItemInfo.ItemContinent, Length(AItemInfo.ItemContinent) - 1));

    // Price
    wNodeValue := ANode.SelectString('price');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemPrice := StrToFloat2(wNodeValue);

    // Quantity
    if AItemInfo.ItemSize >= 0 then
      AItemInfo.ItemQuantity := AItemInfo.ItemSize;

    // Since
    wNodeValue := ANode.SelectString('timestamp');
    if Length(wNodeValue) > 0 then
      AItemInfo.ItemTime := IncHour(IncDay(UnixToDateTime(StrToInt64(wNodeValue)), 7), 2);

    // Specifications
    //DONE: API plein de valeurs sont maintenant flottantes ? => nouvelle propri�t� @value avec la valeur affich�e en jeu
    wNodeValue := ANode.SelectString('.//craftparameters/dmg/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CDmg := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/speed/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CSpeed := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/range/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CRange := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/dodgemodifier/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CDodgeModifier := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/parrymodifier/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CParryModifier := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/adversarydodgemodifier/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CAdvDodgeModifier := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/adversaryparrymodifier/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CAdvParryModifier := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/protectionfactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CFactorProt := StrToFloat2(wNodeValue);
    wNodeValue := ANode.SelectString('.//craftparameters/maxslashingprotection/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CSlashingProt := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/maxbluntprotection/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CBluntProt := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/maxpiercingprotection/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.CPiercingProt := StrToIntDef(wNodeValue, 0);

    //DONE: 5.1 Lire les infos de protection/r�sistance sur les bijoux
    SetProtection;
    SetResistance;

    //DONE: 5.1 Lire les caract�ristiques magiques des amplis
    wNodeValue := ANode.SelectString('.//craftparameters/elementalcastingtimefactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AElementalSpeed := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/elementalpowerfactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AElementalPower := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/offensiveafflictioncastingtimefactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AOffensiveSpeed := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/offensiveafflictionpowerfactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AOffensivePower := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/healcastingtimefactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AHealSpeed := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/healpowerfactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.AHealPower := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/defensiveafflictioncastingtimefactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.ADefensiveSpeed := StrToIntDef(wNodeValue, 0);
    wNodeValue := ANode.SelectString('.//craftparameters/defensiveafflictionpowerfactor/@value');
    if Length(wNodeValue) > 0 then
      AItemInfo.ADefensivePower := StrToIntDef(wNodeValue, 0);

    // Image filename
    AItemInfo.ItemFileName := Format('%s.c%dq%ds%dd%dl%ds%d%s',
      [AItemInfo.ItemName, Ord(AItemInfo.ItemColor), AItemInfo.ItemQuality, AItemInfo.ItemSize,
      MdkBoolToInteger(AItemInfo.ItemDestroyed), MdkBoolToInteger(AItemInfo.ItemLocked),
      MdkBoolToInteger(AItemInfo.ItemSap), _ICON_FORMAT]);
  except
    on E: Exception do
      Exception.CreateFmt('[GetItemInfoFromXML] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Sets the default filter for items
*******************************************************************************}
procedure TRyzom.SetDefaultFilter(var AFilter: TItemFilter);
begin
  AFilter.Enabled := True;
  AFilter.Type_ := [itAnimalMat, itNaturalMat, itSystemMat, itCata, itEquipment, itTeleporter, itOther];
  AFilter.QualityMin := _MIN_QUALITY;
  AFilter.QualityMax := _MAX_QUALITY;
  AFilter.ClassMin := icBasic;
  AFilter.ClassMax := icSupreme;
  AFilter.Ecosystem := [ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes];
  AFilter.ItemName := '';
  AFilter.AllWords := True;
  AFilter.Equipment := [];
  AFilter.CategoryIndex := 0;
  AFilter.Continent := '';
  AFilter.PriceMin := 0;
  AFilter.PriceMax := 0;
  AFilter.Bonus := [];
  AFilter.Sorting := ioType;
  AFilter.QuantityMin := _MIN_QUANTITY;
  AFilter.QuantityMax := _MAX_QUANTITY;
end;

{*==============================================================================
Couleur pour une mp g�n�rique
===============================================================================}
function TRyzom.GetSystemMatColor(AItemInfo: TItemInfo): Integer;
var
  i: Integer;
  wColor: String;
begin
  // on cherche une couleur dans le nom de l'objet (ex: system_mp_choice_purple.sitem ou system_mp_extra_green.sitem)
  for i := 1 to High(_MAT_COLOR) do begin
    wColor := _MAT_COLOR[i];
    if Pos(wColor, AItemInfo.ItemName) > 0 then begin
      Result := i;
      Exit;
    end;
  end;

  // beige par d�faut
  Result := 1;
end;

{*******************************************************************************
Returns information about an item from the item name
*******************************************************************************}
procedure TRyzom.GetItemInfoFromName(AItemInfo: TItemInfo);
var
  wIndex: Integer;
  wCoef: Double;
  wFound: Boolean;
  wRegExpr: TRegExpr;
  wRegExpr2: TRegExpr;
  i: Integer;
begin
  wRegExpr := TRegExpr.Create;
  wRegExpr2 := TRegExpr.Create;
  try
    wCoef := 0.0;

    // Catalyzer
    if Pos('ixpca0', AItemInfo.ItemName) = 1 then begin
      AItemInfo.ItemType := itCata;
      wCoef := 0.01;
    end;

    // Teleporters
    if Pos('tp_ka', AItemInfo.ItemName) = 1 then begin
      AItemInfo.ItemType := itTeleporter;
    end;

    // Tool
    if AItemInfo.ItemType = itOther then begin
      wRegExpr.Expression := _EXPR_TOOL;
      if wRegExpr.Exec(AItemInfo.ItemName) and (Pos('_sap_recharge', AItemInfo.ItemName) = 0) then begin
        AItemInfo.ItemType := itEquipment;
        AItemInfo.ItemEquip := iqTool;
        wCoef := 10.0;
      end;
    end;
  
    // Equipment
    if AItemInfo.ItemType = itOther then begin
      wRegExpr.Expression := _EXPR_EQUIPMENT;
      if wRegExpr.Exec(AItemInfo.ItemName) then begin
        AItemInfo.ItemType := itEquipment;
        case Ord(wRegExpr.Match[1][1]) of
          116:
            AItemInfo.ItemEcosys := ieLakes; // t = tryker
            102:
            AItemInfo.ItemEcosys := ieDesert; // f = fyros
            109:
            AItemInfo.ItemEcosys := ieForest; // m = matis
            122:
            AItemInfo.ItemEcosys := ieJungle; // z = zorai
        else
          AItemInfo.ItemEcosys := ieCommon;
        end;

        AItemInfo.ItemSkin := isSkin1;
        case Ord(wRegExpr.Match[2][2]) of
          50:
            AItemInfo.ItemSkin := isSkin2; // 2 = skin2
            51:
            AItemInfo.ItemSkin := isSkin3; // 3 = skin3
        end;

        // Shield
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_SHIELD;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            case Ord(wRegExpr.Match[2][1]) of
              98:
                begin // b = buckler
                  AItemInfo.ItemEquip := iqBuckler;
                  wCoef := 5.0;
                end;
              115:
                begin // s = shield
                  AItemInfo.ItemEquip := iqShield;
                  if CompareText(AItemInfo.ItemName, 'icbss_pvp.sitem') = 0 then
                    wCoef := 20.0 // grand bouclier pvp
                  else
                    wCoef := 10.0;
                end;
            end;
          end;
        end;

        // Armor
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_ARMOR;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            if AItemInfo.ItemColor = icNone then
              AItemInfo.ItemColor := icBeige;

            case Ord(wRegExpr.Match[1][1]) of
              108, 99:
                AItemInfo.ItemEquip := iqLightArmor; // l,c = light
                98, 103, 112, 115, 118:
                AItemInfo.ItemEquip := iqLightArmor; // b,g,p,s,v = light (armure de r�fugi�)
                109:
                AItemInfo.ItemEquip := iqMediumArmor; // m = medium
                104:
                AItemInfo.ItemEquip := iqHeavyArmor; // h = heavy
            end;
            wCoef := 7.0;
            if Pos('iccah', AItemInfo.ItemName) = 1 then
              wCoef := 20.0 // boss
          end;
        end;

        // Amplifier
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_AMPLIFIER;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            AItemInfo.ItemEquip := iqAmplifier;
            wCoef := 10;
          end;
        end;

        // Weapon
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_WEAPON;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            case Ord(wRegExpr.Match[1][1]) of
              109:
                begin // m = melee
                  AItemInfo.ItemEquip := iqWeaponMelee;
                  case Ord(wRegExpr.Match[2][1]) of
                    49: // 1 = 1 hand
                      begin
                        AItemInfo.ItemWeapon := iwOneHand;
                        wCoef := 10.0;
                        if wRegExpr.Match[3] = 'pd' then
                          wCoef := 5.0; // dagger
                      end;
                    50: // 2 = 2 hands
                      begin
                        AItemInfo.ItemWeapon := iwTwoHands;
                        wCoef := 15.0;
                      end;
                  end;
                end;
              114:
                begin // r = range
                  AItemInfo.ItemEquip := iqWeaponRange;
                  case Ord(wRegExpr.Match[2][1]) of
                    49: // 1 = 1 hand
                      begin
                        AItemInfo.ItemWeapon := iwOneHand;
                        wCoef := 10.0;
                      end;
                    50: // 2 = 2 hands
                      begin
                        AItemInfo.ItemWeapon := iwTwoHands;
                        case Ord(wRegExpr.Match[3][1]) of
                          97:
                            wCoef := 30.0; // machine gun
                            98, 114:
                            wCoef := 15.0; // rifles
                            108:
                            wCoef := 30.0; // grenade launcher
                        end;
                      end;
                  end;
                end;
            end;
          end;
        end;

        // Ammo
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_AMMO;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            AItemInfo.ItemEquip := iqAmmo;
            case Ord(wRegExpr.Match[1][1]) of
              49:
                wCoef := 0.04; // pistols
                50:
                begin
                  case Ord(wRegExpr.Match[1][2]) of
                    97:
                      wCoef := 5.0; // machine gun
                      98, 114:
                      wCoef := 0.1; // rifles
                      108:
                      wCoef := 15.0; // grenade launcher
                  end;
                end;
            end;
          end;
        end;

        // Jewel
        if AItemInfo.ItemEquip = iqOther then begin
          wRegExpr.Expression := _EXPR_EQUIPMENT_JEWEL;
          if wRegExpr.Exec(AItemInfo.ItemName) then begin
            AItemInfo.ItemEquip := iqJewel;
            wCoef := 2.0;
          end;
        end;

        // Others
        if AItemInfo.ItemEquip = iqOther then begin
          if Pos('ic_candy_stick', AItemInfo.ItemName) = 1 then
            wCoef := 30.0;
          if Pos('ic_halloween_stick', AItemInfo.ItemName) = 1 then
            wCoef := 30.0;
          if Pos('ic_anlor_helmet01', AItemInfo.ItemName) = 1 then
            wCoef := 7.0;
        end;
      end;
    end;

    // Natural materials
    if AItemInfo.ItemType = itOther then begin
      wRegExpr.Expression := _EXPR_NATURAL_MAT;
      if wRegExpr.Exec(AItemInfo.ItemName) then begin
        AItemInfo.ItemType := itNaturalMat;
        wCoef := 0.5;
      end;
    end;

    // Animal materials
    if AItemInfo.ItemType = itOther then begin
      wRegExpr.Expression := _EXPR_ANIMAL_MAT;
      if wRegExpr.Exec(AItemInfo.ItemName) then begin
        AItemInfo.ItemType := itAnimalMat;
        wCoef := 0.5;
      end;
    end;

    // Natural and Animal
    if (AItemInfo.ItemType = itNaturalMat) or (AItemInfo.ItemType = itAnimalMat) then begin
      // Categories - Composition d'une ligne
      // 08432013022072082111121132142 => 08 432 013 022 072 082 111 121 132 142
      // 08 = index de la cat�gorie => _MAT_CATEGORY
      // 432 = index des couleurs : basique/fin (4), choix/xl/sup (3) et primes (2) => _MAT_COLOR
      // 013 etc. = index de la caract�ristique (01) suivi de la valeur de 1 � 5 (3) => _MAT_SPEC

      wIndex := FCatStrings.IndexOfName(Copy(AItemInfo.ItemName, 1, 5));
      if wIndex >= 0 then begin
        AItemInfo.ItemCategory1 := StrToInt(Copy(FCatStrings.ValueFromIndex[wIndex], 1, 2));
        // autre que larve de Kitin ?
        if Pos('m0312', AItemInfo.ItemName) = 0 then
          AItemInfo.ItemCategory2 := StrToInt(Copy(FCatStrings.ValueFromIndex[wIndex + 1], 1, 2));
        AItemInfo.MatColor1 := StrToInt(FCatStrings.ValueFromIndex[wIndex][3]);
        AItemInfo.MatColor2 := StrToInt(FCatStrings.ValueFromIndex[wIndex][4]);
        AItemInfo.MatColor3 := StrToInt(FCatStrings.ValueFromIndex[wIndex][5]);

        // Specifications for category 1
        wRegExpr2.InputString := FCatStrings.ValueFromIndex[wIndex];
        wRegExpr2.Expression := '(\d\d)(\d)';
        i := 0;
        wFound := wRegExpr2.Exec(6);
        while wFound do begin
          Inc(i);
          SetLength(AItemInfo.MatSpec1, i);
          AItemInfo.MatSpec1[i - 1][0] := StrToInt(wRegExpr2.Match[1]);
          AItemInfo.MatSpec1[i - 1][1] := StrToInt(wRegExpr2.Match[2]);
          wFound := wRegExpr2.ExecNext;
        end;

        // Specifications for category 2
        if AItemInfo.ItemCategory2 > 0 then begin
          wRegExpr2.InputString := FCatStrings.ValueFromIndex[wIndex + 1];
          wRegExpr2.Expression := '(\d\d)(\d)';
          i := 0;
          wFound := wRegExpr2.Exec(6);
          while wFound do begin
            Inc(i);
            SetLength(AItemInfo.MatSpec2, i);
            AItemInfo.MatSpec2[i - 1][0] := StrToInt(wRegExpr2.Match[1]);
            AItemInfo.MatSpec2[i - 1][1] := StrToInt(wRegExpr2.Match[2]);
            wFound := wRegExpr2.ExecNext;
          end;
        end;
      end;

      // Ecosystem
      case Ord(wRegExpr.Match[1][1]) of
        99, 103:
          AItemInfo.ItemEcosys := ieCommon; // c,g
          112:
          AItemInfo.ItemEcosys := iePrime; // p
          100:
          AItemInfo.ItemEcosys := ieDesert; // d
          102:
          AItemInfo.ItemEcosys := ieForest; // f
          108:
          AItemInfo.ItemEcosys := ieLakes; // l
          106:
          AItemInfo.ItemEcosys := ieJungle; // j
      end;
    end;

    // Natural
    if AItemInfo.ItemType = itNaturalMat then begin
      case Ord(wRegExpr.Match[2][1]) of
        97:
          AItemInfo.ItemClass := icBasic; // a (no item encountered with this until now - basic by default)
          98:
          AItemInfo.ItemClass := icBasic; // b
          99:
          AItemInfo.ItemClass := icFine; // c
          100:
          AItemInfo.ItemClass := icChoice; // d
          101:
          AItemInfo.ItemClass := icExcellent; // e
          102:
          AItemInfo.ItemClass := icSupreme; // f
      end;
    end;

    // Animal
    if AItemInfo.ItemType = itAnimalMat then begin
      case Ord(wRegExpr.Match[2][1]) of
        97:
          AItemInfo.ItemClass := icBasic; // a
          98:
          AItemInfo.ItemClass := icFine; // b
          99:
          AItemInfo.ItemClass := icChoice; // c
          100:
          AItemInfo.ItemClass := icExcellent; // d
          101:
          AItemInfo.ItemClass := icSupreme; // e
          102:
          AItemInfo.ItemClass := icSupreme; // f (materials for missions in prime roots)
      end;
    end;

    //DONE: pb de volumes sur les objets suivants :
    // canne a p�che (winch.sitem): vol 5
    // 2 armes sp�ciales (icbm1sa_2.sitem et icbm1bs.sitem): vol 20
    // botte de fourrage basique : vol 15 / botte (v�rifier les autres types de botte)
    // Others
    if AItemInfo.ItemType = itOther then begin
      if Pos('pre_order.sitem', AItemInfo.ItemName) > 0 then
        wCoef := 5.0; // bouclier de pr�-commande
      if CompareText(AItemInfo.ItemName, 'teddyubo.sitem') = 0 then
        wCoef := 5.0; // peluche de Yubo
      if CompareText(AItemInfo.ItemName, 'xmas_gingeryubo.sitem') = 0 then
        wCoef := 5.0; // yubo pain d'�pice
      if CompareText(AItemInfo.ItemName, 'louche.sitem') = 0 then
        wCoef := 5.0; // louche
      if Pos('ipoc_', AItemInfo.ItemName) = 1 then
        wCoef := 1.0; // flower (ipoc_int.sitem, ipoc_str.sitem, etc.)
      if Pos('ipm', AItemInfo.ItemName) = 1 then
        wCoef := 1.0; // egg (ipme04.sitem, ipmc03.sitem, ipmf04.sitem)
      if Pos('ipk_', AItemInfo.ItemName) = 1 then
        wCoef := 1.0; // potion (ipk_minor_life.sitem, ipk_minor_mage.sitem, etc.)
      if CompareText(AItemInfo.ItemName, 'if1.sitem') = 0 then
        wCoef := 15.0; // food basic
      if CompareText(AItemInfo.ItemName, 'if2.sitem') = 0 then
        wCoef := 5.0; // food concentrated
      if CompareText(AItemInfo.ItemName, 'if3.sitem') = 0 then
        wCoef := 9.0; // food small
      if CompareText(AItemInfo.ItemName, 'winch.sitem') = 0 then
        wCoef := 5.0; // canne � p�che
      if CompareText(AItemInfo.ItemName, 's2e1_salins.sitem') = 0 then
        wCoef := 0.5; // poign�e de salins m�rs
      if CompareText(AItemInfo.ItemName, 's2e1_seve_suc.sitem') = 0 then
        wCoef := 0.5; // gouttelette de suc iris� de salina
      if CompareText(AItemInfo.ItemName, 'ulo_4.sitem') = 0 then
        wCoef := 1.0; // arkoleth
      if CompareText(AItemInfo.ItemName, 'event_magnetized_amber.sitem') = 0 then
        wCoef := 0.5; // ambre Ranger
      if CompareText(AItemInfo.ItemName, 'rite_ranger_map_book.sitem') = 0 then
        wCoef := 0.5; // carte Ranger
      if CompareText(AItemInfo.ItemName, 'anniversary_dance_scroll.sitem') = 0 then
        wCoef := 0.5; // danse classique
      if AnsiIndexText(AItemInfo.ItemName, _MAT_JOBS) >= 0 then
        wCoef := 1.0; // items de m�tier (fleur porte bonheur, ambre de protection, etc.)
      wRegExpr.Expression := _EXPR_BANDIT_CHEST;
      if wRegExpr.Exec(AItemInfo.ItemName) then
        wCoef := 0.5; // loot coffre de bandits
      if AnsiIndexText(AItemInfo.ItemName, _MAT_GUILD_CHEST) >= 0 then
        wCoef := 0.1; // items pour les coffres de guilde (mp g�n�rique dure/molle/liquide, pi�ce de colonne, etc.)
      { Special weapons
      icbm1sa_2.sitem => Hache Cleven des Ren�gats
      icbm1bs.sitem => B�ton Shopan de l'Arbre �ternel
      }
      if (CompareText(AItemInfo.ItemName, 'icbm1sa_2.sitem') = 0) or
        (CompareText(AItemInfo.ItemName, 'icbm1bs.sitem') = 0) then begin
        AItemInfo.ItemType := itEquipment;
        AItemInfo.ItemEquip := iqWeaponMelee;
        AItemInfo.ItemEcosys := ieCommon;
        AItemInfo.ItemSkin := isSkin3;
        wCoef := 20.0;
      end;

      // Kara/Kami dress
      if (Pos('ikaracp_ep', AItemInfo.ItemName) = 1) or
        (Pos('ikamacp_ep', AItemInfo.ItemName) = 1) then begin
        AItemInfo.ItemType := itEquipment;
        AItemInfo.ItemEquip := iqLightArmor;
        AItemInfo.ItemEcosys := ieCommon;
        AItemInfo.ItemSkin := isSkin3;
        wCoef := 7.0;
      end;

      // System materials
      wRegExpr.Expression := _EXPR_SYSTEM_MAT;
      if wRegExpr.Exec(AItemInfo.ItemName) then begin
        AItemInfo.ItemType := itSystemMat;
        AItemInfo.ItemEcosys := ieCommon;
        AItemInfo.ItemCategory1 := 0;
        SetLength(AItemInfo.MatSpec1, 1);
        AItemInfo.MatSpec1[0][0] := 0; // _MAT_SPEC => All
        
        // mp g�n�rique ?
        if Pos('system_mp', wRegExpr.Match[1]) > 0 then begin
          AItemInfo.MatColor1 := GetSystemMatColor(AItemInfo);
        end
        else begin
          AItemInfo.MatColor1 := 8; // blanc
        end;
        AItemInfo.MatColor2 := AItemInfo.MatColor1;

        AItemInfo.ItemClass := icBasic;
        if wRegExpr.Match[2] <> '' then begin
          AItemInfo.MatSpec1[0][1] := 3;
          if Pos('fine', wRegExpr.Match[2]) = 1 then
            AItemInfo.ItemClass := icFine;
          if Pos('choice', wRegExpr.Match[2]) = 1 then
            AItemInfo.ItemClass := icChoice;
          if Pos('xl', wRegExpr.Match[2]) = 1 then
            AItemInfo.ItemClass := icExcellent;
          if Pos('excellent', wRegExpr.Match[2]) = 1 then
            AItemInfo.ItemClass := icExcellent;
          if Pos('supreme', wRegExpr.Match[2]) = 1 then
            AItemInfo.ItemClass := icSupreme;
          if Pos('extra', wRegExpr.Match[2]) = 1 then begin
            AItemInfo.ItemClass := icSupreme;
            AItemInfo.MatSpec1[0][1] := 5;
          end;
        end
        else begin
          AItemInfo.MatSpec1[0][1] := 2;
        end;

        // loot/all�gorie
        if CompareText(AItemInfo.ItemName, 'system_mp_loot.sitem') = 0 then
          wCoef := 0.5;
      end;
    end;

    // Volume
    AItemInfo.ItemVolume := wCoef * Abs(AItemInfo.ItemSize);
  finally
    wRegExpr.Free;
    wRegExpr2.Free;
  end;
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
  wItemDesc: String;
  i: Integer;
begin
  Result := False;

  // If not type then Exit
  if AFilter.Type_ = [] then
    Exit;

  // Item for sale but now > expired date
  if (AItemInfo.ItemPrice > 0) and (Now > AItemInfo.ItemTime) then
    Exit;

  // Quality
  if AItemInfo.ItemQuality <= _MAX_QUALITY then // for sap charges eg
    if (AItemInfo.ItemQuality < AFilter.QualityMin) or (AItemInfo.ItemQuality > AFilter.QualityMax) then
      Exit;

  // Quantity
  if (AItemInfo.ItemSize < AFilter.QuantityMin) or (AItemInfo.ItemSize > AFilter.QuantityMax) then
    Exit;

  // If the name does not match
  if AFilter.ItemName <> '' then begin
    wList := TStringList.Create;
    try
      wList.CommaText := MdkRemoveAccents(AFilter.ItemName);
      wItemDesc := MdkRemoveAccents(AItemInfo.ItemDesc);
      wFound := AFilter.AllWords;
      i := 0;
      while (i < wList.Count) do begin
        if AFilter.AllWords then
          wFound := wFound and (Pos(UpperCase(wList[i]), UpperCase(wItemDesc)) > 0)
        else
          wFound := wFound or (Pos(UpperCase(wList[i]), UpperCase(wItemDesc)) > 0);
        Inc(i);
      end;
      if not wFound then
        Exit;
    finally
      wList.Free;
    end;
  end;

  // Type
  if not (AItemInfo.ItemType in AFilter.Type_) then
    Exit;

  // Materials and equipment
  if (AItemInfo.ItemEquip <> iqTool) and (AItemInfo.ItemType in [itAnimalMat,
    itNaturalMat, itSystemMat, itEquipment]) then begin
    // Ecosystem
    if AItemInfo.ItemEcosys <> ieUnknown then
      if not (AItemInfo.ItemEcosys in AFilter.Ecosystem) then
        Exit;

    // Class
    if AItemInfo.ItemClass <> icUnknown then // for jewels that are looted eg
      if (Ord(AItemInfo.ItemClass) < Ord(AFilter.ClassMin)) or (Ord(AItemInfo.ItemClass) > Ord(AFilter.ClassMax)) then
        Exit;
  end;
  
  // Item category (only materials)
  if AItemInfo.ItemType in [itAnimalMat, itNaturalMat] then begin
    if (AFilter.CategoryIndex > 0) and (Pos('m0312', AItemInfo.ItemName) = 0) then begin // special cond for larva
      wCatIndex1 := AItemInfo.ItemCategory1;
      wCatIndex2 := AItemInfo.ItemCategory2;
      if (wCatIndex1 <> AFilter.CategoryIndex) and (wCatIndex2 <> AFilter.CategoryIndex) then
        Exit;
    end;
  end;
  
  // Item equipment
  if AItemInfo.ItemType = itEquipment then begin
    if AFilter.Equipment <> [] then
      if not (AItemInfo.ItemEquip in AFilter.Equipment) then
        Exit;
  end;

  // Item continent
  if AItemInfo.ItemContinent <> '' then begin
    if (AFilter.Continent <> '') and (CompareText(AItemInfo.ItemContinent, AFilter.Continent) <> 0) then
      Exit;
  end;

  // Item price
  if (AItemInfo.ItemPrice > 0) and (AFilter.PriceMax > 0) then begin
    if (AItemInfo.ItemPrice < AFilter.PriceMin) or
      (AItemInfo.ItemPrice > AFilter.PriceMax) then
      Exit;
  end;

  // Item bonus
  if (AItemInfo.ItemType = itEquipment) and (AFilter.Bonus <> []) then begin
    if not AItemInfo.ItemBonus then
      Exit;
    if (ibHp in AFilter.Bonus) and (AItemInfo.ItemHpb = 0) then
      Exit;
    if (ibSab in AFilter.Bonus) and (AItemInfo.ItemSab = 0) then
      Exit;
    if (ibStamina in AFilter.Bonus) and (AItemInfo.ItemStb = 0) then
      Exit;
    if (ibFocus in AFilter.Bonus) and (AItemInfo.ItemFob = 0) then
      Exit;
  end;

  Result := True;
end;

{ TItemInfo }

{*******************************************************************************
Default values
*******************************************************************************}
constructor TItemInfo.Create;
begin
  ItemSlot := -1;
  ItemName := '';
  ItemColor := icNone;
  ItemQuality := -1;
  ItemSize := -1;
  ItemSap := False;
  ItemDestroyed := False;
  ItemFileName := '';
  ItemClass := icUnknown;
  ItemType := itOther;
  ItemEcosys := ieUnknown;
  ItemEquip := iqOther;
  ItemCategory1 := -1;
  ItemCategory2 := -1;
  ItemSkin := isUnknown;
  ItemDesc := '';
  ItemHp := 0;
  ItemHpb := 0;
  ItemSab := 0;
  ItemStb := 0;
  ItemFob := 0;
  ItemBonus := False;
  ItemWeight := 0;
  ItemVolume := 0;
  ItemPrice := 0;
  ItemQuantity := 1;
  ItemContinent := '';
  ItemTime := 0;
  ItemGuarded := False;
  ItemGuardValue := -1;
  ItemLocked := False;
  MatColor1 := 0;
  MatColor2 := 0;
  MatColor3 := 0;
  CDmg := 0;
  CSpeed := 0;
  CRange := 0;
  CDodgeModifier := 0;
  CParryModifier := 0;
  CAdvDodgeModifier := 0;
  CAdvParryModifier := 0;
  CFactorProt := 0;
  CSlashingProt := 0;
  CBluntProt := 0;
  CPiercingProt := 0;

  BProtect[1] := ipNone;
  BProtect[2] := ipNone;
  BProtect[3] := ipNone;
  BProtectValue[1] := 0;
  BProtectValue[2] := 0;
  BProtectValue[3] := 0;

  BResist[1] := irNone;
  BResist[2] := irNone;
  BResist[3] := irNone;
  BResistValue[1] := 0;
  BResistValue[2] := 0;
  BResistValue[3] := 0;

  AElementalSpeed := 0;
  AElementalPower := 0;
  AOffensiveSpeed := 0;
  AOffensivePower := 0;
  AHealSpeed := 0;
  AHealPower := 0;
  ADefensiveSpeed := 0;
  ADefensivePower := 0;
end;

{*******************************************************************************
Free tables
*******************************************************************************}
destructor TItemInfo.Destroy;
begin
  SetLength(MatSpec1, 0);
  SetLength(MatSpec2, 0);
  inherited;
end;

{ TItemList }

function TItemList.IndexOf(AItemName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do begin
    if CompareText(AItemName, TItemInfo(Self.Items[i]).ItemName) = 0 then begin
      Result := i;
      Break;
    end;
  end;
end;

function TItemList.IndexOf(AItemSlot: Integer; AItemQuality: Integer; AItemName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do begin
    if (AItemSlot = GetItem(i).ItemSlot) and
      (CompareText(AItemName, GetItem(i).ItemName) = 0) and
      (AItemQuality = GetItem(i).ItemQuality) then begin
      Result := i;
      Break;
    end;
  end;
end;

function TItemList.GetItem(AItemIndex: Integer): TItemInfo;
begin
  Result := TItemInfo(Self.Items[AItemIndex]);
end;

end.

