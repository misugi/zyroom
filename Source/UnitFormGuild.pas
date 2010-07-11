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
unit UnitFormGuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi,
  LcUnit, StrUtils, Buttons, SevenButton;

resourcestring
  RS_NEW_GUILD = 'Nouvelle guilde';
  RS_CHANGE_KEY = 'Changement de clé';
  RS_COL_GUILD_LOGO = 'Blason';
  RS_COL_GUILD_NAME = 'Guilde';
  RS_COL_GUILD_NUMBER = 'Numéro';
  RS_COL_COMMENT = 'Commentaire';
  RS_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer la guilde sélectionnée ?';
  RS_GUILD_KEY = 'Clé de guilde :';
  RS_CHECK_CHANGE = 'Surveiller les objets';
  RS_UP = 'Monter';
  RS_DOWN = 'Descendre';

type
  TPublicStringGrid = class(TCustomGrid); 

  TFormGuild = class(TForm)
    GridGuild: TStringGrid;
    Panel1: TPanel;
    BtNew: TSevenButton;
    BtUpdate: TSevenButton;
    BtDelete: TSevenButton;
    BtRoom: TSevenButton;
    BtDown: TSevenButton;
    BtUp: TSevenButton;
    procedure FormCreate(Sender: TObject);
    procedure GridGuildDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtNewClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridGuildMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridGuildMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridGuildSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtRoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridGuildDblClick(Sender: TObject);
    procedure BtDownClick(Sender: TObject);
    procedure BtUpClick(Sender: TObject);
  private
    FIconList: TObjectList;
    procedure LoadGrid;
    procedure Synchronize;
    procedure ShowRoom;
    procedure UpdateGuild(AAuto: Boolean);
    procedure MoveRow(AIndex: Integer);
  public
    procedure UpdateLanguage;
  end;

var
  FormGuild: TFormGuild;

implementation

uses UnitConfig, UnitFormGuildEdit, UnitRyzom, MisuDevKit,
  UnitFormConfirmation, UnitFormProgress, UnitFormMain, UnitFormRoom,
  UnitFormRoomFilter, ScrollRoom;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormGuild.FormCreate(Sender: TObject);
begin
  FIconList := TObjectList.Create;
  GridGuild.DoubleBuffered := True;
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
procedure TFormGuild.GridGuildDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  wServer: String;
begin
  with Sender as TStringGrid do with Canvas do begin
    if ARow = 0 then begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Font.Size := 8;
      Font.Color := clBlack;
      Font.Style := [];
      Font.Name := 'Arial';
      Rect.Left := Rect.Left + 2;
      DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
              DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
    end else begin
      // Background color
      If gdFixed in State
        then Brush.Color := clBtnFace
        else If gdSelected In State
          Then Brush.Color := clHighlight
          Else If Odd(ARow)
            Then Brush.Color := $FFFFFF
            Else Brush.Color := $BBF2F7;

      // Drawing background
      FillRect(Rect);

      // Font color
      If gdSelected In State
        Then Font.Color:=clHighlightText
        Else Font.Color:=clBlack;

      // Name
      if (ACol = 1) then begin
        Font.Size := 10;
        Font.Style := [fsBold];
        Rect.Top := Rect.Top - 15;
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );

        // Server
        Font.Size := 8;
        Font.Style := [];
        Rect.Top := Rect.Top + 35;
        wServer := GGuild.GetServerName(Cells[3,ARow]);
        DrawText(Handle, PChar(wServer), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;

      // Comment
      if (ACol = 2) then begin
        Font.Size := 8;
        Font.Style := [];
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;

      // Number
      if (ACol = 3) then begin
        Font.Size := 8;
        Font.Style := [];
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;

      // Logo
      if (ACol = 0) then
        Draw(Rect.Left + ((ColWidths[ACol] - 32) div 2),
          Rect.Top + ((RowHeights[ARow] - 32) div 2), TPNGObject(FIconList.Items[ARow-1]));
    end;
  end;
end;

{*******************************************************************************
Adds a new guild
*******************************************************************************}
procedure TFormGuild.BtNewClick(Sender: TObject);
var
  wGuildKey: String;
  wGuildID: String;
  wGuildName: String;
  wGuildIcon: String;
  wStream: TMemoryStream;
  wComment: String;
  wCheckVolume: Boolean;
  wCheckChange: Boolean;
  wServer: String;
  wXmlDoc: TXpObjModel;
  wIconFile: String;
  wWatchFile: String;
  i: Integer;
begin
  FormGuildEdit.Caption := RS_NEW_GUILD;
  FormGuildEdit.LbAutoKey.Caption := RS_GUILD_KEY;
  FormGuildEdit.EdKey.Text := '';
  FormGuildEdit.EdComment.Text := '';
  FormGuildEdit.CbCheckVolume.Checked := False;
  FormGuildEdit.CbCheckChange.Checked := False;
  FormGuildEdit.CbCheckChange.Caption := RS_CHECK_CHANGE;
  if FormGuildEdit.ShowModal = mrOk then begin
    wGuildKey := FormGuildEdit.EdKey.Text;
    wComment := FormGuildEdit.EdComment.Text;
    wCheckVolume := FormGuildEdit.CbCheckVolume.Checked;
    wCheckChange := FormGuildEdit.CbCheckChange.Checked;
    wStream := TMemoryStream.Create;
    try
      GRyzomApi.ApiGuild(wGuildKey, wStream);
      wXmlDoc := TXpObjModel.Create(nil);
      try
        wXmlDoc.LoadStream(wStream);
        wGuildID := wXmlDoc.DocumentElement.SelectString('/guild/gid');
        wGuildName := wXmlDoc.DocumentElement.SelectString('/guild/name');
        wGuildIcon := wXmlDoc.DocumentElement.SelectString('/guild/icon');
        wServer := wXmlDoc.DocumentElement.SelectString('/guild/shard');
        wServer := UpperCase(LeftStr(wServer, 1)) + RightStr(wServer, Length(wServer)-1);
        GGuild.AddGuild(wGuildID, wGuildKey, wGuildName, wComment, wServer, wCheckVolume, wCheckChange);

        ForceDirectories(GConfig.GetGuildRoomPath(wGuildID));
        wStream.Clear;
        GRyzomApi.ApiGuildIcon(wGuildIcon, _ICON_SMALL, wStream);
        wIconFile := GConfig.GetGuildPath(wGuildID) + _ICON_FILENAME;
        wStream.SaveToFile(wIconFile);
        LoadGrid;
        for i := 1 to GridGuild.RowCount - 1 do begin
          if CompareText(wGuildName, GridGuild.Cells[1, i]) = 0 then begin
            GridGuild.Row := i;
            Break;
          end;
        end;

        // Delete watch file if exists
        wWatchFile := GConfig.GetGuildPath(wGuildID) + _WATCH_FILENAME;
        if FileExists(wWatchFile) then DeleteFile(wWatchFile);
      finally
        wXmlDoc.Free;
      end;
    finally
      wStream.Free;
    end;
  end;
end;

{*******************************************************************************
Changes the key of a guild
*******************************************************************************}
procedure TFormGuild.BtUpdateClick(Sender: TObject);
begin
  UpdateGuild(False);
end;

{*******************************************************************************
Loads the grid
*******************************************************************************}
procedure TFormGuild.LoadGrid;
var
  wGuildList: TStringList;
  wPng: TPNGObject;
  wIconFile: String;
  wInfoFile: String;
  i: Integer;
begin
  SendMessage(GridGuild.Handle, WM_SETREDRAW, 0, 0);
  try
    GridGuild.RowCount := 1;
    GridGuild.Row := 0;
    GridGuild.ColCount := 4;
    GridGuild.RowHeights[0] := 20;
    GridGuild.ColWidths[0] := 48;
    GridGuild.ColWidths[1] := 250;
    GridGuild.ColWidths[3] := 70;

    FIconList.Clear;
    wGuildList := TStringList.Create;
    try
      GGuild.GuildList(wGuildList);
      for i := 0 to wGuildList.Count - 1 do begin
        wIconFile := GConfig.GetGuildPath(wGuildList[i]) + _ICON_FILENAME;
        wInfoFile := GConfig.GetGuildPath(wGuildList[i]) + _INFO_FILENAME;
        wPng := TPNGObject.Create;
        if FileExists(wIconFile) then begin
          try
            wPng.LoadFromFile(wIconFile);
          except
          end;
        end;
        FIconList.Add(wPng);
        GridGuild.RowCount := GridGuild.RowCount + 1;
        GridGuild.Cells[1, GridGuild.RowCount-1] := GGuild.GetGuildName(wGuildList[i]);
        GridGuild.Cells[2, GridGuild.RowCount-1] := GGuild.GetComment(wGuildList[i]);
        GridGuild.Cells[3, GridGuild.RowCount-1] := wGuildList[i];
      end;

      if GridGuild.RowCount > 1 then begin
        GridGuild.Row := 1;
        BtUpdate.Enabled := True;
        BtDelete.Enabled := True;
        BtRoom.Enabled := True;
      end;
    finally
      wGuildList.Free;
    end;
  finally
    SendMessage(GridGuild.Handle, WM_SETREDRAW, 1, 0);
    GridGuild.Refresh;
  end;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormGuild.GridGuildMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridGuild.Handle, WM_VSCROLL, SB_LINEDOWN, 0) ;
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormGuild.GridGuildMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridGuild.Handle, WM_VSCROLL, SB_LINEUP, 0) ;
end;

{*******************************************************************************
Selects a guild in the grid
*******************************************************************************}
procedure TFormGuild.GridGuildSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow = 0 then CanSelect := False;
  BtUp.Enabled := ARow > 1;
  BtDown.Enabled := ARow < GridGuild.RowCount - 1;
end;

{*******************************************************************************
Deletes the selected guild
*******************************************************************************}
procedure TFormGuild.BtDeleteClick(Sender: TObject);
var
  wRow: Integer;
  wTopRow: Integer;
  wGuildID: String;
begin
  wRow := GridGuild.Row;
  if wRow > 0 then begin
    wGuildID := GridGuild.Cells[3, wRow];
    if FormConfirm.ShowConfirmation(RS_DELETE_CONFIRMATION) <> mrYes then Exit;
    
    SendMessage(GridGuild.Handle, WM_SETREDRAW, 0, 0);
    try
      wTopRow := GridGuild.TopRow;
      TPublicStringGrid(GridGuild).DeleteRow(wRow);
      GridGuild.TopRow := wTopRow;
      if wRow < GridGuild.RowCount then GridGuild.Row := wRow;

      if GridGuild.RowCount = 1 then begin
        BtUpdate.Enabled := False;
        BtDelete.Enabled := False;
        BtRoom.Enabled := False;
      end;
    finally
      SendMessage(GridGuild.Handle, WM_SETREDRAW, 1, 0);
    end;

    GGuild.DeleteGuild(wGuildID);
    MdkRemoveDir(GConfig.GetGuildRoomPath(wGuildID));
    MdkRemoveDir(GConfig.GetGuildPath(wGuildID));
    FIconList.Delete(wRow-1);
    GridGuild.Refresh;
  end;
end;

{*******************************************************************************
Displays information of the selected guild
*******************************************************************************}
procedure TFormGuild.BtRoomClick(Sender: TObject);
begin
  try
    try UpdateGuild(True); except end;
    Synchronize;
  except
    on E: Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  ShowRoom;
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormGuild.FormResize(Sender: TObject);
begin
  GridGuild.ColWidths[2] := GridGuild.Width - GridGuild.ColWidths[0] - GridGuild.ColWidths[1] - GridGuild.ColWidths[3] - 25;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormGuild.GridGuildDblClick(Sender: TObject);
begin
  if GridGuild.Row > 0 then BtRoomClick(BtRoom);
end;

{*******************************************************************************
Display room
*******************************************************************************}
procedure TFormGuild.ShowRoom;
begin
  if not GConfig.SaveFilter then GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormMain.ShowMenuForm(FormRoom);
  FormRoom.UpdateRoom;
end;

{*******************************************************************************
Synchronization
*******************************************************************************}
procedure TFormGuild.Synchronize;
var
  wGuildID: String;
begin
  wGuildID := GridGuild.Cells[3, GridGuild.Row];
  FormProgress.ShowFormSynchronize(wGuildID);
end;

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormGuild.UpdateLanguage;
begin
  GridGuild.Cells[0, 0] := RS_COL_GUILD_LOGO;
  GridGuild.Cells[1, 0] := RS_COL_GUILD_NAME;
  GridGuild.Cells[2, 0] := RS_COL_COMMENT;
  GridGuild.Cells[3, 0] := RS_COL_GUILD_NUMBER;
  BtUp.Hint := RS_UP;
  BtDown.Hint := RS_DOWN;
end;

{*******************************************************************************
Updates guild information
*******************************************************************************}
procedure TFormGuild.UpdateGuild(AAuto: Boolean);
var
  wGuildID: String;
  wGuildKey: String;
  wGuildName: String;
  wComment: String;
  wCheckVolume: Boolean;
  wCheckChange: Boolean;
  wServer: String;
  wGuildIcon: String;
  wIconFile: String;
  wInfoFile: String;
  wWatchFile: String;
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wDoUpdate: Boolean;
begin
  wDoUpdate := AAuto;

  wGuildID := GridGuild.Cells[3, GridGuild.Row];
  wGuildKey := GGuild.GetGuildKey(wGuildID);
  wComment := GGuild.GetComment(wGuildID);
  wCheckVolume := GGuild.GetCheckVolume(wGuildID);
  wCheckChange := GGuild.GetCheckChange(wGuildID);

  if not wDoUpdate then begin
    FormGuildEdit.Caption := RS_CHANGE_KEY;
    FormGuildEdit.LbAutoKey.Caption := RS_GUILD_KEY;
    FormGuildEdit.EdKey.Text := wGuildKey;
    FormGuildEdit.EdComment.Text := wComment;
    FormGuildEdit.CbCheckVolume.Checked := wCheckVolume;
    FormGuildEdit.CbCheckChange.Checked := wCheckChange;
    FormGuildEdit.CbCheckChange.Caption := RS_CHECK_CHANGE;
    wDoUpdate := FormGuildEdit.ShowModal = mrOk;
    wGuildKey := FormGuildEdit.EdKey.Text;
    wComment := FormGuildEdit.EdComment.Text;
    wCheckVolume := FormGuildEdit.CbCheckVolume.Checked;
    wCheckChange := FormGuildEdit.CbCheckChange.Checked;

    // Delete watch file if exists
    wWatchFile := GConfig.GetGuildPath(wGuildID) + _WATCH_FILENAME;
    if (not wCheckChange) and (FileExists(wWatchFile)) then DeleteFile(wWatchFile);
  end;

  if wDoUpdate then begin
    // Updates icon
    wStream := TMemoryStream.Create;
    wXmlDoc := TXpObjModel.Create(nil);
    try
      GRyzomApi.ApiGuild(wGuildKey, wStream);
      wInfoFile := GConfig.GetGuildPath(wGuildID) + _INFO_FILENAME;
      wStream.SaveToFile(wInfoFile);
      wStream.Clear;
      wXmlDoc.LoadDataSource(wInfoFile);
      wGuildName := wXmlDoc.DocumentElement.SelectString('/guild/name');
      wGuildIcon := wXmlDoc.DocumentElement.SelectString('/guild/icon');
      wServer := wXmlDoc.DocumentElement.SelectString('/guild/shard');
      wServer := UpperCase(LeftStr(wServer, 1)) + RightStr(wServer, Length(wServer)-1);
      wIconFile := GConfig.GetGuildPath(wGuildID) + _ICON_FILENAME;
      wStream := TMemoryStream.Create;
      GRyzomApi.ApiGuildIcon(wGuildIcon, _ICON_SMALL, wStream);
      wStream.SaveToFile(wIconFile);
      TPNGObject(FIconList.Items[GridGuild.Row-1]).LoadFromFile(wIconFile);
      GridGuild.Refresh;
    finally
      wXmlDoc.Free;
      wStream.Free;
    end;
    
    GGuild.UpdateGuild(wGuildID, wGuildKey, wGuildName, wComment, wServer, wCheckVolume, wCheckChange);
    GridGuild.Cells[1, GridGuild.Row] := wGuildName;
    GridGuild.Cells[2, GridGuild.Row] := wComment;
  end;
end;

{*******************************************************************************
Up/Down
*******************************************************************************}
procedure TFormGuild.MoveRow(AIndex: Integer);
var
  wRow: Integer;
  wID1, wID2: String;
begin
  wRow := GridGuild.Row;
  wID1 := GridGuild.Cells[3, wRow];
  wID2 := GridGuild.Cells[3, wRow + AIndex];
  GGuild.SetIndex(wID1, wRow + AIndex);
  GGuild.SetIndex(wID2, wRow);
  LoadGrid;
  GridGuild.Row := wRow + AIndex;
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

end.
