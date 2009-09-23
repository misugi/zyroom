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
unit UnitFormGuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi,
  LcUnit;

resourcestring
  RS_NEW_GUILD = 'Nouvelle guilde';
  RS_CHANGE_KEY = 'Changement de clé';
  RS_COL_GUILD_LOGO = 'Blason';
  RS_COL_GUILD_NAME = 'Nom de guilde';
  RS_COL_GUILD_NUMBER = 'Numéro';
  RS_COL_LAST_SYNCHRONIZATION = 'Synchronisation';
  RS_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer la guilde sélectionnée ?';
  RS_PROGRESS_SYNCHRONIZE = 'Syncrhonisation en cours, veuillez patienter...';

type
  TPublicStringGrid = class(TCustomGrid); 

  TFormGuild = class(TForm)
    GridGuild: TStringGrid;
    BtUpdate: TButton;
    BtNew: TButton;
    BtSynchronize: TButton;
    BtDelete: TButton;
    BtRoom: TButton;
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
    procedure BtSynchronizeClick(Sender: TObject);
    procedure BtRoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridGuildDblClick(Sender: TObject);
  private
    FIconList: TObjectList;
    procedure LoadGrid;
  public
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
begin
  with Sender as TStringGrid do with Canvas do begin
    if ARow = 0 then begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Font.Size := 8;
      Font.Color := clBlack;
      Font.Style := [];
      Rect.Left := Rect.Left + 2;
      DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
              DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
    end else begin
      // Background color
      If gdFixed in State
        then Brush.Color := clBtnFace
        else If gdSelected In State
          Then Brush.Color := clNavy
          Else If Odd(ARow)
            Then Brush.Color := $FFFFFF
            Else Brush.Color := $BBF2F7;

      // Drawing background
      FillRect(Rect);

      // Font color
      If gdSelected In State
        Then Font.Color:=clWhite
        Else Font.Color:=clBlack;

      // Drawing text
      if (ACol = 1) then begin
        Font.Size := 10;
        Font.Style := [fsBold];
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;

      // Drawing text
      if (ACol = 2) or (ACol = 3) then begin
        Font.Size := 8;
        Font.Style := [];
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;

      // Drawing image
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
  wXmlDoc: TXpObjModel;
  wIconFile: String;
begin
  FormGuildEdit.Caption := RS_NEW_GUILD;
  FormGuildEdit.EdKey.Text := '';
  if FormGuildEdit.ShowModal = mrOk then begin
    wGuildKey := FormGuildEdit.EdKey.Text;
    wStream := TMemoryStream.Create;
    try
      GRyzomApi.ApiGuild(wGuildKey, wStream);
      wXmlDoc := TXpObjModel.Create(nil);
      try
        wXmlDoc.LoadStream(wStream);
        wGuildID := wXmlDoc.DocumentElement.SelectString('/guild/gid');
        wGuildName := wXmlDoc.DocumentElement.SelectString('/guild/name');
        wGuildIcon := wXmlDoc.DocumentElement.SelectString('/guild/icon');
        GGuild.AddGuild(wGuildID, wGuildKey, wGuildName);

        ForceDirectories(GConfig.GetGuildRoomPath(wGuildID));
        wStream.Clear;
        GRyzomApi.ApiGuildIcon(wGuildIcon, _ICON_SMALL, wStream);
        wIconFile := GConfig.GetGuildPath(wGuildID) + _ICON_FILENAME;
        wStream.SaveToFile(wIconFile);
        LoadGrid;
        GridGuild.Row := GridGuild.RowCount - 1;
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
var
  wGuildID: String;
  wGuildKey: String;
  wGuildName: String;
begin
  wGuildID := GridGuild.Cells[2, GridGuild.Row];
  wGuildKey := GGuild.GetGuildKey(wGuildID);
  FormGuildEdit.Caption := RS_CHANGE_KEY;
  FormGuildEdit.EdKey.Text := wGuildKey;
  if FormGuildEdit.ShowModal = mrOk then begin
    wGuildKey := FormGuildEdit.EdKey.Text;
    wGuildName := GridGuild.Cells[1, GridGuild.Row];
    GGuild.UpdateGuild(wGuildID, wGuildKey, wGuildName);
  end;
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
    GridGuild.Cells[0, 0] := RS_COL_GUILD_LOGO;
    GridGuild.Cells[1, 0] := RS_COL_GUILD_NAME;
    GridGuild.Cells[2, 0] := RS_COL_GUILD_NUMBER;
    GridGuild.Cells[3, 0] := RS_COL_LAST_SYNCHRONIZATION;
    GridGuild.ColCount := 4;
    GridGuild.RowHeights[0] := 20;
    GridGuild.ColWidths[0] := 50;
    GridGuild.ColWidths[2] := 90;
    GridGuild.ColWidths[3] := 130;
    GridGuild.ColWidths[1] := GridGuild.Width - GridGuild.ColWidths[0] -
      GridGuild.ColWidths[2] - GridGuild.ColWidths[3] - 7;
  
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
        GridGuild.Cells[2, GridGuild.RowCount-1] := wGuildList[i];
        if FileExists(wInfoFile) and (MdkFileSize(wInfoFile) > 0) then
          GridGuild.Cells[3, GridGuild.RowCount-1] := FormatDateTime('YYYY-MM-DD HH:NN:SS', MdkGetFileDate(wInfoFile))
        else
          GridGuild.Cells[3, GridGuild.RowCount-1] := '-';
      end;

      if GridGuild.RowCount > _MAX_GRID_LINES then
        GridGuild.ColWidths[1] := GridGuild.ColWidths[1] - _VERT_SCROLLBAR_WIDTH;

      if GridGuild.RowCount > 1 then begin
        GridGuild.Row := 1;
        BtUpdate.Enabled := True;
        BtSynchronize.Enabled := True;
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
    wGuildID := GridGuild.Cells[2, wRow];
    if FormConfirm.ShowConfirmation(RS_DELETE_CONFIRMATION) <> mrYes then Exit;
    
    SendMessage(GridGuild.Handle, WM_SETREDRAW, 0, 0);
    try
      wTopRow := GridGuild.TopRow;
      TPublicStringGrid(GridGuild).DeleteRow(wRow);
      GridGuild.TopRow := wTopRow;
      if wRow < GridGuild.RowCount then GridGuild.Row := wRow;

      if GridGuild.RowCount = _MAX_GRID_LINES then
        GridGuild.ColWidths[1] := GridGuild.ColWidths[1] + _VERT_SCROLLBAR_WIDTH;

      if GridGuild.RowCount = 1 then begin
        BtUpdate.Enabled := False;
        BtDelete.Enabled := False;
        BtSynchronize.Enabled := False;
        BtRoom.Enabled := False;
      end;
    finally
      SendMessage(GridGuild.Handle, WM_SETREDRAW, 1, 0);
      GridGuild.Refresh;
    end;

    GGuild.DeleteGuild(wGuildID);
    MdkRemoveDir(GConfig.GetGuildRoomPath(wGuildID));
    MdkRemoveDir(GConfig.GetGuildPath(wGuildID));
    FIconList.Delete(wRow-1);
  end;
end;

{*******************************************************************************
Synchronizes the selected guild
*******************************************************************************}
procedure TFormGuild.BtSynchronizeClick(Sender: TObject);
var
  wGuildID: String;
  wGuildName: String;
  wGuildIcon: String;
  wIconFile: String;
  wInfoFile: String;
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
begin
  wGuildID := GridGuild.Cells[2, GridGuild.Row];
  FormProgress.ShowFormSynchronize(wGuildID);

  wInfoFile := GConfig.GetGuildPath(wGuildID) + _INFO_FILENAME;
  if FileExists(wInfoFile) and (MdkFileSize(wInfoFile) > 0) then begin
    wXmlDoc := TXpObjModel.Create(nil);
    try
      wXmlDoc.LoadDataSource(wInfoFile);
      wGuildName := wXmlDoc.DocumentElement.SelectString('/guild/name');
      wGuildIcon := wXmlDoc.DocumentElement.SelectString('/guild/icon');
      wIconFile := GConfig.GetGuildPath(wGuildID) + _ICON_FILENAME;
      wStream := TMemoryStream.Create;
      GRyzomApi.ApiGuildIcon(wGuildIcon, _ICON_SMALL, wStream);
      wStream.SaveToFile(wIconFile);
      wStream.Free;
      TPNGObject(FIconList.Items[GridGuild.Row-1]).LoadFromFile(wIconFile);
      GridGuild.Cells[1, GridGuild.Row] := wGuildName;
      GridGuild.Cells[3, GridGuild.Row] := FormatDateTime('YYYY-MM-DD HH:NN:SS', MdkGetFileDate(wInfoFile));
      GridGuild.Refresh;
    finally
      wXmlDoc.Free;
    end;
  end else begin
    GridGuild.Cells[3, GridGuild.Row] := '-';
  end;
end;

{*******************************************************************************
Displays information of the selected guild
*******************************************************************************}
procedure TFormGuild.BtRoomClick(Sender: TObject);
var
  wGuildID: String;
begin
  FormMain.ShowMenuForm(FormRoom);
  wGuildID := FormGuild.GridGuild.Cells[2, FormGuild.GridGuild.Row];
  GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormProgress.ShowFormRoom(wGuildID, FormRoom.GuildRoom, GCurrentFilter);
  FormRoom.LbGuildName.Caption := Format('%s (%d)', [GridGuild.Cells[1, GridGuild.Row], FormRoom.GuildRoom.ControlCount]);
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormGuild.FormResize(Sender: TObject);
begin
  GridGuild.ColWidths[1] := GridGuild.Width - GridGuild.ColWidths[0] - GridGuild.ColWidths[2] - GridGuild.ColWidths[3] - 7;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormGuild.GridGuildDblClick(Sender: TObject);
begin
  BtRoomClick(BtRoom);
end;

end.
