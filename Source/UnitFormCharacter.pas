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
unit UnitFormCharacter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi,
  LcUnit;

resourcestring
  RS_CHAR_NEW_CHARACTER = 'Nouveau personnage';
  RS_CHAR_CHANGE_KEY = 'Changement de clé';
  RS_CHAR_COL_CHAR_SERVER = 'Serveur';
  RS_CHAR_COL_CHAR_NAME = 'Nom de personnage';
  RS_CHAR_COL_CHAR_NUMBER = 'Numéro';
  RS_CHAR_COL_LAST_SYNCHRONIZATION = 'Synchronisation';
  RS_CHAR_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer le personnage sélectionné ?';
  RS_CHAR_PROGRESS_SYNCHRONIZE = 'Syncrhonisation en cours, veuillez patienter...';
  RS_CHAR_KEY = 'Clé de personnage :';

type
  TPublicStringGrid = class(TCustomGrid); 

  TFormCharacter = class(TForm)
    GridChar: TStringGrid;
    BtUpdate: TButton;
    BtNew: TButton;
    BtDelete: TButton;
    BtRoom: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GridCharDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtNewClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridCharMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridCharMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridCharSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtRoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridCharDblClick(Sender: TObject);
  private
    procedure LoadGrid;
    procedure Synchronize;
    procedure Room;
  public
  end;

var
  FormCharacter: TFormCharacter;

implementation

uses UnitConfig, UnitFormGuildEdit, UnitRyzom, MisuDevKit,
  UnitFormConfirmation, UnitFormProgress, UnitFormMain, UnitFormRoom,
  UnitFormRoomFilter, UnitFormInvent;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormCharacter.FormCreate(Sender: TObject);
begin
  GridChar.DoubleBuffered := True;
  LoadGrid;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormCharacter.FormDestroy(Sender: TObject);
begin
end;

{*******************************************************************************
Displays the grid
*******************************************************************************}
procedure TFormCharacter.GridCharDrawCell(Sender: TObject; ACol, ARow: Integer;
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
      if (ACol = 0) or (ACol = 2) or (ACol = 3) then begin
        Font.Size := 8;
        Font.Style := [];
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );
      end;
    end;
  end;
end;

{*******************************************************************************
Adds a new guild
*******************************************************************************}
procedure TFormCharacter.BtNewClick(Sender: TObject);
var
  wCharKey: String;
  wCharID: String;
  wCharName: String;
  wCharServer: String;
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  i: Integer;
begin
  FormGuildEdit.Caption := RS_CHAR_NEW_CHARACTER;
  FormGuildEdit.LbKey.Caption := RS_CHAR_KEY;
  FormGuildEdit.EdKey.Text := '';
  if FormGuildEdit.ShowModal = mrOk then begin
    wCharKey := FormGuildEdit.EdKey.Text;
    wStream := TMemoryStream.Create;
    try
      GRyzomApi.ApiCharacter(wCharKey, cpFull, wStream);
      wXmlDoc := TXpObjModel.Create(nil);
      try
        wXmlDoc.LoadStream(wStream);
        wCharID := wXmlDoc.DocumentElement.SelectString('/character/cid');
        wCharName := wXmlDoc.DocumentElement.SelectString('/character/name');
        wCharServer := wXmlDoc.DocumentElement.SelectString('/character/shard');
        GCharacter.AddChar(wCharID, wCharKey, wCharName, wCharServer);

        ForceDirectories(GConfig.GetCharRoomPath(wCharID));
        LoadGrid;
        for i := 1 to GridChar.RowCount - 1 do begin
          if CompareText(wCharName, GridChar.Cells[1, i]) = 0 then begin
            GridChar.Row := i;
            Break;
          end;
        end;
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
procedure TFormCharacter.BtUpdateClick(Sender: TObject);
var
  wCharID: String;
  wCharKey: String;
  wCharName: String;
  wCharServer: String;
begin
  wCharID := GridChar.Cells[2, GridChar.Row];
  wCharKey := GCharacter.GetCharKey(wCharID);
  FormGuildEdit.Caption := RS_CHAR_CHANGE_KEY;
  FormGuildEdit.LbKey.Caption := RS_CHAR_KEY;
  FormGuildEdit.EdKey.Text := wCharKey;
  if FormGuildEdit.ShowModal = mrOk then begin
    wCharKey := FormGuildEdit.EdKey.Text;
    wCharName := GridChar.Cells[1, GridChar.Row];
    wCharServer := GridChar.Cells[0, GridChar.Row];
    GCharacter.UpdateChar(wCharID, wCharKey, wCharName, wCharServer);
  end;
end;

{*******************************************************************************
Loads the grid
*******************************************************************************}
procedure TFormCharacter.LoadGrid;
var
  wCharList: TStringList;
  wInfoFile: String;
  i: Integer;
begin
  SendMessage(GridChar.Handle, WM_SETREDRAW, 0, 0);
  try
    GridChar.RowCount := 1;
    GridChar.Row := 0;
    GridChar.Cells[0, 0] := RS_CHAR_COL_CHAR_SERVER;
    GridChar.Cells[1, 0] := RS_CHAR_COL_CHAR_NAME;
    GridChar.Cells[2, 0] := RS_CHAR_COL_CHAR_NUMBER;
    GridChar.Cells[3, 0] := RS_CHAR_COL_LAST_SYNCHRONIZATION;
    GridChar.ColCount := 4;
    GridChar.RowHeights[0] := 20;
    GridChar.ColWidths[0] := 50;
    GridChar.ColWidths[2] := 90;
    GridChar.ColWidths[3] := 140;
    GridChar.ColWidths[1] := GridChar.Width - GridChar.ColWidths[0] -
      GridChar.ColWidths[2] - GridChar.ColWidths[3] - 7;
  
    wCharList := TStringList.Create;
    try
      GCharacter.CharList(wCharList);
      for i := 0 to wCharList.Count - 1 do begin
        wInfoFile := GConfig.GetCharPath(wCharList[i]) + _INFO_FILENAME;
        GridChar.RowCount := GridChar.RowCount + 1;
        GridChar.Cells[0, GridChar.RowCount-1] := GCharacter.GetServerName(wCharList[i]);
        GridChar.Cells[1, GridChar.RowCount-1] := GCharacter.GetCharName(wCharList[i]);
        GridChar.Cells[2, GridChar.RowCount-1] := wCharList[i];
        if FileExists(wInfoFile) and (MdkFileSize(wInfoFile) > 0) then
          GridChar.Cells[3, GridChar.RowCount-1] := FormatDateTime('YYYY-MM-DD HH:NN:SS', MdkGetFileDate(wInfoFile))
        else
          GridChar.Cells[3, GridChar.RowCount-1] := '-';
      end;

      if GridChar.RowCount > 1 then begin
        GridChar.Row := 1;
        BtUpdate.Enabled := True;
        BtDelete.Enabled := True;
        BtRoom.Enabled := True;
      end;
    finally
      wCharList.Free;
    end;
  finally
    SendMessage(GridChar.Handle, WM_SETREDRAW, 1, 0);
    GridChar.Refresh;
  end;
end;

{*******************************************************************************
Scroll down
*******************************************************************************}
procedure TFormCharacter.GridCharMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridChar.Handle, WM_VSCROLL, SB_LINEDOWN, 0) ;
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormCharacter.GridCharMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridChar.Handle, WM_VSCROLL, SB_LINEUP, 0) ;
end;

{*******************************************************************************
Selects a guild in the grid
*******************************************************************************}
procedure TFormCharacter.GridCharSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow = 0 then CanSelect := False;
end;

{*******************************************************************************
Deletes the selected guild
*******************************************************************************}
procedure TFormCharacter.BtDeleteClick(Sender: TObject);
var
  wRow: Integer;
  wTopRow: Integer;
  wCharID: String;
begin
  wRow := GridChar.Row;
  if wRow > 0 then begin
    wCharID := GridChar.Cells[2, wRow];
    if FormConfirm.ShowConfirmation(RS_CHAR_DELETE_CONFIRMATION) <> mrYes then Exit;
    
    SendMessage(GridChar.Handle, WM_SETREDRAW, 0, 0);
    try
      wTopRow := GridChar.TopRow;
      TPublicStringGrid(GridChar).DeleteRow(wRow);
      GridChar.TopRow := wTopRow;
      if wRow < GridChar.RowCount then GridChar.Row := wRow;

      if GridChar.RowCount = 1 then begin
        BtUpdate.Enabled := False;
        BtDelete.Enabled := False;
        BtRoom.Enabled := False;
      end;
    finally
      SendMessage(GridChar.Handle, WM_SETREDRAW, 1, 0);
      GridChar.Refresh;
    end;

    GCharacter.DeleteChar(wCharID);
    MdkRemoveDir(GConfig.GetCharRoomPath(wCharID));
    MdkRemoveDir(GConfig.GetCharPath(wCharID));
  end;
end;

{*******************************************************************************
Displays information of the selected guild
*******************************************************************************}
procedure TFormCharacter.BtRoomClick(Sender: TObject);
begin
  try
    Synchronize;
  except
    on E: Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  Room;
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormCharacter.FormResize(Sender: TObject);
begin
  GridChar.ColWidths[1] := GridChar.Width - GridChar.ColWidths[0] - GridChar.ColWidths[2] - GridChar.ColWidths[3] - 7;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormCharacter.GridCharDblClick(Sender: TObject);
begin
  BtRoomClick(BtRoom);
end;

{*******************************************************************************
Display inventory
*******************************************************************************}
procedure TFormCharacter.Room;
var
  wCharID: String;
begin
  FormInvent.TabInvent.TabIndex := _INVENT_BAG;
  FormMain.ShowMenuForm(FormInvent);
  wCharID := Self.GridChar.Cells[2, Self.GridChar.Row];
  if not GConfig.SaveFilter then GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormProgress.ShowFormInvent(wCharID, FormInvent.CharInvent, _INVENT_BAG, GCurrentFilter);
  FormInvent.LbCharName.Caption := GridChar.Cells[1, GridChar.Row];
end;

{*******************************************************************************
Synchronization
*******************************************************************************}
procedure TFormCharacter.Synchronize;
var
  wCharID: String;
  wInfoFile: String;
  wXmlDoc: TXpObjModel;
begin
  wCharID := GridChar.Cells[2, GridChar.Row];
  FormProgress.ShowFormSynchronizeChar(wCharID);

  wInfoFile := GConfig.GetCharPath(wCharID) + _INFO_FILENAME;
  if FileExists(wInfoFile) and (MdkFileSize(wInfoFile) > 0) then begin
    wXmlDoc := TXpObjModel.Create(nil);
    try
      GridChar.Cells[3, GridChar.Row] := FormatDateTime('YYYY-MM-DD HH:NN:SS', MdkGetFileDate(wInfoFile));
    finally
      wXmlDoc.Free;
    end;
  end else begin
    GridChar.Cells[3, GridChar.Row] := '-';
  end;
end;

end.
