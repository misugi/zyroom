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
unit UnitFormGuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi, LcUnit,
  StrUtils, Buttons, SevenButton, UnitConfig;

resourcestring
  RS_NEW_GUILD = 'Nouvelle guilde';
  RS_EDIT_GUILD = 'Modification guilde';
  RS_COL_GUILD_LOGO = 'Blason';
  RS_COL_GUILD_NAME = 'Guilde';
  RS_COL_GUILD_NUMBER = 'Numéro';
  RS_COL_COMMENT = 'Description';
  RS_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer la guilde sélectionnée ?';
  RS_GUILD_KEY = 'Clé API de guilde :';
  RS_CHECK_CHANGE = 'Surveiller les objets';
  RS_UP = 'Monter';
  RS_DOWN = 'Descendre';
  RS_RESET_OK = 'Réinitialisation terminée';

type
  TPublicStringGrid = class(TCustomGrid);

  TFormGuild = class(TForm)
    GridItem: TStringGrid;
    Panel1: TPanel;
    BtNew: TSevenButton;
    BtUpdate: TSevenButton;
    BtDelete: TSevenButton;
    BtRoom: TSevenButton;
    BtDown: TSevenButton;
    BtUp: TSevenButton;
    BtReset: TSevenButton;
    procedure FormCreate(Sender: TObject);
    procedure GridItemDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure BtNewClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridItemMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure GridItemMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure GridItemSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtRoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridItemDblClick(Sender: TObject);
    procedure BtDownClick(Sender: TObject);
    procedure BtUpClick(Sender: TObject);
    procedure BtResetClick(Sender: TObject);
  private
    FIconList: TObjectList;
    FDappers: String;
    procedure LoadGrid;
    procedure Synchronize;
    procedure ShowRoom;
    procedure UpdateItem(AAuto: Boolean);
    procedure SetItemInfo(AAction: TActionType);
    procedure MoveRow(AIndex: Integer);
    procedure SelectItem(AItemID: String);
    procedure EnableButtons(AEnabled: Boolean);
  public
    procedure UpdateLanguage;
  end;

var
  FormGuild: TFormGuild;

implementation

uses
  UnitFormEdit, UnitRyzom, MisuDevKit, UnitFormProgress, UnitFormMain,
  UnitFormFilter, UnitFormRoom, UnitFormDialog;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormGuild.FormCreate(Sender: TObject);
begin
  FIconList := TObjectList.Create;
  GridItem.DoubleBuffered := True;
  LoadGrid;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormGuild.FormDestroy(Sender: TObject);
begin
  FIconList.Free;
end;

{*******************************************************************************
Displays the grid
*******************************************************************************}
procedure TFormGuild.GridItemDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with Sender as TStringGrid do
    with Canvas do begin
      if ARow = 0 then begin
        Brush.Color := clBtnFace;
        FillRect(Rect);
        Font.Size := _FONT_SIZE;
        Font.Color := clBlack;
        Font.Style := [];
        Font.Name := _FONT_NAME;
        Rect.Left := Rect.Left + 2;
        DrawText(Handle, PChar(Cells[ACol, ARow]), -1, Rect,
          DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
      end
      else begin
      // Background color
        If gdFixed in State
          then
          Brush.Color := clBtnFace
        else If gdSelected In State
          Then
          Brush.Color := clHighlight
        Else If Odd(ARow)
          Then
          Brush.Color := $FFFFFF
        Else
          Brush.Color := $BBF2F7;

      // Drawing background
        FillRect(Rect);

      // Font color
        If gdSelected In State
          Then
          Font.Color := clHighlightText
        Else
          Font.Color := clBlack;

      // Name
        if (ACol = 1) then begin
          Font.Size := _FONT_SIZE + 2;
          Font.Style := [fsBold];
          Rect.Left := Rect.Left + 5;
          DrawText(Handle, PChar(Cells[ACol, ARow]), -1, Rect,
            DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        end;

      // Comment
        if (ACol = 2) then begin
          Font.Size := _FONT_SIZE;
          Font.Style := [];
          Rect.Left := Rect.Left + 5;
          DrawText(Handle, PChar(Cells[ACol, ARow]), -1, Rect,
            DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        end;

      // Number
        if (ACol = 3) then begin
          Font.Size := _FONT_SIZE;
          Font.Style := [];
          DrawText(Handle, PChar(Cells[ACol, ARow]), -1, Rect,
            DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        end;

      // Drawing image (logo)
        if (ACol = 0) then
          Draw(Rect.Left + ((ColWidths[ACol] - 32) div 2),
            Rect.Top + ((RowHeights[ARow] - 32) div 2), TPNGObject(FIconList.Items[ARow - 1]));
      end;
    end;
end;

{*******************************************************************************
Adds a new guild
*******************************************************************************}
procedure TFormGuild.BtNewClick(Sender: TObject);
begin
  try
  // Prepare edit window
    FormEdit.Caption := RS_NEW_GUILD;
    FormEdit.LbAutoKey.Caption := RS_GUILD_KEY;
    FormEdit.EdKey.Text := '';
    FormEdit.EdComment.Text := '';
    FormEdit.CbCheckVolume.Checked := False;
    FormEdit.CbCheckChange.Checked := False;
    FormEdit.CbCheckChange.Caption := RS_CHECK_CHANGE;

  // display window
    if FormEdit.ShowModal = mrOk then
      SetItemInfo(atAdd);
  except
    on E: Exception do
      FormDialog.Show(E.Message, mtError);
  end;
end;

{*******************************************************************************
Changes the key of a guild
*******************************************************************************}
procedure TFormGuild.BtUpdateClick(Sender: TObject);
begin
  try
    UpdateItem(False);
  except
    on E: Exception do
      FormDialog.Show(E.Message, mtError);
  end;
end;

{*******************************************************************************
Loads the grid
*******************************************************************************}
procedure TFormGuild.LoadGrid;
var
  wItemList: TStringList;
  wPng: TPNGObject;
  wIconFile: String;
  i: Integer;
begin
  SendMessage(GridItem.Handle, WM_SETREDRAW, 0, 0);
  try
    GridItem.RowCount := 1;
    GridItem.Row := 0;
    GridItem.ColCount := 4;
    GridItem.RowHeights[0] := 20;
    GridItem.ColWidths[0] := 60;
    GridItem.ColWidths[1] := 250;
    GridItem.ColWidths[3] := 90;

    FIconList.Clear;
    wItemList := TStringList.Create;
    try
      GGuild.GuildList(wItemList);
      for i := 0 to wItemList.Count - 1 do begin
        wIconFile := GConfig.GetGuildPath(wItemList[i]) + _ICON_FILENAME;
        wPng := TPNGObject.Create;
        if FileExists(wIconFile) then begin
          try
            wPng.LoadFromFile(wIconFile);
          except
          end;
        end;
        FIconList.Add(wPng);
        GridItem.RowCount := GridItem.RowCount + 1;
        GridItem.Cells[1, GridItem.RowCount - 1] := GGuild.GetGuildName(wItemList[i]);
        GridItem.Cells[2, GridItem.RowCount - 1] := GGuild.GetComment(wItemList[i]);
        GridItem.Cells[3, GridItem.RowCount - 1] := wItemList[i];
      end;

      EnableButtons(False);
      if GridItem.RowCount > 1 then begin
        GridItem.Row := 1;
        EnableButtons(True);
      end;
    finally
      wItemList.Free;
    end;
  finally
    SendMessage(GridItem.Handle, WM_SETREDRAW, 1, 0);
    GridItem.Refresh;
  end;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormGuild.GridItemMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridItem.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormGuild.GridItemMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridItem.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

{*******************************************************************************
Selects a guild in the grid
*******************************************************************************}
procedure TFormGuild.GridItemSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if ARow = 0 then
    CanSelect := False;
  BtUp.Enabled := ARow > 1;
  BtDown.Enabled := ARow < GridItem.RowCount - 1;
end;

{*******************************************************************************
Deletes the selected guild
*******************************************************************************}
procedure TFormGuild.BtDeleteClick(Sender: TObject);
var
  wRow: Integer;
  wTopRow: Integer;
  wItemID: String;
begin
  wRow := GridItem.Row;
  if wRow > 0 then begin
    wItemID := GridItem.Cells[3, wRow];
    if FormDialog.Show(RS_DELETE_CONFIRMATION, mtConfirmation) <> mrYes then
      Exit;

    SendMessage(GridItem.Handle, WM_SETREDRAW, 0, 0);
    try
      wTopRow := GridItem.TopRow;
      TPublicStringGrid(GridItem).DeleteRow(wRow);
      GridItem.TopRow := wTopRow;
      if wRow < GridItem.RowCount then
        GridItem.Row := wRow;

      if GridItem.RowCount = 1 then
        EnableButtons(False);
    finally
      SendMessage(GridItem.Handle, WM_SETREDRAW, 1, 0);
    end;

    GGuild.DeleteGuild(wItemID);
    MdkRemoveDir(GConfig.GetGuildRoomPath(wItemID));
    MdkRemoveDir(GConfig.GetGuildPath(wItemID));
    FIconList.Delete(wRow - 1);
    GridItem.Refresh;
  end;
end;

{*******************************************************************************
Displays information of the selected item
*******************************************************************************}
procedure TFormGuild.BtRoomClick(Sender: TObject);
begin
  try
    UpdateItem(True);
    Synchronize;
    ShowRoom;
  except
    on E: Exception do
      FormDialog.Show(E.Message, mtError);
  end;
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormGuild.FormResize(Sender: TObject);
begin
  GridItem.ColWidths[2] := GridItem.Width - GridItem.ColWidths[0] - GridItem.ColWidths[1] - GridItem.ColWidths[3] - 25;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormGuild.GridItemDblClick(Sender: TObject);
begin
  if GridItem.Row > 0 then
    BtRoomClick(BtRoom);
end;

{*******************************************************************************
Display items
*******************************************************************************}
procedure TFormGuild.ShowRoom;
begin
  if not GConfig.SaveFilter then
    GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormMain.ShowMenuForm(FormRoom);
  FormRoom.Dappers := FDappers;
  FormRoom.UpdateRoom;
end;

{*******************************************************************************
Synchronization
*******************************************************************************}
procedure TFormGuild.Synchronize;
var
  wItemID: String;
begin
  wItemID := GridItem.Cells[3, GridItem.Row];
  FormProgress.ShowFormSyncGuild(wItemID);
end;

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormGuild.UpdateLanguage;
begin
  GridItem.Cells[0, 0] := RS_COL_GUILD_LOGO;
  GridItem.Cells[1, 0] := RS_COL_GUILD_NAME;
  GridItem.Cells[2, 0] := RS_COL_COMMENT;
  GridItem.Cells[3, 0] := RS_COL_GUILD_NUMBER;
  BtUp.Hint := RS_UP;
  BtDown.Hint := RS_DOWN;
end;

{*******************************************************************************
Updates information
*******************************************************************************}
procedure TFormGuild.UpdateItem(AAuto: Boolean);
var
  wItemID: String;
  wDoUpdate: Boolean;
begin
  wDoUpdate := AAuto;

  // read ID
  wItemID := GridItem.Cells[3, GridItem.Row];

  // prepare the edit window
  FormEdit.Caption := RS_EDIT_GUILD;
  FormEdit.LbAutoKey.Caption := RS_GUILD_KEY;
  FormEdit.EdKey.Text := GGuild.GetGuildKey(wItemID);
  FormEdit.EdComment.Text := GGuild.GetComment(wItemID);
  FormEdit.CbCheckVolume.Checked := GGuild.GetCheckVolume(wItemID);
  FormEdit.CbCheckChange.Checked := GGuild.GetCheckChange(wItemID);
  FormEdit.CbCheckChange.Caption := RS_CHECK_CHANGE;

  if not wDoUpdate then
    wDoUpdate := FormEdit.ShowModal = mrOk;

  if wDoUpdate then
    SetItemInfo(atUpdate);
end;

{*******************************************************************************
Up/Down
*******************************************************************************}
procedure TFormGuild.MoveRow(AIndex: Integer);
var
  wRow: Integer;
  wID1, wID2: String;
begin
  wRow := GridItem.Row;
  wID1 := GridItem.Cells[3, wRow];
  wID2 := GridItem.Cells[3, wRow + AIndex];
  GGuild.SetIndex(wID1, wRow + AIndex);
  GGuild.SetIndex(wID2, wRow);
  LoadGrid;
  GridItem.Row := wRow + AIndex;
end;

{*******************************************************************************
Down
*******************************************************************************}
procedure TFormGuild.BtDownClick(Sender: TObject);
begin
  MoveRow(+1);
end;

{*******************************************************************************
Up
*******************************************************************************}
procedure TFormGuild.BtUpClick(Sender: TObject);
begin
  MoveRow(-1);
end;

{*******************************************************************************
Reset the icons directory
*******************************************************************************}
procedure TFormGuild.BtResetClick(Sender: TObject);
var
  wRow: Integer;
  wItemID: String;
begin
  wRow := GridItem.Row;
  if wRow > 0 then begin
    wItemID := GridItem.Cells[3, wRow];
    MdkRemoveDir(GConfig.GetGuildRoomPath(wItemID));
    DeleteFile(GConfig.GetGuildPath(wItemID) + _INDEX_FILENAME);
    FormDialog.Show(RS_RESET_OK);
  end;
end;

{*******************************************************************************
Set info
*******************************************************************************}
procedure TFormGuild.SetItemInfo(AAction: TActionType);
var
  wApiKey: String;
  wComment: String;
  wCheckVolume: Boolean;
  wCheckChange: Boolean;
  wItemID: String;
  wItemName: String;
  wItemIcon: String;
  wItemServer: String;
  wXmlDoc: TXpObjModel;
  wStream: TMemoryStream;
  wInfoFile: String;
  wWatchFile: String;
{$IFNDEF __LOCALINFO}
  wIconFile: String;
{$ENDIF}
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  try
    // read info on the edit window
    wApiKey := FormEdit.EdKey.Text;
    wComment := FormEdit.EdComment.Text;
    wCheckVolume := FormEdit.CbCheckVolume.Checked;
    wCheckChange := FormEdit.CbCheckChange.Checked;

    // call API
    try
{$IFNDEF __LOCALINFO}
      GRyzomApi.ApiGuild(wApiKey, wStream);
      wXmlDoc.LoadStream(wStream);
{$ELSE}
      if AAction = atAdd then begin
        GRyzomApi.ApiGuild(wApiKey, wStream);
        wXmlDoc.LoadStream(wStream);
      end
      else begin
        wItemID := GridItem.Cells[3, GridItem.Row];
        wInfoFile := GConfig.GetGuildPath(wItemID) + _INFO_FILENAME;
        wXmlDoc.LoadDataSource(wInfoFile);
      end;
{$ENDIF}
    except
      on E: Exception do
        raise Exception.CreateFmt(RS_INVALID_APIKEY, [E.Message]);
    end;
    
    // check modules
    if not CheckModules(wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/@modules'), _REQUIRED_MODULES_GUILD) then
      raise Exception.CreateFmt(RS_REQUIRED_MODULES, [MdkArrayToString(_REQUIRED_MODULES_GUILD, ',')]);

    // read info in the XML
    wItemID := wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/gid');
    wItemName := wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/name');
    wItemIcon := wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/icon');
    wItemServer := wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/shard');
    wItemServer := UpperCase(LeftStr(wItemServer, 1)) + LowerCase(RightStr(wItemServer, Length(wItemServer) - 1));
    FDappers := wXmlDoc.DocumentElement.SelectString('/ryzomapi/guild/money');

    // update INI
    GGuild.SetGuild(AAction, wItemID, wApiKey, wItemName, wComment, wItemServer, wCheckVolume, wCheckChange);

    // save to info.xml
{$IFNDEF __LOCALINFO}
    wInfoFile := GConfig.GetGuildPath(wItemID) + _INFO_FILENAME;
    wStream.SaveToFile(wInfoFile);
{$ENDIF}
    // Get image
{$IFNDEF __LOCALINFO}
    wStream.Clear;
    GRyzomApi.ApiGuildIcon(wItemIcon, _ICON_SMALL, wStream);
    wIconFile := GConfig.GetGuildPath(wItemID) + _ICON_FILENAME;
    wStream.SaveToFile(wIconFile);
    if AAction = atUpdate then
      TPNGObject(FIconList.Items[GridItem.Row - 1]).LoadFromFile(wIconFile);
{$ENDIF}
    // delete watch file if necessary
    wWatchFile := GConfig.GetGuildPath(wItemID) + _WATCH_FILENAME;
    if ((AAction = atAdd) or (not wCheckChange)) and FileExists(wWatchFile) then
      DeleteFile(wWatchFile);

    // refresh grid info
    if AAction = atAdd then begin
      GGuild.SetIndex(wItemID, GridItem.RowCount - 1);
      LoadGrid;
      SelectItem(wItemID);
    end
    else begin
      GridItem.Cells[1, GridItem.Row] := wItemName;
      GridItem.Cells[2, GridItem.Row] := wComment;
      GridItem.Refresh;
    end;
  finally
    wXmlDoc.Free;
    wStream.Free;
  end;
end;

{*******************************************************************************
select a char from his ID
*******************************************************************************}
procedure TFormGuild.SelectItem(AItemID: String);
var
  i: Integer;
begin
  for i := 1 to GridItem.RowCount - 1 do begin
    if CompareText(AItemID, GridItem.Cells[3, i]) = 0 then begin
      GridItem.Row := i;
      Break;
    end;
  end;
end;

{*******************************************************************************
Enables or disables buttons
*******************************************************************************}
procedure TFormGuild.EnableButtons(AEnabled: Boolean);
begin
  BtUpdate.Enabled := AEnabled;
  BtDelete.Enabled := AEnabled;
  BtReset.Enabled := AEnabled;
  BtRoom.Enabled := AEnabled;
end;

end.

