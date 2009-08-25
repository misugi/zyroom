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
unit UnitFormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LcUnit, Spin, ExtCtrls, ShlObj;

type
  TFormOptions = class(TForm)
    LbPackFile: TLabel;
    LbLanguage: TLabel;
    CmbLanguage: TComboBox;
    EdPackFile: TEdit;
    CbProxyEnabled: TCheckBox;
    OdBrowsePackFile: TOpenDialog;
    BtBrowsePackFile: TButton;
    BtOK: TButton;
    BtCancel: TButton;
    PnProxy: TPanel;
    LbProxyPassword: TLabel;
    LbProxyAddress: TLabel;
    LbPortAddress: TLabel;
    LbProxyUsername: TLabel;
    CbProxyBasicAuth: TCheckBox;
    EdProxyUsername: TEdit;
    EdProxyPassword: TEdit;
    EdProxyAddress: TEdit;
    EdProxyPort: TSpinEdit;
    OdColor: TColorDialog;
    PnColor: TPanel;
    Label1: TLabel;
    procedure CbProxyEnabledClick(Sender: TObject);
    procedure BtBrowsePackFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PnColorClick(Sender: TObject);
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
  UnitFormGuild, UnitFormGuildEdit, UnitFormMain, UnitFormProgress,
  UnitFormHome, UnitFormRoom;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormOptions.FormCreate(Sender: TObject);
begin
  LoadConfig;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormOptions.FormShow(Sender: TObject);
begin
  BtOK.SetFocus;
end;

{*******************************************************************************
Available languages
*******************************************************************************}
function LcCallBack( iLCID : integer; pUd : pointer ) : integer; stdcall;
var
  wLanguages: TLanguages;
begin
  Result := 1;
  wLanguages := TLanguages.Create;
  TComboBox(pUd).Items.AddObject(wLanguages.NameFromLocaleID[iLCID], Pointer(iLCID));
  wLanguages.Free;
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
procedure TFormOptions.BtBrowsePackFileClick(Sender: TObject);
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
  LoadLcf(GConfig.LanguageFileName, 0, Addr(LcCallBack), CmbLanguage);
  CmbLanguage.ItemIndex := CmbLanguage.Items.IndexOfObject(Pointer(GConfig.Language));

  // Color of the interface
  PnColor.Color := GConfig.InterfaceColor;

  // String resource file
  EdPackFile.Text := GConfig.PackFile;
  OdBrowsePackFile.InitialDir := ExtractFileDir(GConfig.PackFile);

  // Options of the proxy server
  CbProxyEnabled.Checked := GConfig.ProxyEnabled;
  EnableProxy(CbProxyEnabled.Checked);
  EdProxyAddress.Text := GConfig.ProxyAddress;
  EdProxyPort.Value := GConfig.ProxyPort;
  EdProxyUsername.Text := GConfig.ProxyUsername;
  EdProxyPassword.Text := GConfig.ProxyPassword;
  CbProxyBasicAuth.Checked := GConfig.ProxyBasicAuth;
end;

{*******************************************************************************
Saves the settings of the appliaction
*******************************************************************************}
procedure TFormOptions.SaveConfig;
begin
  // Selected language
  GConfig.Language := LCID(CmbLanguage.Items.Objects[CmbLanguage.ItemIndex]);

  // String resource file
  GConfig.PackFile := EdPackFile.Text;

  // Color of the interface
  GConfig.InterfaceColor := PnColor.Color;

  // Options of the proxy server
  GConfig.ProxyEnabled := CbProxyEnabled.Checked;
  GConfig.ProxyBasicAuth := CbProxyBasicAuth.Checked;
  GConfig.ProxyAddress := EdProxyAddress.Text;
  GConfig.ProxyPort := EdProxyPort.Value;
  GConfig.ProxyUsername := EdProxyUsername.Text;
  GConfig.ProxyPassword := EdProxyUsername.Text;
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
  if OdColor.Execute then
    PnColor.Color := OdColor.Color;
end;

{*******************************************************************************
Applies settings of the application
*******************************************************************************}
procedure TFormOptions.ApplyConfig;
begin
  // Language of the interface
  LoadLcf(GConfig.LanguageFileName, GConfig.Language, nil, nil);
  TranslateComponent(FormOptions);
  TranslateComponent(FormMain);
  TranslateComponent(FormGuildEdit);
  TranslateComponent(FormProgress);
  TranslateComponent(FormConfirm);
  TranslateComponent(FormHome);
  TranslateComponent(FormRoom);
  TranslateComponent(FormGuild);

  // Color of the interface
  FormOptions.Color := GConfig.InterfaceColor;
  FormMain.Color := GConfig.InterfaceColor;
  FormGuildEdit.Color := GConfig.InterfaceColor;
  FormProgress.Color := GConfig.InterfaceColor;
  FormConfirm.Color := GConfig.InterfaceColor;
  FormHome.Color := GConfig.InterfaceColor;
  FormRoom.Color := GConfig.InterfaceColor;
  FormGuild.Color := GConfig.InterfaceColor;

  // String resource file
  if FileExists(GConfig.PackFile) then
    GRyzomStringPack.LoadFromFile(GConfig.PackFile);

  // Proxy parameters
  if GConfig.ProxyEnabled then
    GRyzomApi.SetProxyParameters(
      EdProxyAddress.Text,
      EdProxyPort.Value,
      EdProxyUsername.Text,
      EdProxyPassword.Text);
end;

end.
