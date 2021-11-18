object FormOptions: TFormOptions
  Left = 438
  Top = 206
  ActiveControl = CmbLanguage
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 427
  ClientWidth = 543
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 543
    Height = 393
    ActivePage = TabGeneral
    Align = alClient
    TabOrder = 0
    object TabGeneral: TTabSheet
      Caption = 'G'#233'n'#233'ral'
      DesignSize = (
        535
        358)
      object LbLanguage: TLabel
        Left = 5
        Top = 11
        Width = 55
        Height = 20
        Caption = 'Langue :'
      end
      object LbPackFile: TLabel
        Left = 5
        Top = 45
        Width = 406
        Height = 20
        Caption = 'Fichier de ressources "string_client.pack" install'#233' avec Ryzom :'
      end
      object Label1: TLabel
        Left = 230
        Top = 151
        Width = 216
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Couleur de l'#39'interface :'
      end
      object Label2: TLabel
        Left = 5
        Top = 182
        Width = 293
        Height = 20
        Caption = 'Nombre de threads pour la synchronisation :'
      end
      object CmbLanguage: TComboBox
        Left = 150
        Top = 7
        Width = 382
        Height = 28
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        Sorted = True
        TabOrder = 0
        OnChange = CmbLanguageChange
      end
      object EdPackFile: TEdit
        Left = 5
        Top = 71
        Width = 497
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
        OnChange = CmbLanguageChange
      end
      object PnColor: TPanel
        Left = 511
        Top = 151
        Width = 19
        Height = 19
        Cursor = crHandPoint
        Hint = 'S'#233'lectionner une couleur'
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = 12631988
        Ctl3D = False
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = PnColorClick
      end
      object EdThreadCount: TSpinEdit
        Left = 471
        Top = 177
        Width = 61
        Height = 30
        Anchors = [akTop, akRight]
        MaxValue = 25
        MinValue = 1
        TabOrder = 3
        Value = 10
        OnChange = CmbLanguageChange
      end
      object CbKeepFilter: TCheckBox
        Left = 5
        Top = 152
        Width = 216
        Height = 17
        Caption = 'Garder le filtre actif'
        TabOrder = 4
        OnClick = CmbLanguageChange
      end
      object BtAutoBrowsePackFile: TSevenButton
        Left = 505
        Top = 71
        Width = 27
        Height = 27
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 5
        OnClick = BtAutoBrowsePackFileClick
        Border.ColorNormal = 7368816
        Border.ColorHot = 11632444
        Border.ColorDown = 9134636
        Border.ColorDisabled = 11907757
        Border.ColorFocused = 11632444
        Border.WidthNormal = 1
        Border.WidthHot = 1
        Border.WidthDown = 1
        Border.WidthDisabled = 1
        Border.WidthFocused = 1
        Colors.ColorNormalFrom = 16579836
        Colors.ColorNormalTo = 13619151
        Colors.ColorHotFrom = 16579836
        Colors.ColorHotTo = 16112039
        Colors.ColorDownFrom = 16579836
        Colors.ColorDownTo = 14398312
        Colors.ColorDisabledFrom = 16053492
        Colors.ColorDisabledTo = 16053492
        Colors.ColorFocusedFrom = 16579836
        Colors.ColorFocusedTo = 13619151
        Fonts.FontHot.Charset = DEFAULT_CHARSET
        Fonts.FontHot.Color = clWindowText
        Fonts.FontHot.Height = -15
        Fonts.FontHot.Name = 'Segoe UI'
        Fonts.FontHot.Style = []
        Fonts.FontDown.Charset = DEFAULT_CHARSET
        Fonts.FontDown.Color = clWindowText
        Fonts.FontDown.Height = -15
        Fonts.FontDown.Name = 'Segoe UI'
        Fonts.FontDown.Style = []
        Fonts.FontDisabled.Charset = DEFAULT_CHARSET
        Fonts.FontDisabled.Color = clGrayText
        Fonts.FontDisabled.Height = -15
        Fonts.FontDisabled.Name = 'Segoe UI'
        Fonts.FontDisabled.Style = []
        Fonts.FontFocused.Charset = DEFAULT_CHARSET
        Fonts.FontFocused.Color = clWindowText
        Fonts.FontFocused.Height = -15
        Fonts.FontFocused.Name = 'Segoe UI'
        Fonts.FontFocused.Style = []
        Spacing = 5
        Marging = 5
      end
      object LbNeededFile: TStaticText
        Left = 5
        Top = 105
        Width = 461
        Height = 41
        AutoSize = False
        Caption = 
          'Ce fichier doit '#234'tre valide pour afficher le nom des objets et a' +
          'ctiver la sauvegarde des fichiers !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
    end
    object TabProxy: TTabSheet
      Caption = 'Proxy'
      ImageIndex = 1
      DesignSize = (
        535
        358)
      object PnProxy: TPanel
        Left = 0
        Top = 34
        Width = 535
        Height = 172
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Ctl3D = True
        ParentColor = True
        ParentCtl3D = False
        TabOrder = 0
        DesignSize = (
          535
          172)
        object LbProxyPassword: TLabel
          Left = 5
          Top = 100
          Width = 96
          Height = 20
          Caption = 'Mot de passe :'
        end
        object LbProxyAddress: TLabel
          Left = 5
          Top = 5
          Width = 59
          Height = 20
          Caption = 'Adresse :'
        end
        object LbPortAddress: TLabel
          Left = 5
          Top = 37
          Width = 33
          Height = 20
          Caption = 'Port :'
        end
        object LbProxyUsername: TLabel
          Left = 5
          Top = 69
          Width = 121
          Height = 20
          Caption = 'Nom d'#39'utilisateur :'
        end
        object EdProxyUsername: TEdit
          Left = 175
          Top = 65
          Width = 357
          Height = 28
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EdProxyUsername'
          OnChange = CmbLanguageChange
        end
        object EdProxyPassword: TEdit
          Left = 175
          Top = 96
          Width = 357
          Height = 28
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 1
          Text = 'Edit1'
          OnChange = CmbLanguageChange
        end
        object EdProxyAddress: TEdit
          Left = 175
          Top = 1
          Width = 357
          Height = 28
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = '127.0.0.1'
          OnChange = CmbLanguageChange
        end
        object EdProxyPort: TSpinEdit
          Left = 175
          Top = 32
          Width = 96
          Height = 30
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 8080
          OnChange = CmbLanguageChange
        end
      end
      object CbProxyEnabled: TCheckBox
        Left = 5
        Top = 11
        Width = 466
        Height = 17
        Caption = 'Utiliser un serveur proxy'
        TabOrder = 1
        OnClick = CbProxyEnabledClick
      end
    end
    object TabAlertes: TTabSheet
      Caption = 'Alertes'
      ImageIndex = 2
      DesignSize = (
        535
        358)
      object LbVolumeMax: TLabel
        Left = 5
        Top = 33
        Width = 197
        Height = 20
        Caption = 'Seuil d'#39'alerte pour le volume :'
      end
      object LbVolumeGuild: TLabel
        Left = 471
        Top = 7
        Width = 61
        Height = 19
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Guilde'
      end
      object LbVolumeRoom: TLabel
        Left = 403
        Top = 7
        Width = 61
        Height = 19
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Pi'#232'ce'
      end
      object LbSalesCount: TLabel
        Left = 5
        Top = 66
        Width = 315
        Height = 20
        Caption = 'Nombre d'#39'alertes pour l'#39'expiration d'#39'une vente :'
      end
      object LbSeasonCount: TLabel
        Left = 5
        Top = 99
        Width = 387
        Height = 20
        Caption = 'Nombre d'#39'alertes pour le prochain changement de saison :'
      end
      object EdVolumeRoom: TSpinEdit
        Left = 403
        Top = 28
        Width = 61
        Height = 30
        Anchors = [akTop, akRight]
        MaxValue = 2000
        MinValue = 0
        TabOrder = 0
        Value = 1900
        OnChange = CmbLanguageChange
      end
      object EdVolumeGuild: TSpinEdit
        Left = 471
        Top = 28
        Width = 61
        Height = 30
        Anchors = [akTop, akRight]
        MaxValue = 10000
        MinValue = 0
        TabOrder = 1
        Value = 9800
        OnChange = CmbLanguageChange
      end
      object CbSaveAlertFile: TCheckBox
        Left = 5
        Top = 177
        Width = 461
        Height = 17
        Caption = 'Sauvegarder automatiquement les alertes dans un fichier'
        TabOrder = 2
        OnClick = CmbLanguageChange
      end
      object EdSalesCount: TSpinEdit
        Left = 471
        Top = 61
        Width = 61
        Height = 30
        Anchors = [akTop, akRight]
        MaxValue = 24
        MinValue = 0
        TabOrder = 3
        Value = 1
        OnChange = CmbLanguageChange
      end
      object EdSeasonCount: TSpinEdit
        Left = 471
        Top = 94
        Width = 61
        Height = 30
        Anchors = [akTop, akRight]
        MaxValue = 24
        MinValue = 0
        TabOrder = 4
        Value = 1
        OnChange = CmbLanguageChange
      end
      object CbShowHint: TCheckBox
        Left = 5
        Top = 152
        Width = 461
        Height = 17
        Caption = 'Afficher une bulle d'#39'information pour les nouvelles alertes'
        TabOrder = 5
        OnClick = CmbLanguageChange
      end
      object CbIgnoreCata: TCheckBox
        Left = 5
        Top = 127
        Width = 461
        Height = 17
        Caption = 'Ignorer les alertes sur les cristaux'
        TabOrder = 6
        OnClick = CmbLanguageChange
      end
    end
  end
  object PnActions: TPanel
    Left = 0
    Top = 393
    Width = 543
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      543
      34)
    object BtOK: TSevenButton
      Left = 273
      Top = 6
      Width = 85
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtOKClick
      Border.ColorNormal = 7368816
      Border.ColorHot = 11632444
      Border.ColorDown = 9134636
      Border.ColorDisabled = 11907757
      Border.ColorFocused = 11632444
      Border.WidthNormal = 1
      Border.WidthHot = 1
      Border.WidthDown = 1
      Border.WidthDisabled = 1
      Border.WidthFocused = 1
      Colors.ColorNormalFrom = 16579836
      Colors.ColorNormalTo = 13619151
      Colors.ColorHotFrom = 16579836
      Colors.ColorHotTo = 16112039
      Colors.ColorDownFrom = 16579836
      Colors.ColorDownTo = 14398312
      Colors.ColorDisabledFrom = 16053492
      Colors.ColorDisabledTo = 16053492
      Colors.ColorFocusedFrom = 16579836
      Colors.ColorFocusedTo = 13619151
      Fonts.FontHot.Charset = DEFAULT_CHARSET
      Fonts.FontHot.Color = clWindowText
      Fonts.FontHot.Height = -15
      Fonts.FontHot.Name = 'Segoe UI'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -15
      Fonts.FontDown.Name = 'Segoe UI'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -15
      Fonts.FontDisabled.Name = 'Segoe UI'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -15
      Fonts.FontFocused.Name = 'Segoe UI'
      Fonts.FontFocused.Style = []
      ModalResult = 1
      Default = True
      Spacing = 5
      Marging = 5
    end
    object BtCancel: TSevenButton
      Left = 363
      Top = 6
      Width = 85
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'Annuler'
      TabOrder = 1
      Border.ColorNormal = 7368816
      Border.ColorHot = 11632444
      Border.ColorDown = 9134636
      Border.ColorDisabled = 11907757
      Border.ColorFocused = 11632444
      Border.WidthNormal = 1
      Border.WidthHot = 1
      Border.WidthDown = 1
      Border.WidthDisabled = 1
      Border.WidthFocused = 1
      Colors.ColorNormalFrom = 16579836
      Colors.ColorNormalTo = 13619151
      Colors.ColorHotFrom = 16579836
      Colors.ColorHotTo = 16112039
      Colors.ColorDownFrom = 16579836
      Colors.ColorDownTo = 14398312
      Colors.ColorDisabledFrom = 16053492
      Colors.ColorDisabledTo = 16053492
      Colors.ColorFocusedFrom = 16579836
      Colors.ColorFocusedTo = 13619151
      Fonts.FontHot.Charset = DEFAULT_CHARSET
      Fonts.FontHot.Color = clWindowText
      Fonts.FontHot.Height = -15
      Fonts.FontHot.Name = 'Segoe UI'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -15
      Fonts.FontDown.Name = 'Segoe UI'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -15
      Fonts.FontDisabled.Name = 'Segoe UI'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -15
      Fonts.FontFocused.Name = 'Segoe UI'
      Fonts.FontFocused.Style = []
      ModalResult = 2
      Cancel = True
      Spacing = 5
      Marging = 5
    end
    object BtApply: TSevenButton
      Left = 453
      Top = 6
      Width = 85
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'Appliquer'
      TabOrder = 2
      OnClick = BtApplyClick
      Border.ColorNormal = 7368816
      Border.ColorHot = 11632444
      Border.ColorDown = 9134636
      Border.ColorDisabled = 11907757
      Border.ColorFocused = 11632444
      Border.WidthNormal = 1
      Border.WidthHot = 1
      Border.WidthDown = 1
      Border.WidthDisabled = 1
      Border.WidthFocused = 1
      Colors.ColorNormalFrom = 16579836
      Colors.ColorNormalTo = 13619151
      Colors.ColorHotFrom = 16579836
      Colors.ColorHotTo = 16112039
      Colors.ColorDownFrom = 16579836
      Colors.ColorDownTo = 14398312
      Colors.ColorDisabledFrom = 16053492
      Colors.ColorDisabledTo = 16053492
      Colors.ColorFocusedFrom = 16579836
      Colors.ColorFocusedTo = 13619151
      Fonts.FontHot.Charset = DEFAULT_CHARSET
      Fonts.FontHot.Color = clWindowText
      Fonts.FontHot.Height = -15
      Fonts.FontHot.Name = 'Segoe UI'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -15
      Fonts.FontDown.Name = 'Segoe UI'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -15
      Fonts.FontDisabled.Name = 'Segoe UI'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -15
      Fonts.FontFocused.Name = 'Segoe UI'
      Fonts.FontFocused.Style = []
      Spacing = 5
      Marging = 5
    end
  end
  object OdBrowsePackFile: TOpenDialog
    Filter = 'Fichiers pack (*.pack)|*.pack|Tous les fichiers (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 6
    Top = 362
  end
  object OdColor: TColorDialog
    Color = 12631988
    CustomColors.Strings = (
      'ColorA=C0BFB4')
    Options = [cdFullOpen]
    Left = 43
    Top = 362
  end
end
