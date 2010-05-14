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
    Left = 275
    Top = 0
    Width = 417
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object GuildRoom: TScrollRoom
      Left = 0
      Top = 21
      Width = 417
      Height = 366
      HorzScrollBar.Tracking = True
      VertScrollBar.Increment = 44
      VertScrollBar.Tracking = True
      Align = alClient
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
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 417
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        417
        21)
      object LbGuildName: TLabel
        Left = 2
        Top = 0
        Width = 271
        Height = 16
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
      object LbVolume: TLabel
        Left = 275
        Top = 0
        Width = 136
        Height = 16
        Hint = 'Volume'
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
    end
  end
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 275
    Height = 387
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
  end
end
