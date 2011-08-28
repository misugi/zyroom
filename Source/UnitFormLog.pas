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
unit UnitFormLog;

interface

uses
  Forms, SysUtils, Dialogs, OleCtrls, SHDocVw, StdCtrls, SevenButton, Classes,
  Controls, ExtCtrls, RyzomApi, regexpr, ComCtrls, CheckLst, Graphics, Types,
  Windows, Clipbrd, ActiveX;

type
  TFormLog = class(TForm)
    PnHeader: TPanel;
    BtLoad: TSevenButton;
    WebLog: TWebBrowser;
    OdBrowseLogFile: TOpenDialog;
    PnOptions: TPanel;
    OdColor: TColorDialog;
    BtHtml: TSevenButton;
    BtBbcode: TSevenButton;
    GbChannels: TGroupBox;
    ListChannels: TCheckListBox;
    GbCharacters: TGroupBox;
    ListCharacters: TCheckListBox;
    BtDefault: TSevenButton;
    BtCheckChannels: TSevenButton;
    BtUncheckChannels: TSevenButton;
    BtCheckCharacters: TSevenButton;
    BtUncheckCharacters: TSevenButton;
    BtOK: TSevenButton;
    GbOptions: TGroupBox;
    LbColorBackground: TLabel;
    PnColorBackground: TPanel;
    LbColorSystem: TLabel;
    PnColorSystem: TPanel;
    CbShowDate: TCheckBox;
    CbSystemMessage: TCheckBox;
    OdSaveFile: TSaveDialog;
    BtText: TSevenButton;
    GbSystemFilter: TGroupBox;
    BtAddFilter: TSevenButton;
    BtDelFilter: TSevenButton;
    DatePickerStart: TDateTimePicker;
    LbDateEnd: TLabel;
    DatePickerEnd: TDateTimePicker;
    ListFilter: TListBox;
    EdFilter: TEdit;
    TimePickerStart: TDateTimePicker;
    TimePickerEnd: TDateTimePicker;
    procedure BtLoadClick(Sender: TObject);
    procedure CheckListBoxDblClick(Sender: TObject);
    procedure BtCheckChannelsClick(Sender: TObject);
    procedure BtUncheckChannelsClick(Sender: TObject);
    procedure BtUncheckCharactersClick(Sender: TObject);
    procedure BtCheckCharactersClick(Sender: TObject);
    procedure PnColorClick(Sender: TObject);
    procedure BtDefaultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListChannelsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BtHtmlClick(Sender: TObject);
    procedure BtBbcodeClick(Sender: TObject);
    procedure BtTextClick(Sender: TObject);
    procedure BtDelFilterClick(Sender: TObject);
    procedure BtAddFilterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListFilterClick(Sender: TObject);
  private
    FFirstLoading: Boolean;
    FLogFile: String;
    FLogFileHtml: String;
    FLogFileBbode: String;
    FLogFileText: String;
    FFilterFile: String;
    
    FDateStart: TDateTime;
    FDateEnd: TDateTime;
    
    procedure LoadLogFile;
    procedure SetDefault;
  public
    procedure ChangeChecked(AList: TCheckListBox; AChecked: Boolean);
    procedure ChangeEnabled(AEnabled: Boolean);
    property FirstLoading: Boolean read FFirstLoading write FFirstLoading;
    property LogFileHtml: String read FLogFileHtml write FLogFileHtml;
    property LogFileBbode: String read FLogFileBbode write FLogFileBbode;
    property LogFileText: String read FLogFileText write FLogFileText;
  end;

var
  FormLog: TFormLog;

implementation

uses UnitConfig, UnitRyzom, MisuDevKit, UnitFormMain, UnitFormProgress,
  Math, DateUtils;

{$R *.dfm}

{*******************************************************************************
Create the form
*******************************************************************************}
procedure TFormLog.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  WebLog.DoubleBuffered := True;
  PnHeader.DoubleBuffered := True;
  PnOptions.DoubleBuffered := True;

  ForceDirectories(GConfig.CurrentPath + _LOG_DIR);
  FLogFile := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_CHATLOG_FILENAME;
  FLogFileHtml := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_HTML_FILENAME;
  FLogFileBbode := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_BBCODE_FILENAME;
  FLogFileText := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_TEXT_FILENAME;
  FFilterFile := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_FILTER_FILENAME;

  // Load filters
  if FileExists(FFilterFile) then
    ListFilter.Items.LoadFromFile(FFilterFile);

  OdBrowseLogFile.InitialDir := ExtractFileDir(GConfig.PackFile);
end;

{*******************************************************************************
Destroy the form
*******************************************************************************}
procedure TFormLog.FormDestroy(Sender: TObject);
begin
  // Save filters
  ListFilter.Items.SaveToFile(FFilterFile);
end;

{*******************************************************************************
Show the form
*******************************************************************************}
procedure TFormLog.FormShow(Sender: TObject);
var
  wHomeFile: String;
begin
  FDateStart := Now;
  FDateEnd := FDateStart;
  SetDefault;
  ChangeEnabled(False);
  ListChannels.Clear;
  ListCharacters.Clear;
  EdFilter.Text := '';

  // Home page
  wHomeFile := GConfig.CurrentPath + _LOG_HOMEPAGE_FILENAME;
  if FileExists(wHomeFile) then
    WebLog.Navigate(wHomeFile)
  else
    WebLog.Navigate('about:blank');
end;

{*******************************************************************************
Enable or disable buttons
*******************************************************************************}
procedure TFormLog.ChangeEnabled(AEnabled: Boolean);
begin
  BtDefault.Enabled := AEnabled;
  BtOK.Enabled := AEnabled;
  BtHtml.Enabled := AEnabled;
  BtBbcode.Enabled := AEnabled;
  BtText.Enabled := AEnabled;
  GbOptions.Enabled := AEnabled;
  GbChannels.Enabled := AEnabled;
  GbCharacters.Enabled := AEnabled;
  DatePickerStart.Enabled := AEnabled;
  DatePickerEnd.Enabled := AEnabled;
  TimePickerStart.Enabled := AEnabled;
  TimePickerEnd.Enabled := AEnabled;
end;

{*******************************************************************************
Load the log file
*******************************************************************************}
procedure TFormLog.BtLoadClick(Sender: TObject);
begin
  if OdBrowseLogFile.Execute then begin
    CopyFile(PChar(OdBrowseLogFile.FileName), PChar(FLogFile), False);

    FFirstLoading := True;
    SetDefault;
    LoadLogFile;
    FFirstLoading := False;

    FDateStart := DateOf(DatePickerStart.DateTime) + TimeOf(TimePickerStart.DateTime);
    FDateEnd := DateOf(DatePickerEnd.DateTime) + TimeOf(TimePickerEnd.DateTime);
    ChangeEnabled(True);
  end;
end;

{*******************************************************************************
Check box on double click
*******************************************************************************}
procedure TFormLog.CheckListBoxDblClick(Sender: TObject);
var
  wIndex: Integer;
  wList: TCheckListBox;
begin
  wList := TCheckListBox(Sender);
  wIndex := wList.ItemIndex;
  wList.Checked[wIndex] := not wList.Checked[wIndex];
end;

procedure TFormLog.BtCheckChannelsClick(Sender: TObject);
begin
  ChangeChecked(ListChannels, True);
end;

procedure TFormLog.BtUncheckChannelsClick(Sender: TObject);
begin
  ChangeChecked(ListChannels, False);
end;

procedure TFormLog.BtUncheckCharactersClick(Sender: TObject);
begin
  ChangeChecked(ListCharacters, False);
end;

procedure TFormLog.BtCheckCharactersClick(Sender: TObject);
begin
  ChangeChecked(ListCharacters, True);
end;

{*******************************************************************************
Check or unckeck all items in a list
*******************************************************************************}
procedure TFormLog.ChangeChecked(AList: TCheckListBox; AChecked: Boolean);
var
  i: Integer;
begin
  for i := 0 to AList.Count - 1 do begin
    AList.Checked[i] := AChecked;
  end;
end;

{*******************************************************************************
Change a color
*******************************************************************************}
procedure TFormLog.PnColorClick(Sender: TObject);
begin
  OdColor.Color := TPanel(Sender).Color;
  if OdColor.Execute then
    TPanel(Sender).Color := OdColor.Color;
end;

{*******************************************************************************
Restore default values
*******************************************************************************}
procedure TFormLog.BtDefaultClick(Sender: TObject);
begin
  SetDefault;
  LoadLogFile;
end;

{*******************************************************************************
Default values for options
*******************************************************************************}
procedure TFormLog.SetDefault;
begin
  DatePickerStart.Date := DateOf(FDateStart);
  DatePickerEnd.Date := DateOf(FDateEnd);
  TimePickerStart.Time := TimeOf(FDateStart);
  TimePickerEnd.Time := TimeOf(FDateEnd);
  PnColorBackground.Color := $00425E50;
  PnColorSystem.Color := $00000000;
  CbShowDate.Checked := True;
  CbSystemMessage.Checked := True;
  ChangeChecked(ListChannels, True);
  ChangeChecked(ListCharacters, True);
end;

{*******************************************************************************
Reload the log file
*******************************************************************************}
procedure TFormLog.BtOKClick(Sender: TObject);
begin
  LoadLogFile;
end;

{*******************************************************************************
Load the log file
*******************************************************************************}
procedure TFormLog.LoadLogFile;
begin
  FormProgress.ShowParseLog(FLogFile);
  ListChannels.Refresh; // refresh background color
end;

{*******************************************************************************
Color of channels in the list
*******************************************************************************}
procedure TFormLog.ListChannelsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TCheckListBox do with Canvas do begin
    Brush.Color := PnColorBackground.Color;
    Font.Color := FormProgress.LogToDelphiColor(Items[Index]);
    FillRect(Rect);
    DrawText(Handle, PChar(Items[Index]), -1, Rect , DT_LEFT or DT_NOPREFIX);
  end;
end;

{*******************************************************************************
Copy HTML
*******************************************************************************}
procedure TFormLog.BtHtmlClick(Sender: TObject);
begin
  Clipboard.AsText := MdkGetFileContent(FLogFileHtml);
end;

{*******************************************************************************
Copy BBCode
*******************************************************************************}
procedure TFormLog.BtBbcodeClick(Sender: TObject);
begin
  Clipboard.AsText := MdkGetFileContent(FLogFileBbode);
end;

{*******************************************************************************
Copy Text
*******************************************************************************}
procedure TFormLog.BtTextClick(Sender: TObject);
begin
  Clipboard.AsText := MdkGetFileContent(FLogFileText);
end;

{*******************************************************************************
Delete a filter
*******************************************************************************}
procedure TFormLog.BtDelFilterClick(Sender: TObject);
var
  wIndex: Integer;
begin
  wIndex := ListFilter.ItemIndex;
  if wIndex >= 0 then begin
    ListFilter.DeleteSelected;
    wIndex := Min(wIndex, ListFilter.Count-1);
    if wIndex >= 0 then
      ListFilter.Selected[wIndex] := True;
  end;
end;

{*******************************************************************************
Add a filter
*******************************************************************************}
procedure TFormLog.BtAddFilterClick(Sender: TObject);
begin
  if (EdFilter.Text <> '') and (ListFilter.Items.IndexOf(EdFilter.Text) < 0) then
    ListFilter.Items.Append(EdFilter.Text);
  EdFilter.SetFocus;
end;

{*******************************************************************************
Change edit value
*******************************************************************************}
procedure TFormLog.ListFilterClick(Sender: TObject);
begin
  if ListFilter.ItemIndex >= 0 then
    EdFilter.Text := ListFilter.Items[ListFilter.ItemIndex];
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.
