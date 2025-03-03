unit UnitFormDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SevenButton, pngimage, ExtCtrls, Math, AppEvnts;

resourcestring
  RS_DIALOG_TITLE_INFORMATION = 'Information';
  RS_DIALOG_TITLE_CONFIRMATION = 'Confirmation';
  RS_DIALOG_TITLE_WARNING = 'Alerte';
  RS_DIALOG_TITLE_ERROR = 'Erreur';
  RS_DIALOG_BUTTON_YES = 'Oui';
  RS_DIALOG_BUTTON_NO = 'Non';
  RS_DIALOG_BUTTON_OK = 'OK';

type
  TDialogButtons = (vbAuto, vbOK, vbYesNo);
  
  TFormDialog = class(TForm)
    BtYes: TSevenButton;
    BtNo: TSevenButton;
    BtOk: TSevenButton;
    ImageSystem: TImage;
    ApplicationEvents1: TApplicationEvents;
    LbAutoMessage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
  private
    FImgInfo: TPNGObject;
    FImgAlert: TPNGObject;
    FImgError: TPNGObject;
    FImgQuestion: TPNGObject;

    procedure LoadImages;
    procedure FreeImages;
    procedure AdjustDim;
    procedure AdjustPos;
    procedure PosButtons;
  public
    procedure SetFont(AFontName: String = 'Arial'; AFontSize: Integer = 10; AFontColor: TColor = clBlack);
    procedure SetBackground(ABackground: TColor);

    function Show(AMessage: String; AType: TMsgDlgType = mtInformation; AButtons: TDialogButtons = vbAuto): TModalResult;
  end;

var
  FormDialog: TFormDialog;

implementation

{$R *.dfm}
{$R *.res}

const
  _MARGIN = 10;

{*******************************************************************************
Affiche la fenêtre
*******************************************************************************}
function TFormDialog.Show(AMessage: String; AType: TMsgDlgType; AButtons: TDialogButtons): TModalResult;
begin
  try
    LbAutoMessage.Width := 322;
    LbAutoMessage.Caption := AMessage;
    AdjustDim;
    AdjustPos;

    case AType of
      mtInformation: begin
        Caption := RS_DIALOG_TITLE_INFORMATION;
        ImageSystem.Picture.Assign(FImgInfo);
      end;
      mtWarning: begin
        Caption := RS_DIALOG_TITLE_WARNING;
        ImageSystem.Picture.Assign(FImgAlert);
      end;
      mtError: begin
        Caption := RS_DIALOG_TITLE_ERROR;
        ImageSystem.Picture.Assign(FImgError);
      end;
      mtConfirmation: begin
        Caption := RS_DIALOG_TITLE_CONFIRMATION;
        ImageSystem.Picture.Assign(FImgQuestion);
      end;
    end;

    if AButtons = vbAuto then begin
      BtOk.Visible := (AType = mtInformation) or (AType = mtWarning) or (AType = mtError);
      BtYes.Visible := (AType = mtConfirmation);
      BtNo.Visible := (AType = mtConfirmation);
    end else begin
      BtOk.Visible := (AButtons = vbOK);
      BtYes.Visible := (AButtons = vbYesNo);
      BtNo.Visible := (AButtons = vbYesNo);
    end;

    BtOk.Enabled := BtOk.Visible;
    BtYes.Enabled := BtYes.Visible;
    BtNo.Enabled := BtNo.Visible;

    // le bouton Cancel reste toujours invisible mais est actif pour gérer le Echap => mrCancel
  
    Result := ShowModal;
  except
    on E: Exception do raise Exception.Create('[TFormDialog.Show] '+E.Message);
  end;
end;

{*******************************************************************************
Create
*******************************************************************************}
procedure TFormDialog.FormCreate(Sender: TObject);
begin
  LoadImages;
  BtYes.Caption := RS_DIALOG_BUTTON_YES;
  BtNo.Caption := RS_DIALOG_BUTTON_NO;
  BtOk.Caption := RS_DIALOG_BUTTON_OK;
end;

{*******************************************************************************
Destroy
*******************************************************************************}
procedure TFormDialog.FormDestroy(Sender: TObject);
begin
  FreeImages;
end;

{*******************************************************************************
Chargement des images
*******************************************************************************}
procedure TFormDialog.LoadImages;
var
  wRes: TResourceStream;
begin
  try
    FImgInfo := TPNGObject.Create;
    FImgAlert := TPNGObject.Create;
    FImgError := TPNGObject.Create;
    FImgQuestion := TPNGObject.Create;

    wRes := TResourceStream.Create(HInstance, 'msgdlginfo', RT_RCDATA);
    FImgInfo.LoadFromStream(wRes);
    wRes.Free;

    wRes := TResourceStream.Create(HInstance, 'msgdlgalert', RT_RCDATA);
    FImgAlert.LoadFromStream(wRes);
    wRes.Free;

    wRes := TResourceStream.Create(HInstance, 'msgdlgerror', RT_RCDATA);
    FImgError.LoadFromStream(wRes);
    wRes.Free;

    wRes := TResourceStream.Create(HInstance, 'msgdlgquestion', RT_RCDATA);
    FImgQuestion.LoadFromStream(wRes);
    wRes.Free;
  except
    on E: Exception do raise Exception.Create('[TFormDialog.LoadImages] '+E.Message);
  end;
end;

{*******************************************************************************
Libère les images
*******************************************************************************}
procedure TFormDialog.FreeImages;
begin
  FImgInfo.Free;
  FImgAlert.Free;
  FImgError.Free;
  FImgQuestion.Free;
end;

{*******************************************************************************
Change la couleur de fond
*******************************************************************************}
procedure TFormDialog.SetBackground(ABackground: TColor);
begin
  Color := ABackground;
end;

{*******************************************************************************
Change la police
*******************************************************************************}
procedure TFormDialog.SetFont(AFontName: String; AFontSize: Integer; AFontColor: TColor);
  procedure SetFont(AFont: TFont);
  begin
    AFont.Name := AFontName;
    AFont.Size := AFontSize;
    AFont.Color := AFontColor;
  end;

  procedure SetFontButtons(AButton: TSevenButton);
  begin
    SetFont(AButton.Font);
    SetFont(AButton.Fonts.FontHot);
    SetFont(AButton.Fonts.FontDown);
    SetFont(AButton.Fonts.FontDisabled);
    SetFont(AButton.Fonts.FontFocused);
    AButton.Fonts.FontDisabled.Color := clGrayText;
  end;
begin
  try
    // form
    SetFont(Self.Font);

    // boutons
    SetFontButtons(BtOk);
    SetFontButtons(BtYes);
    SetFontButtons(BtNo);
  except
    on E: Exception do raise Exception.Create('[TFormDialog.SetFont] '+E.Message);
  end;
end;

{*******************************************************************************
Ajuste la position des boutons en fonction du message
*******************************************************************************}
procedure TFormDialog.PosButtons;
begin
  try
    // top
    BtOk.Top := Max(ImageSystem.Top + ImageSystem.Height + _MARGIN, LbAutoMessage.Top + LbAutoMessage.Height + _MARGIN);
    BtYes.Top := BtOk.Top;
    BtNo.Top := BtOk.Top;

    // left
    BtOk.Left := (ClientWidth - BtOk.Width) div 2;
    BtYes.Left := ((ClientWidth - _MARGIN) div 2) - BtYes.Width;
    BtNo.Left := BtYes.Left + BtYes.Width + _MARGIN;
  except
    on E: Exception do raise Exception.Create('[TFormDialog.PosButtons] '+E.Message);
  end;
end;

{*******************************************************************************
Ajuste les dimensions de la fenêtre
*******************************************************************************}
procedure TFormDialog.AdjustDim;
begin
  try
    ClientWidth := LbAutoMessage.Left + LbAutoMessage.Width + _MARGIN;
    PosButtons;
    ClientHeight := BtOk.Top + BtOk.Height + _MARGIN;
  except
    on E: Exception do raise Exception.Create('[TFormDialog.AdjustDim] '+E.Message);
  end;
end;

{*******************************************************************************
Ajuste la position de la fenêtre
*******************************************************************************}
procedure TFormDialog.AdjustPos;
begin
  try
    if Assigned(Screen.ActiveForm) then begin
      Left := ((Screen.ActiveForm.Width - Self.Width) div 2) + Screen.ActiveForm.Left;
      Top := ((Screen.ActiveForm.Height - Self.Height) div 2) + Screen.ActiveForm.Top;
    end else begin
      Self.Position := poScreenCenter;
    end;
  except
    on E: Exception do raise Exception.Create('[TFormDialog.AdjustPos] '+E.Message);
  end;
end;

{*******************************************************************************
Focus
*******************************************************************************}
procedure TFormDialog.FormShow(Sender: TObject);
begin
  if BtYes.Visible then
    BtYes.SetFocus
  else
    BtOk.SetFocus;
end;

{*******************************************************************************
Echap = Cancel
*******************************************************************************}
procedure TFormDialog.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  case Msg.message of
    WM_KEYDOWN: begin
      if (Msg.wParam = VK_ESCAPE) then ModalResult := mrCancel;
    end;
  end;
end;

end.
