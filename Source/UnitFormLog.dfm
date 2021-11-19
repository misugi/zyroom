object FormLog: TFormLog
  Left = 331
  Top = 135
  Width = 957
  Height = 620
  Caption = 'Log'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 20
  object PnHeader: TPanel
    Left = 0
    Top = 0
    Width = 941
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      941
      28)
    object Shape1: TShape
      Left = 738
      Top = 12
      Width = 10
      Height = 2
      Anchors = [akTop, akRight]
    end
    object BtLoad: TSevenButton
      Left = 0
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Charger'
      TabOrder = 0
      TabStop = False
      OnClick = BtLoadClick
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
      Spacing = 5
      Marging = 5
    end
    object DatePickerStart: TDateTimePicker
      Left = 550
      Top = 0
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Date = 2.000000000000000000
      Time = 2.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
    end
    object DatePickerEnd: TDateTimePicker
      Left = 753
      Top = 0
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Date = 2.000000000000000000
      Time = 2.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object TimePickerStart: TDateTimePicker
      Left = 652
      Top = 0
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Date = 40704.000000000000000000
      Time = 40704.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
    end
    object TimePickerEnd: TDateTimePicker
      Left = 855
      Top = 0
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Date = 40704.000000000000000000
      Time = 40704.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 4
    end
    object BtCode: TSevenButton
      Left = 90
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Code'
      TabOrder = 5
      TabStop = False
      OnClick = BtCodeClick
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
      Spacing = 5
      Marging = 5
    end
    object BtSave: TSevenButton
      Left = 180
      Top = 0
      Width = 106
      Height = 23
      Caption = 'Sauvegarder'
      TabOrder = 6
      TabStop = False
      OnClick = BtSaveClick
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
      Spacing = 5
      Marging = 5
    end
    object BtClean: TSevenButton
      Left = 291
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Nettoyer'
      TabOrder = 7
      TabStop = False
      OnClick = BtCleanClick
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
      Spacing = 5
      Marging = 5
    end
  end
  object WebLog: TWebBrowser
    Left = 222
    Top = 28
    Width = 719
    Height = 553
    TabStop = False
    Align = alClient
    TabOrder = 1
    ControlData = {
      4C000000504A0000273900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126203000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PnLeft: TPanel
    Left = 0
    Top = 28
    Width = 222
    Height = 553
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object PageControl: TPageControl
      Left = 0
      Top = 91
      Width = 222
      Height = 427
      ActivePage = TabChannels
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object TabChannels: TTabSheet
        Caption = 'Canaux'
        DesignSize = (
          214
          367)
        object ListChannels: TCheckListBox
          Left = 0
          Top = 1
          Width = 214
          Height = 335
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 14
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnDblClick = CheckListBoxDblClick
          OnDrawItem = ListChannelsDrawItem
        end
        object BtCheckChannels: TSevenButton
          Left = 33
          Top = 342
          Width = 70
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Tous'
          TabOrder = 1
          TabStop = False
          OnClick = BtCheckChannelsClick
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
          Spacing = 5
          Marging = 5
        end
        object BtUncheckChannels: TSevenButton
          Left = 108
          Top = 342
          Width = 70
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Aucun'
          TabOrder = 2
          TabStop = False
          OnClick = BtUncheckChannelsClick
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
          Spacing = 5
          Marging = 5
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Syst'#232'me'
        ImageIndex = 1
        DesignSize = (
          214
          367)
        object BtAddFilter: TSevenButton
          Left = 33
          Top = 342
          Width = 70
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Ajouter'
          TabOrder = 0
          TabStop = False
          OnClick = BtAddFilterClick
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
          Spacing = 5
          Marging = 5
        end
        object BtDelFilter: TSevenButton
          Left = 108
          Top = 342
          Width = 87
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Supprimer'
          TabOrder = 1
          TabStop = False
          OnClick = BtDelFilterClick
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
          Spacing = 5
          Marging = 5
        end
        object ListFilter: TListBox
          Left = 0
          Top = 0
          Width = 214
          Height = 305
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 20
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 2
          OnClick = ListFilterClick
        end
        object EdFilter: TEdit
          Left = 0
          Top = 309
          Width = 214
          Height = 28
          TabStop = False
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 3
        end
      end
      object TabCharacters: TTabSheet
        Caption = 'Personnages'
        ImageIndex = 2
        DesignSize = (
          214
          367)
        object ListCharacters: TCheckListBox
          Left = 0
          Top = 0
          Width = 214
          Height = 336
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 20
          TabOrder = 0
          OnDblClick = CheckListBoxDblClick
        end
        object BtCheckCharacters: TSevenButton
          Left = 33
          Top = 342
          Width = 70
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Tous'
          TabOrder = 1
          TabStop = False
          OnClick = BtCheckCharactersClick
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
          Spacing = 5
          Marging = 5
        end
        object BtUncheckCharacters: TSevenButton
          Left = 108
          Top = 342
          Width = 70
          Height = 23
          Anchors = [akLeft, akBottom]
          Caption = 'Aucun'
          TabOrder = 2
          TabStop = False
          OnClick = BtUncheckCharactersClick
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
          Spacing = 5
          Marging = 5
        end
      end
    end
    object PnOptions: TPanel
      Left = 0
      Top = 0
      Width = 222
      Height = 91
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object LbColorBackground: TLabel
        Left = 5
        Top = 5
        Width = 114
        Height = 20
        Caption = 'Couleur de fond :'
      end
      object LbColorSystem: TLabel
        Left = 5
        Top = 26
        Width = 115
        Height = 20
        Caption = 'Couleur syst'#232'me :'
      end
      object PnColorBackground: TPanel
        Left = 197
        Top = 5
        Width = 18
        Height = 18
        Cursor = crHandPoint
        Hint = 'S'#233'lectionner une couleur'
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = 4349520
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = PnColorClick
      end
      object PnColorSystem: TPanel
        Left = 197
        Top = 26
        Width = 18
        Height = 18
        Cursor = crHandPoint
        Hint = 'S'#233'lectionner une couleur'
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = clBlack
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PnColorClick
      end
      object CbShowDate: TCheckBox
        Left = 5
        Top = 48
        Width = 211
        Height = 19
        TabStop = False
        Caption = 'Afficher la date'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object CbSystemMessage: TCheckBox
        Left = 5
        Top = 68
        Width = 211
        Height = 19
        TabStop = False
        Caption = 'Messages syst'#232'me'
        TabOrder = 3
      end
    end
    object PnActions: TPanel
      Left = 0
      Top = 518
      Width = 222
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        222
        35)
      object BtDefault: TSevenButton
        Left = 22
        Top = 7
        Width = 85
        Height = 23
        Anchors = [akLeft, akBottom]
        Caption = 'D'#233'faut'
        TabOrder = 0
        TabStop = False
        OnClick = BtDefaultClick
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
        Spacing = 5
        Marging = 5
      end
      object BtOK: TSevenButton
        Left = 112
        Top = 7
        Width = 85
        Height = 23
        Anchors = [akLeft, akBottom]
        Caption = 'Appliquer'
        TabOrder = 1
        TabStop = False
        OnClick = BtOKClick
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
        Default = True
        Spacing = 5
        Marging = 5
      end
    end
  end
  object OdBrowseLogFile: TOpenDialog
    Filter = 'Fichiers log (*.txt)|*.txt|Tous les fichiers (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 591
    Top = 37
  end
  object OdColor: TColorDialog
    Color = 12631988
    CustomColors.Strings = (
      'ColorA=425E50'
      'ColorB=000000')
    Options = [cdFullOpen]
    Left = 558
    Top = 37
  end
  object OdSaveFile: TSaveDialog
    Filter = 'Fichiers log (*.txt)|*.txt|Tous les fichiers (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 625
    Top = 37
  end
  object PopupMenuCode: TPopupMenu
    AutoPopup = False
    Left = 660
    Top = 37
    object MenuHtml: TMenuItem
      Caption = 'HTML'
      OnClick = BtHtmlClick
    end
    object MenuBBCode: TMenuItem
      Caption = 'BBCode'
      OnClick = BtBbcodeClick
    end
    object MenuText: TMenuItem
      Caption = 'Texte'
      OnClick = BtTextClick
    end
  end
  object PopupMenuClean: TPopupMenu
    AutoPopup = False
    Left = 695
    Top = 37
    object MenuDeleteSystem: TMenuItem
      Caption = 'Supprimer les messages syst'#232'me'
      OnClick = MenuDeleteSystemClick
    end
    object MenuAutoDeleteOld: TMenuItem
      Caption = 'Supprimer les vieux messages'
      OnClick = MenuAutoDeleteOldClick
    end
    object MenuDeleteAll: TMenuItem
      Caption = 'Supprimer tous les messages'
      OnClick = MenuDeleteAllClick
    end
  end
end
