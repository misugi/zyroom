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
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object PnRoom: TPanel
    Left = 285
    Top = 0
    Width = 407
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object GuildRoom: TScrollRoom
      Left = 0
      Top = 21
      Width = 407
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
      OnContextPopup = GuildRoomContextPopup
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
      Width = 407
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        407
        21)
      object LbValueGuildName: TLabel
        Left = 2
        Top = 0
        Width = 223
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LbValueVolume: TLabel
        Left = 226
        Top = 5
        Width = 180
        Height = 16
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
    end
  end
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 387
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
  end
  object PopupWatch: TPopupMenu
    Left = 297
    Top = 58
    object MenuGuard: TMenuItem
      Caption = 'Surveiller'
      OnClick = MenuGuardClick
    end
  end
end
