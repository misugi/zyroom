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
unit UnitFormBackup;

interface

uses
  Forms, SysUtils, Dialogs, OleCtrls, SHDocVw, StdCtrls, SevenButton, Classes,
  Controls, ExtCtrls, RyzomApi, regexpr, ComCtrls, CheckLst, Graphics, Types,
  Windows, Clipbrd, ActiveX, Spin;

const
  _MAX_BACKUP = 30;

resourcestring
  RS_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer la sauvegarde sélectionnée ?';
  RS_DESTORE_CONFIRMATION = 'Etes-vous sûr de vouloir restaurer les personnages sélectionnés ?';
  RS_DEFAULT_AUTO_NAME = 'Sauvegarde automatique';
  RS_DEFAULT_MANUAL_NAME = 'Sauvegarde manuelle';

type
  TFormBackup = class(TForm)
    PnHeader: TPanel;
    PnOptions: TPanel;
    BtSave: TSevenButton;
    ListBackup: TListBox;
    ListCharacters: TListBox;
    BtRestore: TSevenButton;
    BtDelete: TSevenButton;
    CbAutoBackup: TCheckBox;
    BtRename: TSevenButton;
    LbAlert: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
    procedure ListBackupClick(Sender: TObject);
    procedure CbAutoBackupClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtRenameClick(Sender: TObject);
    procedure BtRestoreClick(Sender: TObject);
    procedure ListCharactersClick(Sender: TObject);
  private
    procedure SelectBackup(AIndex: Integer);
    procedure LoadBackups;
    procedure RenameBackup(ABackupDir: String; AName: String);
    procedure EnableButtons;
    procedure BackupFiles(ABackupType: Char; AName: String);
    procedure RestoreBackup;
    function  GetBackupDir: String;
    function  GetBackupName: String;
    procedure LoadCharacters;
  public
    procedure Init;
    procedure StartAutoBackup;
  end;

var
  FormBackup: TFormBackup;

implementation

uses UnitConfig, UnitRyzom, MisuDevKit, UnitFormMain, UnitFormProgress,
  Math, DateUtils, UnitFormName, StrUtils, UnitFormConfirmation;

{$R *.dfm}

{*******************************************************************************
Create the form
*******************************************************************************}
procedure TFormBackup.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  PnHeader.DoubleBuffered := True;

  ForceDirectories(GConfig.CurrentPath + _BACKUP_DIR);
end;

{*******************************************************************************
Destroy the form
*******************************************************************************}
procedure TFormBackup.FormDestroy(Sender: TObject);
begin
  ;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormBackup.FormShow(Sender: TObject);
begin
  Init;
end;

{*******************************************************************************
Manual backup
*******************************************************************************}
procedure TFormBackup.BtSaveClick(Sender: TObject);
begin
  FormName.EdName.Text := RS_DEFAULT_MANUAL_NAME;
  if FormName.ShowModal = mrOk then begin
    BackupFiles('M', FormName.EdName.Text);
    LoadBackups;
    SelectBackup(ListBackup.Count - 1);
  end;
end;

{*******************************************************************************
Select a backup in the list
*******************************************************************************}
procedure TFormBackup.ListBackupClick(Sender: TObject);
begin
  LoadCharacters;
  EnableButtons;
end;

{*******************************************************************************
Load the list of backups
*******************************************************************************}
procedure TFormBackup.LoadBackups;
var
  i: Integer;
  wName: String;
  wFileName: String;
begin
  ListBackup.Clear;
  MdkListDirs(GConfig.CurrentPath + _BACKUP_DIR, '*', ListBackup.Items);
  for i := 0 to ListBackup.Items.Count - 1 do begin
    wName := '';
    wFileName := ListBackup.Items[i] + '\' + _BACKUP_NAME_FILE;
    if FileExists(wFileName) then
      wName := MdkGetFileContent(wFileName);
    ListBackup.Items[i] := Format('%s %s', [ExtractFileName(ListBackup.Items[i]), wName]);
  end;
end;

{*******************************************************************************
Check if the pack file exists well
*******************************************************************************}
procedure TFormBackup.Init;
begin
  BtSave.Enabled := FileExists(GConfig.PackFile);
  BtRestore.Enabled := BtSave.Enabled;
  CbAutoBackup.Enabled := BtSave.Enabled;
  LbAlert.Visible := not BtSave.Enabled;
  CbAutoBackup.Checked := GConfig.AutoBackup;

  LoadBackups;
  EnableButtons;
end;

{*******************************************************************************
Enable or disable buttons
*******************************************************************************}
procedure TFormBackup.EnableButtons;
begin
  BtRestore.Enabled := (ListBackup.ItemIndex >= 0) and (BtSave.Enabled) and (ListCharacters.SelCount > 0);
  BtDelete.Enabled := ListBackup.ItemIndex >= 0;
  BtRename.Enabled := ListBackup.ItemIndex >= 0;
  if ListBackup.ItemIndex < 0 then ListCharacters.Clear;
end;

{*******************************************************************************
Backup files (type: A for Automatic backup - M for Manual backup)
*******************************************************************************}
procedure TFormBackup.BackupFiles(ABackupType: Char; AName: String);
var
  wList: TStringList;
  wBackupDir: String;
  wBackupFile: String;
  wFileName: String;

  // Copy files
  procedure CopyFiles;
  var
    i: integer;
  begin
    for i := 0 to wList.Count - 1 do begin
      wBackupFile := wBackupDir + '\' + ExtractFileName(wList.Strings[i]);
      CopyFile(PChar(wList.Strings[i]), PChar(wBackupFile), False);
    end;
  end;
begin
  if FileExists(GConfig.PackFile) then begin
    // Create the backup directory
    wBackupDir := GConfig.CurrentPath + _BACKUP_DIR + '\' + FormatDateTime('yyyy-mm-dd hhnnss', Now) + ABackupType;
    MkDir(wBackupDir);
    
    wList := TStringList.Create;
    try
      // Keys
      wList.Clear;
      MdkListFiles(ExtractFileDir(GConfig.PackFile), '*.xml', False, wList);
      CopyFiles;

      // Interface
      wList.Clear;
      MdkListFiles(ExtractFileDir(GConfig.PackFile), '*.icfg', False, wList);
      CopyFiles;

      // Log
      wList.Clear;
      MdkListFiles(ExtractFileDir(GConfig.PackFile), '*.txt', False, wList);
      CopyFiles;

      // Name
      wFileName := wBackupDir + '\' + _BACKUP_NAME_FILE;
      MdkWriteFile(wFileName, AName, False, True);
    finally
      wList.Free;
    end;
  end;
end;

{*******************************************************************************
Automatic backups
*******************************************************************************}
procedure TFormBackup.CbAutoBackupClick(Sender: TObject);
begin
  GConfig.AutoBackup := CbAutoBackup.Checked;
end;

{*******************************************************************************
Delete the selected backup
*******************************************************************************}
procedure TFormBackup.BtDeleteClick(Sender: TObject);
var
  wBackupDir: String;
  wIndex: Integer;
begin
  if FormConfirm.ShowConfirmation(RS_DELETE_CONFIRMATION) <> mrYes then Exit;

  wIndex := ListBackup.ItemIndex;
  wBackupDir := GConfig.CurrentPath + _BACKUP_DIR + '\' + GetBackupDir;
  if DirectoryExists(wBackupDir) then begin
    MdkRemoveDir(wBackupDir);
    ListBackup.DeleteSelected;
    if (ListBackup.Count > 0) then begin
      if (wIndex = ListBackup.Count) then
        wIndex := wIndex - 1;
      SelectBackup(wIndex);
    end;
    EnableButtons;
  end;
end;

{*******************************************************************************
Auto backup
*******************************************************************************}
procedure TFormBackup.StartAutoBackup;
var
  wList: TStringList;
  wLastBackupDir: String;
  wLastBackupDate: String;
  wNowBackupDate: String;
begin
  if GConfig.AutoBackup then begin
    wList := TStringList.Create;
    try
      MdkListDirs(GConfig.CurrentPath + _BACKUP_DIR, '*A', wList);
      wList.Sort;
      if wList.Count = 0 then begin
        BackupFiles('A', RS_DEFAULT_AUTO_NAME);
      end else begin
        // Deletes the oldest backup if the limit is reached
        if wList.Count = _MAX_BACKUP then
          MdkRemoveDir(wList.Strings[0]);

        wLastBackupDir := ExtractFileName(wList.Strings[wList.Count-1]);
        wLastBackupDate := Copy(wLastBackupDir, 1, 10);
        wNowBackupDate := FormatDateTime('yyyy-mm-dd', Now);
        if CompareText(wLastBackupDate, wNowBackupDate) <> 0 then
          BackupFiles('A', RS_DEFAULT_AUTO_NAME);
      end;
    finally
      wList.Free;
    end;
  end;
end;

{*******************************************************************************
Rename
*******************************************************************************}
procedure TFormBackup.BtRenameClick(Sender: TObject);
begin
  FormName.EdName.Text := GetBackupName;
  if FormName.ShowModal = mrOk then begin
    RenameBackup(GetBackupDir, FormName.EdName.Text);
  end;
end;

{*******************************************************************************
Rename backup
*******************************************************************************}
procedure TFormBackup.RenameBackup(ABackupDir: String; AName: String);
var
  wFileName: String;
begin
  wFileName := GConfig.CurrentPath + _BACKUP_DIR + '\' + ABackupDir + '\' + _BACKUP_NAME_FILE;
  MdkWriteFile(wFileName, AName, False, True);
  ListBackup.Items[ListBackup.ItemIndex] := Format('%s %s', [ABackupDir, AName]);
end;

{*******************************************************************************
Returns directory of the bckup
*******************************************************************************}
function TFormBackup.GetBackupDir: String;
begin
  Result := LeftStr(ListBackup.Items[ListBackup.ItemIndex], 18);
end;

{*******************************************************************************
Returns name of the backup
*******************************************************************************}
function TFormBackup.GetBackupName: String;
var
  wValue: String;
begin
  wValue := ListBackup.Items[ListBackup.ItemIndex];
  Result := RightStr(wValue, Length(wValue)-19);
end;

{*******************************************************************************
Restore backup
*******************************************************************************}
procedure TFormBackup.BtRestoreClick(Sender: TObject);
begin
  if FormConfirm.ShowConfirmation(RS_DESTORE_CONFIRMATION) <> mrYes then Exit;
  RestoreBackup;
end;

{*******************************************************************************
Load the list of characters
*******************************************************************************}
procedure TFormBackup.LoadCharacters;
var
  wBackupDir: String;
  wList: TStringList;
  wReg: TRegExpr;
  wCharName: String;
  i: Integer;
begin
  ListCharacters.Clear;
  wBackupDir := GConfig.CurrentPath + _BACKUP_DIR + '\' + GetBackupDir;
  wList := TStringList.Create;
  wReg := TRegExpr.Create;
  try
    MdkListFiles(wBackupDir, 'interface_*.icfg', False, wList);
    wReg.Expression := 'interface_(\w+)';
    for i := 0 to wList.Count - 1 do begin
      wReg.Exec(wList.Strings[i]);
      wCharName := wReg.Match[1];
      wCharName := UpperCase(wCharName[1]) + RightStr(wCharName, Length(wCharName)-1);
      ListCharacters.Items.Append(wCharName);
    end;
    ListCharacters.SelectAll;
    
  finally
    wReg.Free;
    wList.Free;
  end;
end;

{*******************************************************************************
Select/Unselect a character
*******************************************************************************}
procedure TFormBackup.ListCharactersClick(Sender: TObject);
begin
  EnableButtons;
end;

{*******************************************************************************
Change the backup selection
*******************************************************************************}
procedure TFormBackup.SelectBackup(AIndex: Integer);
begin
  ListBackup.ItemIndex := AIndex;
  LoadCharacters;
  EnableButtons;
end;

{*******************************************************************************
Restore the backup selected
*******************************************************************************}
procedure TFormBackup.RestoreBackup;
var
  wBackupDir: String;
  wCharName: String;
  wGameFile: String;
  wList: TStringList;
  c: Integer;

  procedure RestoreFiles;
  var
    i: integer;
  begin
    for i := 0 to wList.Count - 1 do begin
      wGameFile := ExtractFileDir(GConfig.PackFile) + '\' + ExtractFileName(wList.Strings[i]);
      CopyFile(PChar(wList.Strings[i]), PChar(wGameFile), False);
    end;
  end;
begin
  wBackupDir := GConfig.CurrentPath + _BACKUP_DIR + '\' + GetBackupDir;

  wList := TStringList.Create;
  try
    for c := 0 to ListCharacters.Count - 1 do begin
      if ListCharacters.Selected[c] then begin
        wCharName := ListCharacters.Items[c];

        // Keys
        wList.Clear;
        MdkListFiles(wBackupDir, Format('*%s*.xml', [wCharName]), False, wList);
        RestoreFiles;

        // Interface
        wList.Clear;
        MdkListFiles(wBackupDir, Format('*%s*.icfg', [wCharName]), False, wList);
        RestoreFiles;

        // Log files are not restored
      end;
    end;
  finally
    wList.Free;
  end;
end;

end.
