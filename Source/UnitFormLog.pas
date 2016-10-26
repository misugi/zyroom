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
  Windows, Clipbrd, ActiveX, ShellAPI, Menus;

resourcestring
  RS_DELETECONFIRMATION1 = 'Attention aucune sauvegarde ne sera faite !';
  RS_DELETECONFIRMATION2 = 'Etes-vous sûr de vouloir nettoyer votre fichier de log ?';
  RS_MENUDELETEOLD = 'Supprimer les vieux messages (avant %s)';

type
  TFormLog = class(TForm)
    PnHeader: TPanel;
    BtLoad: TSevenButton;
    WebLog: TWebBrowser;
    OdBrowseLogFile: TOpenDialog;
    PnOptions: TPanel;
    OdColor: TColorDialog;
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
    PopupMenuCode: TPopupMenu;
    MenuHtml: TMenuItem;
    MenuBBCode: TMenuItem;
    MenuText: TMenuItem;
    PopupMenuClean: TPopupMenu;
    MenuDeleteSystem: TMenuItem;
    MenuAutoDeleteOld: TMenuItem;
    MenuDeleteAll: TMenuItem;
    BtCode: TSevenButton;
    BtSave: TSevenButton;
    BtClean: TSevenButton;
    procedure BtLoadClick(Sender: TObject);
    procedure CheckListBoxDblClick(Sender: TObject);
    procedure BtCheckChannelsClick(Sender: TObject);
    procedure BtUncheckChannelsClick(Sender: TObject);
    procedure BtUncheckCharactersClick(Sender: TObject);
    procedure BtCheckCharactersClick(Sender: TObject);
    procedure PnColorClick(Sender: TObject);
    procedure BtDefaultClick(Sender: TObject);
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
    procedure BtCodeClick(Sender: TObject);
    procedure BtCleanClick(Sender: TObject);
    procedure MenuDeleteAllClick(Sender: TObject);
    procedure MenuDeleteSystemClick(Sender: TObject);
    procedure MenuAutoDeleteOldClick(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
  private
    FLogFileHtml: String;
    FLogFileBbode: String;
    FLogFileText: String;
    FFilterFile: String;
    
    FDateStart: TDateTime;
    FDateEnd: TDateTime;

    FColorReg: TRegExpr;
    
    procedure LoadLogFile(AFirstLoading: Boolean = False);
    procedure SetDefault(ASetDates: Boolean = True);
    procedure ReloadSourceFile;
    function  GetConfirmation: Boolean;
  public
    procedure ChangeChecked(AList: TCheckListBox; AChecked: Boolean);
    procedure ChangeEnabled(AEnabled: Boolean);
    property LogFileHtml: String read FLogFileHtml write FLogFileHtml;
    property LogFileBbode: String read FLogFileBbode write FLogFileBbode;
    property LogFileText: String read FLogFileText write FLogFileText;
  end;

var
  FormLog: TFormLog;

implementation

uses UnitConfig, UnitRyzom, MisuDevKit, UnitFormMain, UnitFormProgress,
  Math, DateUtils, UnitFormConfirmation;

{$R *.dfm}

//DONE: - for chat, a "purge sys info messages" could be useful; after a few months, the log accumulates a lot of useless lines and it takes longer and longer to parse; stripping the system info parts would be immensely helpful, I believe
//DONE: - is the log loader threaded? the Cancel button does not respond while loading the log, and so is quite useless
//DONE: - can the generation of html/BBcode versions be optional instead of automated? I assume it's part of the reason why it takes so much time to load the log..
//DONE: - shouldn't the Guilds page have an 'inventory' button, and the Characters page a 'Room button? they seem to be switched right now

{*******************************************************************************
Create the form
*******************************************************************************}
procedure TFormLog.FormCreate(Sender: TObject);
var
  wHomeFile: String;
begin
  DoubleBuffered := True;
  WebLog.DoubleBuffered := True;
  PnHeader.DoubleBuffered := True;
  PnOptions.DoubleBuffered := True;

  ForceDirectories(GConfig.CurrentPath + _LOG_DIR);
  FLogFileHtml := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_HTML_FILENAME;
  FLogFileBbode := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_BBCODE_FILENAME;
  FLogFileText := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_TEXT_FILENAME;
  FFilterFile := GConfig.CurrentPath + _LOG_DIR + '\' + _LOG_FILTER_FILENAME;

  // Regular expression for color
  FColorReg := TRegExpr.Create;
  FColorReg.Expression := '@\{[0-9A-F]{4}\}';

  // Load filters
  if FileExists(FFilterFile) then
    ListFilter.Items.LoadFromFile(FFilterFile);

  // Initial dir to select a log file
  OdBrowseLogFile.InitialDir := ExtractFileDir(GConfig.PackFile);

  // Home page
  wHomeFile := GConfig.CurrentPath + _LOG_HOMEPAGE_FILENAME;
  if FileExists(wHomeFile) then
    WebLog.Navigate(wHomeFile)
  else
    WebLog.Navigate('about:blank');

  // Init
  ChangeEnabled(False);
  ListChannels.Clear;
  ListCharacters.Clear;
  EdFilter.Text := '';
end;

{*******************************************************************************
Destroy the form
*******************************************************************************}
procedure TFormLog.FormDestroy(Sender: TObject);
begin
  // Save filters
  ListFilter.Items.SaveToFile(FFilterFile);
  FColorReg.Free;
end;

{*******************************************************************************
Enable or disable buttons
*******************************************************************************}
procedure TFormLog.ChangeEnabled(AEnabled: Boolean);
begin
  BtDefault.Enabled := AEnabled;
  BtOK.Enabled := AEnabled;
  BtCode.Enabled := AEnabled;
  BtClean.Enabled := AEnabled;
  BtSave.Enabled := AEnabled;
//  GbOptions.Enabled := AEnabled;
  GbChannels.Enabled := AEnabled;
  GbCharacters.Enabled := AEnabled;
  DatePickerStart.Enabled := AEnabled;
  DatePickerEnd.Enabled := AEnabled;
  TimePickerStart.Enabled := AEnabled;
  TimePickerEnd.Enabled := AEnabled;
end;

{*******************************************************************************
Reload the source file
*******************************************************************************}
procedure TFormLog.ReloadSourceFile;
begin
  // Default filter and load file
  SetDefault(False);
  LoadLogFile(True);

  FDateStart := DateOf(DatePickerStart.DateTime) + TimeOf(TimePickerStart.DateTime);
  FDateEnd := DateOf(DatePickerEnd.DateTime) + TimeOf(TimePickerEnd.DateTime);
  ChangeEnabled(True);
end;

{*******************************************************************************
Load the log file
*******************************************************************************}
procedure TFormLog.BtLoadClick(Sender: TObject);
begin
  if OdBrowseLogFile.Execute then
    ReloadSourceFile;
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
procedure TFormLog.SetDefault(ASetDates: Boolean);
begin
  if ASetDates then begin
    DatePickerStart.Date := DateOf(FDateStart);
    DatePickerEnd.Date := DateOf(FDateEnd);
    TimePickerStart.Time := TimeOf(FDateStart);
    TimePickerEnd.Time := TimeOf(FDateEnd);
  end;
  PnColorBackground.Color := $00425E50;
  PnColorSystem.Color := $00000000;
  CbShowDate.Checked := False;
  CbSystemMessage.Checked := False;
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
procedure TFormLog.LoadLogFile(AFirstLoading: Boolean);
begin
  FormProgress.ShowParseLog(OdBrowseLogFile.FileName, AFirstLoading);
  ListChannels.Refresh; // refresh background color
end;

{*******************************************************************************
Color of channels in the list
*******************************************************************************}
procedure TFormLog.ListChannelsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  wColor: String;
begin
  with Control as TCheckListBox do with Canvas do begin
    FColorReg.Exec(Items[Index]);
    wColor := FColorReg.Match[0];
    Brush.Color := PnColorBackground.Color;
    Font.Color := FormProgress.LogToDelphiColor(wColor);
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
  ShellExecute(0, 'open', PChar(FLogFileHtml), nil, nil , SW_SHOW);
end;

{*******************************************************************************
Copy BBCode
*******************************************************************************}
procedure TFormLog.BtBbcodeClick(Sender: TObject);
begin
  Clipboard.AsText := MdkGetFileContent(FLogFileBbode);
  ShellExecute(0, 'open', PChar(FLogFileBbode), nil, nil , SW_SHOW);
end;

{*******************************************************************************
Copy Text
*******************************************************************************}
procedure TFormLog.BtTextClick(Sender: TObject);
begin
  Clipboard.AsText := MdkGetFileContent(FLogFileText);
  ShellExecute(0, 'open', PChar(FLogFileText), nil, nil , SW_SHOW);
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
    if wIndex >= 0 then begin
      ListFilter.Selected[wIndex] := True;
      EdFilter.Text := ListFilter.Items[wIndex];
    end else begin
      EdFilter.Text := '';
    end;
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

{*******************************************************************************
Ouvre le popup menu pour choisir le format
*******************************************************************************}
procedure TFormLog.BtCodeClick(Sender: TObject);
begin
  PopupMenuCode.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

{*******************************************************************************
Ouvre le popup menu pour choisir le type de suppression
*******************************************************************************}
procedure TFormLog.BtCleanClick(Sender: TObject);
begin
  MenuAutoDeleteOld.Caption := Format(RS_MENUDELETEOLD, [FormatDateTime('yyyy-dd-mm', DatePickerStart.DateTime)]);
  PopupMenuClean.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

{*******************************************************************************
Supprime tous les messages
*******************************************************************************}
procedure TFormLog.MenuDeleteAllClick(Sender: TObject);
begin
  if not GetConfirmation then Exit;
  MdkWriteFile(OdBrowseLogFile.FileName, '', False, True);
  ReloadSourceFile;
end;

{*******************************************************************************
Supprime les messages système
*******************************************************************************}
procedure TFormLog.MenuDeleteSystemClick(Sender: TObject);
begin
  if not GetConfirmation then Exit;
  FormProgress.ShowCleanLog(OdBrowseLogFile.FileName, 0);
  ReloadSourceFile;
end;

{*******************************************************************************
Supprime les vieux messages
*******************************************************************************}
procedure TFormLog.MenuAutoDeleteOldClick(Sender: TObject);
begin
  if not GetConfirmation then Exit;
  FormProgress.ShowCleanLog(OdBrowseLogFile.FileName, DateOf(DatePickerStart.DateTime));
  ReloadSourceFile;
end;

{*******************************************************************************
Demande de confirmation
*******************************************************************************}
function TFormLog.GetConfirmation: Boolean;
begin
  Result := FormConfirm.ShowConfirmation(RS_DELETECONFIRMATION1 + #13#10 + RS_DELETECONFIRMATION2) = mrYes;
end;

{*******************************************************************************
Sauvegarde du fichier de log en cours et suppression de tous les messages
*******************************************************************************}
procedure TFormLog.BtSaveClick(Sender: TObject);
begin
  OdSaveFile.FileName := ChangeFileExt(OdBrowseLogFile.FileName, FormatDateTime(' (yyyy-mm-dd hhnnss)', Now) + ExtractFileExt(OdBrowseLogFile.FileName));
  if OdSaveFile.Execute then
    Windows.CopyFile(PChar(OdBrowseLogFile.FileName), PChar(OdSaveFile.FileName), False);
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.
