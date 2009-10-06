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
  pngimage, UnitRyzom, regexpr, SyncObjs;

resourcestring
  RS_PROGRESS_SYNCHRONIZE = 'Synchronisation en cours, veuillez patienter...';
  RS_PROGRESS_ROOM = 'Affichage du coffre, veuillez patienter...';
  RS_CONNEXION_ERROR = 'Trop d''erreurs API, arrêt de la synchronisation';

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
  TGetItemThread = class(TThread)
  private
    FNode: TXpNode;
    FStoragePath: String;
  public
    constructor Create(ANode: TXpNode; AStoragePath: String);
    procedure Execute; override;
  end;
  
  TFormProgress = class(TForm)
    ProgressBar: TProgressBar;
    LbProgress: TLabel;
    TimerStart: TTimer;
    BtCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
  GSection: TCriticalSection;
  GEvent: TEvent;
  GThreadCount: Integer;
  GStrings: TStringList;

implementation

uses UnitConfig, RyzomApi, MisuDevKit, Math;

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormProgress.FormCreate(Sender: TObject);
begin
  GStrings := TStringList.Create;
  GSection := TCriticalSection.Create;
  GEvent := TEvent.Create(nil, True, False, 'synchronization');
  GEvent.ResetEvent;
end;

{*******************************************************************************
Destroys the form
*******************************************************************************}
procedure TFormProgress.FormDestroy(Sender: TObject);
begin
  GStrings.Free;
  GSection.Free;
  GEvent.Free;
end;

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
  wThread: TGetItemThread;
  wItemName: String;
begin
  GThreadCount := 0;
  i := 0;
  while i < ANodeList.Length do begin
    if ModalResult = mrCancel then Break;

    wItemName := ANodeList.Item(i).Text;
    if GStrings.IndexOfName(wItemName) < 0 then begin
      GStrings.Append(wItemName + '=' + GRyzomStringPack.GetString(wItemName));
    end;

    if GThreadCount < GConfig.ThreadCount then begin
      GSection.Enter;
      try
        wThread := TGetItemThread.Create(ANodeList.Item(i), AStoragePath);
        wThread.Resume;
        Inc(GThreadCount);
      finally
        GSection.Leave;
      end;
      Inc(i);
    end else begin
      GEvent.ResetEvent;
      GEvent.WaitFor(100);
    end;

    ProgressBar.Position := Trunc( ((i+1) / ANodeList.Length) * 100);
    Application.ProcessMessages;
  end;

  while GThreadCount > 0 do begin
    GEvent.ResetEvent;
    GEvent.WaitFor(100);
  end;
end;

{*******************************************************************************
Guild synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeGuild(AGuildID: String);
var
  wXmlFile: TMemoryStream;
  wGuildKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wIndexFile: String;
begin
  wGuildKey := GGuild.GetGuildKey(AGuildID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TMemoryStream.Create;
  try
    GRyzomApi.ApiGuild(wGuildKey, wXmlFile);
    wXmlFile.SaveToFile(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME);
    wXmlFile.Position := 0;
    wXmlDoc.LoadStream(wXmlFile);

    // Prepare the index file for name search
    wIndexFile := GConfig.GetGuildPath(AGuildID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    try
      wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
      try
        GetItem(wNodeList, GConfig.GetGuildRoomPath(AGuildID));
      finally
        wNodeList.Free;
      end;
    finally
      GStrings.SaveToFile(wIndexFile);
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
  wXmlFile: TMemoryStream;
  wCharKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wIndexFile: String;
begin
  wCharKey := GCharacter.GetCharKey(ACharID);
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TMemoryStream.Create;
  try
    GRyzomApi.ApiCharacter(wCharKey, cpItems, wXmlFile);
    wXmlFile.SaveToFile(GConfig.GetCharPath(ACharID) + _INFO_FILENAME);
    wXmlFile.Position := 0;
    wXmlDoc.LoadStream(wXmlFile);

    // Prepare the index file for name search
    wIndexFile := GConfig.GetCharPath(ACharID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    try
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
      GStrings.SaveToFile(wIndexFile);
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
  wItemDesc: String;
  wItemClass: TItemClass;
begin
  wItemList := TStringList.Create;
  try
    // Adjust the width of the room
    FRoom.ColCount := (FRoom.Width - 22) div (FRoom.ControlWidth + FRoom.Spacing);

    for i := 0 to ANodeList.Length - 1 do begin
      if ModalResult = mrCancel then Exit;

      wItemList.Add(Format('%s=%d',
        [ANodeList.Item(i).Text, i]));
    end;
    wItemList.Sort;

    SendMessage(FRoom.Handle, WM_SETREDRAW, 0, 0);
    try
      // Loop on items list
      for i := 0 to wItemList.Count - 1 do begin
        if ModalResult = mrCancel then Exit;

        GRyzomApi.GetItemInfoFromXML(ANodeList.Item(StrToInt(wItemList.ValueFromIndex[i])), wItemName, wItemColor,
          wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName, wItemClass);

        if FFilter.ItemName <> '' then
          wItemDesc := GStrings.Values[wItemName];

        if (not FFilter.Enabled) or GRyzomApi.CheckItem(wItemName, wItemQuality, FFilter, wItemDesc, wItemClass) then begin
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
  wInfoFile: String;
  wIndexFile: String;
begin
  FRoom.Clear;
  wInfoFile := GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME;
  if (not FileExists(wInfoFile)) or (MdkFileSize(wInfoFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wInfoFile, fmOpenRead);
  try
    wIndexFile := GConfig.GetGuildPath(AGuildID) + 'index.dat';
    if FileExists(wIndexFile) then
      GStrings.LoadFromFile(wIndexFile)
    else
      GStrings.Clear;
    
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
  wInfoFile: String;
begin
  FRoom.Clear;
  wInfoFile := GConfig.GetCharPath(ACharID) + _INFO_FILENAME;
  if (not FileExists(wInfoFile)) or (MdkFileSize(wInfoFile) = 0) then Exit;
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(wInfoFile, fmOpenRead);
  try
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := nil;
    case FInventPart of
      0: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/room/item');
      1: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/bag/item');
      2: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal1/item');
      3: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal2/item');
      4: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal3/item');
      5: wNodeList := wXmlDoc.DocumentElement.SelectNodes('/items/inventories/pet_animal4/item');
    end;

    try
      if wNodeList <> nil then
        ShowItem(wNodeList, GConfig.GetCharRoomPath(ACharID));
    finally
      wNodeList.Free;
    end;
  finally
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

{ TGetItemThread }

{*******************************************************************************
Creates the synchronization thread
*******************************************************************************}
constructor TGetItemThread.Create(ANode: TXpNode; AStoragePath: String);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FNode := ANode;
  FStoragePath := AStoragePath;
end;

{*******************************************************************************
Executes the synchronization thread
*******************************************************************************}
procedure TGetItemThread.Execute;
var
  j: Integer;
  wItemName: String;
  wItemColor: TItemColor;
  wItemQuality: Integer;
  wItemSize: Integer;
  wItemSap: Integer;
  wItemDestroyed: Boolean;
  wItemFileName: String;
  wPngCheck: Boolean;
  wPng: TPNGObject;
  wIconFile: TMemoryStream;
  wApi: TRyzomApi;
  wItemClass: TItemClass;
begin
  try
    GRyzomApi.GetItemInfoFromXML(FNode, wItemName, wItemColor,
      wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName, wItemClass);

    wPng := TPNGObject.Create;
    wApi := TRyzomApi.Create;
    try
      if not FileExists(FStoragePath + wItemFileName) then begin
        j := 1;
        wPngCheck := False;
        while (not wPngCheck) and (j < 10) do begin
          wIconFile := TMemoryStream.Create;
          try
            if GConfig.ProxyEnabled then
              wApi.SetProxyParameters(GConfig.ProxyAddress, GConfig.ProxyPort, GConfig.ProxyUsername, GConfig.ProxyPassword)
            else
              wApi.SetProxyParameters('', 0, '', '');
            wApi.ApiItemIcon(wItemName, wIconFile, wItemColor, wItemQuality, wItemSize, wItemSap, wItemDestroyed);
            try
              wPng.LoadFromStream(wIconFile);
              wPng.SaveToFile(FStoragePath + wItemFileName);
              wPngCheck := True;
            except
              Sleep(100);
            end;
          finally
            wIconFile.Free;
          end;
          Inc(j);
        end;

        if not wPngCheck then
          raise Exception.Create(RS_CONNEXION_ERROR);
      end;
    finally
      wPng.Free;
      wApi.Free;
    end;
  finally
    GSection.Enter;
    try
      Dec(GThreadCount);
      GEvent.SetEvent;
    finally
      GSection.Leave;
    end;
  end;
end;

end.
