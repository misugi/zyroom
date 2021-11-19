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
  LcUnit, StrUtils, Buttons, SevenButton, UnitConfig;

resourcestring
  RS_CHAR_NEW_CHARACTER = 'Nouveau personnage';
  RS_CHAR_CHANGE_KEY = 'Changement de clé';
  RS_CHAR_COL_CHAR_HEAD = 'Tête';
  RS_CHAR_COL_CHAR_NAME = 'Personnage';
  RS_CHAR_COL_CHAR_NUMBER = 'Numéro';
  RS_CHAR_COL_LAST_SYNCHRONIZATION = 'Synchronisation';
  RS_CHAR_COL_COMMENT = 'Description';
  RS_CHAR_DELETE_CONFIRMATION = 'Etes-vous sûr de vouloir supprimer le personnage sélectionné ?';
  RS_CHAR_KEY = 'Clé API de personnage :';
  RS_CHECK_SALES = 'Surveiller les ventes';
  RS_UP = 'Monter';
  RS_DOWN = 'Descendre';
  RS_RESET_OK = 'Réinitialisation terminée';

const
  _EXPR_MOUNT = '^chidb2\.creature$';

type
  TPublicStringGrid = class(TCustomGrid); 

  TFormCharacter = class(TForm)
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
    procedure GridItemDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtNewClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridItemMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridItemMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridItemSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
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
    procedure GetHead(AIcon: TPNGObject; ACanvas: TCanvas; ARect: TRect; AColor: TColor);
  public
    procedure UpdateLanguage;
  end;

var
  FormCharacter: TFormCharacter;

implementation

uses UnitFormEdit, UnitRyzom, MisuDevKit,
  UnitFormConfirmation, UnitFormProgress, UnitFormMain,
  UnitFormFilter, UnitFormInvent, ComCtrls, RegExpr;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormCharacter.FormCreate(Sender: TObject);
begin
  FIconList := TObjectList.Create;
  GridItem.DoubleBuffered := True;
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
procedure TFormCharacter.GridItemDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  wGuild: String;
begin
  with Sender as TStringGrid do with Canvas do begin
    if ARow = 0 then begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Font.Size := _FONT_SIZE;
      Font.Color := clBlack;
      Font.Style := [];
      Font.Name := _FONT_NAME;
      Rect.Left := Rect.Left + 2;
      DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
              DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
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
        Font.Size := _FONT_SIZE + 2;
        Font.Style := [fsBold];
        Rect.Top := Rect.Top - 25;
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);

        // Guild
        Font.Size := _FONT_SIZE;
        Font.Style := [];
        Rect.Top := Rect.Top + 45;
        wGuild := GCharacter.GetGuildName(Cells[3,ARow]);
        DrawText(Handle, PChar(wGuild), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
      end;

      // Comment
      if (ACol = 2) then begin
        Font.Size := _FONT_SIZE;
        Font.Style := [];
        Rect.Left := Rect.Left + 5;
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
      end;

      // Number
      if (ACol = 3) then begin
        Font.Size := _FONT_SIZE;
        Font.Style := [];
        DrawText(Handle, PChar(Cells[ACol,ARow]), -1, Rect ,
          DT_CENTER or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
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
begin
  // Prepare edit window
  FormEdit.Caption := RS_CHAR_NEW_CHARACTER;
  FormEdit.LbAutoKey.Caption := RS_CHAR_KEY;
  FormEdit.EdKey.Text := '';
  FormEdit.EdComment.Text := '';
  FormEdit.CbCheckChange.Caption := RS_CHECK_SALES;
  FormEdit.CbCheckVolume.Checked := False;
  FormEdit.CbCheckChange.Checked := False;

  // display window
  if FormEdit.ShowModal = mrOk then
    SetItemInfo(atAdd);
end;

{*******************************************************************************
Changes the key of a guild
*******************************************************************************}
procedure TFormCharacter.BtUpdateClick(Sender: TObject);
begin
  UpdateItem(False);
end;

{*******************************************************************************
Loads the grid
*******************************************************************************}
procedure TFormCharacter.LoadGrid;
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
    GridItem.ColWidths[0] := 48;
    GridItem.ColWidths[1] := 250;
    GridItem.ColWidths[3] := 90;

    FIconList.Clear;
    wItemList := TStringList.Create;
    try
      GCharacter.CharList(wItemList);
      for i := 0 to wItemList.Count - 1 do begin
        wIconFile := GConfig.GetCharPath(wItemList[i]) + _ICON_FILENAME;
        wPng := TPNGObject.Create;
        if FileExists(wIconFile) then begin
          try
            wPng.LoadFromFile(wIconFile);
          except
          end;
        end;
        FIconList.Add(wPng);
        GridItem.RowCount := GridItem.RowCount + 1;
        GridItem.Cells[1, GridItem.RowCount-1] := GCharacter.GetCharName(wItemList[i]);
        GridItem.Cells[2, GridItem.RowCount-1] := GCharacter.GetComment(wItemList[i]);
        GridItem.Cells[3, GridItem.RowCount-1] := wItemList[i];
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
procedure TFormCharacter.GridItemMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridItem.Handle, WM_VSCROLL, SB_LINEDOWN, 0) ;
end;

{*******************************************************************************
Scroll up
*******************************************************************************}
procedure TFormCharacter.GridItemMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  SendMessage(GridItem.Handle, WM_VSCROLL, SB_LINEUP, 0) ;
end;

{*******************************************************************************
Selects a guild in the grid
*******************************************************************************}
procedure TFormCharacter.GridItemSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow = 0 then CanSelect := False;
  BtUp.Enabled := ARow > 1;
  BtDown.Enabled := ARow < GridItem.RowCount - 1;
end;

{*******************************************************************************
Deletes the selected guild
*******************************************************************************}
procedure TFormCharacter.BtDeleteClick(Sender: TObject);
var
  wRow: Integer;
  wTopRow: Integer;
  wItemID: String;
begin
  wRow := GridItem.Row;
  if wRow > 0 then begin
    wItemID := GridItem.Cells[3, wRow];
    if FormConfirm.ShowConfirmation(RS_CHAR_DELETE_CONFIRMATION) <> mrYes then Exit;
    
    SendMessage(GridItem.Handle, WM_SETREDRAW, 0, 0);
    try
      wTopRow := GridItem.TopRow;
      TPublicStringGrid(GridItem).DeleteRow(wRow);
      GridItem.TopRow := wTopRow;
      if wRow < GridItem.RowCount then GridItem.Row := wRow;

      if GridItem.RowCount = 1 then
        EnableButtons(False);
    finally
      SendMessage(GridItem.Handle, WM_SETREDRAW, 1, 0);
    end;

    GCharacter.DeleteChar(wItemID);
    MdkRemoveDir(GConfig.GetCharPath(wItemID));
    MdkRemoveDir(GConfig.GetCharPath(wItemID));
    FIconList.Delete(wRow-1);
    GridItem.Refresh;
  end;
end;

{*******************************************************************************
Displays information of the selected item
*******************************************************************************}
procedure TFormCharacter.BtRoomClick(Sender: TObject);
begin
  try
    UpdateItem(True);
    Synchronize;
    ShowRoom;
  except
    on E: Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

{*******************************************************************************
Resize the window
*******************************************************************************}
procedure TFormCharacter.FormResize(Sender: TObject);
begin
  GridItem.ColWidths[2] := GridItem.Width - GridItem.ColWidths[0] - GridItem.ColWidths[1] - GridItem.ColWidths[3] - 25;
end;

{*******************************************************************************
Double clic on the grid
*******************************************************************************}
procedure TFormCharacter.GridItemDblClick(Sender: TObject);
begin
  if GridItem.Row > 0 then BtRoomClick(BtRoom);
end;

{*******************************************************************************
Display items
*******************************************************************************}
procedure TFormCharacter.ShowRoom;
begin
  if not GConfig.SaveFilter then GRyzomApi.SetDefaultFilter(GCurrentFilter);
  FormInvent.TabInvent.TabIndex := _INVENT_ROOM;
  FormMain.ShowMenuForm(FormInvent);
  FormInvent.Dappers := FDappers;
  FormInvent.UpdateRoom;
end;

{*******************************************************************************
Synchronization
*******************************************************************************}
procedure TFormCharacter.Synchronize;
var
  wItemID: String;
begin
  wItemID := GridItem.Cells[3, GridItem.Row];
  FormProgress.ShowFormSyncChar(wItemID);
end;

{*******************************************************************************
Updates language
*******************************************************************************}
procedure TFormCharacter.UpdateLanguage;
begin
  GridItem.Cells[0, 0] := RS_CHAR_COL_CHAR_HEAD;
  GridItem.Cells[1, 0] := RS_CHAR_COL_CHAR_NAME;
  GridItem.Cells[2, 0] := RS_CHAR_COL_COMMENT;
  GridItem.Cells[3, 0] := RS_CHAR_COL_CHAR_NUMBER;
  BtUp.Hint := RS_UP;
  BtDown.Hint := RS_DOWN;
end;

{*******************************************************************************
Updates information
*******************************************************************************}
procedure TFormCharacter.UpdateItem(AAuto: Boolean);
var
  wItemID: String;
  wDoUpdate: Boolean;
begin
  wDoUpdate := AAuto;

  // read ID
  wItemID := GridItem.Cells[3, GridItem.Row];

  // prepare the edit window
  FormEdit.Caption := RS_CHAR_CHANGE_KEY;
  FormEdit.LbAutoKey.Caption := RS_CHAR_KEY;
  FormEdit.EdKey.Text := GCharacter.GetCharKey(wItemID);
  FormEdit.EdComment.Text := GCharacter.GetComment(wItemID);
  FormEdit.CbCheckChange.Caption := RS_CHECK_SALES;
  FormEdit.CbCheckVolume.Checked := GCharacter.GetCheckVolume(wItemID);
  FormEdit.CbCheckChange.Checked := GCharacter.GetCheckSales(wItemID);

  if not wDoUpdate then
    wDoUpdate := FormEdit.ShowModal = mrOk;

  if wDoUpdate then
    SetItemInfo(atUpdate);
end;

{*******************************************************************************
Up/Down
*******************************************************************************}
procedure TFormCharacter.MoveRow(AIndex: Integer);
var
  wRow: Integer;
  wID1, wID2: String;
begin
  wRow := GridItem.Row;
  wID1 := GridItem.Cells[3, wRow];
  wID2 := GridItem.Cells[3, wRow + AIndex];
  GCharacter.SetIndex(wID1, wRow + AIndex);
  GCharacter.SetIndex(wID2, wRow);
  LoadGrid;
  GridItem.Row := wRow + AIndex;
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

{*******************************************************************************
Reset the icons directory
*******************************************************************************}
procedure TFormCharacter.BtResetClick(Sender: TObject);
var
  wRow: Integer;
  wItemID: String;
begin
  wRow := GridItem.Row;
  if wRow > 0 then begin
    wItemID := GridItem.Cells[3, wRow];
    MdkRemoveDir(GConfig.GetCharRoomPath(wItemID));
    DeleteFile(GConfig.GetCharPath(wItemID) + _INDEX_FILENAME);
    ShowMessage(RS_RESET_OK);
  end;
end;

{*******************************************************************************
Set info
*******************************************************************************}
procedure TFormCharacter.SetItemInfo(AAction: TActionType);
var
  i: Integer;
  
  wItemKey: String;
  wComment: String;
  wCheckVolume: Boolean;
  wCheckSales: Boolean;
  wItemID: String;
  wItemName: String;
  wItemServer: String;
  wItemGuild: String;
  wGabarit: String;
  wMorph: String;

  wXmlDoc: TXpObjModel;
  wStream: TMemoryStream;
  wRegExpr: TRegExpr;
  wNodeList: TXpNodeList;
  wList: TStringList;
  
  wInfoFile: String;
  wIconFile: String;
  wPetSheet: String;
begin
  wStream := TMemoryStream.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  wRegExpr := TRegExpr.Create;
  wList := TStringList.Create;
  try
    // read info on the edit window
    wItemKey := FormEdit.EdKey.Text;
    wComment := FormEdit.EdComment.Text;
    wCheckVolume := FormEdit.CbCheckVolume.Checked;
    wCheckSales := FormEdit.CbCheckChange.Checked;

    // call API
    {$IFNDEF __LOCALINFO}
    GRyzomApi.ApiCharacter(wItemKey, wStream);
    wXmlDoc.LoadStream(wStream);
    {$ELSE}
    if AAction = atAdd then begin
      GRyzomApi.ApiCharacter(wItemKey, wStream);
      wXmlDoc.LoadStream(wStream);
    end else begin
      wItemID := GridItem.Cells[3, GridItem.Row];
      wInfoFile := GConfig.GetCharPath(wItemID) + _INFO_FILENAME;
      wXmlDoc.LoadDataSource(wInfoFile);
    end;
    {$ENDIF}

    // check modules
    if not CheckModules(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/@modules'), _REQUIRED_MODULES_CHAR) then
      MessageDlg(Format(RS_REQUIRED_MODULES, [MdkArrayToString(_REQUIRED_MODULES_CHAR, ',')]), mtWarning, [mbOK], 0);

    // read info in the XML
    wItemID := wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/id');
    wItemName := wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/name');
    wItemServer := wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/shard');
    wItemServer := UpperCase(LeftStr(wItemServer, 1)) + LowerCase(RightStr(wItemServer, Length(wItemServer)-1));
    wItemGuild := wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/guild/name');
    FDappers := wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/money');

    // update INI
    GCharacter.SetChar(AAction, wItemID, wItemKey, wItemName, wItemServer, wComment, wItemGuild, wCheckVolume, wCheckSales);

    // save to info.xml
    {$IFNDEF __LOCALINFO}
    wInfoFile := GConfig.GetCharPath(wItemID) + _INFO_FILENAME;
    wStream.SaveToFile(wInfoFile);
    {$ENDIF}

    // search the mount from the pet list
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/ryzomapi/character/pets/animal');
    try
      FormInvent.MountID := -1;
      for i := 0 to wNodeList.Length - 1 do begin
        wPetSheet := wNodeList.Item(i).SelectString('sheet');
        wRegExpr.Expression := _EXPR_MOUNT;
        if wRegExpr.Exec(wPetSheet) then begin
          FormInvent.MountID := i;
          Break;
        end;
      end;
    finally
      wNodeList.Free;
    end;

    {$IFNDEF __LOCALINFO}
    // Gabarit
    wList.Clear;
    wList.Append(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/gabarit/@height'));
    wList.Append(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/gabarit/@torso'));
    wList.Append(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/gabarit/@arms'));
    wList.Append(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/gabarit/@legs'));
    wList.Append(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/gabarit/@breast'));
    wGabarit := wList.CommaText;

    // Morph
    wList.Clear;
    for i := 1 to 8 do begin
      wList.Append(wXmlDoc.DocumentElement.SelectString(Format('/ryzomapi/character/body/morph/@target%d', [i])));
    end;
    wMorph := wList.CommaText;

    // Get image
    wStream.Clear;
    GRyzomApi.ApiBallisticMystix(
      wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/race'),
      wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/gender'),
      StrToIntDef(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/hairtype'), 0),
      StrToIntDef(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/haircolor'), 0),
      StrToIntDef(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/tattoo'), 0),
      StrToIntDef(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/body/eyescolor'), 0),
      wGabarit, wMorph,
      wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/equipment/chest'),
      StrToIntDef(wXmlDoc.DocumentElement.SelectString('/ryzomapi/character/equipment/chest/@color'), 0),
      wStream);
    wIconFile := GConfig.GetCharPath(wItemID) + _ICON_FILENAME;
    wStream.SaveToFile(wIconFile);
    if AAction = atUpdate then
      TPNGObject(FIconList.Items[GridItem.Row-1]).LoadFromFile(wIconFile);
    {$ENDIF}

    // refresh grid info
    if AAction = atAdd then begin
      GCharacter.SetIndex(wItemID, GridItem.RowCount - 1);
      LoadGrid;
      SelectItem(wItemID);
    end else begin
      GridItem.Cells[1, GridItem.Row] := wItemName;
      GridItem.Cells[2, GridItem.Row] := wComment;
      GridItem.Refresh;
    end;
  finally
    wList.Free;
    wRegExpr.Free;
    wXmlDoc.Free;
    wStream.Free;
  end;
end;

{*******************************************************************************
select a char from his ID
*******************************************************************************}
procedure TFormCharacter.SelectItem(AItemID: String);
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
procedure TFormCharacter.EnableButtons(AEnabled: Boolean);
begin
  BtUpdate.Enabled := AEnabled;
  BtDelete.Enabled := AEnabled;
  BtReset.Enabled := AEnabled;
  BtRoom.Enabled := AEnabled;
end;

{*******************************************************************************
Returns the head of the character
*******************************************************************************}
procedure TFormCharacter.GetHead(AIcon: TPNGObject; ACanvas: TCanvas; ARect: TRect; AColor: TColor);
const
  _HEAD_WIDTH = 48;
  _HEAD_HEIGHT = 48;
var
  wRectSrc: TRect;
  wBmp: TBitmap;
  wHead: TBitmap;
  wRect: TRect;
  wTop: Integer;
  wLeft: Integer;
  wRight: Integer;

  // Search the center of the head
  function HeadCenter(): Boolean;
  var
    x, y: Integer;
  begin
    Result := False;

    // search the first pixel not black from the top of icon.png
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

    if y < AIcon.Height then begin
      wTop := y;
      Inc(y, 20); // jump 20 lines

      // get left and right of the head
      if y < AIcon.Height then begin
        x := 0;
        while (AIcon.Pixels[x, y] = clBlack) and (x < AIcon.Width) do Inc(x);
        wLeft := x;
        
        x := AIcon.Width-1;
        while (AIcon.Pixels[x, y] = clBlack) and (x >= 0) do Dec(x);
        wRight := x;

        if (wRight - wLeft) < _HEAD_WIDTH then
          Result := True;
      end;
    end;
  end;
begin
  if AIcon.Width = 0 then Exit;
  if not HeadCenter then Exit;

  // Defines rectangle
  wRectSrc.Left := wLeft + ((wRight-wLeft) div 2) - (_HEAD_WIDTH div 2);
  wRectSrc.Right := wRectSrc.Left + _HEAD_WIDTH;
  wRectSrc.Top := wTop-2;
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

  wHead := TBitmap.Create;
  wHead.Width := _HEAD_WIDTH;
  wHead.Height := _HEAD_HEIGHT;
  wRect.Left := 0;
  wRect.Right := wHead.Width;
  wRect.Top := 0;
  wRect.Bottom := wHead.Height;
  wHead.Canvas.CopyRect(wRect, wBmp.Canvas, wRectSrc);

  ACanvas.Draw(ARect.Left, ARect.Top, wHead);
  
  wBmp.Free;
end;

end.
