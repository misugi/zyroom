object FormInvent: TFormInvent
  Left = 345
  Top = 287
  Width = 725
  Height = 440
  Caption = 'Inventaire'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 402
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
  end
  object PnInvent: TPanel
    Left = 285
    Top = 0
    Width = 424
    Height = 402
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object TabInvent: TTabControl
      Left = 0
      Top = 21
      Width = 424
      Height = 381
      Align = alClient
      TabOrder = 0
      Tabs.Strings = (
        'Pi'#232'ce'
        'Sac'
        'Animal 1'
        'Animal 2'
        'Animal 3'
        'Animal 4'
        'Ventes')
      TabIndex = 0
      TabStop = False
      OnChange = TabInventChange
      object CharInvent: TScrollRoom
        Left = 4
        Top = 25
        Width = 416
        Height = 352
        HorzScrollBar.Tracking = True
        VertScrollBar.Increment = 42
        VertScrollBar.Tracking = True
        Align = alClient
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        TabStop = True
        OnClick = CharInventClick
        OnMouseMove = CharInventMouseMove
        OnMouseWheelDown = CharInventMouseWheelDown
        OnMouseWheelUp = CharInventMouseWheelUp
        OnResize = CharInventResize
        Spacing = 2
        ColCount = 16
        ControlWidth = 40
        ControlHeight = 40
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 424
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        424
        21)
      object LbValueCharName: TLabel
        Left = 2
        Top = 0
        Width = 243
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
        Left = 243
        Top = 5
        Width = 180
        Height = 16
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
    end
  end
end
