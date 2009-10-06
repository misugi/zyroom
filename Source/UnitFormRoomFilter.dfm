object FormRoomFilter: TFormRoomFilter
  Left = 359
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Filtre'
  ClientHeight = 416
  ClientWidth = 281
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
  DesignSize = (
    281
    416)
  PixelsPerInch = 96
  TextHeight = 13
  object BtOK: TButton
    Left = 202
    Top = 388
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Appliquer'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = BtOKClick
  end
  object GbType: TGroupBox
    Left = 4
    Top = 4
    Width = 133
    Height = 145
    Caption = 'Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object CbTypeNaturalMat: TCheckBox
      Left = 8
      Top = 40
      Width = 121
      Height = 17
      Caption = 'Mati'#232'res naturelles'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CbTypeAnimalMatClick
    end
    object CbTypeAnimalMat: TCheckBox
      Left = 8
      Top = 20
      Width = 121
      Height = 17
      Caption = 'Mati'#232'res animales'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CbTypeAnimalMatClick
    end
    object CbTypeCata: TCheckBox
      Left = 8
      Top = 60
      Width = 121
      Height = 17
      Caption = 'Catalyseurs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CbTypeOthers: TCheckBox
      Left = 8
      Top = 100
      Width = 121
      Height = 17
      Caption = 'Autres'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CbTypeEquipment: TCheckBox
      Left = 8
      Top = 80
      Width = 121
      Height = 17
      Caption = 'Equipement'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = CbTypeAnimalMatClick
    end
  end
  object GbQuality: TGroupBox
    Left = 4
    Top = 240
    Width = 133
    Height = 77
    Caption = 'Qualit'#233
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object LbQualityMin: TLabel
      Left = 8
      Top = 20
      Width = 23
      Height = 13
      Caption = 'Min :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbQualityMax: TLabel
      Left = 8
      Top = 48
      Width = 26
      Height = 13
      Caption = 'Max :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdQualityMin: TSpinEdit
      Left = 40
      Top = 16
      Width = 85
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 270
      MinValue = 0
      ParentFont = False
      TabOrder = 0
      Value = 250
    end
    object EdQualityMax: TSpinEdit
      Left = 40
      Top = 44
      Width = 85
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 300
      MinValue = 0
      ParentFont = False
      TabOrder = 1
      Value = 250
    end
  end
  object GbClass: TGroupBox
    Left = 144
    Top = 240
    Width = 133
    Height = 77
    Caption = 'Classe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object LbClassMin: TLabel
      Left = 8
      Top = 20
      Width = 23
      Height = 13
      Caption = 'Min :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbClassMax: TLabel
      Left = 8
      Top = 48
      Width = 26
      Height = 13
      Caption = 'Max :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdClassMin: TComboBox
      Left = 40
      Top = 16
      Width = 85
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Base'
      Items.Strings = (
        'Base'
        'Fin'
        'Choix'
        'Excellent'
        'Supr'#234'me')
    end
    object EdClassMax: TComboBox
      Left = 40
      Top = 44
      Width = 85
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 4
      ParentFont = False
      TabOrder = 1
      Text = 'Supr'#234'me'
      Items.Strings = (
        'Base'
        'Fin'
        'Choix'
        'Excellent'
        'Supr'#234'me')
    end
  end
  object GbEcosys: TGroupBox
    Left = 144
    Top = 4
    Width = 133
    Height = 145
    Caption = 'Ecosyst'#232'me'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object CbEcoPrime: TCheckBox
      Left = 8
      Top = 40
      Width = 121
      Height = 17
      Caption = 'Primes Racines'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CbEcoCommon: TCheckBox
      Left = 8
      Top = 20
      Width = 121
      Height = 17
      Caption = 'Commun'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object CbEcoDesert: TCheckBox
      Left = 8
      Top = 80
      Width = 121
      Height = 17
      Caption = 'D'#233'sert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CbEcoForest: TCheckBox
      Left = 8
      Top = 60
      Width = 121
      Height = 17
      Caption = 'For'#234't'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CbEcoLakes: TCheckBox
      Left = 8
      Top = 100
      Width = 121
      Height = 17
      Caption = 'Lacs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object CbEcoJungle: TCheckBox
      Left = 8
      Top = 120
      Width = 121
      Height = 17
      Caption = 'Jungle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object BtDefault: TButton
    Left = 8
    Top = 388
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'D'#233'faut'
    ModalResult = 1
    TabOrder = 5
    OnClick = BtDefaultClick
  end
  object GbName: TGroupBox
    Left = 4
    Top = 320
    Width = 273
    Height = 61
    Caption = 'Nom'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object EdName: TEdit
      Left = 8
      Top = 16
      Width = 257
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object RbAllWords: TRadioButton
      Left = 8
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Tous les mots'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
    end
    object RbOneWord: TRadioButton
      Left = 108
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Un des mots'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object GbEquipment: TGroupBox
    Left = 4
    Top = 152
    Width = 273
    Height = 85
    Caption = 'Equipement'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object CbEqHeavyArmors: TCheckBox
      Left = 8
      Top = 60
      Width = 121
      Height = 17
      Caption = 'Armures lourdes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CbEqWeapons1: TCheckBox
      Left = 140
      Top = 20
      Width = 121
      Height = 17
      Caption = 'Armes '#224' 1 main'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object CbEqMediumArmors: TCheckBox
      Left = 8
      Top = 40
      Width = 121
      Height = 17
      Caption = 'Armures moyennes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CbEqLightArmors: TCheckBox
      Left = 8
      Top = 20
      Width = 121
      Height = 17
      Caption = 'Armures l'#233'g'#232'res'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CbEqJewels: TCheckBox
      Left = 140
      Top = 60
      Width = 121
      Height = 17
      Caption = 'Bijoux'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object CbEqWeapons2: TCheckBox
      Left = 140
      Top = 40
      Width = 121
      Height = 17
      Caption = 'Armes '#224' 2 mains'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
end
