object FormCharacter: TFormCharacter
  Left = 438
  Top = 225
  Width = 708
  Height = 438
  Caption = 'Personnages'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 20
  object GridItem: TStringGrid
    Left = 0
    Top = 28
    Width = 692
    Height = 371
    Align = alClient
    ColCount = 3
    DefaultColWidth = 36
    DefaultRowHeight = 48
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnDblClick = GridItemDblClick
    OnDrawCell = GridItemDrawCell
    OnMouseWheelDown = GridItemMouseWheelDown
    OnMouseWheelUp = GridItemMouseWheelUp
    OnSelectCell = GridItemSelectCell
    ColWidths = (
      36
      36
      36)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object BtNew: TSevenButton
      Left = 0
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Ajouter'
      TabOrder = 0
      OnClick = BtNewClick
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
    object BtUpdate: TSevenButton
      Left = 90
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Modifier'
      TabOrder = 1
      OnClick = BtUpdateClick
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
    object BtDelete: TSevenButton
      Left = 270
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Supprimer'
      TabOrder = 2
      OnClick = BtDeleteClick
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
    object BtRoom: TSevenButton
      Left = 360
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Inventaire'
      TabOrder = 3
      OnClick = BtRoomClick
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
    object BtDown: TSevenButton
      Left = 450
      Top = 0
      Width = 19
      Height = 23
      TabOrder = 4
      OnClick = BtDownClick
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
      Pictures.PictureNormal.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000700
        000004080600000042C6257D0000002F744558744372656174696F6E2054696D
        650064696D2E203131206A75696C2E20323031302031363A30313A3030202B30
        31303038FEFB0A0000000774494D4507DA070B0E010797B14710000000097048
        597300000B1200000B1201D2DD7EFC0000000467414D410000B18F0BFC610500
        0000564944415478DA3D89A10D40210C051FC1A1515812044154B0003BC028DD
        AAEBA1FB7F2B3873C95D2022BDF7C2883122E78CDE3B5A6B0816CF399A524229
        05630CF75A2BF8349859E79CA8B5E2B7F7370D11D1BDF76B1F69EA11A8332043
        1C0000000049454E44AE426082}
      Spacing = 5
      Marging = 5
    end
    object BtUp: TSevenButton
      Left = 474
      Top = 0
      Width = 19
      Height = 23
      TabOrder = 5
      OnClick = BtUpClick
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
      Pictures.PictureNormal.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000700
        000004080600000042C6257D0000002F744558744372656174696F6E2054696D
        650064696D2E203131206A75696C2E20323031302031353A35393A3435202B30
        31303031C65A2F0000000774494D4507DA070B0E0027B5C45699000000097048
        597300000B1200000B1201D2DD7EFC0000000467414D410000B18F0BFC610500
        00005B4944415478DA4D8B310A00210C04379D966261173085D8087EC6CFE43F
        BEC8C70836393838B9AD661896F05B6BCDD65AF4F90566B694124A299873D28D
        3967ABB5A2F78E1823CE395055A2318689C8FB0821C07B0FE71CF6DE78000C57
        15264341E3DC0000000049454E44AE426082}
      Spacing = 5
      Marging = 5
    end
    object BtReset: TSevenButton
      Left = 180
      Top = 0
      Width = 85
      Height = 23
      Caption = 'R'#233'initialiser'
      TabOrder = 6
      OnClick = BtResetClick
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
