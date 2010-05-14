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
program zyroom;

uses
  Forms,
  UnitFormMain in 'UnitFormMain.pas' {FormMain},
  UnitFormInvent in 'UnitFormInvent.pas' {FormInvent},
  UnitFormOptions in 'UnitFormOptions.pas' {FormOptions},
  UnitFormProgress in 'UnitFormProgress.pas' {FormProgress},
  UnitConfig in 'UnitConfig.pas',
  UnitRyzom in 'UnitRyzom.pas',
  UnitFormConfirmation in 'UnitFormConfirmation.pas' {FormConfirm},
  UnitFormHome in 'UnitFormHome.pas' {FormHome},
  RyzomApi in 'RyzomApi.pas',
  UnitFormCharacter in 'UnitFormCharacter.pas' {FormCharacter},
  UnitFormGuildEdit in 'UnitFormGuildEdit.pas' {FormGuildEdit},
  UnitFormGuild in 'UnitFormGuild.pas' {FormGuild},
  UnitFormRoom in 'UnitFormRoom.pas' {FormRoom},
  UnitFormRoomFilter in 'UnitFormRoomFilter.pas' {FormRoomFilter};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'zyRoom';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormProgress, FormProgress);
  Application.CreateForm(TFormConfirm, FormConfirm);
  Application.CreateForm(TFormInvent, FormInvent);
  Application.CreateForm(TFormHome, FormHome);
  Application.CreateForm(TFormCharacter, FormCharacter);
  Application.CreateForm(TFormGuildEdit, FormGuildEdit);
  Application.CreateForm(TFormGuild, FormGuild);
  Application.CreateForm(TFormRoom, FormRoom);
  Application.CreateForm(TFormRoomFilter, FormRoomFilter);
  Application.Run;
end.
