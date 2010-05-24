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
unit UnitFormCharacter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, XpDOM, Contnrs, pngimage, ExtCtrls, RyzomApi,
  LcUnit, StrUtils, ComCtrls, Buttons;

resourcestring
  RS_CHAR_NEW_CHARACTER = 'Nouveau personnage';
  RS_CHAR_CHANGE_KEY = 'Changement de clé';
  RS_CHAR_COL_CHAR_HEAD = 'Tête';
  RS_CHAR_COL_CHAR_NAME = 'Personnage';
  RS_CHAR_COL_CHAR_NUMBER = 'Numéro';
  RS_CHAR_COL_LAST_SYNCHRONIZATION = 'Synchronisation';
  RS_CHAR_COL_COMMENT = 'Commentaire';
  RS_CHAR_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer le personnage sélectionné ?';
  RS_CHAR_PROGRESS_SYNCHRONIZE = 'Syncrhonisation en cours, veuillez patienter...';
  RS_CHAR_KEY = 'Clé de personnage :';
  RS_UP = 'Monter';
  RS_DOWN = 'Descendre';

const
  _EXPR_MOUNT = '^ias[dfjl]\.sitem';

type
  TPublicStringGrid = class(TCustomGrid); 

  TFormCharacter = class(TForm)
    GridChar: TStringGrid;
    Panel1: TPanel;
    BtNew: TButton;
    BtUpdate: TButton;
    BtDelete: TButton;
    BtRoom: TButton;
    BtDown: TSpeedButton;
    BtUp: TSpeedButton;
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
    procedure FormShow(Sender: TObject);
    procedure BtDownClick(Sender: TObject);
    procedure BtUpClick(Sender: TObject);
  private
    FIconList: TObjectList;
    procedure LoadGrid;
    procedure Synchronize;
    procedure ShowRoom;
    procedure GetHead(AIcon: TPNGObject; ACanvas: TCanvas; ARect: TRect; AColor: TColor);
    procedure UpdateCharacter(AAuto: Boolean);
    procedure MoveRow(AIndex: Integer);
  public
    procedure UpdateLanguage;
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
  FIconList := TObjectList.Create;
  GridChar.DoubleBuffered := True;
  LoadGrid;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormCharacter.FormDestroy(Sender: TObject);
begin
  FIconList.Free;
end;

{*******************************************************************************
Displays the grid
*******************************************************************************}
procedure TFormCharacter.GridCharDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  wGuild: String;
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
        Rect.Top := Rect.Top - 35;
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );

        // Guild
        Font.Size := 8;
        Font.Style := [];
        Rect.Top := Rect.Top + 35;
        wGuild := GCharacter.GetGuildName(Cells[3,ARow]);
        DrawText(Handle, PChar(wGuild), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE  );

        // Server
        Rect.Top := Rect.Top + 35;
        wServer := GCharacter.GetServerName(Cells[3,ARow]);
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

      // Drawing image (head)
      if (ACol = 0) then
        GetHead(TPNGObject(FIconList.Items[ARow-1]), TStringGrid(Sender).Canvas, Rect, Brush.Color);
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
  wCharGuild: String;
  wStream: TMemoryStream;
  wComment: String;
  wXmlDoc: TXpObjModel;
  wIconFile: String;
  wInfoFile: String;
  i: Integer;
begin
  FormGuildEdit.Caption := RS_CHAR_NEW_CHARACTER;
  FormGuildEdit.LbKey.Caption := RS_CHAR_KEY;
  FormGuildEdit.EdKey.Text := '';
  FormGuildEdit.EdComment.Text := '';
  if FormGuildEdit.ShowModal = mrOk then begin
    wCharKey := FormGuildEdit.EdKey.Text;
    wComment := FormGuildEdit.EdComment.Text;
    wStream := TMemoryStream.Create;
    try
      GRyzomApi.ApiCharacter(wCharKey, cpFull, wStream);
      wXmlDoc := TXpObjModel.Create(nil);
      try
        wXmlDoc.LoadStream(wStream);
        wCharID := wXmlDoc.DocumentElement.SelectString('/character/cid');
        wCharName := wXmlDoc.DocumentElement.SelectString('/character/name');
        wCharServer := wXmlDoc.DocumentElement.SelectString('/character/shard');
        wCharServer := UpperCase(LeftStr(wCharServer, 1)) + RightStr(wCharServer, Length(wCharServer)-1);
        wCharGuild := wXmlDoc.DocumentElement.SelectString('/character/guild/name');
        GCharacter.AddChar(wCharID, wCharKey, wCharName, wCharServer, wComment, wCharGuild);
        GCharacter.SetIndex(wCharID, GridChar.RowCount - 1);

        ForceDirectories(GConfig.GetCharRoomPath(wCharID));
        wInfoFile := GConfig.GetCharPath(wCharID) + _INFO_FILENAME;
        wStream.SaveToFile(wInfoFile);
        wStream.Clear;
        GRyzomApi.ApiBallisticMystix(
          wXmlDoc.DocumentElement.SelectString('/character/race'),
          wXmlDoc.DocumentElement.SelectString('/character/gender'),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/hair_type')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/hair_color')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/tattoo')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/eyes_color')),
          wStream);
        wIconFile := GConfig.GetCharPath(wCharID) + _ICON_FILENAME;
        wStream.SaveToFile(wIconFile);
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
begin
  UpdateCharacter(False);
end;

{*******************************************************************************
Loads the grid
*******************************************************************************}
procedure TFormCharacter.LoadGrid;
var
  wCharList: TStringList;
  wPng: TPNGObject;
  wIconFile: String;
  wItemsFile: String;
  i: Integer;
begin
  SendMessage(GridChar.Handle, WM_SETREDRAW, 0, 0);
  try
    GridChar.RowCount := 1;
    GridChar.Row := 0;
    GridChar.ColCount := 4;
    GridChar.RowHeights[0] := 20;
    GridChar.ColWidths[0] := 60;
    GridChar.ColWidths[1] := 200;
    GridChar.ColWidths[3] := 70;
  
    FIconList.Clear;
    wCharList := TStringList.Create;
    try
      GCharacter.CharList(wCharList);
      for i := 0 to wCharList.Count - 1 do begin
        wIconFile := GConfig.GetCharPath(wCharList[i]) + _ICON_FILENAME;
        wItemsFile := GConfig.GetCharPath(wCharList[i]) + _ITEMS_FILENAME;
        wPng := TPNGObject.Create;
        if FileExists(wIconFile) then begin
          try
            wPng.LoadFromFile(wIconFile);
          except
          end;
        end;
        FIconList.Add(wPng);
        GridChar.RowCount := GridChar.RowCount + 1;
        GridChar.Cells[1, GridChar.RowCount-1] := GCharacter.GetCharName(wCharList[i]);
        GridChar.Cells[2, GridChar.RowCount-1] := GCharacter.GetComment(wCharList[i]);
        GridChar.Cells[3, GridChar.RowCount-1] := wCharList[i];
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
  BtUp.Enabled := ARow > 1;
  BtDown.Enabled := ARow < GridChar.RowCount - 1;
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
    wCharID := GridChar.Cells[3, wRow];
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
    end;

    GCharacter.DeleteChar(wCharID);
    MdkRemoveDir(GConfig.GetCharRoomPath(wCharID));
    MdkRemoveDir(GConfig.GetCharPath(wCharID));
    FIconList.Delete(wRow-1);
    GridChar.Refresh;
  end;
end;

{*******************************************************************************
Displays information of the selected guild
*******************************************************************************}
procedure TFormCharacter.BtRoomClick(Sender: TObject);
begin
  try
    UpdateCharacter(True);
    Synchronize;
  except
    on E: Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  ShowRoom;
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormCharacter.FormResize(Sender: TObject);
begin
  GridChar.ColWidths[2] := GridChar.Width - GridChar.ColWidths[0] - GridChar.ColWidths[1] - GridChar.ColWidths[3] - 25;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormCharacter.GridCharDblClick(Sender: TObject);
begin
  if GridChar.Row > 0 then BtRoomClick(BtRoom);
end;

{*******************************************************************************
Display inventory
*******************************************************************************}
procedure TFormCharacter.ShowRoom;
begin
  if not GConfig.SaveFilter then GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormInvent.TabInvent.TabIndex := _INVENT_ROOM;
  FormMain.ShowMenuForm(FormInvent);
  FormInvent.UpdateRoom;
end;

{*******************************************************************************
Synchronization
*******************************************************************************}
procedure TFormCharacter.Synchronize;
var
  wCharID: String;
begin
  wCharID := GridChar.Cells[3, GridChar.Row];
  FormProgress.ShowFormSynchronizeChar(wCharID);
end;

{*******************************************************************************
Returns the head of the character
*******************************************************************************}
procedure TFormCharacter.GetHead(AIcon: TPNGObject; ACanvas: TCanvas; ARect: TRect; AColor: TColor);
const
  _HEAD_WIDTH = 60;
  _HEAD_HEIGHT = 60;
var
  x, y: Integer;
  wRectSrc: TRect;
  wBmp: TBitmap;
  wRect: TRect;
begin
  if AIcon.Width = 0 then Exit;

  // Detects the first pixel not black
  x := 0;
  y := 0;
  while (AIcon.Pixels[x, y] = clBlack) and (y < AIcon.Height) do begin
    if x < AIcon.Width then begin
      Inc(x);
    end else begin
      x := 0;
      Inc(y);
    end;
  end;

  if y = AIcon.Height then Exit;

  // Defines rectangle
  wRectSrc.Left := (AIcon.Width div 2) - (_HEAD_WIDTH div 2);
  wRectSrc.Right := wRectSrc.Left + _HEAD_WIDTH;
  wRectSrc.Top := y-2;
  wRectSrc.Bottom := wRectSrc.Top + _HEAD_HEIGHT;

  // Copy bitmap
  wBmp := TBitmap.Create;
  wBmp.Width := AIcon.Width;
  wBmp.Height := AIcon.Height;
  wBmp.Canvas.Brush.Color := AColor;
  wRect.Left := 0;
  wRect.Right := wBmp.Width;
  wRect.Top := 0;
  wRect.Bottom := wBmp.Height;
  wBmp.Canvas.FillRect(wRect);
  wBmp.Canvas.Draw(0, 0, AIcon);
  ACanvas.CopyRect(ARect, wBmp.Canvas, wRectSrc);
  wBmp.Free;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormCharacter.FormShow(Sender: TObject);
begin
  UpdateLanguage;
end;

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormCharacter.UpdateLanguage;
begin
  GridChar.Cells[0, 0] := RS_CHAR_COL_CHAR_HEAD;
  GridChar.Cells[1, 0] := RS_CHAR_COL_CHAR_NAME;
  GridChar.Cells[2, 0] := RS_CHAR_COL_COMMENT;
  GridChar.Cells[3, 0] := RS_CHAR_COL_CHAR_NUMBER;
  BtUp.Hint := RS_UP;
  BtDown.Hint := RS_DOWN;
end;

{*******************************************************************************
Updates character information
*******************************************************************************}
procedure TFormCharacter.UpdateCharacter(AAuto: Boolean);
var
  wCharID: String;
  wCharKey: String;
  wCharName: String;
  wCharServer: String;
  wComment: String;
  wCharGuild: String;
  wStream: TMemoryStream;
  wXmlDoc: TXpObjModel;
  wInfoFile: String;
  wIconFile: String;
  wDoUpdate: Boolean;
  wPetList: TXpNodeList;
  wPetSheet: String;
  i: Integer;
begin
  wDoUpdate := AAuto;

  wCharID := GridChar.Cells[3, GridChar.Row];
  wCharKey := GCharacter.GetCharKey(wCharID);
  wComment := GGuild.GetComment(wCharID);

  if not wDoUpdate then begin
    FormGuildEdit.Caption := RS_CHAR_CHANGE_KEY;
    FormGuildEdit.LbKey.Caption := RS_CHAR_KEY;
    FormGuildEdit.EdKey.Text := wCharKey;
    FormGuildEdit.EdComment.Text := wComment;
    wDoUpdate := FormGuildEdit.ShowModal = mrOk;
    wCharKey := FormGuildEdit.EdKey.Text;
    wComment := FormGuildEdit.EdComment.Text;
  end;

  if wDoUpdate then begin
    // Updates icon
    wStream := TMemoryStream.Create;
    wXmlDoc := TXpObjModel.Create(nil);
    try
      GRyzomApi.ApiCharacter(wCharKey, cpFull, wStream);
      wInfoFile := GConfig.GetCharPath(wCharID) + _INFO_FILENAME;
      wStream.SaveToFile(wInfoFile);
      wStream.Clear;
      wXmlDoc.LoadDataSource(wInfoFile);

      wPetList := wXmlDoc.DocumentElement.SelectNodes('/character/pets/pet');
      FormInvent.MountID := -1;
      for i := 0 to wPetList.Length - 1 do begin
        wPetSheet := wPetList.Item(i).Attributes.GetNamedItem('sheet').NodeValue;
        GRegExpr.Expression := _EXPR_MOUNT;
        if GRegExpr.Exec(wPetSheet) then begin
          FormInvent.MountID := i;
          Break;
        end;
      end;

      wCharName := wXmlDoc.DocumentElement.SelectString('/character/name');
      wCharServer := wXmlDoc.DocumentElement.SelectString('/character/shard');
      wCharServer := UpperCase(LeftStr(wCharServer, 1)) + RightStr(wCharServer, Length(wCharServer)-1);
      wCharGuild := wXmlDoc.DocumentElement.SelectString('/character/guild/name');
      wIconFile := GConfig.GetCharPath(wCharID) + _ICON_FILENAME;
      GRyzomApi.ApiBallisticMystix(
          wXmlDoc.DocumentElement.SelectString('/character/race'),
          wXmlDoc.DocumentElement.SelectString('/character/gender'),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/hair_type')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/hair_color')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/tattoo')),
          StrToInt(wXmlDoc.DocumentElement.SelectString('/character/body/eyes_color')),
          wStream);
      wStream.SaveToFile(wIconFile);
      TPNGObject(FIconList.Items[GridChar.Row-1]).LoadFromFile(wIconFile);
      GridChar.Refresh;
    finally
      wXmlDoc.Free;
      wStream.Free;
    end;

    GCharacter.UpdateChar(wCharID, wCharKey, wCharName, wCharServer, wComment, wCharGuild);
    GridChar.Cells[1, GridChar.Row] := wCharName;
    GridChar.Cells[2, GridChar.Row] := wComment;
  end;
end;

{*******************************************************************************
Up/Down
*******************************************************************************}
procedure TFormCharacter.MoveRow(AIndex: Integer);
var
  wRow: Integer;
  wID1, wID2: String;
begin
  wRow := GridChar.Row;
  wID1 := GridChar.Cells[3, wRow];
  wID2 := GridChar.Cells[3, wRow + AIndex];
  GCharacter.SetIndex(wID1, wRow + AIndex);
  GCharacter.SetIndex(wID2, wRow);
  LoadGrid;
  GridChar.Row := wRow + AIndex;
end;

{*******************************************************************************
Down
*******************************************************************************}
procedure TFormCharacter.BtDownClick(Sender: TObject);
begin
  MoveRow(+1);
end;

{*******************************************************************************
Up
*******************************************************************************}
procedure TFormCharacter.BtUpClick(Sender: TObject);
begin
  MoveRow(-1);
end;

end.
