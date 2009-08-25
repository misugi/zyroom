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
program zyroom;

uses
  Forms,
  UnitFormMain in 'UnitFormMain.pas' {FormMain},
  UnitFormRoom in 'UnitFormRoom.pas' {FormRoom},
  UnitFormOptions in 'UnitFormOptions.pas' {FormOptions},
  UnitFormRoomFilter in 'UnitFormRoomFilter.pas' {FormRoomFilter},
  UnitFormProgress in 'UnitFormProgress.pas' {FormProgress},
  UnitConfig in 'UnitConfig.pas',
  UnitRyzom in 'UnitRyzom.pas',
  UnitFormConfirmation in 'UnitFormConfirmation.pas' {FormConfirm},
  UnitFormHome in 'UnitFormHome.pas' {FormHome},
  RyzomApi in 'RyzomApi.pas',
  UnitFormGuild in 'UnitFormGuild.pas' {FormGuild},
  UnitFormGuildEdit in 'UnitFormGuildEdit.pas' {FormGuildEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'zyRoom';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormRoomFilter, FormRoomFilter);
  Application.CreateForm(TFormProgress, FormProgress);
  Application.CreateForm(TFormConfirm, FormConfirm);
  Application.CreateForm(TFormRoom, FormRoom);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormGuild, FormGuild);
  Application.CreateForm(TFormGuildEdit, FormGuildEdit);
  Application.Run;
end.
