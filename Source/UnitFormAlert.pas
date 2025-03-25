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
unit UnitFormAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi, LcUnit,
  StrUtils, ComCtrls, Buttons, SyncObjs, CoolTrayIcon, SevenButton;

resourcestring
  RS_ALERT_DURABILITY = 'la durabilité de l''objet %s Q%d est en dessous du seuil de surveillance (%d/%d)';
  RS_ALERT_QUANTITY = 'la quantité de l''objet %s Q%d est en dessous du seuil de surveillance (%d/%d)';
  RS_ALERT_UNFOUND = 'l''objet sous surveillance %s Q%d n''existe plus';
  RS_ALERT_ADDED = 'l''objet %s Q%d a été ajouté (%d)';
  RS_ALERT_REMOVED = 'l''objet %s Q%d a été retiré (%d)';
  RS_ALERT_MODIFIED = 'la quantité de l''objet %s Q%d a changé (%d > %d)';
  RS_ALERT_SALES = 'l''objet %s Q%d sera automatiquement vendu au marchand dans %s (%s)';
  RS_ALERT_VOLUME_ROOM = 'le volume de la pièce est au dessus du seuil limite (%d/%d)';
  RS_ALERT_VOLUME_GUILD = 'le volume du coffre est au dessus du seuil limite (%d/%d)';
  RS_ALERT_SEASON = 'Prochain changement de saison dans %s (%s)';
  RS_ALERT_HINT = 'Nouvelles alertes !';

type
  TAlertType = (atDurability, atQuantity, atUnfound, atAdded, atRemoved,
    atModified, atSales, atVolumeRoom, atVolumeGuild, atSeason);

  TAlertMessage = class(TObject)
  public
    MsgType: TAlertType;
    MsgDate: TDateTime;
    MsgName: String;
    MsgLocation: String;
    MsgObject: String;
    MsgQuality: Integer;
    MsgValue1: Integer;
    MsgValue2: Integer;
    MsgValue3: Integer;
    MsgInfo: String;
    ItemName: String;
  end;

  TFormAlert = class(TForm)
    RichEditAlert: TRichEdit;
    Panel1: TPanel;
    TimerUpdate: TTimer;
    SaveAlert: TSaveDialog;
    BtClear: TSevenButton;
    BtSave: TSevenButton;
    procedure TimerUpdateTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtClearClick(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure ReadMessage;
    procedure AutoSave;
  public
    procedure NewMessage(AMsg: TAlertMessage);
  end;

var
  FormAlert: TFormAlert;
  GAlertCS: TCriticalSection;
  GMsgList: TObjectList;

implementation

uses
  UnitConfig, UnitRyzom, MisuDevKit, UnitFormMain;

{$R *.dfm}

{*******************************************************************************
Post new alert message
*******************************************************************************}
procedure TFormAlert.NewMessage(AMsg: TAlertMessage);
begin
  GAlertCS.Enter;
  try
    GMsgList.Add(AMsg);
  finally
    GAlertCS.Leave;
  end;
end;

{*******************************************************************************
Read new alert message posted
*******************************************************************************}
procedure TFormAlert.ReadMessage;
var
  wExpiration: String;
  wShowHint: Boolean;
  wStart, wPos: Integer;
begin
  GAlertCS.Enter;
  try
    // Auto save if too many lines
    if (GMsgList.Count > 0) and (RichEditAlert.Lines.Count > 10000) then begin
      AutoSave;
      RichEditAlert.Clear;
    end;

    wShowHint := False;
    while GMsgList.Count > 0 do begin
      wShowHint := True;
      try
        with GMsgList.Items[0] as TAlertMessage do begin
          // Ignore cata
          if GConfig.IgnoreCata and (Pos('ixpca0', ItemName) = 1) then
            Continue;

          wStart := Length(RichEditAlert.Text);
          case MsgType of
            atDurability:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_DURABILITY,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, MsgValue1, MsgValue2]));
              end;
            atQuantity:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_QUANTITY,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, MsgValue1, MsgValue2]));
              end;
            atUnfound:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_UNFOUND,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality]));
              end;
            atAdded:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_ADDED,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, MsgValue1]));
              end;
            atRemoved:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_REMOVED,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, MsgValue1]));
              end;
            atModified:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_MODIFIED,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, MsgValue1, MsgValue2]));
              end;
            atSales:
              begin
                wExpiration := Format('%d %s %s %d %s', [
                  {MsgValue1, RS_DAYS, }
                  MsgValue2, RS_HOURS, RS_AND, MsgValue3, RS_MINUTES]);
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_SALES,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgObject, MsgQuality, wExpiration, MsgInfo]));
              end;
            atVolumeRoom:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_VOLUME_ROOM,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgValue1, MsgValue2]));
              end;
            atVolumeGuild:
              begin
                RichEditAlert.Lines.Append(Format('%s | %s (%s): ' + RS_ALERT_VOLUME_GUILD,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  MsgName, MsgLocation, MsgValue1, MsgValue2]));
              end;
            atSeason:
              begin
                wExpiration := Format('%d %s %s %d %s', [
                  {MsgValue1, RS_DAYS, }
                  MsgValue2, RS_HOURS, RS_AND, MsgValue3, RS_MINUTES]);
                RichEditAlert.Lines.Append(Format('%s | ' + RS_ALERT_SEASON,
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', MsgDate),
                  wExpiration, MsgInfo]));
              end;
          end;

          // Change styles
          if MsgName <> '' then begin
            wPos := PosEx(MsgName, RichEditAlert.Text, wStart);
            RichEditAlert.SelStart := wPos - 1;
            RichEditAlert.SelLength := Length(MsgName);
            RichEditAlert.SelAttributes.Style := [fsBold];
            RichEditAlert.SelAttributes.Color := clBlack;
          end;

          if MsgObject <> '' then begin
            wPos := PosEx(MsgObject, RichEditAlert.Text, wStart);
            RichEditAlert.SelStart := wPos - 1;
            RichEditAlert.SelLength := Length(MsgObject);
            RichEditAlert.SelAttributes.Style := [fsBold];
            RichEditAlert.SelAttributes.Color := $007D491F;
          end;

          if MsgQuality > 0 then begin
            wPos := PosEx('Q' + IntToStr(MsgQuality), RichEditAlert.Text, wStart);
            RichEditAlert.SelStart := wPos - 1;
            RichEditAlert.SelLength := Length('Q' + IntToStr(MsgQuality));
            RichEditAlert.SelAttributes.Style := [fsBold];
            RichEditAlert.SelAttributes.Color := $000000CC;
          end;

          if MsgLocation <> '' then begin
            wPos := PosEx(MsgLocation, RichEditAlert.Text, wStart);
            RichEditAlert.SelStart := wPos - 1;
            RichEditAlert.SelLength := Length(MsgLocation);
            RichEditAlert.SelAttributes.Style := [];
            RichEditAlert.SelAttributes.Color := $00008000;
          end;

          if MsgInfo <> '' then begin
            wPos := PosEx(MsgInfo, RichEditAlert.Text, wStart);
            RichEditAlert.SelStart := wPos - 1;
            RichEditAlert.SelLength := Length(MsgInfo);
            RichEditAlert.SelAttributes.Style := [];
            RichEditAlert.SelAttributes.Color := $00008000;
          end;

          RichEditAlert.SelLength := 0;
          RichEditAlert.Perform(EM_SCROLLCARET, 0, 0);
          RichEditAlert.Refresh;
        end;
      finally
        GMsgList.Delete(0);
      end;
    end;

    // Show hint on tray icon
    if wShowHint and (GConfig.ShowHint) then
      FormMain.TrayIcon.ShowBalloonHint('zyRoom', RS_ALERT_HINT, bitInfo, 10);
  finally
    GAlertCS.Leave;
  end;
end;

{*******************************************************************************
Update alert
*******************************************************************************}
procedure TFormAlert.TimerUpdateTimer(Sender: TObject);
begin
  TimerUpdate.Enabled := False;
  try
    ReadMessage;
  finally
    TimerUpdate.Enabled := True;
  end;
end;

{*******************************************************************************
Load alert file
*******************************************************************************}
procedure TFormAlert.FormCreate(Sender: TObject);
begin
  RichEditAlert.Clear;
{$IFDEF __DEBUG}
  TimerUpdate.Interval := 5000;
{$ENDIF}
end;

{*******************************************************************************
Save alert file
*******************************************************************************}
procedure TFormAlert.FormDestroy(Sender: TObject);
begin
  AutoSave;
end;

{*******************************************************************************
Empty text
*******************************************************************************}
procedure TFormAlert.BtClearClick(Sender: TObject);
begin
  RichEditAlert.Clear;
end;

{*******************************************************************************
Save alerts in a file
*******************************************************************************}
procedure TFormAlert.BtSaveClick(Sender: TObject);
begin
  if SaveAlert.Execute then
    RichEditAlert.Lines.SaveToFile(SaveAlert.FileName);
end;

{*******************************************************************************
Auto save alert in file
*******************************************************************************}
procedure TFormAlert.AutoSave;
var
  wAlertDir: String;
  wAlertFile: String;
begin
  if (GConfig.SaveAlert) and (RichEditAlert.Lines.Count > 0) then begin
    wAlertDir := Format('%s\%s\%s', [GConfig.CurrentDir, _ALERT_DIR, FormatDateTime('yyyymm', Now)]);
    ForceDirectories(wAlertDir);
    wAlertFile := Format('%s\alert-%s.rtf', [wAlertDir, FormatDateTime('yyyymmdd-hhnnss', Now)]);
    RichEditAlert.Lines.SaveToFile(wAlertFile);
  end;
end;

{*******************************************************************************
Refresh data
*******************************************************************************}
procedure TFormAlert.FormResize(Sender: TObject);
begin
  RichEditAlert.Refresh;
end;

end.

