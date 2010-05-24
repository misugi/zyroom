object FormConfirm: TFormConfirm
  Left = 425
  Top = 347
  BorderStyle = bsDialog
  Caption = 'Confirmation'
  ClientHeight = 71
  ClientWidth = 350
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    350
    71)
  PixelsPerInch = 96
  TextHeight = 14
  object LbMessage: TLabel
    Left = 5
    Top = 12
    Width = 340
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object BtYes: TButton
    Left = 97
    Top = 43
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Oui'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 6
    ParentFont = False
    TabOrder = 0
  end
  object BtNo: TButton
    Left = 178
    Top = 43
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Non'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 7
    ParentFont = False
    TabOrder = 1
  end
end
