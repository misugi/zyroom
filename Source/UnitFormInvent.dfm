object FormInvent: TFormInvent
  Left = 345
  Top = 282
  Width = 708
  Height = 432
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
  object LbCharName: TLabel
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
  object TabInvent: TTabControl
    Left = 0
    Top = 28
    Width = 700
    Height = 377
    TabOrder = 0
    Tabs.Strings = (
      'Appartement'
      'Sac'
      'Mektoub 1'
      'Mektoub 2'
      'Mektoub 3'
      'Monture')
    TabIndex = 0
    OnChange = TabInventChange
    object CharInvent: TScrollRoom
      Left = 2
      Top = 24
      Width = 694
      Height = 349
      HorzScrollBar.Visible = False
      VertScrollBar.Tracking = True
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabStop = True
      OnClick = CharInventClick
      OnMouseMove = CharInventMouseMove
      OnMouseWheelDown = CharInventMouseWheelDown
      OnMouseWheelUp = CharInventMouseWheelUp
      Spacing = 2
      ColCount = 16
      ControlWidth = 40
      ControlHeight = 40
    end
  end
end
