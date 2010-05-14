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
unit RyzomApi;

interface

uses
  Classes, Windows, SysUtils, IdHTTP, IdCompressorZLib, Math, MisuDevKit,
  Registry, XpDOM;

resourcestring
  RS_ERROR_LOADING_XML = 'Erreur de chargement du flux XML';

const
  _STATUS_CLOSED = 0;
  _STATUS_OPEN = 1;
  _STATUS_RESTRICTED = 2;

  _SHARD_ANIRO_ID = 'ani';
  _SHARD_LEANON_ID = 'lea';
  _SHARD_ARIPOTLE_ID = 'ari';

  _FORMAT_XML = 'xml';
  _FORMAT_RAW = 'raw';
  _FORMAT_TXT = 'txt';

  _ICON_SMALL = 's';
  _ICON_BIG = 'b';

  _NODE_ERROR = 'error';
  _ICON_FORMAT = '.png';

type
  TItemColor = (icRed, icBeige, icGreen, icTurquoise, icBlue, icPurple, icWhite, icBlack, icNone);
  TCharacterPart = (cpFull, cpItems);

  // Ryzom API
  TRyzomApi = class
  private
    FHttpRequest: TIdHTTP;
    FHttpCompressor: TIdCompressorZLib;
    FXmlDocument: TXpObjModel;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ApiGuild(AKey: String; AResponse: TStream);
    procedure ApiCharacter(AKey: String; APart: TCharacterPart; AResponse: TStream);
    procedure ApiGuildIcon(AIcon: String; ASize: String; AResponse: TStream);
    procedure ApiItemIcon(AId: String; AResponse: TStream; AColor: TItemColor = icWhite;
      AQuality: Integer = 0; ASize: Integer = 0; ASap: Integer = -1; ADestroyed: Boolean = False);
    procedure ApiStatus(AFormat: String; AResponse: TStream);
    procedure ApiBallisticMystix(ARace: String; AGender: String; AHairType: Integer; AHairColor: Integer;
      ATatoo: Integer; AEyesColor: Integer; AResponse: TStream);
    procedure ApiTime(AShardID: String; AFormat: String; AResponse: TStream);
    procedure SetProxyParameters(AProxyAddress: String; AProxyPort: Integer;
      AProxyUsername: String; AProxyPassword: String);
    procedure SendRequest(ARequest: String; AResponse: TStream);
  end;

  // Resource file
  TStringClient = class
  private
    FStream: TStringStream;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(AFileName: String);
    function GetString(AStringKey: String): WideString;
  end;

  function ToItemColor(AColor: String): TItemColor;
  function GetRyzomInstallDir: String;

implementation

uses StrUtils;

{*******************************************************************************
Convert a color code to an item color
*******************************************************************************}
function ToItemColor(AColor: String): TItemColor;
begin
  Result := TItemColor(StrToIntDef(AColor, 8));
end;

{*******************************************************************************
Returns the installation directory of Ryzom
*******************************************************************************}
function GetRyzomInstallDir: String;
var
  wReg: TRegistry;
begin
  Result := '';
  wReg := TRegistry.Create(KEY_READ);
  try
    wReg.RootKey := HKEY_LOCAL_MACHINE;
    if wReg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Ryzom') then
      Result := wReg.ReadString('InstallLocation');
  finally
    wReg.Free;
  end;
end;

{ TRyzomApi }

{*******************************************************************************
Creates the API interface
*******************************************************************************}
constructor TRyzomApi.Create;
begin
  FXmlDocument := TXpObjModel.Create(nil);
  FHttpCompressor := TIdCompressorZLib.Create;
  FHttpRequest := TIdHTTP.Create;
  FHttpRequest.Compressor := FHttpCompressor;
  FHttpRequest.ProxyParams.BasicAuthentication := True;
end;

{*******************************************************************************
Destroys the API interface
*******************************************************************************}
destructor TRyzomApi.Destroy;
begin
  FXmlDocument.Free;
  FHttpRequest.Free;
  FHttpCompressor.Free;
end;

{*******************************************************************************
Calls the "Guild" API
*******************************************************************************}
procedure TRyzomApi.ApiGuild(AKey: String; AResponse: TStream);
begin
  FHttpRequest.Get(Format('http://atys.ryzom.com/api/guild.php?key=%s', [AKey]), AResponse);
  AResponse.Position := 0;

  if not FXmlDocument.LoadStream(AResponse) then
    raise Exception.Create(RS_ERROR_LOADING_XML);

  if CompareText(FXmlDocument.DocumentElement.NodeName, _NODE_ERROR) = 0 then
    raise Exception.Create(FXmlDocument.DocumentElement.FirstChild.NodeValue);

  AResponse.Position := 0;
end;

{*******************************************************************************
Calls the "Character" API
*******************************************************************************}
procedure TRyzomApi.ApiCharacter(AKey: String; APart: TCharacterPart; AResponse: TStream);
begin
  case APart of
    cpFull: FHttpRequest.Get(Format('http://atys.ryzom.com/api/character.php?part=full&key=%s', [AKey]), AResponse);
    cpItems: FHttpRequest.Get(Format('http://atys.ryzom.com/api/character.php?part=items&key=%s', [AKey]), AResponse);
  end;
  AResponse.Position := 0;

  if not FXmlDocument.LoadStream(AResponse) then
    raise Exception.Create(RS_ERROR_LOADING_XML);

  if CompareText(FXmlDocument.DocumentElement.NodeName, _NODE_ERROR) = 0 then
    raise Exception.Create(FXmlDocument.DocumentElement.FirstChild.NodeValue);

  AResponse.Position := 0;
end;

{*******************************************************************************
Calls the "GuildIcon" API
*******************************************************************************}
procedure TRyzomApi.ApiGuildIcon(AIcon, ASize: String; AResponse: TStream);
begin
  FHttpRequest.Get(Format('http://atys.ryzom.com/api/guild_icon.php?icon=%s&size=%s', [AIcon, ASize]), AResponse);
  AResponse.Position := 0;
end;

{*******************************************************************************
Calls the "ItemIcon" API
*******************************************************************************}
procedure TRyzomApi.ApiItemIcon(AId: String; AResponse: TStream;
  AColor: TItemColor; AQuality, ASize, ASap: Integer;
  ADestroyed: Boolean);
var
  wOptions: String;
begin
  wOptions := Format('?sheetid=%s', [AId]);
  if AColor <> icNone then wOptions := wOptions + Format('&c=%d', [Ord(AColor)]);
  if AQuality > 0 then wOptions := wOptions + Format('&q=%d', [AQuality]);
  if ASize > 0 then wOptions := wOptions + Format('&s=%d', [ASize]);
  if ASap >= 0 then wOptions := wOptions + Format('&sap=%d', [ASap]);
  if ADestroyed then wOptions := wOptions + '&destroyed=1';
  
  FHttpRequest.Get('http://atys.ryzom.com/api/item_icon.php' + wOptions, AResponse);
  AResponse.Position := 0;
end;

{*******************************************************************************
Calls the "Status" API
*******************************************************************************}
procedure TRyzomApi.ApiStatus(AFormat: String; AResponse: TStream);
begin
  FHttpRequest.Get(Format('http://atys.ryzom.com/api/status.php?format=%s', [AFormat]), AResponse);
  AResponse.Position := 0;
end;

{*******************************************************************************
Calls the "Time" API
*******************************************************************************}
procedure TRyzomApi.ApiTime(AShardID: String; AFormat: String; AResponse: TStream);
begin
  FHttpRequest.Get(Format('http://atys.ryzom.com/api/time.php?shardid=%s&format=%s', [AShardID, AFormat]), AResponse);
  AResponse.Position := 0;
end;


{ TStringClient }

{*******************************************************************************
Creates the resource file object
*******************************************************************************}
constructor TStringClient.Create;
begin
  inherited;
  FStream := TStringStream.Create('');
end;

{*******************************************************************************
Destroys the resource file object
*******************************************************************************}
destructor TStringClient.Destroy;
begin
  FStream.Free;
  inherited;
end;

{*******************************************************************************
Returns a string from a key
*******************************************************************************}
function TStringClient.GetString(AStringKey: String): WideString;
var
  wPos: Integer;
  wLength: Integer;
  wBuffer: array[0..255] of Char;
begin
  try
    with FStream do begin
      Result := '';
      wPos := Pos(#0+AStringKey+#1, DataString);
      if wPos = 0 then Exit;
      Position := wPos + Length(AStringKey) + 1;
      ReadBuffer(wLength, 4);
      ReadBuffer(wBuffer, wLength*2);
      Result := WideCharLenToString(@wBuffer, wLength);
    end;
  except
    on E: Exception do raise Exception.CreateFmt('[TStringClient.GetString] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Loads a resource file
*******************************************************************************}
procedure TStringClient.LoadFromFile(AFileName: String);
var
  wStream: TFileStream;
begin
  wStream := TFileStream.Create(AFileName, fmOpenRead);
  FStream.CopyFrom(wStream, wStream.Size);
  wStream.Free;
end;

{*******************************************************************************
Sets the proxy parameters
*******************************************************************************}
procedure TRyzomApi.SetProxyParameters(AProxyAddress: String; AProxyPort: Integer;
  AProxyUsername, AProxyPassword: String);
begin
  FHttpRequest.ProxyParams.ProxyServer := AProxyAddress;
  FHttpRequest.ProxyParams.ProxyPort := AProxyPort;
  FHttpRequest.ProxyParams.ProxyUsername := AProxyUsername;
  FHttpRequest.ProxyParams.ProxyPassword := AProxyPassword;
end;

{*******************************************************************************
Send an HTTP request
*******************************************************************************}
procedure TRyzomApi.SendRequest(ARequest: String; AResponse: TStream);
begin
  FHttpRequest.Get(ARequest, AResponse);
  AResponse.Position := 0;
end;

{*******************************************************************************
Get character image
*******************************************************************************}
procedure TRyzomApi.ApiBallisticMystix(ARace, AGender: String; AHairType,
  AHairColor, ATatoo, AEyesColor: Integer; AResponse: TStream);
begin
  FHttpRequest.Get(Format('http://ballisticmystix.net/api/dressingroom.php?race=%s&gender=%s&hair=%d/%d&tattoo=%d&eyes=%d',
    [ARace, AGender, AHairType, AHairColor, ATatoo, AEyesColor]), AResponse);
  AResponse.Position := 0;
end;

end.
 
