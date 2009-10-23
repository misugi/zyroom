object FormInvent: TFormInvent
  Left = 345
  Top = 287
  Width = 708
  Height = 425
  Caption = 'Inventaire'
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
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 398
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
  end
  object PnInvent: TPanel
    Left = 280
    Top = 0
    Width = 420
    Height = 398
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      420
      398)
    object LbCharName: TLabel
      Left = 58
      Top = 2
      Width = 305
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
    object TabInvent: TTabControl
      Left = 2
      Top = 20
      Width = 416
      Height = 376
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      Tabs.Strings = (
        'Appartement'
        'Sac'
        'Animal 1'
        'Animal 2'
        'Animal 3'
        'Animal 4')
      TabIndex = 0
      OnChange = TabInventChange
      DesignSize = (
        416
        376)
      object CharInvent: TScrollRoom
        Left = 3
        Top = 23
        Width = 410
        Height = 350
        HorzScrollBar.Tracking = True
        VertScrollBar.Increment = 42
        VertScrollBar.Tracking = True
        Anchors = [akLeft, akTop, akRight, akBottom]
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
  end
end
