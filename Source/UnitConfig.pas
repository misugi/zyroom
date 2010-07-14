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
unit UnitConfig;

interface

uses
  Classes, IniFiles, SysUtils, LbCipher, LbClass, LbString, XpDOM, Graphics,
  Forms, RegExpr, MisuDevKit, StrUtils;

resourcestring
  RS_ERROR_GUILD_ALREADY_EXISTS = 'La guilde existe déjà';
  RS_ERROR_GUILD_NOTFOUND = 'La guilde est introuvable';
  RS_ERROR_KEY_NOTFOUND = 'La clé API est introuvable';
  RS_ERROR_NAME_NOTFOUND = 'Le nom de la guilde est introuvable';
  RS_ERROR_CHAR_ALREADY_EXISTS = 'Le personnage existe déjà';
  RS_ERROR_CHAR_NOTFOUND = 'Le personnage est introuvable';
  RS_ERROR_CHARNAME_NOTFOUND = 'Le nom du personnage est introuvable';
  
const
  _ENCRYPTION_KEY : TKey64 = (10, 158, 47, 92, 35, 221, 29, 203);
  _CONFIG_FILENAME = 'config.ini';
  _GUILD_DIR = 'guild';
  _ROOM_DIR = 'room';
  _ALERT_DIR = 'alert';
  _CHARACTER_DIR = 'character';
  _PACK_FILEPATH = '\save\string_client.pack';
  _LANGUAGE_FILENAME = 'languages.lcf';
  _LANGUAGE_FRENCH_ID = 1036;
  _LANGUAGE_GERMAN_ID = 1031;
  _LANGUAGE_ENGLISH_ID = 2057;
  
  _SECTION_GENERAL = 'GENERAL';
  _SECTION_PROXY = 'PROXY';
  _SECTION_POSITION = 'POSITION';
  _SECTION_ALERT = 'ALERT';
  _SECTION_ROOM = 'room';
  _KEY_LANGUAGE = 'Language';
  _KEY_PACKFILE = 'PackFile';
  _KEY_PROXY_ENABLED = 'Enabled';
  _KEY_PROXY_BASIC_AUTH = 'BasicAuth';
  _KEY_PROXY_ADDRESS = 'Address';
  _KEY_PROXY_PORT = 'Port';
  _KEY_PROXY_USER = 'Username';
  _KEY_PROXY_PASSWORD = 'Password';
  _KEY_INTERFACE_COLOR = 'Color';
  _KEY_POS_AUTOSAVE = 'AutoSave';
  _KEY_POS_MAIN_LEFT = 'MainLeft';
  _KEY_POS_MAIN_TOP = 'MainTop';
  _KEY_POS_FILTER_LEFT = 'FilterLeft';
  _KEY_POS_FILTER_TOP = 'FilterTop';
  _KEY_THREAD_COUNT = 'ThreadCount';
  _KEY_SAVE_FILTER = 'SaveFilter';
  _KEY_ALERT_SAVEFILE = 'SaveFile';
  _KEY_ALERT_VOLUME_ROOM = 'VolumeRoom';
  _KEY_ALERT_VOLUME_GUILD = 'VolumeGuild';
  _KEY_ALERT_SHOW_HINT = 'ShowHint';
  _KEY_ALERT_SALES_COUNT = 'SalesCount';
  _KEY_ALERT_SEASON_COUNT = 'SeasonCount';
  _KEY_ALERT_IGNORE_CATA = 'IgnoreCata';

  _GUILD_FILENAME = 'guild.ini';
  _CHARACTER_FILENAME = 'character.ini';
  _KEY_KEY = 'Key';
  _KEY_NAME = 'Name';
  _KEY_COMMENT = 'Comment';
  _KEY_SERVER = 'Server';
  _KEY_GUILD = 'Guild';
  _KEY_INDEX = 'Index';
  _KEY_CHECK_VOLUME = 'CheckVolume';
  _KEY_CHECK_CHANGE = 'CheckChange';
  _KEY_CHECK_SALES = 'CheckSales';

  _RES_LOGO = 'logo';
  _RES_CLOSED = 'closed';
  _RES_OPEN = 'open';
  _RES_RESTRICTED = 'restricted';
  _RES_NOICON = 'noicon';
  _RES_EYES = 'eyes';

  _ICON_FILENAME = 'icon.png';
  _INFO_FILENAME = 'info.xml';
  _ITEMS_FILENAME = 'items.xml';
  _INDEX_FILENAME = 'index.dat';
  _GUARD_FILENAME = 'guard.dat';
  _WATCH_FILENAME = 'watch.dat';
  _MIN_QUALITY = 0;
  _MAX_QUALITY = 270;

type
  // List of the guilds
  TGuild = class(TObject)
  private
    FIniFile: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;

    function  GetGuildKey(AGuildID: String): String;
    function  GetGuildName(AGuildID: String): String;
    function  GetComment(AID: String): String;
    function  GetServerName(AGuildID: String): String;
    function  GetCheckVolume(AID: String): Boolean;
    function  GetCheckChange(AID: String): Boolean;
    function  GuildExists(AGuildID: String): Boolean;
    procedure AddGuild(AGuildID, AGuildKey, AGuildName, AComment, AServer: String; ACheckVolume, ACheckChange: Boolean);
    procedure UpdateGuild(AGuildID, AGuildKey, AGuildName, AComment, AServer: String; ACheckVolume, ACheckChange: Boolean);
    procedure DeleteGuild(AGuildID: String);
    procedure GuildList(AGuildIDList: TStrings);
    procedure SetIndex(AGuildID: String; AIndex: Integer);
  end;

  // List of the characters
  TCharacter = class(TObject)
  private
    FIniFile: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;

    function  GetCharKey(ACharID: String): String;
    function  GetCharName(ACharID: String): String;
    function  GetComment(AID: String): String;
    function  GetServerName(ACharID: String): String;
    function  GetGuildName(ACharID: String): String;
    function  GetCheckVolume(AID: String): Boolean;
    function  GetCheckSales(AID: String): Boolean;
    function  CharExists(ACharID: String): Boolean;
    procedure AddChar(ACharID, ACharKey, ACharName, ACharServer, AComment, AGuild: String; ACheckVolume, ACheckSales: Boolean);
    procedure UpdateChar(ACharID, ACharKey, ACharName, ACharServer, AComment, AGuild: String; ACheckVolume, ACheckSales: Boolean);
    procedure DeleteChar(ACharID: String);
    procedure CharList(ACharIDList: TStrings);
    procedure SetIndex(ACharID: String; AIndex: Integer);
  end;

  // Settings of the application
  TConfig = class(TObject)
  private
    FIniFile: TIniFile;
    FCurrentDir: String;
    FCurrentPath: String;
    FConfigFileName: String;
    FLanguageFileName: String;
    FVersion: String;
    
    function GetLanguage: Integer;
    function GetPackFile: String;
    function GetProxyAddress: String;
    function GetProxyEnabled: Boolean;
    function GetProxyPassword: String;
    function GetProxyPort: Integer;
    function GetProxyUsername: String;
    function GetProxyBasicAuth: Boolean;
    function GetInterfaceColor: TColor;
    procedure SetLanguage(const Value: Integer);
    procedure SetPackFile(const Value: String);
    procedure SetProxyAddress(const Value: String);
    procedure SetProxyEnabled(const Value: Boolean);
    procedure SetProxyPassword(Value: String);
    procedure SetProxyPort(Value: Integer);
    procedure SetProxyUsername(const Value: String);
    procedure SetProxyBasicAuth(const Value: Boolean);
    procedure SetInterfaceColor(const Value: TColor);
    function GetThreadCount: Integer;
    procedure SetThreadCount(const Value: Integer);
    function GetSaveFilter: Boolean;
    procedure SetSaveFilter(const Value: Boolean);
    function GetSaveAlert: Boolean;
    procedure SetSaveAlert(const Value: Boolean);
    function GetVolumeGuild: Integer;
    function GetVolumeRoom: Integer;
    procedure SetVolumeGuild(const Value: Integer);
    procedure SetVolumeRoom(const Value: Integer);
    function GetSalesCount: Integer;
    function GetSeasonCount: Integer;
    function GetShowHint: Boolean;
    procedure SetSalesCount(const Value: Integer);
    procedure SetSeasonCount(const Value: Integer);
    procedure SetShowHint(const Value: Boolean);
    function GetIgnoreCata: Boolean;
    procedure SetIgnoreCata(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property CurrentDir: String read FCurrentDir;
    property CurrentPath: String read FCurrentPath;
    property ConfigFileName: String read FConfigFileName;
    property LanguageFileName: String read FLanguageFileName;

    property Language: Integer read GetLanguage write SetLanguage;
    property PackFile: String read GetPackFile write SetPackFile;
    property InterfaceColor: TColor read GetInterfaceColor write SetInterfaceColor;
    property ThreadCount: Integer read GetThreadCount write SetThreadCount;
    property SaveFilter: Boolean read GetSaveFilter write SetSaveFilter;
    property Version: String read FVersion;
    
    property ProxyEnabled: Boolean read GetProxyEnabled write SetProxyEnabled;
    property ProxyBasicAuth: Boolean read GetProxyBasicAuth write SetProxyBasicAuth;
    property ProxyAddress: String read GetProxyAddress write SetProxyAddress;
    property ProxyPort: Integer read GetProxyPort write SetProxyPort;
    property ProxyUsername: String read GetProxyUsername write SetProxyUsername;
    property ProxyPassword: String read GetProxyPassword write SetProxyPassword;

    property SaveAlert: Boolean read GetSaveAlert write SetSaveAlert;
    property VolumeRoom: Integer read GetVolumeRoom write SetVolumeRoom;
    property VolumeGuild: Integer read GetVolumeGuild write SetVolumeGuild;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property SalesCount: Integer read GetSalesCount write SetSalesCount;
    property SeasonCount: Integer read GetSeasonCount write SetSeasonCount;
    property IgnoreCata: Boolean read GetIgnoreCata write SetIgnoreCata;

    function GetGuildPath(AGuildID: String): String;
    function GetGuildRoomPath(AGuildID: String): String;
    function GetCharPath(ACharID: String): String;
    function GetCharRoomPath(ACharID: String): String;
    function CheckVersion(var AFileUrl: String): Boolean;
  end;


var
  GConfig: TConfig;
  GGuild: TGuild;
  GCharacter: TCharacter;

implementation

uses RyzomApi, UnitRyzom;

{ TConfig }

{*******************************************************************************
Creates settings object
*******************************************************************************}
constructor TConfig.Create;
var
  wReg: TRegExpr;
  wVersion: String;
begin
  inherited;
  FCurrentDir := ExtractFileDir(ParamStr(0));
  FCurrentPath := ExtractFilePath(ParamStr(0));
  FConfigFileName := FCurrentPath + _CONFIG_FILENAME;
  FLanguageFileName := FCurrentPath + _LANGUAGE_FILENAME;;
  FIniFile := TIniFile.Create(FConfigFileName);

  wReg := TRegExpr.Create;
  wVersion := MdkFileVersionInfo(Application.ExeName, fviFileVersion);
  wReg.Expression := '(\d+\.\d+\.\d+)\.\d+';
  if wReg.Exec(wVersion) then
    if wReg.SubExprMatchCount > 0 then
      FVersion := wReg.Match[1];
  wReg.Free;
end;

{*******************************************************************************
Destroys settings object
*******************************************************************************}
destructor TConfig.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

{*******************************************************************************
Returns the path of a guild directory
*******************************************************************************}
function TConfig.GetGuildPath(AGuildID: String): String;
begin
  Result := Format('%s%s\%s\', [FCurrentPath, _GUILD_DIR, AGuildID]);
end;

{*******************************************************************************
Returns the path of a room directory
*******************************************************************************}
function TConfig.GetGuildRoomPath(AGuildID: String): String;
begin
  Result := Format('%s%s\%s\%s\', [FCurrentPath, _GUILD_DIR, AGuildID, _ROOM_DIR]);
end;

{*******************************************************************************
Returns the path of a character directory
*******************************************************************************}
function TConfig.GetCharPath(ACharID: String): String;
begin
  Result := Format('%s%s\%s\', [FCurrentPath, _CHARACTER_DIR, ACharID]);
end;

{*******************************************************************************
Returns the path of a character directory
*******************************************************************************}
function TConfig.GetCharRoomPath(ACharID: String): String;
begin
  Result := Format('%s%s\%s\%s\', [FCurrentPath, _CHARACTER_DIR, ACharID, _ROOM_DIR]);
end;

{*******************************************************************************
Returns the color of the interface
*******************************************************************************}
function TConfig.GetInterfaceColor: TColor;
begin
  Result := FIniFile.ReadInteger(_SECTION_GENERAL, _KEY_INTERFACE_COLOR, $00C0BFB4);
end;

{*******************************************************************************
Returns the language code
*******************************************************************************}
function TConfig.GetLanguage: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_GENERAL, _KEY_LANGUAGE, 2057);
end;

{*******************************************************************************
Returns the resource file
*******************************************************************************}
function TConfig.GetPackFile: String;
var
  wRyzomDir: String;
begin
  Result := FIniFile.ReadString(_SECTION_GENERAL, _KEY_PACKFILE, '');
  if Result = '' then begin
    wRyzomDir := GetRyzomInstallDir;
    if wRyzomDir <> '' then Result := wRyzomDir + _PACK_FILEPATH;
  end;
end;

{*******************************************************************************
Returns the proxy address
*******************************************************************************}
function TConfig.GetProxyAddress: String;
begin
  Result := FIniFile.ReadString(_SECTION_PROXY, _KEY_PROXY_ADDRESS, '127.0.0.1');
end;

{*******************************************************************************
Returns the proxy authentication type (Basic/Digest)
*******************************************************************************}
function TConfig.GetProxyBasicAuth: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_PROXY, _KEY_PROXY_BASIC_AUTH, False);
end;

{*******************************************************************************
Returns the proxy status (enabled/disabled)
*******************************************************************************}
function TConfig.GetProxyEnabled: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_PROXY, _KEY_PROXY_ENABLED, False);
end;

{*******************************************************************************
Returns the proxy status
*******************************************************************************}
function TConfig.GetProxyPassword: String;
begin
  Result := FIniFile.ReadString(_SECTION_PROXY, _KEY_PROXY_PASSWORD, '');
  if Result <> '' then begin
    Result := DESEncryptStringEx(Result, _ENCRYPTION_KEY, False);
  end;
end;

{*******************************************************************************
Returns the proxy port
*******************************************************************************}
function TConfig.GetProxyPort: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_PROXY, _KEY_PROXY_PORT, 3128);
end;

{*******************************************************************************
Returns the proxy username
*******************************************************************************}
function TConfig.GetProxyUsername: String;
begin
  Result := FIniFile.ReadString(_SECTION_PROXY, _KEY_PROXY_USER, '');
end;

{*******************************************************************************
Changes the color interface
*******************************************************************************}
procedure TConfig.SetInterfaceColor(const Value: TColor);
begin
  FIniFile.WriteInteger(_SECTION_GENERAL, _KEY_INTERFACE_COLOR, Value);
end;

{*******************************************************************************
Changes the language code
*******************************************************************************}
procedure TConfig.SetLanguage(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_GENERAL, _KEY_LANGUAGE, Value);
end;

{*******************************************************************************
Changes the resource file
*******************************************************************************}
procedure TConfig.SetPackFile(const Value: String);
begin
  FIniFile.WriteString(_SECTION_GENERAL, _KEY_PACKFILE, Value);
end;

{*******************************************************************************
Changes the proxy address
*******************************************************************************}
procedure TConfig.SetProxyAddress(const Value: String);
begin
  FIniFile.WriteString(_SECTION_PROXY, _KEY_PROXY_ADDRESS, Value);
end;

{*******************************************************************************
Changes the proxy authentication type (Basic/Digest)
*******************************************************************************}
procedure TConfig.SetProxyBasicAuth(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_PROXY, _KEY_PROXY_BASIC_AUTH, Value);
end;

{*******************************************************************************
Changes the proxy status (enabled/disabled)
*******************************************************************************}
procedure TConfig.SetProxyEnabled(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_PROXY, _KEY_PROXY_ENABLED, Value);
end;

{*******************************************************************************
Changes the proxy password
*******************************************************************************}
procedure TConfig.SetProxyPassword(Value: String);
begin
  Value := DESEncryptStringEx(Value, _ENCRYPTION_KEY, True);
  FIniFile.WriteString(_SECTION_PROXY, _KEY_PROXY_PASSWORD, Value);
end;

{*******************************************************************************
Changes the proxy port
*******************************************************************************}
procedure TConfig.SetProxyPort(Value: Integer);
begin
  if Value <= 0 then Value := 3128;
  FIniFile.WriteInteger(_SECTION_PROXY, _KEY_PROXY_PORT, Value);
end;

{*******************************************************************************
Changes the proxy username
*******************************************************************************}
procedure TConfig.SetProxyUsername(const Value: String);
begin
  FIniFile.WriteString(_SECTION_PROXY, _KEY_PROXY_USER, Value);
end;

{*******************************************************************************
Threads count for synchronization
*******************************************************************************}
function TConfig.GetThreadCount: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_GENERAL, _KEY_THREAD_COUNT, 10);
end;

procedure TConfig.SetThreadCount(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_GENERAL, _KEY_THREAD_COUNT, Value);
end;

{*******************************************************************************
Save filter
*******************************************************************************}
function TConfig.GetSaveFilter: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_GENERAL, _KEY_SAVE_FILTER, False);
end;

procedure TConfig.SetSaveFilter(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_GENERAL, _KEY_SAVE_FILTER, Value);
end;

{*******************************************************************************
Save alert in file
*******************************************************************************}
function TConfig.GetSaveAlert: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_ALERT, _KEY_ALERT_SAVEFILE, False);
end;

procedure TConfig.SetSaveAlert(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_ALERT, _KEY_ALERT_SAVEFILE, Value);
end;

{*******************************************************************************
Alert for guild volume
*******************************************************************************}
function TConfig.GetVolumeGuild: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_ALERT, _KEY_ALERT_VOLUME_GUILD, 9900);
end;

procedure TConfig.SetVolumeGuild(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_ALERT, _KEY_ALERT_VOLUME_GUILD, Value);
end;

{*******************************************************************************
Alert for room volume
*******************************************************************************}
function TConfig.GetVolumeRoom: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_ALERT, _KEY_ALERT_VOLUME_ROOM, 1900);
end;

procedure TConfig.SetVolumeRoom(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_ALERT, _KEY_ALERT_VOLUME_ROOM, Value);
end;

{*******************************************************************************
Alert count for sales
*******************************************************************************}
function TConfig.GetSalesCount: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_ALERT, _KEY_ALERT_SALES_COUNT, 12);
end;

procedure TConfig.SetSalesCount(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_ALERT, _KEY_ALERT_SALES_COUNT, Value);
end;

{*******************************************************************************
Alert count for season
*******************************************************************************}
function TConfig.GetSeasonCount: Integer;
begin
  Result := FIniFile.ReadInteger(_SECTION_ALERT, _KEY_ALERT_SEASON_COUNT, 12);
end;

procedure TConfig.SetSeasonCount(const Value: Integer);
begin
  FIniFile.WriteInteger(_SECTION_ALERT, _KEY_ALERT_SEASON_COUNT, Value);
end;

{*******************************************************************************
Alert hint
*******************************************************************************}
function TConfig.GetShowHint: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_ALERT, _KEY_ALERT_SHOW_HINT, True);
end;

procedure TConfig.SetShowHint(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_ALERT, _KEY_ALERT_SHOW_HINT, Value);
end;

{*******************************************************************************
Ignore alerts for cata
*******************************************************************************}
function TConfig.GetIgnoreCata: Boolean;
begin
  Result := FIniFile.ReadBool(_SECTION_ALERT, _KEY_ALERT_IGNORE_CATA, False);
end;

procedure TConfig.SetIgnoreCata(const Value: Boolean);
begin
  FIniFile.WriteBool(_SECTION_ALERT, _KEY_ALERT_IGNORE_CATA, Value);
end;

{*******************************************************************************
Check version on Internet
*******************************************************************************}
function TConfig.CheckVersion(var AFileUrl: String): Boolean;
var
  wStream: TStringStream;
begin
  Result := False;
  try
    wStream := TStringStream.Create('');
    GRyzomApi.SendRequest('http://zyroom.misulud.fr/version/version.txt', wStream);
    if FVersion <> wStream.DataString then begin
      AFileUrl := Format('http://zyroom.misulud.fr/version/zyroom-%s.zip', [wStream.DataString]);
      Result := True;
    end;
  except
  end;
end;



//------------------------------------------------------------------------------
{ TGuild }

{*******************************************************************************
Creates guild object
*******************************************************************************}
constructor TGuild.Create;
begin
  inherited;
  FIniFile := TIniFile.Create(GConfig.CurrentPath + _GUILD_FILENAME);
end;

{*******************************************************************************
Destroys guild object
*******************************************************************************}
destructor TGuild.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

{*******************************************************************************
Adds a guild
*******************************************************************************}
procedure TGuild.AddGuild(AGuildID, AGuildKey, AGuildName, AComment, AServer: String; ACheckVolume, ACheckChange: Boolean);
var
  wKey: String;
begin
  if FIniFile.SectionExists(AGuildID) then
    raise Exception.Create(RS_ERROR_GUILD_ALREADY_EXISTS);
  wKey := DESEncryptStringEx(AGuildKey, _ENCRYPTION_KEY, True);
  FIniFile.WriteString(AGuildID, _KEY_KEY, wKey);
  FIniFile.WriteString(AGuildID, _KEY_NAME, AGuildName);
  FIniFile.WriteString(AGuildID, _KEY_COMMENT, AComment);
  FIniFile.WriteString(AGuildID, _KEY_SERVER, AServer);
  FIniFile.WriteBool(AGuildID, _KEY_CHECK_VOLUME, ACheckVolume);
  FIniFile.WriteBool(AGuildID, _KEY_CHECK_CHANGE, ACheckChange);
end;

{*******************************************************************************
Updates a guild
*******************************************************************************}
procedure TGuild.UpdateGuild(AGuildID, AGuildKey, AGuildName, AComment, AServer: String; ACheckVolume, ACheckChange: Boolean);
var
  wKey: String;
begin
  if not FIniFile.SectionExists(AGuildID) then
    raise Exception.Create(RS_ERROR_GUILD_NOTFOUND);
  wKey := DESEncryptStringEx(AGuildKey, _ENCRYPTION_KEY, True);
  FIniFile.WriteString(AGuildID, _KEY_KEY, wKey);
  FIniFile.WriteString(AGuildID, _KEY_NAME, AGuildName);
  FIniFile.WriteString(AGuildID, _KEY_COMMENT, AComment);
  FIniFile.WriteString(AGuildID, _KEY_SERVER, AServer);
  FIniFile.WriteBool(AGuildID, _KEY_CHECK_VOLUME, ACheckVolume);
  FIniFile.WriteBool(AGuildID, _KEY_CHECK_CHANGE, ACheckChange);
end;

{*******************************************************************************
Deletes a guild
*******************************************************************************}
procedure TGuild.DeleteGuild(AGuildID: String);
begin
  FIniFile.EraseSection(AGuildID);
end;

{*******************************************************************************
Returns the guild key from an ID number
*******************************************************************************}
function TGuild.GetGuildKey(AGuildID: String): String;
var
  wKey: String;
begin
  wKey := FIniFile.ReadString(AGuildID, _KEY_KEY, '');
  if wKey = '' then
    raise Exception.Create(RS_ERROR_KEY_NOTFOUND);
  Result := DESEncryptStringEx(wKey, _ENCRYPTION_KEY, False);
end;

{*******************************************************************************
Returns the guild name from an ID number
*******************************************************************************}
function TGuild.GetGuildName(AGuildID: String): String;
begin
  Result := FIniFile.ReadString(AGuildID, _KEY_NAME, '');
end;

{*******************************************************************************
Returns the comment
*******************************************************************************}
function TGuild.GetComment(AID: String): String;
begin
  Result := FIniFile.ReadString(AID, _KEY_COMMENT, '');
end;

{*******************************************************************************
Verifies if a guild exists
*******************************************************************************}
function TGuild.GuildExists(AGuildID: String): Boolean;
begin
  Result := FIniFile.SectionExists(AGuildID);
end;

{*******************************************************************************
Updates index
*******************************************************************************}
procedure TGuild.SetIndex(AGuildID: String; AIndex: Integer);
begin
  FIniFile.WriteInteger(AGuildID, _KEY_INDEX, AIndex);
end;

{*******************************************************************************
Returns the list of the guilds
*******************************************************************************}
procedure TGuild.GuildList(AGuildIDList: TStrings);
var
  wList: TStringList;
  wIndex: Integer;
  i: Integer;
begin
  AGuildIDList.Clear;
  FIniFile.ReadSections(AGuildIDList);

  wList := TStringList.Create;
  for i := 0 to AGuildIDList.Count - 1 do begin
    wIndex := FIniFile.ReadInteger(AGuildIDList[i], _KEY_INDEX, -1);
    if wIndex < 0 then begin
      wIndex := i+1;
      FIniFile.WriteInteger(AGuildIDList[i], _KEY_INDEX, wIndex);
    end;
    wList.Append(Format('%3.3d=%s', [FIniFile.ReadInteger(AGuildIDList[i], _KEY_INDEX, 999), AGuildIDList[i]]));
  end;
  wList.Sort;

  AGuildIDList.Clear;
  for i := 0 to wList.Count - 1 do begin
    AGuildIDList.Append(wList.ValueFromIndex[i]);
  end;
end;

{*******************************************************************************
Returns the server from an ID number
*******************************************************************************}
function TGuild.GetServerName(AGuildID: String): String;
begin
  Result := FIniFile.ReadString(AGuildID, _KEY_SERVER, '');
end;

{*******************************************************************************
Returns the check change state
*******************************************************************************}
function TGuild.GetCheckChange(AID: String): Boolean;
begin
  Result := FIniFile.ReadBool(AID, _KEY_CHECK_CHANGE, False);
end;

{*******************************************************************************
Returns the check volume state
*******************************************************************************}
function TGuild.GetCheckVolume(AID: String): Boolean;
begin
  Result := FIniFile.ReadBool(AID, _KEY_CHECK_VOLUME, False);
end;



//------------------------------------------------------------------------------
{ TCharacter }

{*******************************************************************************
Adds a character
*******************************************************************************}
procedure TCharacter.AddChar(ACharID, ACharKey, ACharName, ACharServer, AComment, AGuild: String; ACheckVolume, ACheckSales: Boolean);
var
  wKey: String;
begin
  if FIniFile.SectionExists(ACharID) then
    raise Exception.Create(RS_ERROR_CHAR_ALREADY_EXISTS);
  wKey := DESEncryptStringEx(ACharKey, _ENCRYPTION_KEY, True);
  FIniFile.WriteString(ACharID, _KEY_KEY, wKey);
  FIniFile.WriteString(ACharID, _KEY_NAME, ACharName);
  FIniFile.WriteString(ACharID, _KEY_SERVER, ACharServer);
  FIniFile.WriteString(ACharID, _KEY_COMMENT, AComment);
  FIniFile.WriteString(ACharID, _KEY_GUILD, AGuild);
  FIniFile.WriteBool(ACharID, _KEY_CHECK_VOLUME, ACheckVolume);
  FIniFile.WriteBool(ACharID, _KEY_CHECK_SALES, ACheckSales);
end;

{*******************************************************************************
Updates a character
*******************************************************************************}
procedure TCharacter.UpdateChar(ACharID, ACharKey, ACharName, ACharServer, AComment, AGuild: String; ACheckVolume, ACheckSales: Boolean);
var
  wKey: String;
begin
  if not FIniFile.SectionExists(ACharID) then
    raise Exception.Create(RS_ERROR_CHAR_NOTFOUND);
  wKey := DESEncryptStringEx(ACharKey, _ENCRYPTION_KEY, True);
  FIniFile.WriteString(ACharID, _KEY_KEY, wKey);
  FIniFile.WriteString(ACharID, _KEY_NAME, ACharName);
  FIniFile.WriteString(ACharID, _KEY_SERVER, ACharServer);
  FIniFile.WriteString(ACharID, _KEY_COMMENT, AComment);
  FIniFile.WriteString(ACharID, _KEY_GUILD, AGuild);
  FIniFile.WriteBool(ACharID, _KEY_CHECK_VOLUME, ACheckVolume);
  FIniFile.WriteBool(ACharID, _KEY_CHECK_SALES, ACheckSales);
end;

{*******************************************************************************
Verifies if a character exists
*******************************************************************************}
function TCharacter.CharExists(ACharID: String): Boolean;
begin
  Result := FIniFile.SectionExists(ACharID);
end;

{*******************************************************************************
Updates index
*******************************************************************************}
procedure TCharacter.SetIndex(ACharID: String; AIndex: Integer);
begin
  FIniFile.WriteInteger(ACharID, _KEY_INDEX, AIndex);
end;

{*******************************************************************************
Returns the list of the characters
*******************************************************************************}
procedure TCharacter.CharList(ACharIDList: TStrings);
var
  wList: TStringList;
  wIndex: Integer;
  i: Integer;
begin
  ACharIDList.Clear;
  FIniFile.ReadSections(ACharIDList);

  wList := TStringList.Create;
  for i := 0 to ACharIDList.Count - 1 do begin
    wIndex := FIniFile.ReadInteger(ACharIDList[i], _KEY_INDEX, -1);
    if wIndex < 0 then begin
      wIndex := i+1;
      FIniFile.WriteInteger(ACharIDList[i], _KEY_INDEX, wIndex);
    end;
    wList.Append(Format('%3.3d=%s', [FIniFile.ReadInteger(ACharIDList[i], _KEY_INDEX, 999), ACharIDList[i]]));
  end;
  wList.Sort;

  ACharIDList.Clear;
  for i := 0 to wList.Count - 1 do begin
    ACharIDList.Append(wList.ValueFromIndex[i]);
  end;
end;

{*******************************************************************************
Creates character object
*******************************************************************************}
constructor TCharacter.Create;
begin
  inherited;
  FIniFile := TIniFile.Create(GConfig.CurrentPath + _CHARACTER_FILENAME);
end;

{*******************************************************************************
Destroys character object
*******************************************************************************}
destructor TCharacter.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

{*******************************************************************************
Deletes a character
*******************************************************************************}
procedure TCharacter.DeleteChar(ACharID: String);
begin
  FIniFile.EraseSection(ACharID);
end;

{*******************************************************************************
Returns the character key from an ID number
*******************************************************************************}
function TCharacter.GetCharKey(ACharID: String): String;
var
  wKey: String;
begin
  wKey := FIniFile.ReadString(ACharID, _KEY_KEY, '');
  if wKey = '' then
    raise Exception.Create(RS_ERROR_KEY_NOTFOUND);
  Result := DESEncryptStringEx(wKey, _ENCRYPTION_KEY, False);
end;

{*******************************************************************************
Returns the character name from an ID number
*******************************************************************************}
function TCharacter.GetCharName(ACharID: String): String;
begin
  Result := FIniFile.ReadString(ACharID, _KEY_NAME, '');
  if Result = '' then
    raise Exception.Create(RS_ERROR_CHARNAME_NOTFOUND);
end;

{*******************************************************************************
Returns the server from an ID number
*******************************************************************************}
function TCharacter.GetServerName(ACharID: String): String;
begin
  Result := FIniFile.ReadString(ACharID, _KEY_SERVER, '');
end;

{*******************************************************************************
Returns the guild from an ID number
*******************************************************************************}
function TCharacter.GetGuildName(ACharID: String): String;
begin
  Result := FIniFile.ReadString(ACharID, _KEY_GUILD, '');
end;

{*******************************************************************************
Returns the check volume state
*******************************************************************************}
function TCharacter.GetCheckVolume(AID: String): Boolean;
begin
  Result := FIniFile.ReadBool(AID, _KEY_CHECK_VOLUME, False);
end;

{*******************************************************************************
Returns the check sales state
*******************************************************************************}
function TCharacter.GetCheckSales(AID: String): Boolean;
begin
  Result := FIniFile.ReadBool(AID, _KEY_CHECK_SALES, False);
end;

{*******************************************************************************
Returns the comment
*******************************************************************************}
function TCharacter.GetComment(AID: String): String;
begin
  Result := FIniFile.ReadString(AID, _KEY_COMMENT, '');
end;

end.
