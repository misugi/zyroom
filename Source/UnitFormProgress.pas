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
unit UnitFormProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, XpDOM, ExtCtrls, ScrollRoom, ItemImage,
  pngimage, UnitRyzom, regexpr, SyncObjs, Contnrs, StrUtils, IniFiles,
  SevenButton;

resourcestring
  RS_PROGRESS_SYNCHRONIZE = 'Synchronisation en cours, veuillez patienter...';
  RS_PROGRESS_ROOM = 'Affichage en cours, veuillez patienter...';
  RS_CONNEXION_ERROR = 'Trop d''erreurs API, arrêt de la synchronisation';
  RS_PARSE_LOG = 'Analyse du fichier de log, veuillez patienter...';
  RS_CLEAN_LOG = 'Nettoyage du fichier de log, veuillez patienter...';

const
  _TASK_SYNCHRONIZE = 0;
  _TASK_ROOM = 1;
  _TASK_SYNCHRONIZE_CHAR = 2;
  _TASK_INVENT = 3;
  _TASK_PARSE_LOG = 4;
  _TASK_CLEAN_LOG = 5;

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
    BtCancel: TSevenButton;
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
    FEyes: TPNGObject;
    FGuardFile: TIniFile;
    FLogFile: String;
    FFirstLoading: Boolean;
    FCleanDate: TDateTime;
    FDappers: String;

    procedure FillRoom(AGuildID: String);
    procedure FillInvent(ACharID: String);
    procedure GetItem(ANodeList: TXpNodeList; AStoragePath: String);
    procedure ShowItem(ANodeList: TXpNodeList; ASection: String; AStoragePath: String);
    function  GetSortPrefix(AItemInfo: TItemInfo): String;
    procedure CloseForm;

    procedure ParseLogFile(AFirstLoading: Boolean);
    procedure CleanLogFile(ADate: TDateTime = 0);
    function  ColorTextHtml(AHtmlColor: String; AText: String): String;
    function  ColorTextBbcode(AHtmlColor: String; AText: String): String;
    function  CheckSystemFilter(AMessage: String): Boolean;
    function  IsSystemLine(ALine: String): Boolean;
    function  ReplaceHtmlSpecialChars(ALine: String): String;
  public
    procedure SynchronizeGuild(AGuildID: String);
    procedure SynchronizeChar(ACharID: String);
    procedure ShowFormSyncGuild(AGuildID: String);
    procedure ShowFormSyncChar(ACharID: String);
    procedure ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
    procedure ShowFormInvent(ACharID: String; ARoom: TScrollRoom; AInventPart: Integer; AFilter: TItemFilter);
    procedure ShowParseLog(ALogFile: String; AFirstLoading: Boolean);
    procedure ShowCleanLog(ALogFile: String; ADate: TDateTime = 0);

    function  LogToHtmlColor(ALogColor: String): String;
    function  LogToDelphiColor(ALogColor: String): TColor;
    function  DelphiToHtmlColor(ADelphiColor: TColor): String;

    property  TotalVolume: Double read FTotalVolume write FTotalVolume;
    property  Dappers: String read FDappers write FDappers;
  end;

var
  FormProgress: TFormProgress;
  GSection: TCriticalSection;
  GEvent: TEvent;
  GThreadCount: Integer;
  GStrings: TStringList;
  GGuarded: TStringList;

implementation

uses UnitConfig, RyzomApi, MisuDevKit, Math, UnitFormLog, DateUtils;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormProgress.FormCreate(Sender: TObject);
begin
  GStrings := TStringList.Create;
  GStrings.Sorted := True;
  GGuarded := TStringList.Create;
  GSection := TCriticalSection.Create;
  GEvent := TEvent.Create(nil, True, False, 'synchronization');
  GEvent.ResetEvent;
  FEyes := TPNGObject.Create;
  FEyes.LoadFromResourceName(HInstance, _RES_CLOSED);
  FGuardFile := nil;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormProgress.FormDestroy(Sender: TObject);
begin
  FGuardFile.Free;
  FEyes.Free;
  GStrings.Free;
  GGuarded.Free;
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
  wItemDesc: String;
begin
  GThreadCount := 0;
  i := 0;
  while i < ANodeList.Length do begin
    if ModalResult = mrCancel then Break;

    wItemName := ANodeList.Item(i).SelectString('.//sheet');
    if Pos('#', wItemName) = 1 then
      wItemName := GRyzomApi.GetSheetName(wItemName);
    if GStrings.IndexOfName(wItemName) < 0 then begin
      wItemDesc := GRyzomStringPack.GetString(wItemName);
      if wItemDesc <> '' then
        GStrings.Append(wItemName + '=' + wItemDesc);
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
  wGuardFile: String;
begin
  wGuildKey := GGuild.GetGuildKey(AGuildID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TMemoryStream.Create;
  try
    // Prepare the index file for name search
    wIndexFile := GConfig.GetGuildPath(AGuildID) + _INDEX_FILENAME;
    if FileExists(wIndexFile) then begin
      GStrings.LoadFromFile(wIndexFile);
      if (GStrings.Count > 0) and (GStrings.ValueFromIndex[0] = '') then GStrings.Clear; // Compatibility code (version 3.1.6)
      GStrings.Sort;
    end else begin
      GStrings.Clear;
    end;

    // Load the file with guarded items
    wGuardFile := GConfig.GetGuildPath(AGuildID) + _GUARD_FILENAME;
    FreeAndNil(FGuardFile);
    FGuardFile := TIniFile.Create(wGuardFile);

    {$IFNDEF  __NOSYNCH}
    wXmlDoc.LoadDataSource(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME);
    try
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_GUILD);
      try
        GetItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
      finally
        wNodeList.Free;
      end;
    finally
      GStrings.SaveToFile(wIndexFile);
    end;
    {$ENDIF}
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
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wIndexFile: String;
  wGuardFile: String;
begin
  wXmlDoc := TXpObjModel.Create(nil);
  try
    // Prepare the index file for name search
    wIndexFile := GConfig.GetCharPath(ACharID) + _INDEX_FILENAME;
    if FileExists(wIndexFile) then begin
      GStrings.LoadFromFile(wIndexFile);
      if (GStrings.Count > 0) and (GStrings.ValueFromIndex[0] = '') then GStrings.Clear; // Compatibility code (version 3.1.6)
      GStrings.Sort;
    end else begin
      GStrings.Clear;
    end;

    // Load the file with guarded items
    wGuardFile := GConfig.GetCharPath(ACharID) + _GUARD_FILENAME;
    FreeAndNil(FGuardFile);
    FGuardFile := TIniFile.Create(wGuardFile);

    {$IFNDEF __NOSYNCH}
    wXmlDoc.LoadDataSource(GConfig.GetCharPath(ACharID) + _INFO_FILENAME);
    try
      // Room
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_CHAR);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Bag
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_BAG);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet1
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET1);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet2
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET2);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet3
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET3);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Pet4
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET4);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;

      // Sales
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_STORE);
      try
        GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
      finally
        wNodeList.Free;
      end;
    finally
      GStrings.SaveToFile(wIndexFile);
    end;
    {$ENDIF}
  finally
    wXmlDoc.Free;
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
      _TASK_INVENT: FillInvent(FCharID);
      _TASK_PARSE_LOG: ParseLogFile(FFirstLoading);
      _TASK_CLEAN_LOG: CleanLogFile(FCleanDate);
    end;
  finally
    CloseForm;
  end;
end;

{*******************************************************************************
Starts a guild synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSyncGuild(AGuildID: String);
begin
  FGuildID := AGuildID;
  FProcessingType := _TASK_SYNCHRONIZE;
  LbProgress.Caption := RS_PROGRESS_SYNCHRONIZE;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a character synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSyncChar(ACharID: String);
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
Parse a log file
*******************************************************************************}
procedure TFormProgress.ShowParseLog(ALogFile: String; AFirstLoading: Boolean);
begin
  FLogFile := ALogFile;
  FFirstLoading := AFirstLoading;
  FProcessingType := _TASK_PARSE_LOG;
  LbProgress.Caption := RS_PARSE_LOG;
  Self.ShowModal;
end;

{*******************************************************************************
Clean a log file
*******************************************************************************}
procedure TFormProgress.ShowCleanLog(ALogFile: String; ADate: TDateTime);
begin
  FLogFile := ALogFile;
  FCleanDate := ADate;
  FProcessingType := _TASK_CLEAN_LOG;
  LbProgress.Caption := RS_CLEAN_LOG;
  Self.ShowModal;
end;

{*******************************************************************************
Show items
*******************************************************************************}
procedure TFormProgress.ShowItem(ANodeList: TXpNodeList; ASection: String; AStoragePath: String);
var
  i: Integer;
  wItemImage: TItemImage;
  wItemInfo: TItemInfo;
  wItemList: TObjectList;
  wItemSort: TStringList;
  wSortPrefix: String;
  wIndex: Integer;
  wIdent: String;
begin
  wItemList := TObjectList.Create(False);
  wItemSort := TStringList.Create;
  try
    // Adjust the width of the room
    FRoom.ColCount := (FRoom.Width - GetSystemMetrics(SM_CXVSCROLL)) div (FRoom.ControlWidth + FRoom.Spacing);

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

        // Item guarded
        wIdent := Format('%d.%d.%s', [wItemInfo.ItemSlot, wItemInfo.ItemQuality, wItemInfo.ItemName]);
        wIndex := GGuarded.IndexOf(wIdent);
        if wIndex >= 0 then begin
          wItemInfo.ItemGuarded := True;
          wItemInfo.ItemGuardValue := FGuardFile.ReadInteger(ASection, wIdent, -1);
        end;

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
        wItemImage.StickerPosX := 9;
        wItemImage.StickerPosY := 9;
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

        if wItemInfo.ItemGuarded then
          wItemImage.PngSticker.LoadFromResourceName(HInstance, _RES_EYES);

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
    ioVolume: Result := FormatFloat2('0000.00', AItemInfo.ItemVolume);
    ioQuantity: Result := Format('%.3d', [AItemInfo.ItemSize]);
    ioPrice: if AItemInfo.ItemPrice > 0 then Result := FormatFloat2('00000000', AItemInfo.ItemPrice);
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
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
begin
  FRoom.Clear;
  wItemsFile := GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_GUILD);

    GGuarded.Clear;
    if FGuardFile <> nil then
      FGuardFile.ReadSection(_SECTION_ROOM, GGuarded);

    try
      ShowItem(wNodeList, _SECTION_ROOM, GConfig.GetGuildRoomPath(AGuildID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
  end;
end;

{*******************************************************************************
Show the inventory of a character
*******************************************************************************}
procedure TFormProgress.FillInvent(ACharID: String);
var
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
  wSection: String;
begin
  FRoom.Clear;
  wItemsFile := GConfig.GetCharPath(ACharID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);
    wSection := '';
    wNodeList := nil;
    case FInventPart of
      0: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_CHAR); wSection := _SECTION_ROOM; end;
      1: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_BAG);  wSection := _SECTION_BAG; end;
      2: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET1);  wSection := _SECTION_PET1; end;
      3: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET2);  wSection := _SECTION_PET2; end;
      4: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET3);  wSection := _SECTION_PET3; end;
      5: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_PET4);  wSection := _SECTION_PET4; end;
      6: begin wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_STORE);  wSection := _SECTION_STORE; end;
    end;

    GGuarded.Clear;
    if FGuardFile <> nil then
      FGuardFile.ReadSection(wSection, GGuarded);

    try
      if wNodeList <> nil then
        ShowItem(wNodeList, wSection, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
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
            wApi.ApiItemIcon(wItemInfo.ItemName, wIconFile, wItemInfo.ItemColor, wItemInfo.ItemQuality, wItemInfo.ItemSize, IfThen(wItemInfo.ItemSap, 0, -1), wItemInfo.ItemDestroyed, wItemInfo.ItemLocked);
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

{*******************************************************************************
Convert a log color to HTML color
*******************************************************************************}
function TFormProgress.LogToHtmlColor(ALogColor: String): String;
var
  wRed: Integer;
  wGreen: Integer;
  wBlue: Integer;
begin
  if Length(ALogColor) <> 7 then
    raise Exception.Create('Invalid color: '+ALogColor);

  wRed := (StrToInt('$'+ALogColor[3]) shl 4);
  wGreen := (StrToInt('$'+ALogColor[4]) shl 4);
  wBlue := (StrToInt('$'+ALogColor[5]) shl 4);

  Result := '#' + IntToHex(wRed, 2) + IntToHex(wGreen, 2) + IntToHex(wBlue, 2);
end;

{*******************************************************************************
Convert a log color to Delphi color
*******************************************************************************}
function TFormProgress.LogToDelphiColor(ALogColor: String): TColor;
var
  wColor: String;
begin
  wColor := LogToHtmlColor(ALogColor);
  Result := StrToInt('$00' + Copy(wColor, 6, 2) + Copy(wColor, 4, 2) + Copy(wColor, 2, 2));
end;

{*******************************************************************************
Convert a Delphi color to HTML color
*******************************************************************************}
function TFormProgress.DelphiToHtmlColor(ADelphiColor: TColor): String;
var
  wHex: String;
begin
  wHex := IntToHex(ADelphiColor, 6);
  Result := '#' + Copy(wHex, 5, 2) + Copy(wHex, 3, 2) + Copy(wHex, 1, 2);
end;

{*******************************************************************************
Add color to the text in HTML
*******************************************************************************}
function TFormProgress.ColorTextHtml(AHtmlColor: String; AText: String): String;
begin
  AText := ReplaceHtmlSpecialChars(AText);
  Result := Format('<font color="%s">%s</font>', [AHtmlColor, AText]);
end;

{*******************************************************************************
Add color to the text in BBCode
*******************************************************************************}
function TFormProgress.ColorTextBbcode(AHtmlColor, AText: String): String;
begin
  Result := Format('[color=%s]%s[/color]', [AHtmlColor, AText]);
end;

{*******************************************************************************
Parse the log file
*******************************************************************************}
procedure TFormProgress.ParseLogFile(AFirstLoading: Boolean);
const
  _BOM_UTF8 = #$EF#$BB#$BF;
var
  wReg: TRegExpr;
  wReg2: TRegExpr;
  wChatLog: TextFile;
  wHtmlFile: TextFile;
  wBbcodeFile: TextFile;
  wTextFile: TextFile;
  wChatSize: Cardinal;
  wTotalBytes: Integer;
  wFirstLine: Boolean;
  
  wDate: String;
  wText: String;
  wTextHtml, wTextBbcode, wTextBrut: String;
  wLine, wLine2: String;
  wCharacter: String;
  wUtf8File: Boolean;

  wSysColor, wBackColor: String;
  wColorText1, wColorText2: String;
  wColorPos1, wColorPos2: Integer;
  wChannel: String;

  wDateStart, wDateEnd, wDateLine: TDateTime;
  wListChannels, wListCharacters: TStringList;

  wSystemMessage: Boolean;
  wWriteEnabled: Boolean;
begin
  with FormLog do begin
    // Colors
    wSysColor := DelphiToHtmlColor(PnColorSystem.Color);
    wBackColor := DelphiToHtmlColor(PnColorBackground.Color);
    wColorText2 := wSysColor;

    // Create objects
    wReg := TRegExpr.Create;
    wReg2 := TRegExpr.Create;
    wListChannels := TStringList.Create;
    wListCharacters := TStringList.Create;

    // Open files
    AssignFile(wChatLog, FLogFile);
    Reset(wChatLog);
    
    AssignFile(wHtmlFile, LogFileHtml);
    Rewrite(wHtmlFile);
    
    AssignFile(wBbcodeFile, LogFileBbode);
    Rewrite(wBbcodeFile);
    
    AssignFile(wTextFile, LogFileText);
    Rewrite(wTextFile);
    try
      wReg.ModifierM := True;
      wReg.ModifierG := False;
      wReg2.ModifierG := False;

      // Header
      WriteLn(wHtmlFile, Format('<html><head><title></title></head><body bgcolor="%s"><font face="%s" size=2 color="%s">', [wBackColor, _FONT_NAME, wSysColor]));
      WriteLn(wBbcodeFile, '[quote]');

      // All lines
      wDateStart := 0;
      wDateEnd := 0;
      wDateLine := 0;
      wUtf8File := True;
      wFirstLine := True;
      wSystemMessage := True;

      wTotalBytes := 0;
      wChatSize := MdkFileSize(FLogFile);
      while not Eof(wChatLog) do begin
        if Self.ModalResult = mrCancel then Exit;
        ReadLn(wChatLog, wLine);

        // Empty line ?
        wLine := Trim(wLine);
        if Length(wLine) = 0 then Continue;

        // Decode the line (UTF-8)
        if wUtf8File then begin
          // Remove the UTF-8 BOM if exists (only for the first line)
          if wFirstLine and (Pos(_BOM_UTF8, wLine) = 1) then
            wLine := RightStr(wLine, Length(wLine) - Length(_BOM_UTF8));
          wFirstLine := False;

          wLine2 := UTF8Decode(wLine); // if function failed, return empty string
          if Length(wLine2) > 0 then
            wLine := wLine2
          else
            wUtf8File := False;
        end;

        wReg.Expression := '^(\d{4})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2}) (\((.*)\) )?\* (.*)$';
        if wReg.Exec(wLine) then begin
          // Date at the beginning of the line
          wDateLine := EncodeDateTime(StrToInt(wReg.Match[1]), StrToInt(wReg.Match[2]), StrToInt(wReg.Match[3]),
                                      StrToInt(wReg.Match[4]), StrToInt(wReg.Match[5]), StrToInt(wReg.Match[6]), 0);
          if wDateStart = 0 then
            wDateStart := wDateLine;

          if CbShowDate.Checked then
            wDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', wDateLine) + ' * ';

          // Message système ?
          wSystemMessage := IsSystemLine(wLine);
          wLine := wReg.Match[wReg.SubExprMatchCount];
          if wSystemMessage then begin
            wTextHtml := wLine;
            wTextBbcode := wLine;
            wTextBrut := wLine;
          end else begin
            // Initialization
            wTextHtml := '';
            wTextBbcode := '';
            wColorPos1 := 0;
            wColorPos2 := 0;

            // Find character
            wReg2.Expression := '@\{\w{4}\}.*(\w+)\s';
            if wReg2.Exec(wLine) then begin
              wCharacter := wReg2.Match[1];
              wCharacter := UpperCase(wCharacter[1]) + RightStr(wCharacter, Length(wCharacter)-1);
              if wListCharacters.IndexOf(wCharacter) < 0 then
                wListCharacters.Append(wCharacter);
            end;

            // Find channels identified by a color code: @{FFFF}
            wReg2.Expression := '@\{\w{4}\}';
            if wReg2.Exec(wLine) then begin
              wColorPos1 := wReg2.MatchPos[0];
              wColorText1 := wReg2.Match[0];
              if wReg2.ExecNext then begin
                wColorPos2 := wReg2.MatchPos[0];
                wColorText2 := wReg2.Match[0];
              end;
            end;

            // First color
            if wColorPos1 > 0 then begin
              wText := Copy(wLine, wColorPos1 + 7, wColorPos2-8);
              wTextHtml := wTextHtml + ColorTextHtml(LogToHtmlColor(wColorText1), wText);
              wTextBbcode := wTextBbcode + ColorTextBbcode(LogToHtmlColor(wColorText1), wText);
              wTextBrut := wText;
            end;

            // Second color
            if wColorPos2 > 0 then begin
              wChannel := wColorText2;
              if Length(wReg.Match[8]) > 0 then
                wChannel := wReg.Match[8] + wColorText2;
              if (wListChannels.IndexOf(wChannel) < 0) then
                wListChannels.Append(wChannel);

              wText := Copy(wLine, wColorPos2 + 7, Length(wLine)-wColorPos2-6);
              wTextHtml := wTextHtml + ColorTextHtml(LogToHtmlColor(wColorText2), wText);
              wTextBbcode := wTextBbcode + ColorTextBbcode(LogToHtmlColor(wColorText2), wText);
              wTextBrut := wTextBrut + wText;
            end;
          end;
        end else begin
          // No date at the beginning of the line
          wDate := '';
          wTextHtml := ColorTextHtml(LogToHtmlColor(wColorText2), wLine);
          wTextBbcode := ColorTextBbcode(LogToHtmlColor(wColorText2), wLine);
          wTextBrut := wLine;
        end;

        // Check date
        if CbShowDate.Checked then begin
          wTextHtml := wDate + wTextHtml;
          wTextBbcode := wDate + wTextBbcode;
          wTextBrut := wDate + wTextBrut;
        end;

        // Write HTML code
        wWriteEnabled := ((not wSystemMessage) or (wSystemMessage and CbSystemMessage.Checked and CheckSystemFilter(wTextBrut)));
        if not AFirstLoading then
          // Check options
          wWriteEnabled :=
           (wWriteEnabled) and 
           (wDateLine >= (DateOf(DatePickerStart.Date) + TimeOf(TimePickerStart.Time))) and
           (wDateLine <= (DateOf(DatePickerEnd.Date) + TimeOf(TimePickerEnd.Time))) and
           ((wSystemMessage) or ((ListChannels.Count > 0) and ListChannels.Checked[ListChannels.Items.IndexOf(wChannel)])) and
           ((wSystemMessage) or ((ListCharacters.Count > 0) and ListCharacters.Checked[ListCharacters.Items.IndexOf(wCharacter)]));

        // Writing OK
        if wWriteEnabled then begin
          WriteLn(wHtmlFile, wTextHtml + '<br>');
          WriteLn(wBbcodeFile, wTextBbcode);
          WriteLn(wTextFile, wTextBrut);
        end;

        // Stop if the end date has passed
        if (not AFirstLoading) and (wDateLine > (DateOf(DatePickerEnd.Date) + TimeOf(TimePickerEnd.Time))) then Break;

        // Progression
        wTotalBytes := wTotalBytes + Length(wLine)+2;
        ProgressBar.Position := Trunc( (wTotalBytes / wChatSize) * 100);
        Application.ProcessMessages;
      end; // end while

      // Date end
      if (wDateStart > 0) then
        wDateEnd := wDateLine;

      // Update available options
      if AFirstLoading then begin
        if wDateStart > 0 then begin
          // initialisation à 0 pour éviter l'erreur Min > Max
          DatePickerStart.MinDate := 0;
          DatePickerStart.MaxDate := DateOf(wDateEnd);
          DatePickerStart.MinDate := DateOf(wDateStart);
          DatePickerStart.Date := DateOf(wDateStart);
          TimePickerStart.Time := TimeOf(wDateStart);

          DatePickerEnd.MinDate := 0;
          DatePickerEnd.MaxDate := DateOf(wDateEnd);
          DatePickerEnd.MinDate := DateOf(wDateStart);
          DatePickerEnd.Date := DateOf(wDateEnd);
          TimePickerEnd.Time := TimeOf(wDateEnd);
        end;

        ListChannels.Items.Assign(wListChannels);
        ChangeChecked(ListChannels, True);

        wListCharacters.Sort;
        ListCharacters.Items.Assign(wListCharacters);
        ChangeChecked(ListCharacters, True);
      end;

      // Footer
      WriteLn(wHtmlFile, '</font></body></html>');
      WriteLn(wBbcodeFile, '[/quote]');
    finally
      // Free objects
      wListCharacters.Free;
      wListChannels.Free;
      wReg2.Free;
      wReg.Free;

      // Close files
      CloseFile(wBbcodeFile);
      CloseFile(wHtmlFile);
      CloseFile(wTextFile);
      CloseFile(wChatLog);
    end;

    // Load HTML file in the browser
    WebLog.Navigate(LogFileHtml);
  end;
end;

{*******************************************************************************
Check a system message with filters defined
*******************************************************************************}
function TFormProgress.CheckSystemFilter(AMessage: String): Boolean;
var
  i: Integer;
begin
  Result := True;
  with FormLog do begin
    for i := 0 to ListFilter.Count - 1 do begin
      if Pos(LowerCase(ListFilter.Items[i]), LowerCase(AMessage)) > 0 then begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

{*******************************************************************************
Nettoyage du fichier de log
*******************************************************************************}
procedure TFormProgress.CleanLogFile(ADate: TDateTime);
var
  wChatLog: TextFile;
  wNewFile: TextFile;
  wNewFileName: String;
  wLine: String;
  wDateLine: TDate;
  wChatSize: Cardinal;
  wTotalBytes: Integer;
  wYear, wMonth, wDay: Integer;
begin
  wNewFileName := ChangeFileExt(FLogFile, '-clean' + ExtractFileExt(FLogFile));
  AssignFile(wChatLog, FLogFile);
  AssignFile(wNewFile, wNewFileName);
  Reset(wChatLog);
  Rewrite(wNewFile);
  try
    wTotalBytes := 0;
    wChatSize := MdkFileSize(FLogFile);
    ReadLn(wChatLog, wLine);

    if ADate = 0 then begin
      // suppression des messages système
      while not Eof(wChatLog) do begin
        if ModalResult = mrCancel then Exit;

        if not IsSystemLine(wLine) then
          WriteLn(wNewFile, wLine);

        // Progression
        wTotalBytes := wTotalBytes + Length(wLine)+2;
        ProgressBar.Position := Trunc( (wTotalBytes / wChatSize) * 100);
        Application.ProcessMessages;

        ReadLn(wChatLog, wLine);
      end;
    end else begin
      // suppression des vieux messages
      while not Eof(wChatLog) do begin
        if ModalResult = mrCancel then Exit;

        wDateLine := 0;
        wYear := StrToIntDef(Copy(wLine, 1, 4), -1);
        if wYear >= 0 then begin
          wMonth := StrToInt(Copy(wLine, 6, 2));
          wDay := StrToInt(Copy(wLine, 9, 2));
          wDateLine := EncodeDate(wYear, wMonth, wDay);
        end;

        if (wDateLine = 0) or (wDateLine >= ADate) then
          WriteLn(wNewFile, wLine);

        // Progression
        wTotalBytes := wTotalBytes + Length(wLine)+2;
        ProgressBar.Position := Trunc( (wTotalBytes / wChatSize) * 100);
        Application.ProcessMessages;

        ReadLn(wChatLog, wLine);
      end;
    end;
  finally
    CloseFile(wChatLog);
    CloseFile(wNewFile);
  end;

  Windows.MoveFileEx(PChar(wNewFileName), PChar(FLogFile), MOVEFILE_REPLACE_EXISTING);
end;

{*******************************************************************************
Indique si la ligne du log est une ligne système
*******************************************************************************}
function TFormProgress.IsSystemLine(ALine: String): Boolean;
begin
  // Une ligne système = pas de caractère @ et début avec la date
  Result := (Pos('* @{', ALine) = 0) and (StrToIntDef(Copy(ALine, 1, 4), -1) >= 0);
end;

{*==============================================================================
Replace special chars for HTML
===============================================================================}
function TFormProgress.ReplaceHtmlSpecialChars(ALine: String): String;
begin
  Result := ALine;
  if (Pos('>', ALine) > 0) or (Pos('<', ALine) > 0) then begin
    Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
    Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  end;
end;

end.
