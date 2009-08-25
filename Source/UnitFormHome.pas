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
unit UnitFormHome;

interface

uses
  Controls, Forms, StdCtrls, pngimage, Classes, ExtCtrls, ShellAPI, Windows,
  MisuDevKit, RegExpr;

resourcestring
  RS_VERSION = 'Version';

const
  _URL_CONTEST_SITE = 'http://dev.ryzom.com/projects/ryzom-api/wiki/Contest';
  _URL_PROJECT_SITE = 'http://zyroom.misulud.fr';
  _URL_RYZOM_SITE = 'http://www.ryzom.com';
  
type
  TFormHome = class(TForm)
    ImgRoom: TImage;
    LbCreatedFor: TLabel;
    LbContest: TLabel;
    LbCreatedBy: TLabel;
    LbAuthor: TLabel;
    LbWebsite: TLabel;
    LbProjectWebsite: TLabel;
    ImgRyzom: TImage;
    LbVersion: TLabel;
    LbVersionNum: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LbContestClick(Sender: TObject);
    procedure LbProjectWebsiteClick(Sender: TObject);
    procedure ImgRyzomClick(Sender: TObject);
  private
  public
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}

{*******************************************************************************
Creates the form
*******************************************************************************}
procedure TFormHome.FormCreate(Sender: TObject);
var
  wReg: TRegExpr;
  wVersion: String;
begin
  wReg := TRegExpr.Create;
  ImgRyzom.Hint := _URL_RYZOM_SITE;
  LbProjectWebsite.Hint := _URL_PROJECT_SITE;
  LbContest.Hint := _URL_CONTEST_SITE;
  wVersion := MdkFileVersionInfo(Application.ExeName, fviFileVersion);
  wReg.Expression := '(\d+\.\d+\.\d+)\.\d+';
  if wReg.Exec(wVersion) then
    if wReg.SubExprMatchCount > 0 then
      LbVersionNum.Caption := wReg.Match[1];
  wReg.Free;
end;

{*******************************************************************************
Link to the contest site
*******************************************************************************}
procedure TFormHome.LbContestClick(Sender: TObject);
begin
  ShellExecute(0, 'open', _URL_CONTEST_SITE, nil, nil, SW_SHOW);
end;

{*******************************************************************************
Link to the project site
*******************************************************************************}
procedure TFormHome.LbProjectWebsiteClick(Sender: TObject);
begin
  ShellExecute(0, 'open', _URL_PROJECT_SITE, nil, nil, SW_SHOW);
end;

{*******************************************************************************
Link to the Ryzom site
*******************************************************************************}
procedure TFormHome.ImgRyzomClick(Sender: TObject);
begin
  ShellExecute(0, 'open', _URL_RYZOM_SITE, nil, nil, SW_SHOW);
end;

end.
