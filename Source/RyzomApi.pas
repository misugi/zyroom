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
unit RyzomApi;

interface

uses
  Classes, Windows, SysUtils, IdHTTP, IdCompressorZLib, Math, MisuDevKit,
  Registry, XpDOM, IdSSLOpenSSL, SHLObj;

resourcestring
  RS_ERROR_LOADING_XML = 'Erreur de chargement du flux XML';
  RS_REQUIRED_MODULES = 'Veuillez activer tous les modules requis sur votre clé API : %s';

const
  _API_BASE_URL = 'https://api.ryzom.com';
  _REQUIRED_MODULES_CHAR: array[0..4] of String = ('C01', 'C04', 'C05', 'C06', 'A03');
  _REQUIRED_MODULES_GUILD: array[0..2] of String = ('G01', 'G02', 'G03');
  _FORMAT_XML = 'xml';
  _FORMAT_RAW = 'raw';
  _FORMAT_TXT = 'txt';
  _ICON_SMALL = 's';
  _ICON_BIG = 'b';
  _ICON_FORMAT = '.png';
  _XPATH_ROOM_CHAR = '/ryzomapi/character/room/item';
  _XPATH_ROOM_GUILD = '/ryzomapi/guild/room/item';
  _XPATH_BAG = '/ryzomapi/character/bag/item';
  _XPATH_PET1 = '/ryzomapi/character/pets/animal[@index=''0'']/inventory/item';
  _XPATH_PET2 = '/ryzomapi/character/pets/animal[@index=''1'']/inventory/item';
  _XPATH_PET3 = '/ryzomapi/character/pets/animal[@index=''2'']/inventory/item';
  _XPATH_PET4 = '/ryzomapi/character/pets/animal[@index=''3'']/inventory/item';
  _XPATH_STORE = '/ryzomapi/character/shop/shopitem';
  _XPATH_ERROR_MESSAGE = '/ryzomapi/*/error';
  _XPATH_ERROR_CODE = '/ryzomapi/*/error/@code';

type
  TItemColor = (icRed, icBeige, icGreen, icTurquoise, icBlue, icPurple, icWhite, icBlack, icNone);

  // Ryzom API
  TRyzomApi = class
  private
    FHttpRequest: TIdHTTP;
    FHttpCompressor: TIdCompressorZLib;
    FSslHandler: TIdSSLIOHandlerSocketOpenSSL;
    FXmlDocument: TXpObjModel;
    procedure CheckXmlError(AResponse: TStream);
    procedure CallAPI(AUrl: String; AResponse: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ApiGuild(AKey: String; AResponse: TStream);
    procedure ApiCharacter(AKey: String; AResponse: TStream);
    procedure ApiGuildIcon(AIcon: String; ASize: String; AResponse: TStream);
    procedure ApiItemIcon(AId: String; AResponse: TStream; AColor: TItemColor =
      icWhite; AQuality: Integer = 0; ASize: Integer = 0; ASap: Integer = -1;
      ADestroyed: Boolean = False; ALocked: Boolean = False);
    procedure ApiBallisticMystix(ARace: String; AGender: String; AHairType:
      Integer; AHairColor: Integer; ATatoo: Integer; AEyesColor: Integer;
      AGabarit, AMorph: String; AChestItem: String; AChestColor: Integer; AResponse: TStream);
    procedure ApiTime(AFormat: String; AResponse: TStream);
    procedure ApiWeather(AContinent: String; ACycles: Integer; AOffset: Integer; AResponse: TStream);
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

function CheckModules(AModules: String; ARequired: array of String): Boolean;

implementation

uses
  StrUtils;

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
function GetRyzomInstallDir(): String;
var
  SpecialPath: Array[0..MAX_PATH] Of Char;
  wRoamingDir: String;
begin
  Result := '';
  if SHGetSpecialFolderPath(0, @SpecialPath[0], CSIDL_APPDATA, False) then begin
    wRoamingDir := String(PAnsiChar(@SpecialPath[0]));
    Result := IncludeTrailingPathDelimiter(wRoamingDir) + 'Ryzom';
  end;
end;

{*******************************************************************************
Check required modules
*******************************************************************************}
function CheckModules(AModules: String; ARequired: array of String): Boolean;
var
  wList: TStringList;
  i: Integer;
begin
  Result := False;
  wList := TStringList.Create;
  try
    wList.Delimiter := ':';
    wList.DelimitedText := AModules;
    for i := 0 to High(ARequired) do begin
      if wList.IndexOf(ARequired[i]) < 0 then
        Exit;
    end;
    Result := True;
  finally
    wList.Free;
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
  FHttpRequest.HandleRedirects := True;

  // SSL
  FSslHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  FSslHandler.SSLOptions.Method := sslvSSLv23;
  FHttpRequest.IOHandler := FSslHandler;
end;

{*******************************************************************************
Destroys the API interface
*******************************************************************************}
destructor TRyzomApi.Destroy;
begin
  FXmlDocument.Free;
  FHttpRequest.Free;
  FHttpCompressor.Free;
  FSslHandler.Free;
end;

{*******************************************************************************
Calls the "Guild" API
*******************************************************************************}
procedure TRyzomApi.ApiGuild(AKey: String; AResponse: TStream);
begin
  try
    CallAPI(Format('%s/guild.php?apikey=%s', [_API_BASE_URL, AKey]), AResponse);
    CheckXmlError(AResponse);
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiGuild] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Calls the "Character" API
*******************************************************************************}
procedure TRyzomApi.ApiCharacter(AKey: String; AResponse: TStream);
begin
  try
    CallAPI(Format('%s/character.php?apikey=%s', [_API_BASE_URL, AKey]), AResponse);
    CheckXmlError(AResponse);
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiCharacter] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Calls the "GuildIcon" API
*******************************************************************************}
procedure TRyzomApi.ApiGuildIcon(AIcon, ASize: String; AResponse: TStream);
begin
  try
    CallAPI(Format('%s/guild_icon.php?icon=%s&size=%s', [_API_BASE_URL, AIcon, ASize]), AResponse);
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiGuildIcon] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Calls the "ItemIcon" API

c (optional)
The color of the item. It's a value between 0 and 7 (example).
 
q (optional)
The quality of the item (example).
 
s (optional)
Default is 1.
The size of the stack (example).
 
sap (optional)
Default is -1.
The number of sap of the item.
-1 no sap icon, no number 
0 sap icon, no number 
1 sap icon number 0 
2 sap icon number 1 
3 sap icon number 2 

destroyed (optional)
Default is 0.
0: nothing special (example).
1: display the item as if it was destroyed (with a red cross) (example).
*******************************************************************************}
procedure TRyzomApi.ApiItemIcon(AId: String; AResponse: TStream; AColor:
  TItemColor; AQuality, ASize, ASap: Integer; ADestroyed: Boolean; ALocked: Boolean);
var
  wOptions: String;
begin
  try
    wOptions := Format('?sheetid=%s', [AId]);
    if AColor = icNone then
      AColor := icBeige;
    wOptions := wOptions + Format('&c=%d', [Ord(AColor)]);
    if AQuality > 0 then
      wOptions := wOptions + Format('&q=%d', [AQuality]);
    if ASize > 0 then
      wOptions := wOptions + Format('&s=%d', [ASize]);
    if ASap >= 0 then
      wOptions := wOptions + Format('&sap=%d', [ASap]);
    if ADestroyed then
      wOptions := wOptions + '&destroyed=1';
    if ALocked then
      wOptions := wOptions + '&locked=1';

    CallAPI(Format('%s/item_icon.php%s', [_API_BASE_URL, wOptions]), AResponse);
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiItemIcon] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Calls the "Time" API
*******************************************************************************}
procedure TRyzomApi.ApiTime(AFormat: String; AResponse: TStream);
begin
  try
    try
      FHttpRequest.Get(Format('%s/time.php?format=%s', [_API_BASE_URL, AFormat]), AResponse);
    except
      on E: Exception do
        raise Exception.Create('[API Call Error] ' + E.Message);
    end;
    AResponse.Position := 0;
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiTime] %s', [E.Message]);
  end;
end;

{*==============================================================================
Calls the "Weather" API
https://api.ryzom.com/#weather-api
https://api.bmsite.net/#weather => API à utiliser de préférence !
Car celle-ci met continuellement à jour l'heure retournée (hour), ce qui permet d'être précis sur le moment présent
Contrairement à l'API officielle qui met à jour l'heure toutes les 2 minutes environ
===============================================================================}
procedure TRyzomApi.ApiWeather(AContinent: String; ACycles: Integer; AOffset: Integer; AResponse: TStream);
begin
  try
    try
      FHttpRequest.Get(Format('https://api.bmsite.net/atys/weather?continent=%s&cycles=%d&offset=%d',
        [AContinent, ACycles, AOffset]), AResponse);
    except
      on E: Exception do
        raise Exception.Create('[API Call Error] ' + E.Message);
    end;
    AResponse.Position := 0;
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiWeather] %s', [E.Message]);
  end;
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
      wPos := Pos(#0 + AStringKey + #2, DataString); // la clé d'un item (ex: tp_kami_pyr.sitem) est encadré par #0 et #2
      if wPos = 0 then
        Exit;
      Position := wPos + Length(AStringKey) + 1;
      ReadBuffer(wLength, 4); // 4 octets pour stocker la longueur de la chaîne
      FillChar(wBuffer, SizeOf(wBuffer), 0);
      ReadBuffer(wBuffer, wLength); // lecture de la chaîne selon la longueur
      Result := UTF8Decode(wBuffer); // décodage UTF-8
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt('[TStringClient.GetString] %s', [E.Message]);
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
procedure TRyzomApi.SetProxyParameters(AProxyAddress: String; AProxyPort:
  Integer; AProxyUsername, AProxyPassword: String);
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
  AHairColor, ATatoo, AEyesColor: Integer; AGabarit, AMorph: String; AChestItem:
  String; AChestColor: Integer; AResponse: TStream);
begin
  try
    // API documentation at this address : http://api.bmsite.net
    CallAPI(Format('http://api.bmsite.net/char/render/3d/180?race=%s&gender=%s&hair=%d/%d&tattoo=%d&eyes=%d&gabarit=%s&morph=%s&chest=%s/%d',
      [Copy(ARace, 1, 2), AGender, AHairType, AHairColor, ATatoo, AEyesColor, AGabarit, AMorph, AChestItem, AChestColor]), AResponse);
  except
    on E: Exception do
      raise Exception.CreateFmt('[ApiBallisticMystix] %s', [E.Message]);
  end;
end;

{*******************************************************************************
Check the XML returned by the API
*******************************************************************************}
procedure TRyzomApi.CheckXmlError(AResponse: TStream);
var
  wCode: Integer;
  wMessage: String;
begin
  if not FXmlDocument.LoadStream(AResponse) then
    raise Exception.Create(RS_ERROR_LOADING_XML);

  wCode := FXmlDocument.DocumentElement.SelectInteger(_XPATH_ERROR_CODE);
  if wCode > 0 then begin
    wMessage := FXmlDocument.DocumentElement.SelectString(_XPATH_ERROR_MESSAGE);
    raise Exception.CreateFmt('[API Result Error] %d: %s', [wCode, wMessage]);
  end;

  AResponse.Position := 0;
end;

{*******************************************************************************
Call API
*******************************************************************************}
procedure TRyzomApi.CallAPI(AUrl: String; AResponse: TStream);
begin
  try
    FHttpRequest.Get(AUrl, AResponse);
    AResponse.Position := 0;
  except
    on E: Exception do
      raise Exception.CreateFmt('[API Call Error] %s', [E.Message]);
  end;
end;

end.
 
