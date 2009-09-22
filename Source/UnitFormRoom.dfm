object FormRoom: TFormRoom
  Left = 345
  Top = 282
  Width = 708
  Height = 432
  Caption = 'Room'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LbGuildName: TLabel
    Left = 348
    Top = 7
    Width = 345
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtFilter: TSpeedButton
    Left = 7
    Top = 2
    Width = 75
    Height = 23
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Filtre'
    Flat = True
    Transparent = False
    OnClick = BtFilterClick
  end
  object BtInfo: TSpeedButton
    Left = 92
    Top = 2
    Width = 75
    Height = 23
    AllowAllUp = True
    GroupIndex = 2
    Caption = 'Informations'
    Enabled = False
    Flat = True
    Transparent = False
  end
  object GuildRoom: TScrollRoom
    Left = 3
    Top = 28
    Width = 694
    Height = 375
    HorzScrollBar.Visible = False
    VertScrollBar.Tracking = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    TabStop = True
    OnClick = GuildRoomClick
    OnMouseMove = GuildRoomMouseMove
    OnMouseWheelDown = GuildRoomMouseWheelDown
    OnMouseWheelUp = GuildRoomMouseWheelUp
    Spacing = 2
    ColCount = 16
    ControlWidth = 40
    ControlHeight = 40
  end
end
