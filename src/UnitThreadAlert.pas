unit UnitThreadAlert;

interface

uses
  Classes, SyncObjs, Contnrs, XpDOM, UnitRyzom, RyzomApi, SysUtils, MisuDevKit,
  IniFiles, RegExpr;

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
    procedure CheckItems(AGuardFile: String; AObjectName: String; ASection:
      String; ANodeList: TXpNodeList; out AVolume: Double; ASlotMin: Integer = 0; ASlotMax: Integer = MaxInt);
    procedure CheckSales(ACharID: String);
    procedure CheckSeason;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Timeout: Integer read FTimeout write FTimeout;
    procedure Terminate; overload;
  end;

implementation

uses
  UnitConfig, UnitFormProgress, UnitFormAlert, DateUtils, UnitFormMain;

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
{$IFNDEF __DEBUG}
  FTimeout := 3600000; // 1h
{$ELSE}
  FTimeout := 10000;
{$ENDIF}

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
      try
        SynchroChars;
        SynchroGuilds;
        CheckSeason;
      finally
        FPause.WaitFor(FTimeout);
      end;
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
      try
        if Terminated then
          Exit;
        wCharID := wList[i];
        wCharKey := GCharacter.GetCharKey(wCharID);
        wXmlFile.Clear;
        FApi.ApiCharacter(wCharKey, wXmlFile);
        wXmlFile.SaveToFile(GConfig.GetCharPath(wCharID) + _INFO_FILENAME);
        CheckInvent(wCharID);
        if GConfig.SalesCount > 0 then
          CheckSales(wCharID);
      except
      end;
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
      try
        if Terminated then
          Exit;
        wGuildID := wList[i];
        wGuildKey := GGuild.GetGuildKey(wGuildID);
        wXmlFile.Clear;
        FApi.ApiGuild(wGuildKey, wXmlFile);
        wXmlFile.SaveToFile(GConfig.GetGuildPath(wGuildID) + _INFO_FILENAME);
        CheckRoom(wGuildID);
        CheckObjects(wGuildID);
      except
      end;
    end;
  finally
    wXmlFile.Free;
    wList.Free;
  end;
end;

{*******************************************************************************
Show items
*******************************************************************************}
procedure TAlert.CheckItems(AGuardFile: String; AObjectName: String; ASection:
  String; ANodeList: TXpNodeList; out AVolume: Double; ASlotMin: Integer; ASlotMax: Integer);
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
      if Terminated then
        Exit;

      // filtrage selon le slot (pour les coffres de guilde)
      wItemSlot := ANodeList.Item(i).SelectInteger('@slot');
      if (wItemSlot < ASlotMin) or (wItemSlot > ASlotMax) then
        Continue;

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
        if Terminated then
          Exit;

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
            if wItemFound.ItemHp < wValue then begin
              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atDurability;
              wMsg.MsgDate := Now;
              wMsg.MsgName := AObjectName;
              wMsg.MsgLocation := ASection;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
              wMsg.MsgQuality := wItemFound.ItemQuality;
              wMsg.MsgValue1 := wItemFound.ItemHp;
              wMsg.MsgValue2 := wValue;
              wMsg.ItemName := wItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end
          else begin
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
        end
        else begin
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
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemsFile: String;
  wGuardFile: String;
  wCharName: String;
  wVolume: Double;
  wMsg: TAlertMessage;
  i: Integer;
  wXpath, wSection: String;
begin
  wItemsFile := GConfig.GetCharPath(ACharID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then
    Exit;

  wGuardFile := GConfig.GetCharPath(ACharID) + _GUARD_FILENAME;
  wCharName := GCharacter.GetCharName(ACharID);

  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);

    if Terminated then
      Exit;

    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_CHAR);
    CheckItems(wGuardFile, wCharName, _SECTION_ROOM, wNodeList, wVolume);
    wNodeList.Free;

    // Check volume for room
    if GCharacter.GetCheckVolume(ACharID) then begin
      if wVolume > (_MAX_VOLUME_CHAR_ROOM * (GConfig.Volume / 100)) then begin
        wMsg := TAlertMessage.Create;
        wMsg.MsgType := atVolumeRoom;
        wMsg.MsgDate := Now;
        wMsg.MsgName := wCharName;
        wMsg.MsgLocation := _SECTION_ROOM;
        wMsg.MsgObject := '';
        wMsg.MsgValue1 := Round(wVolume * 100 / _MAX_VOLUME_CHAR_ROOM);
        FormAlert.NewMessage(wMsg);
      end;
    end;

    // sac
    if Terminated then
      Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_BAG);
    CheckItems(wGuardFile, wCharName, _SECTION_BAG, wNodeList, wVolume);
    wNodeList.Free;

    // animaux (7)
    for i := 0 to 6 do begin
      if Terminated then
        Exit;
      wXpath := Format(_XPATH_PET, [i]);
      wNodeList := wXmlDoc.DocumentElement.SelectNodes(wXpath);
      wSection := Format(_SECTION_PET, [i + 1]);
      CheckItems(wGuardFile, wCharName, wSection, wNodeList, wVolume);
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
  end;
end;

{*******************************************************************************
Check guild room
*******************************************************************************}
procedure TAlert.CheckRoom(AGuildID: String);
var
  wXmlDoc: TXpObjModel;
  wNodeList, wChestList: TXpNodeList;
  wItemsFile: String;
  wGuardFile: String;
  wGuildName: String;
  wVolume: Double;
  wMsg: TAlertMessage;
  wSlotMin, wSlotMax: Integer;
  wCheckVolume: Boolean;
  wBulkmax, wChestNum: Integer;
  wLocation: String;
  i: Integer;
begin
  wItemsFile := GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then
    Exit;

  wGuardFile := GConfig.GetGuildPath(AGuildID) + _GUARD_FILENAME;
  wGuildName := GGuild.GetGuildName(AGuildID);
  wCheckVolume := GGuild.GetCheckVolume(AGuildID);

  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);

    if Terminated then
      Exit;

    wChestList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_GUILD_CHEST);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_GUILD);
    try
      // boucle sur les coffres
      for i := 0 to wChestList.Length - 1 do begin
        wBulkmax := wChestList.Item(i).SelectInteger('bulkmax');
        wChestNum := i + 1;
        wLocation := Format('%s #%d', [_SECTION_ROOM, wChestNum]);

        wSlotMin := i * _CHEST_SEGMENT_SIZE;
        wSlotMax := wSlotMin + _CHEST_SEGMENT_SIZE - 1;
        CheckItems(wGuardFile, wGuildName, _SECTION_ROOM, wNodeList, wVolume, wSlotMin, wSlotMax);

        // Check volume for guild
        if wCheckVolume then begin
          if wVolume > (wBulkmax * (GConfig.Volume / 100)) then begin // todo
            wMsg := TAlertMessage.Create;
            wMsg.MsgType := atVolumeGuild;
            wMsg.MsgDate := Now;
            wMsg.MsgName := wGuildName;
            wMsg.MsgLocation := wLocation;
            wMsg.MsgObject := '';
            wMsg.MsgValue1 := Round(wVolume * 100 / wBulkmax);
            FormAlert.NewMessage(wMsg);
          end;
        end;
      end;
    finally
      wNodeList.Free;
      wChestList.Free;
    end;
  finally
    wXmlDoc.Free;
  end;
end;

{*******************************************************************************
Check all objects in guild
*******************************************************************************}
procedure TAlert.CheckObjects(AGuildID: String);
var
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
  wChestNum: Integer;
  wLocation: String;
begin
  if not GGuild.GetCheckChange(AGuildID) then
    Exit;

  wItemsFile := GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then
    Exit;

  wWatchFile := GConfig.GetGuildPath(AGuildID) + _WATCH_FILENAME;
  wGuildName := GGuild.GetGuildName(AGuildID);

  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);

    if Terminated then
      Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_ROOM_GUILD);
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
        end
        else begin
          // Loop to get items
          for i := 0 to wNodeList.Length - 1 do begin
            if Terminated then
              Exit;
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
          if (wKeys.Count > 0) and (wKeys[0] = '[room]') then
            wKeys.Delete(0); // Compatibility
          i := 0;
          while i < wKeys.Count - 1 do begin
            if Terminated then
              Exit;

            wRegExpr.Expression := '(\d+)\.(\d+)\.(.*)';
            wRegExpr.Exec(wKeys.Names[i]);
            wItemSlot := StrToInt(wRegExpr.Match[1]);
            wItemQuality := StrToInt(wRegExpr.Match[2]);
            wItemName := wRegExpr.Match[3];
            wValue := StrToIntDef(wKeys.ValueFromIndex[i], -1);

            // num�ro de coffre
            wChestNum := (wItemSlot div _CHEST_SEGMENT_SIZE) + 1;
            wLocation := Format('%s #%d', [_SECTION_ROOM, wChestNum]);

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
                wMsg.MsgLocation := wLocation;
                wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
                wMsg.MsgQuality := wItemFound.ItemQuality;
                wMsg.MsgValue1 := wValue;
                wMsg.MsgValue2 := wItemFound.ItemSize;
                wMsg.ItemName := wItemName;
                FormAlert.NewMessage(wMsg);
              end;
              Inc(i);
            end
            else begin
              // Object removed
              wKeys.Delete(i);

              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atRemoved;
              wMsg.MsgDate := Now;
              wMsg.MsgName := wGuildName;
              wMsg.MsgLocation := wLocation;
              wMsg.MsgObject := GRyzomStringPack.GetString(wItemName);
              wMsg.MsgQuality := wItemQuality;
              wMsg.MsgValue1 := Abs(wValue);
              wMsg.ItemName := wItemName;
              FormAlert.NewMessage(wMsg);
            end;
          end;

          // new objects
          for i := 0 to wItemList.Count - 1 do begin
            wItemSlot := wItemList.GetItem(i).ItemSlot;
            wItemQuality := wItemList.GetItem(i).ItemQuality;
            wItemName := wItemList.GetItem(i).ItemName;
            wIdent := Format('%d.%d.%s', [wItemSlot, wItemQuality, wItemName]);
            if wKeys.IndexOfName(wIdent) < 0 then begin
              // num�ro de coffre
              wChestNum := (wItemSlot div _CHEST_SEGMENT_SIZE) + 1;
              wLocation := Format('%s #%d', [_SECTION_ROOM, wChestNum]);

              wValue := wItemList.GetItem(i).ItemSize;
              wKeys.Append(wIdent + '=' + IntToStr(wValue));

              wMsg := TAlertMessage.Create;
              wMsg.MsgType := atAdded;
              wMsg.MsgDate := Now;
              wMsg.MsgName := wGuildName;
              wMsg.MsgLocation := wLocation;
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
  end;
end;

{*******************************************************************************
Check sales
*******************************************************************************}
procedure TAlert.CheckSales(ACharID: String);
var
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  i: Integer;
  wCharName: String;
  wItemsFile: String;
  wItemInfo: TItemInfo;
  wMsg: TAlertMessage;
  wNow: TDateTime;
  wHours, wMinutes: Integer;
begin
  if not GCharacter.GetCheckSales(ACharID) then
    Exit;

  wItemsFile := GConfig.GetCharPath(ACharID) + _INFO_FILENAME;
  if (not FileExists(wItemsFile)) or (MdkFileSize(wItemsFile) = 0) then
    Exit;

  wCharName := GCharacter.GetCharName(ACharID);

  wXmlDoc := TXpObjModel.Create(nil);
  try
    wXmlDoc.LoadDataSource(wItemsFile);

    if Terminated then
      Exit;
    wNodeList := wXmlDoc.DocumentElement.SelectNodes(_XPATH_SHOP);

    // Loop sales
    for i := 0 to wNodeList.Length - 1 do begin
      if Terminated then
        Exit;
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
          wMsg.MsgLocation := _SECTION_SHOP;
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
  end;
end;

{*******************************************************************************
Check season
*******************************************************************************}
procedure TAlert.CheckSeason;
var
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wSeasonIndex: Integer;
  wSeason: String;
  wDayOfSeason: Integer;
  wTimeOfDay: Integer;
  wHours, wMinutes: Integer;
  wNextSeason: TDateTime;
  wMsg: TAlertMessage;
  wNow: TDateTime;
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    GRyzomApi.ApiTime(_FORMAT_XML, wStream);
    wXmlDoc.LoadStream(wStream);
    wSeasonIndex := StrToIntDef(wXmlDoc.DocumentElement.SelectString('/shard_time/season'), -1);

    // Calculation of next season
    wDayOfSeason := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/day_of_season'));
    wTimeOfDay := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/time_of_day'));
    wMinutes := ((89 - wDayOfSeason) * 24 + (23 - wTimeOfDay)) * 3;
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
          0:
            wSeason := RS_SEASON_SUMMER;
          1:
            wSeason := RS_SEASON_AUTUMN;
          2:
            wSeason := RS_SEASON_WINTER;
          3:
            wSeason := RS_SEASON_SPRING;
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

