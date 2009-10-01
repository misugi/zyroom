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
  _EXPR_NATURAL_MAT = 'm\d{4}dxa([pcdflj])([b-f])01\.sitem';
  _EXPR_ANIMAL_MAT = 'm\d{4}.{3}([pcdflj])([a-e])01\.sitem';
  _EXPR_EQUIPMENT = 'ic.+';
  
type
  TItemType =(itAnimalMat, itNaturalMat, itCata, itEquipment, itOthers);
  TItemTypes = set of TItemType;
  TItemClass = (icBasic, icFine, icChoice, icExcellent, icSupreme, icUnknown);
  TItemEcosystem = (ieCommon, iePrime, ieDesert, ieJungle, ieForest, ieLakes, ieUnknown);
  TItemEcosystems = set of TItemEcosystem;

  TItemFilter = record
    Enabled: Boolean;
    Type_: TItemTypes;
    QualityMin: Integer;
    QualityMax: Integer;
    ClassMin: TItemClass;
    ClassMax: TItemClass;
    Ecosystem: TItemEcosystems;
    ItemName: String;
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
      var AQuality, ASize, ASap: Integer; var ADestroyed: Boolean; var AFileName: String);
    function  CheckItem(AItemName: String; AQuality: Integer; AFilter: TItemFilter; AItemDesc: String): Boolean;
    procedure GetItemInfoFromName(AItemName: String; var AItemType: TItemType; var AItemClass: TItemClass; var AItemEcosys: TItemEcosystem);
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
  var AQuality, ASize, ASap: Integer; var ADestroyed: Boolean; var AFileName: String);
var
  wNode: TXpNode;
begin
  // Default values
  AColor := icNone;
  AQuality := -1;
  ASize := -1;
  ASap := -1;
  ADestroyed := False;
  
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
end;

{*******************************************************************************
Returns information about an item from the item name
*******************************************************************************}
procedure TRyzom.GetItemInfoFromName(AItemName: String; var AItemType: TItemType; var AItemClass: TItemClass;
    var AItemEcosys: TItemEcosystem);
begin
  AItemType := itOthers;
  AItemClass := icUnknown;
  AItemEcosys := ieUnknown;

  // Catalyzer
  if CompareText(AItemName, _CATA_ITEM_NAME) = 0 then
    AItemType := itCata;

  // Equipment
  GRegExpr.Expression := _EXPR_EQUIPMENT;
  if GRegExpr.Exec(AItemName) then
    AItemType := itEquipment;

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
function TRyzom.CheckItem(AItemName: String; AQuality: Integer; AFilter: TItemFilter; AItemDesc: String): Boolean;
var
  wItemType: TItemType;
  wItemClass: TItemClass;
  wItemEcosys: TItemEcosystem;
  wList: TStringList;
  wFound: Boolean;
  i: Integer;
begin
  Result := False;

  // If the name does not match
  if AFilter.ItemName <> '' then begin
    wList := TStringList.Create;
    try
      wList.CommaText := AFilter.ItemName;
      AItemDesc := MdkRemoveAccents(AItemDesc);
      wFound := True;
      i := 0;
      while (i < wList.Count) and (wFound) do begin
        wFound := wFound and (Pos(UpperCase(wList[i]), UpperCase(AItemDesc)) > 0);
        Inc(i);
      end;
      if not wFound then Exit;
    finally
      wList.Free;
    end;
  end;

  // If not type then Exit
  if AFilter.Type_ = [] then Exit;

  // Quality
  if (AQuality < AFilter.QualityMin) or (AQuality > AFilter.QualityMax) then Exit;

  GRyzomApi.GetItemInfoFromName(AItemName, wItemType, wItemClass, wItemEcosys);
  
  // Type
  if not (wItemType in AFilter.Type_) then Exit;

  // Only for materials
  if wItemType in [itAnimalMat, itNaturalMat] then begin
    // Ecosystem
    if not (wItemEcosys in AFilter.Ecosystem) then Exit;

    // Class
    if (Ord(wItemClass) < Ord(AFilter.ClassMin)) or (Ord(wItemClass) > Ord(AFilter.ClassMax)) then Exit;
  end;
  
  Result := True;
end;

end.
