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
unit UnitFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UnitRyzom, UnitConfig, pngimage, RyzomApi,
  ShellApi, regexpr;

resourcestring
  RS_STATUS_CLOSED = 'Fermé';
  RS_STATUS_OPEN = 'Ouvert';
  RS_STATUS_RESTRICTED = 'Limité';
  
type
  TFormMain = class(TForm)
    ImgLogo: TImage;
    PnContainer: TPanel;
    BtOptions: TButton;
    BtGuild: TButton;
    TimerStatus: TTimer;
    Button1: TButton;
    ImgAniro: TImage;
    LbAniro: TLabel;
    LbTime: TLabel;
    ImgLeanon: TImage;
    LbLeanon: TLabel;
    ImgArispotle: TImage;
    LbArispotle: TLabel;
    procedure BtOptionsClick(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtGuildClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LbServerClick(Sender: TObject);
    procedure ImgLogoClick(Sender: TObject);
  private
    FPngClosed: TPNGObject;
    FPngOpen: TPNGObject;
    FPngRestricted: TPNGObject;
    FServerLabelSelected: TLabel;
    FCurrentForm: TForm;

    procedure UpdateStatusAndTime(AOnlyTime: Boolean);
  public
    procedure ShowMenuForm(AForm: TForm);
  end;

var
  FormMain: TFormMain;

implementation

uses UnitFormGuild, UnitFormOptions, UnitFormProgress, UnitFormRoom, UnitFormHome;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormMain.FormCreate(Sender: TObject);
begin
  GConfig := TConfig.Create;
  GRyzomApi := TRyzom.Create;
  GGuild := TGuild.Create;
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

  // Prepare all the project forms
  FormHome.BorderStyle := bsNone;
  FormHome.Parent := PnContainer;
  FormHome.Align := alClient;
  
  FormGuild.BorderStyle := bsNone;
  FormGuild.Parent := PnContainer;
  FormGuild.Align := alClient;

  FormRoom.BorderStyle := bsNone;
  FormRoom.Parent := PnContainer;
  FormRoom.Align := alClient;

  // Displays the home form by default
  ShowMenuForm(FormHome);

  // Update the status and time
  UpdateStatusAndTime(False);
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  GRyzomStringPack.Free;
  GGuild.Free;
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
    LbTime.Caption := wStream.DataString;
  except
    wStream.Free;
  end;
end;

{*******************************************************************************
Displays the list of guilds
*******************************************************************************}
procedure TFormMain.BtGuildClick(Sender: TObject);
begin
  ShowMenuForm(FormGuild);
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

  // Update only the time
  UpdateStatusAndTime(True);
end;

{*******************************************************************************
Displays the home form
*******************************************************************************}
procedure TFormMain.ImgLogoClick(Sender: TObject);
begin
  ShowMenuForm(FormHome);
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

end.
