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
unit UnitRyzom;

interface

uses
  Classes, SysUtils, RyzomApi, XpDOM, regexpr, UnitConfig;

const
  _EXPR_NATURAL_MAT = '^m\d{4}dxa([pcdflj])([b-f])01\.sitem';
  _EXPR_ANIMAL_MAT = '^m\d{4}.{3}([pcdflj])([a-e])01\.sitem';
  _EXPR_EQUIPMENT = '^ic(.).+';
  _EXPR_EQUIPMENT_ARMOR = '^ic.a(.).+';
  _EXPR_EQUIPMENT_AMPLIFIER = '^ic.+m2ms.*';
  _EXPR_EQUIPMENT_WEAPON = '^ic.+([rm])[12].*';
  _EXPR_EQUIPMENT_JEWEL = '^ic.j.*';
  
type
  TItemType =(itAnimalMat, itNaturalMat, itCata, itEquipment, itOthers);
  TItemTypes = set of TItemType;
  TItemClass = (icBasic, icFine, icChoice, icExcellent, icSupreme, icUnknown);
  TItemEcosystem = (ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes, ieUnknown);
  TItemEcosystems = set of TItemEcosystem;
  TItemEquip = (iqLightArmor, iqMediumArmor, iqHeavyArmor, iqWeaponMelee, iqWeaponRange, iqAmplifier, iqJewel, iqOthers);
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
  end;

  TRyzom = class(TRyzomApi)
  private
    FXmlDocument: TXpObjModel;

    FAniroStatus: Integer;
    FArispotleStatus: Integer;
    FLeanonStatus: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure UpdateStatus;
    procedure GetItemInfoFromXML(ANode: TXpNode; var AName: String; var AColor: TItemColor;
      var AQuality, ASize, ASap: Integer; var ADestroyed: Boolean; var AFileName: String; var AItemClass: TItemClass);
    function  CheckItem(AItemName: String; AQuality: Integer; AFilter: TItemFilter;
      AItemDesc: String; AItemType: TItemType; AItemClass: TItemClass; AItemEcosys: TItemEcosystem; AItemEquip: TItemEquip): Boolean;
    procedure GetItemInfoFromName(AItemName: String; var AItemType: TItemType; var AItemClass: TItemClass; var AItemEcosys: TItemEcosystem; var AItemEquip: TItemEquip);
    procedure SetDefaultFilter(var AFilter: TItemFilter);

    property AniroStatus: Integer read FAniroStatus;
    property LeanonStatus: Integer read FLeanonStatus;
    property ArispotleStatus: Integer read FArispotleStatus;
  end;


var
  GRyzomApi: TRyzom;
  GRyzomStringPack: TStringClient;
  GRegExpr: TRegExpr;
  GCurrentFilter: TItemFilter;

implementation

uses MisuDevKit;

{ TRyzom }

{*******************************************************************************
Creates the interface object
*******************************************************************************}
constructor TRyzom.Create;
begin
  inherited Create;
  FXmlDocument := TXpObjModel.Create(nil);
end;

{*******************************************************************************
Destroys the interface object
*******************************************************************************}
destructor TRyzom.Destroy;
begin
  FXmlDocument.Free;
  inherited;
end;

{*******************************************************************************
Returns information of an item
*******************************************************************************}
procedure TRyzom.GetItemInfoFromXML(ANode: TXpNode; var AName: String; var AColor: TItemColor;
  var AQuality, ASize, ASap: Integer; var ADestroyed: Boolean; var AFileName: String; var AItemClass: TItemClass);
var
  wNode: TXpNode;
begin
  // Default values
  AColor := icNone;
  AQuality := -1;
  ASize := -1;
  ASap := -1;
  ADestroyed := False;
  AItemClass := icUnknown;
  
  // Name
  AName := ANode.Text;

  // Color
  wNode := ANode.Attributes.GetNamedItem('c');
  if Assigned(wNode) then AColor := ToItemColor(wNode.NodeValue);

  // Quality
  wNode := ANode.Attributes.GetNamedItem('q');
  if Assigned(wNode) then AQuality := StrToInt(wNode.NodeValue);

  // Size
  wNode := ANode.Attributes.GetNamedItem('s');
  if Assigned(wNode) then ASize := StrToInt(wNode.NodeValue);

  // Sap load
  wNode := ANode.Attributes.GetNamedItem('sap');
  if Assigned(wNode) then ASap := StrToInt(wNode.NodeValue);

  // Destroyed
  wNode := ANode.Attributes.GetNamedItem('hp');
  if Assigned(wNode) then ADestroyed := StrToInt(wNode.NodeValue) <= 1;

  // Destroyed
  wNode := ANode.Attributes.GetNamedItem('e');
  if Assigned(wNode) then begin
    case Ord(wNode.NodeValue[1]) of
      98:  AItemClass := icBasic; {b = base}
      102: AItemClass := icFine; {f = fine}
      99:  AItemClass := icChoice; {c = choice}
      101: AItemClass := icExcellent; {e = excelent}
      115: AItemClass := icSupreme; {s = supreme}
    end;
  end;

  // Image filename
  AFileName := Format('%s.c%dq%ds%dd%d%s', [AName, Ord(AColor), AQuality, ASize, MdkBoolToInteger(ADestroyed), _ICON_FORMAT]);
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
  AFilter.Type_ := [itAnimalMat, itNaturalMat, itCata, itEquipment, itOthers];
  AFilter.QualityMin := _MIN_QUALITY;
  AFilter.QualityMax := _MAX_QUALITY;
  AFilter.ClassMin := icBasic;
  AFilter.ClassMax := icSupreme;
  AFilter.Ecosystem := [ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes];
  AFilter.ItemName := '';
  AFilter.AllWords := True;
  AFilter.Equipment := [iqLightArmor, iqMediumArmor, iqHeavyArmor, iqWeaponMelee, iqWeaponRange, iqJewel, iqAmplifier, iqOthers];
end;

{*******************************************************************************
Returns information about an item from the item name
*******************************************************************************}
procedure TRyzom.GetItemInfoFromName(AItemName: String; var AItemType: TItemType; var AItemClass: TItemClass;
    var AItemEcosys: TItemEcosystem; var AItemEquip: TItemEquip);
begin
  AItemType := itOthers;
  AItemEcosys := ieUnknown;

  // Catalyzer
  if CompareText(AItemName, _CATA_ITEM_NAME) = 0 then begin
    AItemType := itCata;
    Exit;
  end;

  // Equipment
  GRegExpr.Expression := _EXPR_EQUIPMENT;
  if GRegExpr.Exec(AItemName) then begin
    AItemType := itEquipment;
    case Ord(GRegExpr.Match[1][1]) of
      99: AItemEcosys := ieCommon; {c = common}
      111: AItemEcosys := ieCommon; {o = common}
      116: AItemEcosys := ieLakes; {t = tryker}
      102: AItemEcosys := ieDesert; {f = fyros}
      109: AItemEcosys := ieForest; {m = matis}
      122: AItemEcosys := ieJungle; {z = zorai}
    end;

    AItemEquip := iqOthers;
    
    // Armor
    GRegExpr.Expression := _EXPR_EQUIPMENT_ARMOR;
    if GRegExpr.Exec(AItemName) then begin
      case Ord(GRegExpr.Match[1][1]) of
        108: AItemEquip := iqLightArmor; {l = light}
        99: AItemEquip := iqLightArmor; {c = light}
        109: AItemEquip := iqMediumArmor; {m = medium}
        104: AItemEquip := iqHeavyArmor; {h = heavy}
      end;
    end;

    // Amplifier
    if AItemEquip = iqOthers then begin
      GRegExpr.Expression := _EXPR_EQUIPMENT_AMPLIFIER;
      if GRegExpr.Exec(AItemName) then begin
        AItemEquip := iqAmplifier;
      end;
    end;

    // Weapon
    if AItemEquip = iqOthers then begin
      GRegExpr.Expression := _EXPR_EQUIPMENT_WEAPON;
      if GRegExpr.Exec(AItemName) then begin
        case Ord(GRegExpr.Match[1][1]) of
          109: AItemEquip := iqWeaponMelee; {m = melee}
          114: AItemEquip := iqWeaponRange; {r = range}
        end;
      end;
    end;

    // Jewel
    if AItemEquip = iqOthers then begin
      GRegExpr.Expression := _EXPR_EQUIPMENT_JEWEL;
      if GRegExpr.Exec(AItemName) then begin
        AItemEquip := iqJewel;
      end;
    end;
  end;

  // Natural materials
  if AItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_NATURAL_MAT;
    if GRegExpr.Exec(AItemName) then
      AItemType := itNaturalMat;
  end;

  // Animal materials
  if AItemType = itOthers then begin
    GRegExpr.Expression := _EXPR_ANIMAL_MAT;
    if GRegExpr.Exec(AItemName) then
      AItemType := itAnimalMat;
  end;

  // Natural and Animal
  if (AItemType = itNaturalMat) or (AItemType = itAnimalMat) then begin
    case Ord(GRegExpr.Match[1][1]) of
      99: AItemEcosys := ieCommon; {c}
      112: AItemEcosys := iePrime; {p}
      100: AItemEcosys := ieDesert; {d}
      102: AItemEcosys := ieForest; {f}
      108: AItemEcosys := ieLakes; {l}
      106: AItemEcosys := ieJungle; {j}
    end;
  end;

  // Natural
  if AItemType = itNaturalMat then begin
    case Ord(GRegExpr.Match[2][1]) of
      98: AItemClass := icBasic; {b}
      99: AItemClass := icFine; {c}
      100: AItemClass := icChoice; {d}
      101: AItemClass := icExcellent; {e}
      102: AItemClass := icSupreme; {f}
    end;
  end;

  // Animal
  if AItemType = itAnimalMat then begin
    case Ord(GRegExpr.Match[2][1]) of
      97: AItemClass := icBasic; {a}
      98: AItemClass := icFine; {b}
      99: AItemClass := icChoice; {c}
      100: AItemClass := icExcellent; {d}
      101: AItemClass := icSupreme; {e}
    end;
  end;
end;

{*******************************************************************************
Verifies if the item respects the filter
*******************************************************************************}
function TRyzom.CheckItem(AItemName: String; AQuality: Integer; AFilter: TItemFilter;
  AItemDesc: String; AItemType: TItemType; AItemClass: TItemClass; AItemEcosys: TItemEcosystem;
  AItemEquip: TItemEquip): Boolean;
var
  wList: TStringList;
  wFound: Boolean;
  i: Integer;
begin
  Result := False;

  // If not type then Exit
  if AFilter.Type_ = [] then Exit;

  // Quality
  if (AQuality < AFilter.QualityMin) or (AQuality > AFilter.QualityMax) then Exit;

  // If the name does not match
  if AFilter.ItemName <> '' then begin
    wList := TStringList.Create;
    try
      wList.CommaText := MdkRemoveAccents(AFilter.ItemName);
      AItemDesc := MdkRemoveAccents(AItemDesc);
      wFound := AFilter.AllWords;
      i := 0;
      while (i < wList.Count) do begin
        if AFilter.AllWords then
          wFound := wFound and (Pos(UpperCase(wList[i]), UpperCase(AItemDesc)) > 0)
        else
          wFound := wFound or (Pos(UpperCase(wList[i]), UpperCase(AItemDesc)) > 0);
        Inc(i);
      end;
      if not wFound then Exit;
    finally
      wList.Free;
    end;
  end;

  // Type
  if not (AItemType in AFilter.Type_) then Exit;

  // Only for materials
  if AItemType in [itAnimalMat, itNaturalMat, itEquipment] then begin
    // Ecosystem
    if not (AItemEcosys in AFilter.Ecosystem) then Exit;

    // Class
    if (Ord(AItemClass) < Ord(AFilter.ClassMin)) or (Ord(AItemClass) > Ord(AFilter.ClassMax)) then Exit;
  end;
  
  // Item equipment
  if AItemType = itEquipment then begin
    if AFilter.Equipment = [] then Exit;
    if not (AItemEquip in AFilter.Equipment) then Exit;
  end;

  Result := True;
end;

end.
