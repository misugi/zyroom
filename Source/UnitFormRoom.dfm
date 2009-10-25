object FormRoom: TFormRoom
  Left = 345
  Top = 282
  Width = 708
  Height = 425
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
  object PnRoom: TPanel
    Left = 280
    Top = 0
    Width = 420
    Height = 398
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      420
      398)
    object LbGuildName: TLabel
      Left = 78
      Top = 2
      Width = 264
      Height = 16
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GuildRoom: TScrollRoom
      Left = 2
      Top = 20
      Width = 416
      Height = 376
      HorzScrollBar.Tracking = True
      VertScrollBar.Increment = 44
      VertScrollBar.Tracking = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabStop = True
      OnClick = GuildRoomClick
      OnMouseMove = GuildRoomMouseMove
      OnMouseWheelDown = GuildRoomMouseWheelDown
      OnMouseWheelUp = GuildRoomMouseWheelUp
      OnResize = GuildRoomResize
      Spacing = 2
      ColCount = 16
      ControlWidth = 40
      ControlHeight = 40
    end
  end
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 398
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
  end
end
