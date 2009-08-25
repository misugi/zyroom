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
    FGuildID: String;
    FRoom: TScrollRoom;
    FFilter: TItemFilter;

    procedure SynchronizeGuild(AGuildID: String);
    procedure FillRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
    procedure CloseForm;
  public
    procedure ShowFormSynchronize(AGuildID: String);
    procedure ShowFormRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
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
Guild synchronization
*******************************************************************************}
procedure TFormProgress.SynchronizeGuild(AGuildID: String);
var
  wXmlFile: TFileStream;
  wIconFile: TFileStream;
  wGuildKey: String;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wRoomPath: String;
  wPngCheck: Boolean;
  wPng: TPNGObject;

  wItemName: String;
  wItemColor: TItemColor;
  wItemQuality: Integer;
  wItemSize: Integer;
  wItemSap: Integer;
  wItemDestroyed: Boolean;
  wItemFileName: String;
  
  i: Integer;
begin
  wGuildKey := GGuild.GetGuildKey(AGuildID);
  wPng := TPNGObject.Create;
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME, fmCreate);
  try
    GRyzomApi.ApiGuild(wGuildKey, wXmlFile);
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      wRoomPath := GConfig.GetRoomPath(AGuildID);
      for i := 0 to wNodeList.Length - 1 do begin
        if ModalResult = mrCancel then Exit;

        GRyzomApi.GetItemInfoFromXML(wNodeList.Item(i), wItemName, wItemColor,
          wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName);
        if not FileExists(wRoomPath + wItemFileName) then begin
          wPngCheck := False;
          while not wPngCheck do begin
            if ModalResult = mrCancel then Exit;
            wIconFile := TFileStream.Create(wRoomPath + wItemFileName, fmCreate);
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
        ProgressBar.Position := Trunc( ((i+1) / wNodeList.Length) * 100);
        Application.ProcessMessages;
      end;
    finally
      wNodeList.Free;
    end;
  finally
    wPng.Free;
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
      _TASK_ROOM: FillRoom(FGuildID, FRoom, FFilter);
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
Show the room of a guild
*******************************************************************************}
procedure TFormProgress.FillRoom(AGuildID: String; ARoom: TScrollRoom; AFilter: TItemFilter);
var
  wXmlFile: TFileStream;
  wXmlDoc: TXpObjModel;
  wNodeList: TXpNodeList;
  wItemList: TStringList;
  wRoomPath: String;

  wItemName: String;
  wItemColor: TItemColor;
  wItemQuality: Integer;
  wItemSize: Integer;
  wItemSap: Integer;
  wItemDestroyed: Boolean;
  wItemFileName: String;
  wItemImage: TItemImage;
  i: Integer;
begin
  wXmlDoc := TXpObjModel.Create(nil);
  wXmlFile := TFileStream.Create(GConfig.GetGuildPath(AGuildID) + _INFO_FILENAME, fmOpenRead);
  wItemList := TStringList.Create;
  try
    wXmlDoc.LoadStream(wXmlFile);
    wNodeList := wXmlDoc.DocumentElement.SelectNodes('/guild/room/item');
    try
      wRoomPath := GConfig.GetRoomPath(AGuildID);
      for i := 0 to wNodeList.Length - 1 do begin
        if ModalResult = mrCancel then Exit;

        wItemList.Add(Format('%s=%d',
          [wNodeList.Item(i).Text, i]));
      end;
      wItemList.Sort;

      SendMessage(ARoom.Handle, WM_SETREDRAW, 0, 0);
      try
        ARoom.Clear;
        for i := 0 to wItemList.Count - 1 do begin
          if ModalResult = mrCancel then Exit;

          GRyzomApi.GetItemInfoFromXML(wNodeList.Item(StrToInt(wItemList.ValueFromIndex[i])), wItemName, wItemColor,
            wItemQuality, wItemSize, wItemSap, wItemDestroyed, wItemFileName);

          if (not AFilter.Enabled) or GRyzomApi.CheckItem(wItemName, wItemQuality, AFilter) then begin
            wItemImage := TItemImage.Create(nil);
            wItemImage.ItemName := wItemName;
            if FileExists(wRoomPath + wItemFileName) then begin
              try
                wItemImage.LoadFromFile(wRoomPath + wItemFileName);
              except
                wItemImage.LoadFromResourceName(_RES_NOICON);
              end;
            end else begin
              wItemImage.LoadFromResourceName(_RES_NOICON);
            end;
            ARoom.AddControl(wItemImage);
            ProgressBar.Position := Trunc( ((i+1) / wNodeList.Length) * 100);
            Application.ProcessMessages;
          end;
        end;
      finally
        SendMessage(ARoom.Handle, WM_SETREDRAW, 1, 0);
        ARoom.Refresh;
      end;
    finally
      wNodeList.Free;
    end;
  finally
    wItemList.Free;
    wXmlDoc.Free;
    wXmlFile.Free;
  end;
end;

end.
