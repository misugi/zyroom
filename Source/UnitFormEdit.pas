{*******************************************************************************
zyRoom project for Ryzom Summer Coding Contest 2009
Copyright (C) 2009 Misugi
http://github.com/misugi/zyroom

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
unit UnitFormEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, ShellAPI, SevenButton;

const
  _URL_PROFILE_PAGE = 'http://app.ryzom.com/app_ryzomapi';

type
  TFormEdit = class(TForm)
    LbAutoKey: TLabel;
    EdKey: TEdit;
    ImgProfilePage: TImage;
    LbComment: TLabel;
    EdComment: TEdit;
    CbCheckVolume: TCheckBox;
    CbCheckChange: TCheckBox;
    BtOK: TSevenButton;
    BtCancel: TSevenButton;
    procedure FormShow(Sender: TObject);
    procedure ImgProfilePageClick(Sender: TObject);
  private
  public
  end;

var
  FormEdit: TFormEdit;

implementation

{$R *.dfm}

{*******************************************************************************
Displays the form
*******************************************************************************}
procedure TFormEdit.FormShow(Sender: TObject);
begin
  EdKey.SetFocus;
end;

{*******************************************************************************
Link to the Ryzom account page
*******************************************************************************}
procedure TFormEdit.ImgProfilePageClick(Sender: TObject);
begin
  ShellExecute(0, 'open', _URL_PROFILE_PAGE, nil, nil, SW_SHOW);
end;

end.

