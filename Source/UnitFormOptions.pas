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
unit UnitFormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LcUnit, Spin, ExtCtrls, ShlObj, SevenButton, ComCtrls;

type
  TFormOptions = class(TForm)
    OdBrowsePackFile: TOpenDialog;
    OdColor: TColorDialog;
    PageControl: TPageControl;
    TabGeneral: TTabSheet;
    TabProxy: TTabSheet;
    TabAlertes: TTabSheet;
    LbLanguage: TLabel;
    LbPackFile: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    CmbLanguage: TComboBox;
    EdPackFile: TEdit;
    PnColor: TPanel;
    EdThreadCount: TSpinEdit;
    CbKeepFilter: TCheckBox;
    BtAutoBrowsePackFile: TSevenButton;
    LbNeededFile: TStaticText;
    PnProxy: TPanel;
    LbProxyPassword: TLabel;
    LbProxyAddress: TLabel;
    LbPortAddress: TLabel;
    LbProxyUsername: TLabel;
    EdProxyUsername: TEdit;
    EdProxyPassword: TEdit;
    EdProxyAddress: TEdit;
    EdProxyPort: TSpinEdit;
    CbProxyEnabled: TCheckBox;
    LbVolumeMax: TLabel;
    LbVolumeGuild: TLabel;
    LbVolumeRoom: TLabel;
    LbSalesCount: TLabel;
    LbSeasonCount: TLabel;
    EdVolumeRoom: TSpinEdit;
    EdVolumeGuild: TSpinEdit;
    CbSaveAlertFile: TCheckBox;
    EdSalesCount: TSpinEdit;
    EdSeasonCount: TSpinEdit;
    CbShowHint: TCheckBox;
    CbIgnoreCata: TCheckBox;
    PnActions: TPanel;
    BtOK: TSevenButton;
    BtCancel: TSevenButton;
    BtApply: TSevenButton;
    procedure CbProxyEnabledClick(Sender: TObject);
    procedure BtAutoBrowsePackFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PnColorClick(Sender: TObject);
    procedure BtApplyClick(Sender: TObject);
    procedure CmbLanguageChange(Sender: TObject);
  private
    procedure LoadConfig;
    procedure SaveConfig;
    procedure EnableProxy(AEnabled: Boolean);
  public
    procedure ApplyConfig;
  end;

var
  FormOptions: TFormOptions;

implementation

uses UnitConfig, UnitRyzom, MisuDevKit, UnitFormConfirmation,
  UnitFormGuild, UnitFormEdit, UnitFormMain, UnitFormProgress,
  UnitFormHome, UnitFormRoom, UnitFormCharacter, UnitFormFilter,
  UnitFormInvent, UnitFormAlert, UnitFormWatch, UnitFormLog,
  UnitFormBackup, UnitFormName;

{$R *.dfm}

{*******************************************************************************
Available languages
*******************************************************************************}
function LocalesCallback(Name: PChar): Integer; stdcall;
  function GetLocaleData(ID: LCID; Flag: DWORD): string;
  var
    BufSize: Integer;
  begin
    BufSize := GetLocaleInfo(ID, Flag, nil, 0);
    SetLength(Result, BufSize);
    GetLocaleinfo(ID, Flag, PChar(Result), BufSize);
    SetLength(Result, BufSize - 1);
  end;
const
  _SUPPORTED_LANGUAGES: array[0..2] of Integer = (1031, 1036, 2057);
var
  i: Integer;
  LCID: Integer;
begin
  LCID := StrToInt('$' + Name);
  for i := Low(_SUPPORTED_LANGUAGES) to High(_SUPPORTED_LANGUAGES) do begin
    if LCID = _SUPPORTED_LANGUAGES[i] then
      FormOptions.CmbLanguage.Items.AddObject(GetLocaleData(LCID, LOCALE_SLANGUAGE), Pointer(LCID));
  end;
  Result := 1;
end;

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormOptions.FormCreate(Sender: TObject);
begin
  {$IFNDEF __DEBUG}
  LoadLcf(GConfig.LanguageFileName, GConfig.Language, nil, nil);
  EnumSystemLocales(@LocalesCallback, LCID_SUPPORTED);
  {$ELSE}
  // no limit
  EdSalesCount.MaxValue := 0;
  EdSeasonCount.MaxValue := 0;
  {$ENDIF}
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormOptions.FormShow(Sender: TObject);
begin
  LoadConfig;
  BtOK.SetFocus;
  BtApply.Enabled := False;
end;

{*******************************************************************************
Enables or disables all components in the proxy group
*******************************************************************************}
procedure TFormOptions.EnableProxy(AEnabled: Boolean);
var
  i: Integer;
begin
  for i := 0 to PnProxy.ControlCount - 1 do begin
     PnProxy.Controls[i].Enabled := AEnabled;
  end;
  BtApply.Enabled := True;
end;

{*******************************************************************************
Enable or disable the proxy group
*******************************************************************************}
procedure TFormOptions.CbProxyEnabledClick(Sender: TObject);
begin
  EnableProxy(CbProxyEnabled.Checked);
end;

{*******************************************************************************
Selects the string resource file
*******************************************************************************}
procedure TFormOptions.BtAutoBrowsePackFileClick(Sender: TObject);
begin
  if OdBrowsePackFile.Execute then
    EdPackFile.Text := OdBrowsePackFile.FileName;
end;

{*******************************************************************************
Laods the settings of the appliaction
*******************************************************************************}
procedure TFormOptions.LoadConfig;
begin
  // Supported languages
  CmbLanguage.ItemIndex := CmbLanguage.Items.IndexOfObject(Pointer(GConfig.Language));

  // Color of the interface
  PnColor.Color := GConfig.InterfaceColor;

  // String resource file
  EdPackFile.Text := GConfig.PackFile;
  OdBrowsePackFile.InitialDir := ExtractFileDir(GConfig.PackFile);
  OdBrowsePackFile.FileName := GConfig.PackFile;

  // Options of the proxy server
  CbProxyEnabled.Checked := GConfig.ProxyEnabled;
  EnableProxy(CbProxyEnabled.Checked);
  EdProxyAddress.Text := GConfig.ProxyAddress;
  EdProxyPort.Value := GConfig.ProxyPort;
  EdProxyUsername.Text := GConfig.ProxyUsername;
  EdProxyPassword.Text := GConfig.ProxyPassword;

  // Threads count
  EdThreadCount.Value := GConfig.ThreadCount;

  // Save filter
  CbKeepFilter.Checked := GConfig.SaveFilter;

  // Alert
  CbSaveAlertFile.Checked := GConfig.SaveAlert;
  CbShowHint.Checked := GConfig.ShowHint;
  EdVolumeRoom.Value := GConfig.VolumeRoom;
  EdVolumeGuild.Value := GConfig.VolumeGuild;
  EdSalesCount.Value := GConfig.SalesCount;
  EdSeasonCount.Value := GConfig.SeasonCount;
  CbIgnoreCata.Checked := GConfig.IgnoreCata;
end;

{*******************************************************************************
Saves the settings of the appliaction
*******************************************************************************}
procedure TFormOptions.SaveConfig;
begin
  // Selected language
  if CmbLanguage.ItemIndex >= 0 then
    GConfig.Language := LCID(CmbLanguage.Items.Objects[CmbLanguage.ItemIndex]);

  // String resource file
  GConfig.PackFile := EdPackFile.Text;

  // Color of the interface
  GConfig.InterfaceColor := PnColor.Color;

  // Options of the proxy server
  GConfig.ProxyEnabled := CbProxyEnabled.Checked;
  GConfig.ProxyAddress := EdProxyAddress.Text;
  GConfig.ProxyPort := EdProxyPort.Value;
  GConfig.ProxyUsername := EdProxyUsername.Text;
  GConfig.ProxyPassword := EdProxyUsername.Text;

  // Threads count
  GConfig.ThreadCount := EdThreadCount.Value;

  // Save filter
  GConfig.SaveFilter := CbKeepFilter.Checked;

  // Alert
  GConfig.SaveAlert := CbSaveAlertFile.Checked;
  GConfig.ShowHint := CbShowHint.Checked;
  GConfig.VolumeRoom := EdVolumeRoom.Value;
  GConfig.VolumeGuild := EdVolumeGuild.Value;
  GConfig.SalesCount := EdSalesCount.Value;
  GConfig.SeasonCount := EdSeasonCount.Value;
  GConfig.IgnoreCata := CbIgnoreCata.Checked;
end;

{*******************************************************************************
Confirms changes
*******************************************************************************}
procedure TFormOptions.BtOKClick(Sender: TObject);
begin
  SaveConfig;
  ApplyConfig;
end;

{*******************************************************************************
Selects the color of the interface
*******************************************************************************}
procedure TFormOptions.PnColorClick(Sender: TObject);
begin
  if OdColor.Execute then begin
    PnColor.Color := OdColor.Color;
    BtApply.Enabled := True;
  end;
end;

{*******************************************************************************
Applies settings of the application
*******************************************************************************}
procedure TFormOptions.ApplyConfig;
begin
  // Language of the interface
  {$IFNDEF __DEBUG}
  LoadLcf(GConfig.LanguageFileName, GConfig.Language, nil, nil);
  TranslateComponent(FormOptions);
  TranslateComponent(FormMain);
  TranslateComponent(FormEdit);
  TranslateComponent(FormProgress);
  TranslateComponent(FormConfirm);
  TranslateComponent(FormHome);
  TranslateComponent(FormRoom);
  TranslateComponent(FormGuild);
  TranslateComponent(FormCharacter);
  FormFilter.BackupComboIndex;
  TranslateComponent(FormFilter);
  FormFilter.RestoreComboIndex;
  TranslateComponent(FormInvent);
  TranslateComponent(FormAlert);
  TranslateComponent(FormWatch);
  TranslateComponent(FormLog);
  TranslateComponent(FormBackup);
  TranslateComponent(FormName);
  {$ENDIF}
  
  FormInvent.UpdateLanguage;
  FormCharacter.UpdateLanguage;
  FormGuild.UpdateLanguage;
  FormFilter.UpdateLanguage;
  FormRoom.UpdateLanguage;

  // Color of the interface
  FormOptions.Color := GConfig.InterfaceColor;
  FormMain.Color := GConfig.InterfaceColor;
  FormEdit.Color := GConfig.InterfaceColor;
  FormProgress.Color := GConfig.InterfaceColor;
  FormConfirm.Color := GConfig.InterfaceColor;
  FormHome.Color := GConfig.InterfaceColor;
  FormRoom.Color := GConfig.InterfaceColor;
  FormGuild.Color := GConfig.InterfaceColor;
  FormCharacter.Color := GConfig.InterfaceColor;
  FormFilter.Color := GConfig.InterfaceColor;
  FormInvent.Color := GConfig.InterfaceColor;
  FormLog.Color := GConfig.InterfaceColor;
  FormAlert.Color := GConfig.InterfaceColor;
  FormWatch.Color := GConfig.InterfaceColor;
  FormBackup.Color := GConfig.InterfaceColor;
  FormName.Color := GConfig.InterfaceColor;

  // String resource file
  if FileExists(GConfig.PackFile) then
    GRyzomStringPack.LoadFromFile(GConfig.PackFile);

  // Proxy parameters
  if GConfig.ProxyEnabled then begin
    GRyzomApi.SetProxyParameters(
      EdProxyAddress.Text,
      EdProxyPort.Value,
      EdProxyUsername.Text,
      EdProxyPassword.Text);
  end else begin
    GRyzomApi.SetProxyParameters('', 0, '', '');
  end;

  // Init backup window
  FormBackup.Init;
end;

{*******************************************************************************
Confirms changes without close the windows
*******************************************************************************}
procedure TFormOptions.BtApplyClick(Sender: TObject);
begin
  SaveConfig;
  ApplyConfig;
  BtApply.Enabled := False;
end;

{*******************************************************************************
Enables the apply button
*******************************************************************************}
procedure TFormOptions.CmbLanguageChange(Sender: TObject);
begin
  BtApply.Enabled := True;
end;

end.
