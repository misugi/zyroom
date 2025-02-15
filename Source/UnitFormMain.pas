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
  ShellApi, regexpr, ComCtrls, XpDOM, UnitThreadAlert, CoolTrayIcon, Menus,
  SevenButton;

resourcestring
  RS_STATUS_CLOSED = 'Fermé';
  RS_STATUS_OPEN = 'Ouvert';
  RS_STATUS_RESTRICTED = 'Limité';
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
    ImgStatus: TImage;
    LbAutoStatus: TLabel;
    StatusBar: TStatusBar;
    TrayIcon: TCoolTrayIcon;
    PopupMenuTray: TPopupMenu;
    MenuClose: TMenuItem;
    MenuOpen: TMenuItem;
    N1: TMenuItem;
    MenuShowHint: TMenuItem;
    N2: TMenuItem;
    MenuKeepFilter: TMenuItem;
    MenuSaveAlert: TMenuItem;
    BtOptions: TSevenButton;
    BtGuild: TSevenButton;
    BtCharacter: TSevenButton;
    BtAlert: TSevenButton;
    BtLog: TSevenButton;
    BtBackup: TSevenButton;
    MenuAutoBackup: TMenuItem;
    procedure BtOptionsClick(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtGuildClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtCharacterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtAlertClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure ChangeOptions(Sender: TObject);
    procedure PopupMenuTrayPopup(Sender: TObject);
    procedure TrayIconBalloonHintClick(Sender: TObject);
    procedure BtLogClick(Sender: TObject);
    procedure BtBackupClick(Sender: TObject);
  private
    FPngClosed: TPNGObject;
    FPngOpen: TPNGObject;
    FPngRestricted: TPNGObject;
    FCurrentForm: TForm;
    {$IFNDEF __NOALERT}
    FAlert: TAlert;
    {$ENDIF}
    FVisible: Boolean;
    FPanelTime: TStatusPanel;
    FPanelCurrentSeason: TStatusPanel;
    FPanelNextSeason: TStatusPanel;
    FPanelVersion: TStatusPanel;
    procedure UpdateStatusAndTime;
    procedure GetSeasonInfo;
  public
    procedure ShowMenuForm(AForm: TForm);
  end;

var
  FormMain: TFormMain;

implementation

uses
  UnitFormGuild, UnitFormOptions, UnitFormProgress, UnitFormRoom, UnitFormHome,
  UnitFormCharacter, UnitFormInvent, UnitFormFilter, DateUtils, UnitFormAlert,
  SyncObjs, Contnrs, UnitFormlog, UnitFormBackup;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormMain.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  StatusBar.DoubleBuffered := True;
  PnHeader.DoubleBuffered := True;
  PnContainer.DoubleBuffered := True;
  FVisible := False;

  GConfig := TConfig.Create;
  GRyzomApi := TRyzom.Create;
  GGuild := TGuild.Create;
  GCharacter := TCharacter.Create;
  GRyzomStringPack := TStringClient.Create;

  FPngClosed := TPNGObject.Create;
  FPngOpen := TPNGObject.Create;
  FPngRestricted := TPNGObject.Create;

  // Load the status images
  FPngClosed.LoadFromResourceName(HInstance, _RES_CLOSED);
  FPngOpen.LoadFromResourceName(HInstance, _RES_OPEN);
  FPngRestricted.LoadFromResourceName(HInstance, _RES_RESTRICTED);

  FCurrentForm := nil;
  GAlertCS := TCriticalSection.Create;
  GMsgList := TObjectList.Create(True);

  FPanelTime := StatusBar.Panels.Items[0];
  FPanelCurrentSeason := StatusBar.Panels.Items[1];
  FPanelNextSeason := StatusBar.Panels.Items[2];
  FPanelVersion := StatusBar.Panels.Items[3];

  {$IFNDEF __NOALERT}
  // Start thread for alerts
  FAlert := TAlert.Create;
  {$ENDIF}
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormMain.FormShow(Sender: TObject);
begin
  if FVisible then
    Exit;
  
  // Load the settings
  FormOptions.ApplyConfig;

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

  FormAlert.BorderStyle := bsNone;
  FormAlert.Parent := PnContainer;
  FormAlert.Align := alClient;

  FormLog.BorderStyle := bsNone;
  FormLog.Parent := PnContainer;
  FormLog.Align := alClient;

  FormBackup.BorderStyle := bsNone;
  FormBackup.Parent := PnContainer;
  FormBackup.Align := alClient;

  FormFilter.BorderStyle := bsNone;
  FormFilter.Align := alClient;

  // Displays the home form by default
  ShowMenuForm(FormHome);

  // Updates the status and time
  UpdateStatusAndTime;

  // Sets default filter
  GRyzomApi.SetDefaultFilter(GCurrentFilter);

  // Start automatic backup
  FormBackup.StartAutoBackup;

  // Check version
  FPanelVersion.Text := RS_VERSION + ' ' + GConfig.Version;

  FVisible := True;
end;

{*******************************************************************************
Closes the window
*******************************************************************************}
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  {$IFNDEF __NOALERT}
  FAlert.Terminate;
  WaitForSingleObject(FAlert.Handle, 10000);
  {$ENDIF}

  GAlertCS.Free;
  GMsgList.Free;

  GRyzomStringPack.Free;
  GGuild.Free;
  GCharacter.Free;
  GRyzomApi.Free;
  GConfig.Free;

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
    UpdateStatusAndTime;
end;

{*******************************************************************************
Update status and time
*******************************************************************************}
procedure TFormMain.UpdateStatusAndTime;
{$IFNDEF __NOSTATUS}
var
  wStream: TStringStream;
{$ENDIF}
begin
  ImgStatus.Hint := RS_STATUS_OPEN;
  ImgStatus.Picture.Assign(FPngOpen);
  {$IFNDEF __NOSTATUS}
  try
    // Time
    wStream := TStringStream.Create('');
    try
      GRyzomApi.ApiTime(_FORMAT_TXT, wStream);
      FPanelTime.Text := wStream.DataString;
      GetSeasonInfo;
    finally
      wStream.Free;
    end;
  except
    FPanelTime.Text := '-';
    FPanelCurrentSeason.Text := '-';
    FPanelNextSeason.Text := '-';
    ImgStatus.Hint := RS_STATUS_CLOSED;
    ImgStatus.Picture.Assign(FPngClosed);
  end;
  {$ENDIF}
end;

{*******************************************************************************
Displays the list of guilds
*******************************************************************************}
procedure TFormMain.BtGuildClick(Sender: TObject);
begin
  ShowMenuForm(FormGuild);
  Constraints.MinHeight := _WIN_HEIGTH;
end;

{*******************************************************************************
Displays the list of characters
*******************************************************************************}
procedure TFormMain.BtCharacterClick(Sender: TObject);
begin
  ShowMenuForm(FormCharacter);
  Constraints.MinHeight := _WIN_HEIGTH;
end;

{*******************************************************************************
Displays a project form at the bottom
*******************************************************************************}
procedure TFormMain.ShowMenuForm(AForm: TForm);
begin
  if FCurrentForm = AForm then
    Exit;
  if Assigned(FCurrentForm) then
    FCurrentForm.Close;
  AForm.Show;
  FCurrentForm := AForm;
end;

{*******************************************************************************
Get season information
*******************************************************************************}
procedure TFormMain.GetSeasonInfo;
var
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wSeasonIndex: Integer;
  wSeason: String;
  wDayOfSeason: Integer;
  wTimeOfDay: Integer;
  wMinutes: Integer;
  wNextSeason: TDateTime;
  wServerTick: Int64;
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    GRyzomApi.ApiTime(_FORMAT_XML, wStream);
    wXmlDoc.LoadStream(wStream);
    wSeasonIndex := StrToIntDef(wXmlDoc.DocumentElement.SelectString('/shard_time/season'), -1);
    case wSeasonIndex of
      0:
        wSeason := RS_SEASON_SPRING;
      1:
        wSeason := RS_SEASON_SUMMER;
      2:
        wSeason := RS_SEASON_AUTUMN;
      3:
        wSeason := RS_SEASON_WINTER;
    else
      wSeason := '-';
    end;
    FPanelCurrentSeason.Text := wSeason;

    // Calculation of next season
    wDayOfSeason := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/day_of_season'));
    wTimeOfDay := StrToInt(wXmlDoc.DocumentElement.SelectString('/shard_time/time_of_day'));
    wMinutes := ((89 - wDayOfSeason) * 24 + (23 - wTimeOfDay)) * 3;
    wNextSeason := IncMinute(Now, wMinutes);
    FPanelNextSeason.Text := Format('%s %s %s %s', [
      RS_NEXT_SEASON, DateToStr(wNextSeason), RS_AT, FormatDateTime('hh:nn', wNextSeason)]);

    // Check server tick
    wServerTick := wXmlDoc.DocumentElement.SelectInteger('/shard_time/server_tick');
    if wServerTick <= 0 then
      raise Exception.Create('Bad server tick, the server is probably closed');
  finally
    wXmlDoc.Free;
    wStream.Free;
  end;
end;

{*******************************************************************************
Show alerts
*******************************************************************************}
procedure TFormMain.BtAlertClick(Sender: TObject);
begin
  ShowMenuForm(FormAlert);
  Constraints.MinHeight := _WIN_HEIGTH;
end;

{*******************************************************************************
Open application
*******************************************************************************}
procedure TFormMain.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.ShowMainForm;
end;

{*******************************************************************************
Open application
*******************************************************************************}
procedure TFormMain.MenuOpenClick(Sender: TObject);
begin
  TrayIcon.ShowMainForm;
end;

{*******************************************************************************
Close application
*******************************************************************************}
procedure TFormMain.MenuCloseClick(Sender: TObject);
begin
  Close;
end;

{*******************************************************************************
Change options
*******************************************************************************}
procedure TFormMain.ChangeOptions(Sender: TObject);
begin
  GConfig.SaveFilter := MenuKeepFilter.Checked;
  GConfig.SaveAlert := MenuSaveAlert.Checked;
  GConfig.ShowHint := MenuShowHint.Checked;
  GConfig.AutoBackup := MenuAutoBackup.Checked;
end;

{*******************************************************************************
Show popup menu
*******************************************************************************}
procedure TFormMain.PopupMenuTrayPopup(Sender: TObject);
begin
  MenuKeepFilter.Checked := GConfig.SaveFilter;
  MenuSaveAlert.Checked := GConfig.SaveAlert;
  MenuShowHint.Checked := GConfig.ShowHint;
  MenuAutoBackup.Checked := GConfig.AutoBackup;
end;

{*******************************************************************************
Show alert window
*******************************************************************************}
procedure TFormMain.TrayIconBalloonHintClick(Sender: TObject);
begin
  if not FormMain.Visible then begin
    TrayIcon.ShowMainForm;
    BtAlert.SetFocus;
    BtAlertClick(BtAlert);
  end;
end;

{*******************************************************************************
Show log window
*******************************************************************************}
procedure TFormMain.BtLogClick(Sender: TObject);
begin
  ShowMenuForm(FormLog);
  Constraints.MinHeight := _WIN_HEIGTH;
end;

{*******************************************************************************
Show backup window
*******************************************************************************}
procedure TFormMain.BtBackupClick(Sender: TObject);
begin
  ShowMenuForm(FormBackup);
  Constraints.MinHeight := _WIN_HEIGTH;
end;

end.

