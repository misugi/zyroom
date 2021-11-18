object FormProgress: TFormProgress
  Left = 709
  Top = 463
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 87
  ClientWidth = 321
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    321
    87)
  PixelsPerInch = 96
  TextHeight = 20
  object LbProgress: TLabel
    Left = 4
    Top = 5
    Width = 312
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'Traitement en cours'
  end
  object ProgressBar: TProgressBar
    Left = 4
    Top = 30
    Width = 312
    Height = 20
    ParentShowHint = False
    Position = 33
    Smooth = True
    Step = 1
    ShowHint = False
    TabOrder = 0
  end
  object BtCancel: TSevenButton
    Left = 123
    Top = 59
    Width = 75
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Annuler'
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
    Fonts.FontHot.Height = -11
    Fonts.FontHot.Name = 'Arial'
    Fonts.FontHot.Style = []
    Fonts.FontDown.Charset = DEFAULT_CHARSET
    Fonts.FontDown.Color = clWindowText
    Fonts.FontDown.Height = -11
    Fonts.FontDown.Name = 'Arial'
    Fonts.FontDown.Style = []
    Fonts.FontDisabled.Charset = DEFAULT_CHARSET
    Fonts.FontDisabled.Color = clGrayText
    Fonts.FontDisabled.Height = -11
    Fonts.FontDisabled.Name = 'Arial'
    Fonts.FontDisabled.Style = []
    Fonts.FontFocused.Charset = DEFAULT_CHARSET
    Fonts.FontFocused.Color = clWindowText
    Fonts.FontFocused.Height = -11
    Fonts.FontFocused.Name = 'Arial'
    Fonts.FontFocused.Style = []
    ModalResult = 2
    Cancel = True
    Spacing = 5
    Marging = 5
  end
  object TimerStart: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerStartTimer
    Left = 284
    Top = 4
  end
end
