object FormOptions: TFormOptions
  Left = 384
  Top = 293
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 337
  ClientWidth = 389
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    389
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object LbLanguage: TLabel
    Left = 8
    Top = 9
    Width = 42
    Height = 13
    Caption = 'Langue :'
  end
  object LbPackFile: TLabel
    Left = 8
    Top = 33
    Width = 255
    Height = 13
    Caption = 'Fichier des cha'#238'nes de ressource (string_client.pack) :'
  end
  object Label1: TLabel
    Left = 8
    Top = 79
    Width = 105
    Height = 13
    Caption = 'Couleur de l'#39'interface :'
  end
  object Label2: TLabel
    Left = 8
    Top = 283
    Width = 207
    Height = 13
    Caption = 'Nombre de threads pour la synchronisation :'
  end
  object CmbLanguage: TComboBox
    Left = 68
    Top = 5
    Width = 237
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnChange = CmbLanguageChange
  end
  object EdPackFile: TEdit
    Left = 8
    Top = 49
    Width = 297
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
    OnChange = CmbLanguageChange
  end
  object CbProxyEnabled: TCheckBox
    Left = 8
    Top = 101
    Width = 281
    Height = 17
    Caption = 'Utiliser un serveur proxy'
    TabOrder = 2
    OnClick = CbProxyEnabledClick
  end
  object BtBrowsePackFile: TButton
    Left = 306
    Top = 48
    Width = 75
    Height = 23
    Caption = 'Parcourir...'
    TabOrder = 3
    OnClick = BtBrowsePackFileClick
  end
  object BtOK: TButton
    Left = 143
    Top = 310
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = BtOKClick
  end
  object BtCancel: TButton
    Left = 224
    Top = 310
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 5
  end
  object PnProxy: TPanel
    Left = 8
    Top = 119
    Width = 373
    Height = 110
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 6
    object LbProxyPassword: TLabel
      Left = 8
      Top = 84
      Width = 70
      Height = 13
      Caption = 'Mot de passe :'
    end
    object LbProxyAddress: TLabel
      Left = 8
      Top = 12
      Width = 44
      Height = 13
      Caption = 'Adresse :'
    end
    object LbPortAddress: TLabel
      Left = 8
      Top = 36
      Width = 25
      Height = 13
      Caption = 'Port :'
    end
    object LbProxyUsername: TLabel
      Left = 8
      Top = 60
      Width = 83
      Height = 13
      Caption = 'Nom d'#39'utilisateur :'
    end
    object EdProxyUsername: TEdit
      Left = 108
      Top = 56
      Width = 253
      Height = 21
      TabOrder = 0
      Text = 'EdProxyUsername'
      OnChange = CmbLanguageChange
    end
    object EdProxyPassword: TEdit
      Left = 108
      Top = 80
      Width = 253
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = 'Edit1'
      OnChange = CmbLanguageChange
    end
    object EdProxyAddress: TEdit
      Left = 108
      Top = 8
      Width = 253
      Height = 21
      TabOrder = 2
      Text = '127.0.0.1'
      OnChange = CmbLanguageChange
    end
    object EdProxyPort: TSpinEdit
      Left = 108
      Top = 32
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 8080
      OnChange = CmbLanguageChange
    end
  end
  object PnColor: TPanel
    Left = 124
    Top = 75
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Hint = 'S'#233'lectionner une couleur'
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Color = 12631988
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = PnColorClick
  end
  object BtApply: TButton
    Left = 305
    Top = 310
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Caption = 'Appliquer'
    Enabled = False
    TabOrder = 8
    OnClick = BtApplyClick
  end
  object CbSavePosition: TCheckBox
    Left = 8
    Top = 237
    Width = 281
    Height = 17
    Caption = 'Sauvegarder la position des fen'#234'tres'
    TabOrder = 9
    OnClick = CbProxyEnabledClick
  end
  object EdThreadCount: TSpinEdit
    Left = 220
    Top = 278
    Width = 49
    Height = 22
    MaxValue = 25
    MinValue = 1
    TabOrder = 10
    Value = 10
    OnChange = CmbLanguageChange
  end
  object CbKeepFilter: TCheckBox
    Left = 8
    Top = 257
    Width = 281
    Height = 17
    Caption = 'Garder le filtre actif'
    TabOrder = 11
    OnClick = CbProxyEnabledClick
  end
  object OdBrowsePackFile: TOpenDialog
    Filter = 'Fichiers pack (*.pack)|*.pack|Tous les fichiers (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 324
    Top = 8
  end
  object OdColor: TColorDialog
    Color = 12631988
    CustomColors.Strings = (
      'ColorA=C0BFB4')
    Left = 356
    Top = 8
  end
end
