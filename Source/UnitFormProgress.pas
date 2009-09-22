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
unit UnitFormProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, XpDOM, ExtCtrls, ScrollRoom, ItemImage,
  pngimage, UnitRyzom, regexpr;

resourcestring
  RS_PROGRESS_SYNCHRONIZE = 'Synchronisation en cours, veuillez patienter...';
  RS_PROGRESS_ROOM = 'Affichage du coffre, veuillez patienter...';

const
  _TASK_SYNCHRONIZE = 0;
  _TASK_ROOM = 1;
  _TASK_SYNCHRONIZE_CHAR = 2;
  _TASK_INVENT = 3;

  _INVENT_BAG = 0;
  _INVENT_PET1 = 1;
  _INVENT_PET2 = 2;
  _INVENT_PET3 = 3;
  _INVENT_PET4 = 4;
  _INVENT_ROOM = 5;
  
type
  TFormProgress = class(TForm)
    ProgressBar: TProgressBar;
    LbProgress: TLabel;
    TimerStart: TTimer;
    BtNo: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartTimer(Sender: TObject);
  private
    FEnabled: Boolean;
    FProcessingType: Integer;
    FInventPart: Integer;
    FGuildID: String;
    FCharID: String;
    FRoom: TScrollRoom;
    FFilter: TItemFilter;

    procedure SynchronizeGuild(AGuildID: String);
    procedure SynchronizeChar(ACharID: String);
    procedure FillRoom(AGuildID: String);
    procedure FillInvent(ACharID: String);
    procedure GetItem(ANodeList: TXpNodeList; AStoragePath: String);
    procedure ShowItem(ANodeList: TXpNodeList; AStoragePath: String);
    procedure CloseForm;
  public
    procedure ShowFormSynchronize(AGuildID: String);
    procedure ShowFormSynchronizeChar(ACharID: String);
    procedure ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
    procedure ShowFormInvent(ACharID: String; ARoom: TScrollRoom; AInventPart: Integer; AFilter: TItemFilter);
  end;

var
  FormProgress: TFormProgress;

implementation

uses UnitConfig, RyzomApi, MisuDevKit, Math;

{$R *.dfm}

{*******************************************************************************
Closes the form
*******************************************************************************}
procedure TFormProgress.CloseForm;
begin
  FEnabled := True;
  inherited Close;
end;

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormProgress.FormShow(Sender: TObject);
begin
  ProgressBar.Position := 0;
  TimerStart.Enabled := True;
  FEnabled := False;
end;

{*******************************************************************************
Authorization to close the form
*******************************************************************************}
procedure TFormProgress.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := FEnabled;
end;

{*******************************************************************************
Get items and save image files
*******************************************************************************}
procedure TFormProgress.GetItem(ANodeList: TXpNodeList;
  AStoragePath: String);
var
  i: Integer;
  wItemName: String;
  wItemColor: TItemColor;
  wItemQuality: Integer;
  wItemSize: Integer;
  wItemSap: Integer;
  wItemDestroyed: Boolean;
  wItemFileName: String;
  wPngCheck: Boolean;
  wPng: TPNGObject;
  wIconFile: TFileStream;
begin
  wPng := TPNGObject.Create;
  try
    for i := 0 to ANodeList.Length - 1 do begin
      if ModalResult = mrCancel then Exit;

      GRyzomApi.GetItemInfoFromXML(ANodeList.Item(i), wItemName, wItemColor,
        wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName);
      if not FileExists(AStoragePath + wItemFileName) then begin
        wPngCheck := False;
        while not wPngCheck do begin
          if ModalResult = mrCancel then Exit;
          wIconFile := TFileStream.Create(AStoragePath + wItemFileName, fmCreate);
          try
            GRyzomApi.ApiItemIcon(wItemName, wIconFile, wItemColor, wItemQuality, wItemSize, wItemSap, wItemDestroyed);
            try
              wPng.LoadFromStream(wIconFile);
              wPngCheck := True;
            except
              Sleep(100);
              Application.ProcessMessages;
            end;
          finally
            wIconFile.Free;
          end;
        end;
      end;
      ProgressBar.Position := Trunc( ((i+1) / ANodeList.Length) * 100);
      Application.ProcessMessages;
    end;
  finally
    wPng.Free;
  end;
end;

{*******************************************************************************
Guild synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeGuild(AGuildID: String);
var
  wXmlFile: TFileStream;
  wGuildKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
begin
  wGuildKey := GGuild.GetGuildKey(AGuildID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME, fmCreate);
  try
    GRyzomApi.ApiGuild(wGuildKey, wXmlFile);
    wXmlDoc.LoadStream(wXmlFile);

    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      GetItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Character synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeChar(ACharID: String);
var
  wXmlFile: TFileStream;
  wCharKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
begin
  wCharKey := GCharacter.GetCharKey(ACharID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetCharPath(ACharID) + _INFO_FILENAME, fmCreate);
  try
    GRyzomApi.ApiCharacter(wCharKey, cpItems, wXmlFile);
    wXmlDoc.LoadStream(wXmlFile);

    // Room
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;

   // Bag
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;

    // Pet1
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;

    // Pet2
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;

    // Pet3
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;

    // Pet4
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
    try
      GetItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Starts a task
*******************************************************************************}
procedure TFormProgress.TimerStartTimer(Sender: TObject);
begin
  TimerStart.Enabled := False;
  try
    case FProcessingType of
      _TASK_SYNCHRONIZE: SynchronizeGuild(FGuildID);
      _TASK_ROOM: FillRoom(FGuildID);
      _TASK_SYNCHRONIZE_CHAR: SynchronizeChar(FCharID);
      _TASK_INVENT: FillInvent(FCharID)
    end;
  finally
    CloseForm;
  end;
end;

{*******************************************************************************
Starts a guild synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSynchronize(AGuildID: String);
begin
  FGuildID := AGuildID;
  FProcessingType := _TASK_SYNCHRONIZE;
  LbProgress.Caption := RS_PROGRESS_SYNCHRONIZE;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a character synchronization
*******************************************************************************}
procedure TFormProgress.ShowFormSynchronizeChar(ACharID: String);
begin
  FCharID := ACharID;
  FProcessingType := _TASK_SYNCHRONIZE_CHAR;
  LbProgress.Caption := RS_PROGRESS_SYNCHRONIZE;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a guild room
*******************************************************************************}
procedure TFormProgress.ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
begin
  FGuildID := AGuildID;
  FRoom := ARoom;
  FFilter := AFilter;
  FProcessingType := _TASK_ROOM;
  LbProgress.Caption := RS_PROGRESS_ROOM;
  Self.ShowModal;
end;

{*******************************************************************************
Starts a character 
*******************************************************************************}
procedure TFormProgress.ShowFormInvent(ACharID: String; ARoom: TScrollRoom; AInventPart: Integer; AFilter: TItemFilter);
begin
  FCharID := ACharID;
  FRoom := ARoom;
  FFilter := AFilter;
  FProcessingType := _TASK_INVENT;
  FInventPart := AInventPart;
  LbProgress.Caption := RS_PROGRESS_ROOM;
  Self.ShowModal;
end;

{*******************************************************************************
Show items
*******************************************************************************}
procedure TFormProgress.ShowItem(ANodeList: TXpNodeList; AStoragePath: String);
var
  wItemName: String;
  wItemColor: TItemColor;
  wItemQuality: Integer;
  wItemSize: Integer;
  wItemSap: Integer;
  wItemDestroyed: Boolean;
  wItemFileName: String;
  wItemImage: TItemImage;
  i: Integer;
  wItemList: TStringList;
begin
  wItemList := TStringList.Create;
  try
    for i := 0 to ANodeList.Length - 1 do begin
      if ModalResult = mrCancel then Exit;

      wItemList.Add(Format('%s=%d',
        [ANodeList.Item(i).Text, i]));
    end;
    wItemList.Sort;

    SendMessage(FRoom.Handle, WM_SETREDRAW, 0, 0);
    try
      FRoom.Clear;
      for i := 0 to wItemList.Count - 1 do begin
        if ModalResult = mrCancel then Exit;

        GRyzomApi.GetItemInfoFromXML(ANodeList.Item(StrToInt(wItemList.ValueFromIndex[i])), wItemName, wItemColor,
          wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName);

        if (not FFilter.Enabled) or GRyzomApi.CheckItem(wItemName, wItemQuality, FFilter) then begin
          wItemImage := TItemImage.Create(nil);
          wItemImage.ItemName := wItemName;
          if FileExists(AStoragePath + wItemFileName) then begin
            try
              wItemImage.LoadFromFile(AStoragePath + wItemFileName);
            except
              wItemImage.LoadFromResourceName(_RES_NOICON);
            end;
          end else begin
            wItemImage.LoadFromResourceName(_RES_NOICON);
          end;
          FRoom.AddControl(wItemImage);
          ProgressBar.Position := Trunc( ((i+1) / ANodeList.Length) * 100);
          Application.ProcessMessages;
        end;
      end;
    finally
      SendMessage(FRoom.Handle, WM_SETREDRAW, 1, 0);
      FRoom.Refresh;
    end;
  finally
    wItemList.Free;
  end;
end;

{*******************************************************************************
Show the room of a guild
*******************************************************************************}
procedure TFormProgress.FillRoom(AGuildID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
begin
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      ShowItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{*******************************************************************************
Show the inventory of a character
*******************************************************************************}
procedure TFormProgress.FillInvent(ACharID: String);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
begin
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetCharPath(ACharID) + _INFO_FILENAME, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);
    case FInventPart of
      0: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
      1: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
      2: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
      3: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
      4: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
      5: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
    end;

    try
      ShowItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

end.
