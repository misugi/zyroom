unit UnitThreadAlert;

interface

uses
  Classes, SyncObjs, Contnrs, XpDOM, UnitRyzom, RyzomApi, SysUtils,
  MisuDevKit, IniFiles, RegExpr;

type
  TAlert = class(TThread)
  private
    { Private declarations }
    FPause: TEvent;
    FTimeout: Integer;
    FApi: TRyzomApi;

    procedure SynchroChars;
    procedure SynchroGuilds;
    procedure CheckInvent(ACharID: String);
    procedure CheckRoom(AGuildID: String);
    procedure CheckObjects(AGuildID: String);
    procedure CheckItems(AGuardFile: String; AObjectName: String; ASection: String; ANodeList: TXpNodeList; var AVolume: Double);
    procedure CheckSales(ACharID: String);
    procedure CheckSeason(AServerID: String);
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor  Destroy; override;

    property Timeout: Integer read FTimeout write FTimeout;
    procedure Terminate; overload;
  end;

implementation

uses UnitConfig, UnitFormProgress, UnitFormAlert, DateUtils, UnitFormMain;

{ Alert }

{*******************************************************************************
Create
*******************************************************************************}
constructor TAlert.Create;
begin
  inherited Create(False);
  FreeOnTerminate := True;

  FPause := TEvent.Create(nil, True, False, IntToStr(Self.ThreadID));
  FPause.ResetEvent;
  FTimeout := 3600000; // 1h
//  FTimeout := 10000; // Debug

  FApi := TRyzomApi.Create;
  // Set proxy parameters
  if GConfig.ProxyEnabled then
    FApi.SetProxyParameters(GConfig.ProxyAddress, GConfig.ProxyPort, GConfig.ProxyUsername, GConfig.ProxyPassword)
  else
    FApi.SetProxyParameters('', 0, '', '');
end;

{*******************************************************************************
Destroy
*******************************************************************************}
destructor TAlert.Destroy;
begin
  FApi.Free;
  FPause.Free;
  Inherited Destroy;
end;

{*******************************************************************************
Thread for alerts
*******************************************************************************}
procedure TAlert.Execute;
begin
  FPause.WaitFor(10000);
  while not Terminated do begin
    try
      SynchroChars;
      SynchroGuilds;
      CheckSeason(FormMain.ServerID);
      FPause.WaitFor(FTimeout);
    except
    end;
  end;
end;

{*******************************************************************************
Terminate thread
*******************************************************************************}
procedure TAlert.Terminate;
begin
  inherited Terminate;
  FPause.SetEvent;
end;

{*******************************************************************************
Synchronization of all characters
*******************************************************************************}
procedure TAlert.SynchroChars;
var
  wXmlFile: TMemoryStream;
  wList: TStringList;
  wCharID: String;
  wCharKey: String;
  i: Integer;
begin
  wList := TStringList.Create;
  wXmlFile := TMemoryStream.Create;
  try
    GCharacter.CharList(wList);
    for i := 0 to wList.Count - 1 do begin
      if Terminated then Exit;
      wCharID := wList[i];
      wCharKey := GCharacter.GetCharKey(wCharID);
      wXmlFile.Clear;
      FApi.ApiCharacter(wCharKey, cpItems, wXmlFile);
      wXmlFile.SaveToFile(GConfig.GetCharPath(wCharID) + _ITEMS_FILENAME);
      CheckInvent(wCharID);
      if GConfig.SalesCount > 0 then CheckSales(wCharID);
    end;
  finally
    wXmlFile.Free;
    wList.Free;
  end;
end;

{*******************************************************************************
Synchronization of all guilds
*******************************************************************************}
procedure TAlert.SynchroGuilds;
var
  wXmlFile: TMemoryStream;
  wList: TStringList;
  wGuildID: String;
  wGuildKey: String;
  i: Integer;
begin
  wList := TStringList.Create;
  wXmlFile := TMemoryStream.Create;
  try
    GGuild.GuildList(wList);
    for i := 0 to wList.Count - 1 do begin
      if Terminated then Exit;
      wGuildID := wList[i];
      wGuildKey := GGuild.GetGuildKey(wGuildID);
      wXmlFile.Clear;
      FApi.ApiGuild(wGuildKey, wXmlFile);
      wXmlFile.SaveToFile(GConfig.GetGuildPath(wGuildID) + _ITEMS_FILENAME);
      CheckRoom(wGuildID);
      CheckObjects(wGuildID);
    end;
  finally
    wXmlFile.Free;
    wList.Free;
  end;
end;

{*******************************************************************************
Show items
*******************************************************************************}
procedure TAlert.CheckItems(AGuardFile: String; AObjectName: String; ASection: String; ANodeList: TXpNodeList; var AVolume: Double);
var
  i: Integer;
  wItemInfo: TItemInfo;
  wItemList: TItemList;
  wGuard: TIniFile;
  wKeys: TStringList;
  wRegExpr: TRegExpr;
  wItemSlot: Integer;
  wItemQuality: Integer;
  wItemName: String;
  wItemIndex: Integer;
  wItemFound: TItemInfo;
  wValue: Integer;
  wMsg: TAlertMessage;
begin
  wItemList := TItemList.Create(True);
  wKeys := TStringList.Create;
  wRegExpr := TRegExpr.Create;
  try
    AVolume := 0;
    // Loop to get items
    for i := 0 to ANodeList.Length - 1 do begin
      if Terminated then Exit;
      wItemInfo := TItemInfo.Create;

      // Get direct information from XML file
      GRyzomApi.GetItemInfoFromXML(ANodeList.Item(i), wItemInfo);

      // Get more information from item name
      GRyzomApi.GetItemInfoFromName(wItemInfo);

      // Add item in the list
      wItemList.Add(wItemInfo);
      AVolume := AVolume + wItemInfo.ItemVolume;
    end;

    // Check
    wRegExpr.Expression := '(\d+)\.(\d+)\.(.*)';

    wGuard := TIniFile.Create(AGuardFile);
    try
      wGuard.ReadSection(ASection, wKeys);
      for i := 0 to wKeys.Count - 1 do begin
        if Terminated then Exit;

        wRegExpr.Exec(wKeys[i]);
        wItemSlot := StrToInt(wRegExpr.Match[1]);
        wItemQuality := StrToInt(wRegExpr.Match[2]);
        wItemName := wRegExpr.Match[3];
        wItemIndex := wItemList.IndexOf(wItemSlot, wItemQuality, wItemName);
        if wItemIndex > 0 then begin
          wItemFound := wItemList.GetItem(wItemIndex); 
          wValue := wGuard.ReadInteger(ASection, wKeys[i], -1);
          if wItemFound.ItemType = itEquipment then begin
            // Durability alert
            if wItemFound.ItemDur < wValue then begin
              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atDurability;
              wMsg.MsgDate := Now;
              wMsg.MsgName := AObjectName;
              wMsg.MsgLocation := ASection;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
              wMsg.MsgQuality := wItemFound.ItemQuality;
              wMsg.MsgValue1 := wItemFound.ItemDur;
              wMsg.MsgValue2 := wValue;
              wMsg.ItemName := wItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end else begin
            // Quantity alert
            if wItemFound.ItemSize < wValue then begin
              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atQuantity;
              wMsg.MsgDate := Now;
              wMsg.MsgName := AObjectName;
              wMsg.MsgLocation := ASection;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
              wMsg.MsgQuality := wItemFound.ItemQuality;
              wMsg.MsgValue1 := wItemFound.ItemSize;
              wMsg.MsgValue2 := wValue;
              wMsg.ItemName := wItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end;
        end else begin
          // Unfound alert
          wGuard.DeleteKey(ASection, wKeys[i]);
          wMsg := TAlertMessage.Create;
          wMsg.MsgType := atUnfound;
          wMsg.MsgDate := Now;
          wMsg.MsgName := AObjectName;
          wMsg.MsgLocation := ASection;
          wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
          wMsg.MsgQuality := wItemQuality;
          wMsg.ItemName := wItemName;
          FormAlert.NewMessage(wMsg);
        end;
      end;
    finally
      wGuard.Free;
    end;
  finally
    wRegExpr.Free;
    wKeys.Free;
    wItemList.Free;
  end;
end;

{*******************************************************************************
Check character invent
*******************************************************************************}
procedure TAlert.CheckInvent(ACharID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
  wNodeName: String;
  wGuardFile: String;
  wCharName: String;
  wVolume: Double;
  wMsg: TAlertMessage;
begin
  wItemsFile := GConfig.GetCharPath(ACharID) + _ITEMS_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;

  wGuardFile := GConfig.GetCharPath(ACharID) + _GUARD_FILENAME;
  wCharName := GCharacter.GetCharName(ACharID);

  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wItemsFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
    wNodeName := _SECTION_ROOM;
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;

    // Check volume for room
    if GCharacter.GetCheckVolume(ACharID) then begin
      if Trunc(wVolume) > GConfig.VolumeRoom then begin
        wMsg := TAlertMessage.Create;
        wMsg.MsgType := atVolumeRoom;
        wMsg.MsgDate := Now;
        wMsg.MsgName := wCharName;
        wMsg.MsgLocation := wNodeName;
        wMsg.MsgObject := '';
        wMsg.MsgValue1 := Trunc(wVolume);
        wMsg.MsgValue2 := GConfig.VolumeRoom;
        FormAlert.NewMessage(wMsg);
      end;
    end;

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
    wNodeName := 'bag';
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;
    
    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
    wNodeName := 'pet_animal1';
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
    wNodeName := 'pet_animal2';
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
    wNodeName := 'pet_animal3';
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
    wNodeName := 'pet_animal4';
    CheckItems(wGuardFile, wCharName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Check guild room
*******************************************************************************}
procedure TAlert.CheckRoom(AGuildID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
  wNodeName: String;
  wGuardFile: String;
  wGuildName: String;
  wVolume: Double;
  wMsg: TAlertMessage;
begin
  wItemsFile := GConfig.GetGuildPath(AGuildID) + _ITEMS_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;

  wGuardFile := GConfig.GetGuildPath(AGuildID) + _GUARD_FILENAME;
  wGuildName := GGuild.GetGuildName(AGuildID);

  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wItemsFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    wNodeName := _SECTION_ROOM;
    CheckItems(wGuardFile, wGuildName, wNodeName, wNodeList, wVolume);
    wNodeList.Free;

    // Check volume for guild
    if GGuild.GetCheckVolume(AGuildID) then begin
      if Trunc(wVolume) > GConfig.VolumeGuild then begin
        wMsg := TAlertMessage.Create;
        wMsg.MsgType := atVolumeGuild;
        wMsg.MsgDate := Now;
        wMsg.MsgName := wGuildName;
        wMsg.MsgLocation := wNodeName;
        wMsg.MsgObject := '';
        wMsg.MsgValue1 := Trunc(wVolume);
        wMsg.MsgValue2 := GConfig.VolumeGuild;
        FormAlert.NewMessage(wMsg);
      end;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Check all objects in guild
*******************************************************************************}
procedure TAlert.CheckObjects(AGuildID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemInfo: TItemInfo;
  wKeys: TStringList;
  wItemsFile: String;
  wWatchFile: String;
  wGuildName: String;
  wIdent: String;
  wMsg: TAlertMessage;
  wItemList: TItemList;
  wRegExpr: TRegExpr;
  wValue: Integer;
  i: Integer;
  wItemSlot: Integer;
  wItemQuality: Integer;
  wItemName: String;
  wItemIndex: Integer;
  wItemFound: TItemInfo;
begin
  if not GGuild.GetCheckChange(AGuildID) then Exit;
  
  wItemsFile := GConfig.GetGuildPath(AGuildID) + _ITEMS_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;

  wWatchFile := GConfig.GetGuildPath(AGuildID) + _WATCH_FILENAME;
  wGuildName := GGuild.GetGuildName(AGuildID);

  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wItemsFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      wItemList := TItemList.Create(True);
      wRegExpr := TRegExpr.Create;
      wKeys := TStringList.Create;
      try
        if not FileExists(wWatchFile) then begin
          // Create file
          for i := 0 to wNodeList.Length - 1 do begin
            wItemInfo := TItemInfo.Create;
            GRyzomApi.GetItemInfoFromXML(wNodeList.Item(i), wItemInfo);
            GRyzomApi.GetItemInfoFromName(wItemInfo);
            wIdent := Format('%d.%d.%s', [wItemInfo.ItemSlot, wItemInfo.ItemQuality, wItemInfo.ItemName]);
            wKeys.Append(wIdent + '=' + IntToStr(wItemInfo.ItemSize));
            wItemInfo.Free;
          end;
        end else begin
          // Loop to get items
          for i := 0 to wNodeList.Length - 1 do begin
            if Terminated then Exit;
            wItemInfo := TItemInfo.Create;

            // Get direct information from XML file
            GRyzomApi.GetItemInfoFromXML(wNodeList.Item(i), wItemInfo);

            // Get more information from item name
            GRyzomApi.GetItemInfoFromName(wItemInfo);

            // Add item in the list
            wItemList.Add(wItemInfo);
          end;

          // Compare file
          wKeys.LoadFromFile(wWatchFile);
          if wKeys[0] = '[room]' then wKeys.Delete(0); // Compatibility
          i := 0;
          while i < wKeys.Count - 1 do begin
            if Terminated then Exit;

            wRegExpr.Expression := '(\d+)\.(\d+)\.(.*)';
            wRegExpr.Exec(wKeys.Names[i]);
            wItemSlot := StrToInt(wRegExpr.Match[1]);
            wItemQuality := StrToInt(wRegExpr.Match[2]);
            wItemName := wRegExpr.Match[3];
            wValue := StrToIntDef(wKeys.ValueFromIndex[i], -1);

            wItemIndex := wItemList.IndexOf(wItemSlot, wItemQuality, wItemName);
            if wItemIndex >= 0 then begin
              wItemFound := wItemList.GetItem(wItemIndex); 
              // Object modified
              if wItemFound.ItemSize <> wValue then begin
                wKeys.ValueFromIndex[i] := IntToStr(wItemFound.ItemSize);

                wMsg := TAlertMessage.Create;
                wMsg.MsgType := atModified;
                wMsg.MsgDate := Now;
                wMsg.MsgName := wGuildName;
                wMsg.MsgLocation := _SECTION_ROOM;
                wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
                wMsg.MsgQuality := wItemFound.ItemQuality;
                wMsg.MsgValue1 := wValue;
                wMsg.MsgValue2 := wItemFound.ItemSize;
                wMsg.ItemName := wItemName;
                FormAlert.NewMessage(wMsg);
              end;
              Inc(i);
            end else begin
              // Object removed
              wKeys.Delete(i);

              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atRemoved;
              wMsg.MsgDate := Now;
              wMsg.MsgName := wGuildName;
              wMsg.MsgLocation := _SECTION_ROOM;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
              wMsg.MsgQuality := wItemQuality;
              wMsg.MsgValue1 := Abs(wValue);
              wMsg.ItemName := wItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end;

          // new objects
          for i := 0 to wItemList.Count - 1 do begin
            wIdent := Format('%d.%d.%s', [wItemList.GetItem(i).ItemSlot, wItemList.GetItem(i).ItemQuality, wItemList.GetItem(i).ItemName]);
            if wKeys.IndexOfName(wIdent) < 0 then begin
              wValue := wItemList.GetItem(i).ItemSize;
              wKeys.Append(wIdent + '=' + IntToStr(wValue));
              
              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atAdded;
              wMsg.MsgDate := Now;
              wMsg.MsgName := wGuildName;
              wMsg.MsgLocation := _SECTION_ROOM;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemList.GetItem(i).ItemName);
              wMsg.MsgQuality := wItemList.GetItem(i).ItemQuality;
              wMsg.MsgValue1 := Abs(wItemList.GetItem(i).ItemSize);
              wMsg.ItemName := wItemList.GetItem(i).ItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end;
        end;

        // Save file
        wKeys.SaveToFile(wWatchFile);
      finally
        wRegExpr.Free;
        wKeys.Free;
        wItemList.Free;
      end;
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Check sales
*******************************************************************************}
procedure TAlert.CheckSales(ACharID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  i: Integer;
  wCharName: String;
  wItemsFile: String;
  wItemInfo: TItemInfo;
  wMsg: TAlertMessage;
  wNow: TDateTime;
  {wDays, }wHours, wMinutes: Integer;
begin
  if not GCharacter.GetCheckSales(ACharID) then Exit;

  wItemsFile := GConfig.GetCharPath(ACharID) + _ITEMS_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then Exit;

  wCharName := GCharacter.GetCharName(ACharID);

  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wItemsFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);

    if Terminated then Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/item_in_store/item');

    // Loop sales
    for i := 0 to wNodeList.Length - 1 do begin
      if Terminated then Exit;
      wItemInfo := TItemInfo.Create;
      GRyzomApi.GetItemInfoFromXML(wNodeList.Item(i), wItemInfo);

      wNow := Now;
      if wNow < wItemInfo.ItemTime then begin
        wHours := HoursBetween(wNow, wItemInfo.ItemTime);
        if wHours < GConfig.SalesCount then begin
//          wDays := DaysBetween(wNow, wItemInfo.ItemTime);
//          wNow := IncDay(wNow, wDays);
//          wHours := HoursBetween(wNow, wItemInfo.ItemTime);
          wNow := IncHour(wNow, wHours);
          wMinutes := MinutesBetween(wNow, wItemInfo.ItemTime);

          wMsg := TAlertMessage.Create;
          wMsg.MsgType := atSales;
          wMsg.MsgDate := Now;
          wMsg.MsgName := wCharName;
          wMsg.MsgLocation := 'store';
          wMsg.MsgObject := GRyzomStringPack.GetString(wItemInfo.ItemName);
          wMsg.MsgQuality := wItemInfo.ItemQuality;
          wMsg.MsgValue1 := 0;
          wMsg.MsgValue2 := wHours;
          wMsg.MsgValue3 := wMinutes;
          wMsg.MsgInfo := wItemInfo.ItemContinent;
          wMsg.ItemName := wItemInfo.ItemName;
          FormAlert.NewMessage(wMsg);
        end;
      end;
      
      wItemInfo.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Check season
*******************************************************************************}
procedure TAlert.CheckSeason(AServerID: String);
var
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wSeasonIndex: Integer;
  wSeason: String;
  wDayOfSeason: Integer;
  wTimeOfDay: Integer;
  {wDays, }wHours, wMinutes: Integer;
  wNextSeason: TDateTime;
  wMsg: TAlertMessage;
  wNow: TDateTime;
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    GRyzomApi.ApiTime(AServerID, _FORMAT_XML, wStream);
    wXmlDoc.LoadStream(wStream);
    wSeasonIndex := StrToIntDef(wXmlDoc.DocumentElement.SelectString('/shard_time/season'), -1);

    // Calculation of next season
    wDayOfSeason := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/day_of_season'));
    wTimeOfDay := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/time_of_day'));
    wMinutes := ( (89-wDayOfSeason)*24 + (23-wTimeOfDay) )*3;
    wNextSeason := IncMinute(Now, wMinutes);
    
    wNow := Now;
    if wNow < wNextSeason then begin
      wHours := HoursBetween(wNow, wNextSeason);
      if wHours < GConfig.SeasonCount then begin
//          wDays := DaysBetween(wNow, wNextSeason);
//          wNow := IncDay(wNow, wDays);
//          wHours := HoursBetween(wNow, wNextSeason);
        wNow := IncHour(wNow, wHours);
        wMinutes := MinutesBetween(wNow, wNextSeason);

        case wSeasonIndex of
          0: wSeason := RS_SEASON_SUMMER;
          1: wSeason := RS_SEASON_AUTUMN;
          2: wSeason := RS_SEASON_WINTER;
          3: wSeason := RS_SEASON_SPRING;
        else
          wSeason := '-';
        end;

        wMsg := TAlertMessage.Create;
        wMsg.MsgType := atSeason;
        wMsg.MsgDate := Now;
        wMsg.MsgValue1 := 0;
        wMsg.MsgValue2 := wHours;
        wMsg.MsgValue3 := wMinutes;
        wMsg.MsgInfo := wSeason;
        FormAlert.NewMessage(wMsg);
      end;
    end;
  finally
    wXmlDoc.Free;
    wStream.Free;
  end;
end;

end.
