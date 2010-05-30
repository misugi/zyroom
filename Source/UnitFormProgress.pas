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
unit UnitFormProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, XpDOM, ExtCtrls, ScrollRoom, ItemImage,
  pngimage, UnitRyzom, regexpr, SyncObjs, Contnrs, StrUtils;

resourcestring
  RS_PROGRESS_SYNCHRONIZE = 'Synchronisation en cours, veuillez patienter...';
  RS_PROGRESS_ROOM = 'Affichage en cours, veuillez patienter...';
  RS_CONNEXION_ERROR = 'Trop d''erreurs API, arrêt de la synchronisation';

const
  _TASK_SYNCHRONIZE = 0;
  _TASK_ROOM = 1;
  _TASK_SYNCHRONIZE_CHAR = 2;
  _TASK_INVENT = 3;

  _INVENT_ROOM = 0;
  _INVENT_BAG = 1;
  _INVENT_PET1 = 2;
  _INVENT_PET2 = 3;
  _INVENT_PET3 = 4;
  _INVENT_PET4 = 5;
  
type
  TGetItemThread = class(TThread)
  private
    FNode: TXpNode;
    FStoragePath: String;
  public
    constructor Create(ANode: TXpNode; AStoragePath: String);
    procedure Execute; override;
  end;
  
  TFormProgress = class(TForm)
    ProgressBar: TProgressBar;
    LbProgress: TLabel;
    TimerStart: TTimer;
    BtCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FEnabled: Boolean;
    FProcessingType: Integer;
    FInventPart: Integer;
    FGuildID: String;
    FCharID: String;
    FRoom: TScrollRoom;
    FFilter: TItemFilter;
    FTotalVolume: Double;

    procedure SynchronizeGuild(AGuildID: String);
    procedure SynchronizeChar(ACharID: String);
    procedure FillRoom(AGuildID: String);
    procedure FillInvent(ACharID: String);
    procedure GetItem(ANodeList: TXpNodeList; AStoragePath: String);
    procedure ShowItem(ANodeList: TXpNodeList; AStoragePath: String);
    function  GetSortPrefix(AItemInfo: TItemInfo): String;
    procedure CloseForm;
  public
    procedure ShowFormSynchronize(AGuildID: String);
    procedure ShowFormSynchronizeChar(ACharID: String);
    procedure ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
    procedure ShowFormInvent(ACharID: String; ARoom: TScrollRoom; AInventPart: Integer; AFilter: TItemFilter);
    property  TotalVolume: Double read FTotalVolume write FTotalVolume;
  end;

var
  FormProgress: TFormProgress;
  GSection: TCriticalSection;
  GEvent: TEvent;
  GThreadCount: Integer;
  GStrings: TStringList;

implementation

uses UnitConfig, RyzomApi, MisuDevKit, Math;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormProgress.FormCreate(Sender: TObject);
begin
  GStrings := TStringList.Create;
  GSection := TCriticalSection.Create;
  GEvent := TEvent.Create(nil, True, False, 'synchronization');
  GEvent.ResetEvent;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormProgress.FormDestroy(Sender: TObject);
begin
  GStrings.Free;
  GSection.Free;
  GEvent.Free;
end;

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormProgress.CloseForm;
begin
  FEnabled := True;
  inherited Close;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormProgress.FormShow(Sender: TObject);
begin
  ProgressBar.Position := 0;
  TimerStart.Enabled := True;
  FEnabled := False;
end;

{*******************************************************************************
Authorization to close the form
*******************************************************************************}
procedure TFormProgress.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := FEnabled;
end;

{*******************************************************************************
Get items and save image files
*******************************************************************************}
procedure TFormProgress.GetItem(ANodeList: TXpNodeList;
  AStoragePath: String);
var
  i: Integer;
  wThread: TGetItemThread;
  wItemName: String;
begin
  GThreadCount := 0;
  i := 0;
  while i < ANodeList.Length do begin
    if ModalResult = mrCancel then Break;

    wItemName := ANodeList.Item(i).Text;
    if GStrings.IndexOfName(wItemName) < 0 then begin
      GStrings.Append(wItemName + '=' + GRyzomStringPack.GetString(wItemName));
    end;

    if GThreadCount < GConfig.ThreadCount then begin
      GSection.Enter;
      try
        wThread := TGetItemThread.Create(ANodeList.Item(i), AStoragePath);
        wThread.Resume;
        Inc(GThreadCount);
      finally
        GSection.Leave;
      end;
      Inc(i);
    end else begin
      GEvent.ResetEvent;
      GEvent.WaitFor(100);
    end;

    ProgressBar.Position := Trunc( ((i+1) / ANodeList.Length) * 100);
    Application.ProcessMessages;
  end;

  while GThreadCount > 0 do begin
    GEvent.ResetEvent;
    GEvent.WaitFor(100);
  end;
end;

{*******************************************************************************
Guild synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeGuild(AGuildID: String);
var
  wXmlFile: TMemoryStream;
  wGuildKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wIndexFile: String;
begin
  wGuildKey := GGuild.GetGuildKey(AGuildID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TMemoryStream.Create;
  try
    GRyzomApi.ApiGuild(wGuildKey, wXmlFile);
    wXmlFile.SaveToFile(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME);
    wXmlFile.Position := 0;
    wXmlDoc.LoadStream(wXmlFile);

    // Prepare the index file for name search
    wIndexFile := GConfig.GetGuildPath(AGuildID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    try
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
      try
        GetItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
      finally
        wNodeList.Free;
      end;
    finally
      GStrings.SaveToFile(wIndexFile);
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Character synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeChar(ACharID: String);
var
  wXmlFile: TMemoryStream;
  wCharKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wIndexFile: String;
begin
  wCharKey := GCharacter.GetCharKey(ACharID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TMemoryStream.Create;
  try
    GRyzomApi.ApiCharacter(wCharKey, cpItems, wXmlFile);
    wXmlFile.SaveToFile(GConfig.GetCharPath(ACharID) + _ITEMS_FILENAME);
    wXmlFile.Position := 0;
    wXmlDoc.LoadStream(wXmlFile);

    // Prepare the index file for name search
    wIndexFile := GConfig.GetCharPath(ACharID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    try
      // Room
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

     // Bag
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet1
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet2
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet3
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet4
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Sales
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/item_in_store/item');
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;
    finally
      GStrings.SaveToFile(wIndexFile);
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Starts a task
*******************************************************************************}
procedure TFormProgress.TimerStartTimer(Sender: TObject);
begin
  TimerStart.Enabled := False;
  try
    case FProcessingType of
      _TASK_SYNCHRONIZE: SynchronizeGuild(FGuildID);
      _TASK_ROOM: FillRoom(FGuildID);
      _TASK_SYNCHRONIZE_CHAR: SynchronizeChar(FCharID);
      _TASK_INVENT: FillInvent(FCharID)
    end;
  finally
    CloseForm;
  end;
end;

{*******************************************************************************
Starts a guild synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSynchronize(AGuildID: String);
begin
  FGuildID := AGuildID;
  FProcessingType := _TASK_SYNCHRONIZE;
  LbProgress.Caption := RS_PROGRESS_SYNCHRONIZE;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a character synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSynchronizeChar(ACharID: String);
begin
  FCharID := ACharID;
  FProcessingType := _TASK_SYNCHRONIZE_CHAR;
  LbProgress.Caption := RS_PROGRESS_SYNCHRONIZE;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a guild room
*******************************************************************************}
procedure TFormProgress.ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
begin
  FGuildID := AGuildID;
  FRoom := ARoom;
  FFilter := AFilter;
  FProcessingType := _TASK_ROOM;
  LbProgress.Caption := RS_PROGRESS_ROOM;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a character 
*******************************************************************************}
procedure TFormProgress.ShowFormInvent(ACharID: String; ARoom: TScrollRoom; AInventPart: Integer; AFilter: TItemFilter);
begin
  FCharID := ACharID;
  FRoom := ARoom;
  FFilter := AFilter;
  FProcessingType := _TASK_INVENT;
  FInventPart := AInventPart;
  LbProgress.Caption := RS_PROGRESS_ROOM;
  Self.ShowModal;
end;

{*******************************************************************************
Show items
*******************************************************************************}
procedure TFormProgress.ShowItem(ANodeList: TXpNodeList; AStoragePath: String);
var
  i: Integer;
  wItemImage: TItemImage;
  wItemInfo: TItemInfo;
  wItemList: TObjectList;
  wItemSort: TStringList;
  wSortPrefix: String;
begin
  wItemList := TObjectList.Create(False);
  wItemSort := TStringList.Create;
  try
    // Adjust the width of the room
    FRoom.ColCount := (FRoom.Width - 22) div (FRoom.ControlWidth + FRoom.Spacing);

    SendMessage(FRoom.Handle, WM_SETREDRAW, 0, 0);
    try
      // Loop to filter and sort items
      for i := 0 to ANodeList.Length - 1 do begin
        if ModalResult = mrCancel then Exit;

        wItemInfo := TItemInfo.Create;

        // Get direct information from XML file
        GRyzomApi.GetItemInfoFromXML(ANodeList.Item(i), wItemInfo);

        // Get more information from item name
        GRyzomApi.GetItemInfoFromName(wItemInfo);

        // Item description
        wItemInfo.ItemDesc := GStrings.Values[wItemInfo.ItemName];

        // Check filter
        if (not FFilter.Enabled) or GRyzomApi.CheckItem(wItemInfo, FFilter) then begin
          wItemList.Add(wItemInfo);
          wSortPrefix := GetSortPrefix(wItemInfo);
          wItemSort.Append(Format('%s%3.3d%d%s=%d', [wSortPrefix, wItemInfo.ItemQuality, Ord(wItemInfo.ItemClass), wItemInfo.ItemName, wItemList.Count-1]));
        end else begin
          wItemInfo.Free;
        end;
      end;

      // Sorting
      wItemSort.Sort;

      // Loop to display items
      FTotalVolume := 0.0;
      for i := 0 to wItemSort.Count - 1 do begin
        if ModalResult = mrCancel then Exit;

        wItemInfo := TItemInfo(wItemList.Items[StrToInt(wItemSort.ValueFromIndex[i])]);
        FTotalVolume := FTotalVolume + wItemInfo.ItemVolume;

        wItemImage := TItemImage.Create(nil);
        wItemImage.Hint := wItemInfo.ItemDesc;
        wItemImage.Data := wItemInfo;
        if FileExists(AStoragePath + wItemInfo.ItemFileName) then begin
          try
            wItemImage.LoadFromFile(AStoragePath + wItemInfo.ItemFileName);
          except
            wItemImage.LoadFromResourceName(_RES_NOICON);
          end;
        end else begin
          wItemImage.LoadFromResourceName(_RES_NOICON);
        end;
        FRoom.AddControl(wItemImage);
        ProgressBar.Position := Trunc( ((i+1) / ANodeList.Length) * 100);
        Application.ProcessMessages;
      end;
    finally
      SendMessage(FRoom.Handle, WM_SETREDRAW, 1, 0);
      FRoom.Refresh;
    end;
  finally
    wItemSort.Free;
    wItemList.Free;
  end;
end;

{*******************************************************************************
Returns a sorting prefix
*******************************************************************************}
function TFormProgress.GetSortPrefix(AItemInfo: TItemInfo): String;
begin
  Result := '';
  case GCurrentFilter.Sorting of
    ioEcosys: Result := IntToStr(Ord(AItemInfo.ItemEcosys));
    ioClass: Result := IntToStr(Ord(AItemInfo.ItemClass));
    ioQuality: Result := Format('%.3d', [AItemInfo.ItemQuality]);
    ioVolume: Result := FormatFloat('0000.00', AItemInfo.ItemVolume);
    ioPrice: if AItemInfo.ItemPrice > 0 then Result := FormatFloat('00000000', AItemInfo.ItemPrice);
    ioTime: if AItemInfo.ItemPrice > 0 then Result := FormatDateTime('yyyymmddhhnnss', AItemInfo.ItemTime);
  end;
    
  case AItemInfo.ItemType of
    itEquipment: begin
      case AItemInfo.ItemEquip of
        iqLightArmor: Result := Result + '01';
        iqMediumArmor: Result := Result + '02';
        iqHeavyArmor: Result := Result + '03';
        iqWeaponMelee: begin
          case AItemInfo.ItemWeapon of
            iwOneHand: Result := Result + '041';
            iwTwoHands: Result := Result + '042';
          end;
        end;
        iqAmplifier: Result := Result + '05';
        iqWeaponRange: begin
          case AItemInfo.ItemWeapon of
            iwOneHand: Result := Result + '061';
            iwTwoHands: Result := Result + '062';
          end;
        end;
        iqShield: Result := Result + '070';
        iqBuckler: Result := Result + '071';
        iqAmmo: Result := Result + '072';
        iqTool: Result := Result + '073';
        iqOther: Result := Result + '08';
        iqJewel: Result := Result + '09';
      end;
    end;
    itNaturalMat, itAnimalMat, itSystemMat: begin
      Result := Result + '10' + Format('%.2d', [AItemInfo.ItemCategory1]);
      if Pos('m0312', AItemInfo.ItemName) = 1 then Result := Result + '1098'; {larva}
      if Pos('system_mp', AItemInfo.ItemName) = 1 then Result := Result + '1099'; {system mp}
    end;
    itTeleporter: Result := Result + '14';
    itOther: Result := Result + '15';
    itCata: Result := Result + '16';
  end;
end;

{*******************************************************************************
Show the room of a guild
*******************************************************************************}
procedure TFormProgress.FillRoom(AGuildID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wInfoFile: String;
  wIndexFile: String;
begin
  FRoom.Clear;
  wInfoFile := GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME;
  if (not FileExists(wInfoFile)) or (MdkFileSize(wInfoFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wInfoFile, fmOpenRead);
  try
    wIndexFile := GConfig.GetGuildPath(AGuildID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      ShowItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Show the inventory of a character
*******************************************************************************}
procedure TFormProgress.FillInvent(ACharID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
begin
  FRoom.Clear;
  wItemsFile := GConfig.GetCharPath(ACharID) + _ITEMS_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wItemsFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := nil;
    case FInventPart of
      0: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
      1: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
      2: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
      3: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
      4: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
      5: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
      6: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/item_in_store/item');
    end;

    try
      if wNodeList <> nil then
        ShowItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{ TGetItemThread }

{*******************************************************************************
Creates the synchronization thread
*******************************************************************************}
constructor TGetItemThread.Create(ANode: TXpNode; AStoragePath: String);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FNode := ANode;
  FStoragePath := AStoragePath;
end;

{*******************************************************************************
Executes the synchronization thread
*******************************************************************************}
procedure TGetItemThread.Execute;
var
  j: Integer;
  wPngCheck: Boolean;
  wPng: TPNGObject;
  wIconFile: TMemoryStream;
  wApi: TRyzomApi;
  wItemInfo: TItemInfo;
begin
  try
    wPng := TPNGObject.Create;
    wApi := TRyzomApi.Create;
    wItemInfo := TItemInfo.Create;
    try
      // Get item infos
      GRyzomApi.GetItemInfoFromXML(FNode, wItemInfo);

      // Ignore item if file already exists in guild directory
      if not FileExists(FStoragePath + wItemInfo.ItemFileName) then begin
        j := 1;
        wPngCheck := False;
        while (not wPngCheck) and (j < 10) do begin
          wIconFile := TMemoryStream.Create;
          try
            // Set proxy parameters
            if GConfig.ProxyEnabled then
              wApi.SetProxyParameters(GConfig.ProxyAddress, GConfig.ProxyPort, GConfig.ProxyUsername, GConfig.ProxyPassword)
            else
              wApi.SetProxyParameters('', 0, '', '');

            // Get item icon
            wApi.ApiItemIcon(wItemInfo.ItemName, wIconFile, wItemInfo.ItemColor, wItemInfo.ItemQuality, wItemInfo.ItemSize, wItemInfo.ItemSap, wItemInfo.ItemDestroyed);
            try
              wPng.LoadFromStream(wIconFile);
              wPng.SaveToFile(FStoragePath + wItemInfo.ItemFileName);
              wPngCheck := True;
            except
              Sleep(100);
            end;
          finally
            wIconFile.Free;
          end;
          Inc(j);
        end;

        if not wPngCheck then
          raise Exception.Create(RS_CONNEXION_ERROR);
      end;
    finally
      wItemInfo.Free;
      wPng.Free;
      wApi.Free;
    end;
  finally
    GSection.Enter;
    try
      Dec(GThreadCount);
      GEvent.SetEvent;
    finally
      GSection.Leave;
    end;
  end;
end;

end.
