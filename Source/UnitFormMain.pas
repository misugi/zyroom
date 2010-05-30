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
unit UnitFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UnitRyzom, UnitConfig, pngimage, RyzomApi,
  ShellApi, regexpr, ComCtrls, XpDOM;

resourcestring
  RS_STATUS_CLOSED = 'Fermé';
  RS_STATUS_OPEN = 'Ouvert';
  RS_STATUS_RESTRICTED = 'Limité';
  RS_NEW_VERSION = 'Nouvelle version disponible !';
  RS_SEASON_SPRING = 'Printemps';
  RS_SEASON_SUMMER = 'Eté';
  RS_SEASON_AUTUMN = 'Automne';
  RS_SEASON_WINTER = 'Hiver';
  RS_VERSION = 'Version';
  RS_NEXT_SEASON = 'Prochain changement de saison le';
  RS_AT = 'à';

type
  TFormMain = class(TForm)
    PnContainer: TPanel;
    TimerStatus: TTimer;
    PnHeader: TPanel;
    ImgAniro: TImage;
    LbAniro: TLabel;
    ImgLeanon: TImage;
    LbLeanon: TLabel;
    ImgArispotle: TImage;
    LbArispotle: TLabel;
    BtOptions: TButton;
    BtGuild: TButton;
    BtCharacter: TButton;
    TimerUpdate: TTimer;
    StatusBar: TStatusBar;
    ImgUpdate: TImage;
    procedure BtOptionsClick(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtGuildClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LbServerClick(Sender: TObject);
    procedure ImgLogoClick(Sender: TObject);
    procedure BtCharacterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImgUpdateClick(Sender: TObject);
    procedure TimerUpdateTimer(Sender: TObject);
  private
    FPngClosed: TPNGObject;
    FPngOpen: TPNGObject;
    FPngRestricted: TPNGObject;
    FServerLabelSelected: TLabel;
    FCurrentForm: TForm;
    FFileUrl: String;

    procedure UpdateStatusAndTime(AOnlyTime: Boolean);
    procedure GetSeasonInfo(AServerID: String);
  public
    procedure ShowMenuForm(AForm: TForm);
  end;

var
  FormMain: TFormMain;

implementation

uses UnitFormGuild, UnitFormOptions, UnitFormProgress, UnitFormRoom, UnitFormHome,
  UnitFormCharacter, UnitFormInvent, UnitFormRoomFilter, DateUtils;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormMain.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  DoubleBuffered := True;
  StatusBar.DoubleBuffered := True;
  PnHeader.DoubleBuffered := True;
  PnContainer.DoubleBuffered := True;
  
  GConfig := TConfig.Create;
  GRyzomApi := TRyzom.Create;
  GGuild := TGuild.Create;
  GCharacter := TCharacter.Create;
  GRyzomStringPack := TStringClient.Create;
  GRegExpr := TRegExpr.Create;

  FPngClosed := TPNGObject.Create;
  FPngOpen := TPNGObject.Create;
  FPngRestricted := TPNGObject.Create;

  // Load the status images
  FPngClosed.LoadFromResourceName(HInstance, _RES_CLOSED);
  FPngOpen.LoadFromResourceName(HInstance, _RES_OPEN);
  FPngRestricted.LoadFromResourceName(HInstance, _RES_RESTRICTED);

  FCurrentForm := nil;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormMain.FormShow(Sender: TObject);
begin
  // Load the settings
  FormOptions.ApplyConfig;

  // Default server to display the time
  case GConfig.Language of
    _LANGUAGE_FRENCH_ID: FServerLabelSelected := LbAniro;
    _LANGUAGE_ENGLISH_ID: FServerLabelSelected := LbArispotle;
    _LANGUAGE_GERMAN_ID: FServerLabelSelected := LbLeanon;
  end;
  FServerLabelSelected.Font.Style := [fsBold];
  FServerLabelSelected.Cursor := crDefault;
  FServerLabelSelected.OnClick := nil;
  StatusBar.Panels.Items[0].Text := FServerLabelSelected.Caption;

  // Prepare all the project forms
  FormHome.BorderStyle := bsNone;
  FormHome.Parent := PnContainer;
  FormHome.Align := alClient;
  
  FormGuild.BorderStyle := bsNone;
  FormGuild.Parent := PnContainer;
  FormGuild.Align := alClient;

  FormCharacter.BorderStyle := bsNone;
  FormCharacter.Parent := PnContainer;
  FormCharacter.Align := alClient;

  FormRoom.BorderStyle := bsNone;
  FormRoom.Parent := PnContainer;
  FormRoom.Align := alClient;

  FormInvent.BorderStyle := bsNone;
  FormInvent.Parent := PnContainer;
  FormInvent.Align := alClient;

  FormRoomFilter.BorderStyle := bsNone;
  FormRoomFilter.Align := alClient;

  // Displays the home form by default
  ShowMenuForm(FormHome);

  // Updates the status and time
  UpdateStatusAndTime(False);

  // Sets default filter
  GRyzomApi.SetDefaultFilter(GCurrentFilter);

  // Check version
  StatusBar.Panels.Items[4].Text := RS_VERSION + ' ' + GConfig.Version;
  ImgUpdate.Hint := RS_NEW_VERSION;
  if GConfig.CheckVersion(FFileUrl) then begin
    ImgUpdate.Visible := True;
    TimerUpdate.Enabled := True;
  end;
end;

{*******************************************************************************
Closes the window
*******************************************************************************}
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GConfig.PosMainLeft := FormMain.Left;
  GConfig.PosMainTop := FormMain.Top;
  GConfig.PosFilterLeft := FormRoomFilter.Left;
  GConfig.PosFilterTop := FormRoomFilter.Top;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  GRyzomStringPack.Free;
  GGuild.Free;
  GCharacter.Free;
  GRyzomApi.Free;
  GConfig.Free;
  GRegExpr.Free;

  FPngClosed.Free;
  FPngOpen.Free;
  FPngRestricted.Free;
end;

{*******************************************************************************
Displays the options form
*******************************************************************************}
procedure TFormMain.BtOptionsClick(Sender: TObject);
begin
  FormOptions.ShowModal;
end;

{*******************************************************************************
Auto-timer to update status and time
*******************************************************************************}
procedure TFormMain.TimerStatusTimer(Sender: TObject);
begin
  if not FormProgress.Visible then
    UpdateStatusAndTime(False);
end;

{*******************************************************************************
Update status and time
*******************************************************************************}
procedure TFormMain.UpdateStatusAndTime(AOnlyTime: Boolean);
var
  wStream: TStringStream;
  wServerID: String;
begin
  try
    if not AOnlyTime then begin
      GRyzomApi.UpdateStatus;

      // Aniro status
      case GRyzomApi.AniroStatus of
        _STATUS_CLOSED: begin
          ImgAniro.Hint := RS_STATUS_CLOSED;
          ImgAniro.Picture.Assign(FPngClosed);
        end;
        _STATUS_OPEN: begin
          ImgAniro.Hint := RS_STATUS_OPEN;
          ImgAniro.Picture.Assign(FPngOpen);
        end;
        _STATUS_RESTRICTED: begin
          ImgAniro.Hint := RS_STATUS_RESTRICTED;
          ImgAniro.Picture.Assign(FPngRestricted);
        end;
      end;

      // Leanon status
      case GRyzomApi.LeanonStatus of
        _STATUS_CLOSED: begin
          ImgLeanon.Hint := RS_STATUS_CLOSED;
          ImgLeanon.Picture.Assign(FPngClosed);
        end;
        _STATUS_OPEN: begin
          ImgLeanon.Hint := RS_STATUS_OPEN;
          ImgLeanon.Picture.Assign(FPngOpen);
        end;
        _STATUS_RESTRICTED: begin
          ImgLeanon.Hint := RS_STATUS_RESTRICTED;
          ImgLeanon.Picture.Assign(FPngRestricted);
        end;
      end;

      // Arispotle status
      case GRyzomApi.ArispotleStatus of
        _STATUS_CLOSED: begin
          ImgArispotle.Hint := RS_STATUS_CLOSED;
          ImgArispotle.Picture.Assign(FPngClosed);
        end;
        _STATUS_OPEN: begin
          ImgArispotle.Hint := RS_STATUS_OPEN;
          ImgArispotle.Picture.Assign(FPngOpen);
        end;
        _STATUS_RESTRICTED: begin
          ImgArispotle.Hint := RS_STATUS_RESTRICTED;
          ImgArispotle.Picture.Assign(FPngRestricted);
        end;
      end;
    end;

    // Time
    wStream := TStringStream.Create('');
    try
      if FServerLabelSelected = LbAniro then wServerID := _SHARD_ANIRO_ID;
      if FServerLabelSelected = LbLeanon then wServerID := _SHARD_LEANON_ID;
      if FServerLabelSelected = LbArispotle then wServerID := _SHARD_ARIPOTLE_ID;
   
      GRyzomApi.ApiTime(wServerID, _FORMAT_TXT, wStream);
      StatusBar.Panels.Items[1].Text := wStream.DataString;
      GetSeasonInfo(wServerID);
    finally
      wStream.Free;
    end;
  except
    StatusBar.Panels.Items[1].Text := '-';
    StatusBar.Panels.Items[2].Text := '-';
    StatusBar.Panels.Items[3].Text := '-';
  end;
end;

{*******************************************************************************
Displays the list of guilds
*******************************************************************************}
procedure TFormMain.BtGuildClick(Sender: TObject);
begin
  ShowMenuForm(FormGuild);
  BtGuild.Font.Style := [fsBold];
  BtCharacter.Font.Style := [];
  Constraints.MinHeight := 635;
end;

{*******************************************************************************
Displays the list of characters
*******************************************************************************}
procedure TFormMain.BtCharacterClick(Sender: TObject);
begin
  ShowMenuForm(FormCharacter);
  BtGuild.Font.Style := [];
  BtCharacter.Font.Style := [fsBold];
  Constraints.MinHeight := 635;
end;

{*******************************************************************************
Displays the home form
*******************************************************************************}
procedure TFormMain.ImgLogoClick(Sender: TObject);
begin
  ShowMenuForm(FormHome);
  BtGuild.Font.Style := [];
  BtCharacter.Font.Style := [];
end;

{*******************************************************************************
Change the server to display the time
*******************************************************************************}
procedure TFormMain.LbServerClick(Sender: TObject);
begin
  FServerLabelSelected.Font.Style := [];
  FServerLabelSelected.Cursor := crHandPoint;
  FServerLabelSelected.OnClick := LbServerClick;

  // New server
  FServerLabelSelected := TLabel(Sender);
  FServerLabelSelected.Font.Style := [fsBold];
  FServerLabelSelected.Cursor := crDefault;
  FServerLabelSelected.OnClick := nil;
  StatusBar.Panels.Items[0].Text := FServerLabelSelected.Caption;

  // Update only the time
  UpdateStatusAndTime(True);
end;

{*******************************************************************************
Displays a project form at the bottom
*******************************************************************************}
procedure TFormMain.ShowMenuForm(AForm: TForm);
begin
  if FCurrentForm = AForm then Exit;
  if Assigned(FCurrentForm) then FCurrentForm.Close;
  AForm.Show;
  FCurrentForm := AForm;
end;

{*******************************************************************************
Link to the last version
*******************************************************************************}
procedure TFormMain.ImgUpdateClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(FFileUrl), nil, nil, SW_SHOW);
end;

{*******************************************************************************
Hide and show image to update version
*******************************************************************************}
procedure TFormMain.TimerUpdateTimer(Sender: TObject);
begin
  ImgUpdate.Visible := False;
  Application.ProcessMessages;
  Sleep(200);
  ImgUpdate.Visible := True;
end;

{*******************************************************************************
Get season information
*******************************************************************************}
procedure TFormMain.GetSeasonInfo(AServerID: String);
var
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wSeasonIndex: Integer;
  wSeason: String;
  wDayOfSeason: Integer;
  wTimeOfDay: Integer;
  wMinutes: Integer;
  wNextSeason: TDateTime;
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    GRyzomApi.ApiTime(AServerID, _FORMAT_XML, wStream);
    wXmlDoc.LoadStream(wStream);
    wSeasonIndex := StrToIntDef(wXmlDoc.DocumentElement.SelectString('/shard_time/season'), -1);
    case wSeasonIndex of
      0: wSeason := RS_SEASON_SPRING;
      1: wSeason := RS_SEASON_SUMMER;
      2: wSeason := RS_SEASON_AUTUMN;
      3: wSeason := RS_SEASON_WINTER;
    else
      wSeason := '-';
    end;
    StatusBar.Panels.Items[2].Text := wSeason;

    // Calculation of next season
    wDayOfSeason := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/day_of_season'));
    wTimeOfDay := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/time_of_day'));
    wMinutes := ( (89-wDayOfSeason)*24 + (23-wTimeOfDay) )*3;
    wNextSeason := IncMinute(Now, wMinutes);
    StatusBar.Panels.Items[3].Text := Format('%s %s %s %s', [
      RS_NEXT_SEASON, DateToStr(wNextSeason), RS_AT, FormatDateTime('hh:nn', wNextSeason)]);
  finally
    wXmlDoc.Free;
    wStream.Free;
  end;
end;

end.
