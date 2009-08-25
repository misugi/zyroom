object FormOptions: TFormOptions
  Left = 384
  Top = 293
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 284
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
    284)
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
    Anchors = [akBottom]
    Caption = 'Fichier des cha'#238'nes de ressource (string_client.pack) :'
  end
  object Label1: TLabel
    Left = 8
    Top = 79
    Width = 105
    Height = 13
    Anchors = [akBottom]
    Caption = 'Couleur de l'#39'interface :'
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
  end
  object EdPackFile: TEdit
    Left = 8
    Top = 49
    Width = 297
    Height = 21
    Anchors = [akBottom]
    ReadOnly = True
    TabOrder = 1
  end
  object CbProxyEnabled: TCheckBox
    Left = 8
    Top = 101
    Width = 229
    Height = 17
    Anchors = [akBottom]
    Caption = 'Utiliser un serveur proxy'
    TabOrder = 2
    OnClick = CbProxyEnabledClick
  end
  object BtBrowsePackFile: TButton
    Left = 306
    Top = 48
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Caption = 'Parcourir...'
    TabOrder = 3
    OnClick = BtBrowsePackFileClick
  end
  object BtOK: TButton
    Left = 224
    Top = 257
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
    Left = 306
    Top = 257
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
    Height = 133
    Anchors = [akBottom]
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
    object CbProxyBasicAuth: TCheckBox
      Left = 8
      Top = 108
      Width = 361
      Height = 17
      Caption = 'Utiliser la m'#233'thode d'#39'identification HTTP Basic'
      TabOrder = 0
    end
    object EdProxyUsername: TEdit
      Left = 108
      Top = 56
      Width = 253
      Height = 21
      TabOrder = 1
      Text = 'EdProxyUsername'
    end
    object EdProxyPassword: TEdit
      Left = 108
      Top = 80
      Width = 253
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
      Text = 'Edit1'
    end
    object EdProxyAddress: TEdit
      Left = 108
      Top = 8
      Width = 253
      Height = 21
      TabOrder = 3
      Text = '127.0.0.1'
    end
    object EdProxyPort: TSpinEdit
      Left = 108
      Top = 32
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 8080
    end
  end
  object PnColor: TPanel
    Left = 124
    Top = 75
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Hint = 'S'#233'lectionner une couleur'
    Anchors = [akBottom]
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
