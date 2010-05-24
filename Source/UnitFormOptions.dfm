object FormOptions: TFormOptions
  Left = 384
  Top = 293
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 338
  ClientWidth = 389
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    389
    338)
  PixelsPerInch = 96
  TextHeight = 14
  object LbLanguage: TLabel
    Left = 8
    Top = 9
    Width = 42
    Height = 14
    Caption = 'Langue :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LbPackFile: TLabel
    Left = 8
    Top = 33
    Width = 263
    Height = 14
    Caption = 'Fichier des cha'#238'nes de ressource (string_client.pack) :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 79
    Width = 108
    Height = 14
    Caption = 'Couleur de l'#39'interface :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 127
    Width = 214
    Height = 14
    Caption = 'Nombre de threads pour la synchronisation :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object CmbLanguage: TComboBox
    Left = 68
    Top = 5
    Width = 237
    Height = 22
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnChange = CmbLanguageChange
  end
  object EdPackFile: TEdit
    Left = 8
    Top = 49
    Width = 281
    Height = 22
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnChange = CmbLanguageChange
  end
  object CbProxyEnabled: TCheckBox
    Left = 8
    Top = 149
    Width = 281
    Height = 17
    Caption = 'Utiliser un serveur proxy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = CbProxyEnabledClick
  end
  object BtBrowsePackFile: TButton
    Left = 292
    Top = 49
    Width = 89
    Height = 23
    Caption = 'Parcourir...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BtBrowsePackFileClick
  end
  object BtOK: TButton
    Left = 143
    Top = 311
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 4
    OnClick = BtOKClick
  end
  object BtCancel: TButton
    Left = 224
    Top = 311
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Annuler'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 5
  end
  object PnProxy: TPanel
    Left = 8
    Top = 167
    Width = 373
    Height = 110
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 6
    object LbProxyPassword: TLabel
      Left = 8
      Top = 84
      Width = 71
      Height = 14
      Caption = 'Mot de passe :'
    end
    object LbProxyAddress: TLabel
      Left = 8
      Top = 12
      Width = 48
      Height = 14
      Caption = 'Adresse :'
    end
    object LbPortAddress: TLabel
      Left = 8
      Top = 36
      Width = 25
      Height = 14
      Caption = 'Port :'
    end
    object LbProxyUsername: TLabel
      Left = 8
      Top = 60
      Width = 84
      Height = 14
      Caption = 'Nom d'#39'utilisateur :'
    end
    object EdProxyUsername: TEdit
      Left = 108
      Top = 56
      Width = 253
      Height = 22
      TabOrder = 0
      Text = 'EdProxyUsername'
      OnChange = CmbLanguageChange
    end
    object EdProxyPassword: TEdit
      Left = 108
      Top = 80
      Width = 253
      Height = 22
      PasswordChar = '*'
      TabOrder = 1
      Text = 'Edit1'
      OnChange = CmbLanguageChange
    end
    object EdProxyAddress: TEdit
      Left = 108
      Top = 8
      Width = 253
      Height = 22
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = PnColorClick
  end
  object BtApply: TButton
    Left = 305
    Top = 311
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Caption = 'Appliquer'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = BtApplyClick
  end
  object EdThreadCount: TSpinEdit
    Left = 244
    Top = 122
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxValue = 25
    MinValue = 1
    ParentFont = False
    TabOrder = 9
    Value = 10
    OnChange = CmbLanguageChange
  end
  object CbKeepFilter: TCheckBox
    Left = 8
    Top = 101
    Width = 281
    Height = 17
    Caption = 'Garder le filtre actif'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
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
