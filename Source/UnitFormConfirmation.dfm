object FormConfirm: TFormConfirm
  Left = 425
  Top = 347
  BorderStyle = bsDialog
  Caption = 'Information'
  ClientHeight = 106
  ClientWidth = 350
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    350
    106)
  PixelsPerInch = 96
  TextHeight = 20
  object LbMessage: TLabel
    Left = 5
    Top = 7
    Width = 340
    Height = 64
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Etes-vous s'#251'r de vouloir restaurer les personnages s'#233'lectionn'#233's ' +
      '? Et si le message fait trois lignes '#231'a donne quoi ?'
    WordWrap = True
  end
  object BtYes: TSevenButton
    Left = 97
    Top = 78
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Oui'
    TabOrder = 0
    Border.ColorNormal = 7368816
    Border.ColorHot = 11632444
    Border.ColorDown = 9134636
    Border.ColorDisabled = 11907757
    Border.ColorFocused = 11632444
    Border.WidthNormal = 1
    Border.WidthHot = 1
    Border.WidthDown = 1
    Border.WidthDisabled = 1
    Border.WidthFocused = 1
    Colors.ColorNormalFrom = 16579836
    Colors.ColorNormalTo = 13619151
    Colors.ColorHotFrom = 16579836
    Colors.ColorHotTo = 16112039
    Colors.ColorDownFrom = 16579836
    Colors.ColorDownTo = 14398312
    Colors.ColorDisabledFrom = 16053492
    Colors.ColorDisabledTo = 16053492
    Colors.ColorFocusedFrom = 16579836
    Colors.ColorFocusedTo = 13619151
    Fonts.FontHot.Charset = DEFAULT_CHARSET
    Fonts.FontHot.Color = clWindowText
    Fonts.FontHot.Height = -15
    Fonts.FontHot.Name = 'Segoe UI'
    Fonts.FontHot.Style = []
    Fonts.FontDown.Charset = DEFAULT_CHARSET
    Fonts.FontDown.Color = clWindowText
    Fonts.FontDown.Height = -15
    Fonts.FontDown.Name = 'Segoe UI'
    Fonts.FontDown.Style = []
    Fonts.FontDisabled.Charset = DEFAULT_CHARSET
    Fonts.FontDisabled.Color = clGrayText
    Fonts.FontDisabled.Height = -15
    Fonts.FontDisabled.Name = 'Segoe UI'
    Fonts.FontDisabled.Style = []
    Fonts.FontFocused.Charset = DEFAULT_CHARSET
    Fonts.FontFocused.Color = clWindowText
    Fonts.FontFocused.Height = -15
    Fonts.FontFocused.Name = 'Segoe UI'
    Fonts.FontFocused.Style = []
    ModalResult = 6
    Default = True
    Spacing = 5
    Marging = 5
  end
  object BtNo: TSevenButton
    Left = 178
    Top = 78
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Non'
    TabOrder = 1
    Border.ColorNormal = 7368816
    Border.ColorHot = 11632444
    Border.ColorDown = 9134636
    Border.ColorDisabled = 11907757
    Border.ColorFocused = 11632444
    Border.WidthNormal = 1
    Border.WidthHot = 1
    Border.WidthDown = 1
    Border.WidthDisabled = 1
    Border.WidthFocused = 1
    Colors.ColorNormalFrom = 16579836
    Colors.ColorNormalTo = 13619151
    Colors.ColorHotFrom = 16579836
    Colors.ColorHotTo = 16112039
    Colors.ColorDownFrom = 16579836
    Colors.ColorDownTo = 14398312
    Colors.ColorDisabledFrom = 16053492
    Colors.ColorDisabledTo = 16053492
    Colors.ColorFocusedFrom = 16579836
    Colors.ColorFocusedTo = 13619151
    Fonts.FontHot.Charset = DEFAULT_CHARSET
    Fonts.FontHot.Color = clWindowText
    Fonts.FontHot.Height = -15
    Fonts.FontHot.Name = 'Segoe UI'
    Fonts.FontHot.Style = []
    Fonts.FontDown.Charset = DEFAULT_CHARSET
    Fonts.FontDown.Color = clWindowText
    Fonts.FontDown.Height = -15
    Fonts.FontDown.Name = 'Segoe UI'
    Fonts.FontDown.Style = []
    Fonts.FontDisabled.Charset = DEFAULT_CHARSET
    Fonts.FontDisabled.Color = clGrayText
    Fonts.FontDisabled.Height = -15
    Fonts.FontDisabled.Name = 'Segoe UI'
    Fonts.FontDisabled.Style = []
    Fonts.FontFocused.Charset = DEFAULT_CHARSET
    Fonts.FontFocused.Color = clWindowText
    Fonts.FontFocused.Height = -15
    Fonts.FontFocused.Name = 'Segoe UI'
    Fonts.FontFocused.Style = []
    ModalResult = 7
    Cancel = True
    Spacing = 5
    Marging = 5
  end
  object BtOK: TSevenButton
    Left = 137
    Top = 78
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 2
    Border.ColorNormal = 7368816
    Border.ColorHot = 11632444
    Border.ColorDown = 9134636
    Border.ColorDisabled = 11907757
    Border.ColorFocused = 11632444
    Border.WidthNormal = 1
    Border.WidthHot = 1
    Border.WidthDown = 1
    Border.WidthDisabled = 1
    Border.WidthFocused = 1
    Colors.ColorNormalFrom = 16579836
    Colors.ColorNormalTo = 13619151
    Colors.ColorHotFrom = 16579836
    Colors.ColorHotTo = 16112039
    Colors.ColorDownFrom = 16579836
    Colors.ColorDownTo = 14398312
    Colors.ColorDisabledFrom = 16053492
    Colors.ColorDisabledTo = 16053492
    Colors.ColorFocusedFrom = 16579836
    Colors.ColorFocusedTo = 13619151
    Fonts.FontHot.Charset = DEFAULT_CHARSET
    Fonts.FontHot.Color = clWindowText
    Fonts.FontHot.Height = -15
    Fonts.FontHot.Name = 'Segoe UI'
    Fonts.FontHot.Style = []
    Fonts.FontDown.Charset = DEFAULT_CHARSET
    Fonts.FontDown.Color = clWindowText
    Fonts.FontDown.Height = -15
    Fonts.FontDown.Name = 'Segoe UI'
    Fonts.FontDown.Style = []
    Fonts.FontDisabled.Charset = DEFAULT_CHARSET
    Fonts.FontDisabled.Color = clGrayText
    Fonts.FontDisabled.Height = -15
    Fonts.FontDisabled.Name = 'Segoe UI'
    Fonts.FontDisabled.Style = []
    Fonts.FontFocused.Charset = DEFAULT_CHARSET
    Fonts.FontFocused.Color = clWindowText
    Fonts.FontFocused.Height = -15
    Fonts.FontFocused.Name = 'Segoe UI'
    Fonts.FontFocused.Style = []
    ModalResult = 2
    Default = True
    Spacing = 5
    Marging = 5
  end
end
