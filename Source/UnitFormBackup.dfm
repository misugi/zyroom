object FormBackup: TFormBackup
  Left = 560
  Top = 252
  Width = 773
  Height = 581
  Caption = 'Sauvegarde'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object PnHeader: TPanel
    Left = 0
    Top = 0
    Width = 757
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      757
      51)
    object LbAlert: TLabel
      Left = 335
      Top = 31
      Width = 420
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 
        'Vous devez s'#233'lectionner un fichier "string_client.pack" valide d' +
        'ans les options !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object BtSave: TSevenButton
      Left = 0
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Ajouter'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabStop = False
      OnClick = BtSaveClick
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
      Fonts.FontHot.Height = -11
      Fonts.FontHot.Name = 'Arial'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -11
      Fonts.FontDown.Name = 'Arial'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -11
      Fonts.FontDisabled.Name = 'Arial'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -11
      Fonts.FontFocused.Name = 'Arial'
      Fonts.FontFocused.Style = []
      Spacing = 5
      Marging = 5
    end
    object BtRestore: TSevenButton
      Left = 90
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Restaurer'
      Enabled = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      TabStop = False
      OnClick = BtRestoreClick
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
      Fonts.FontHot.Height = -11
      Fonts.FontHot.Name = 'Arial'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -11
      Fonts.FontDown.Name = 'Arial'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -11
      Fonts.FontDisabled.Name = 'Arial'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -11
      Fonts.FontFocused.Name = 'Arial'
      Fonts.FontFocused.Style = []
      Spacing = 5
      Marging = 5
    end
    object BtDelete: TSevenButton
      Left = 180
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Supprimer'
      Enabled = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      TabStop = False
      OnClick = BtDeleteClick
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
      Fonts.FontHot.Height = -11
      Fonts.FontHot.Name = 'Arial'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -11
      Fonts.FontDown.Name = 'Arial'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -11
      Fonts.FontDisabled.Name = 'Arial'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -11
      Fonts.FontFocused.Name = 'Arial'
      Fonts.FontFocused.Style = []
      Spacing = 5
      Marging = 5
    end
    object CbAutoBackup: TCheckBox
      Left = 0
      Top = 30
      Width = 326
      Height = 17
      Caption = 'Activer la sauvegarde automatique'
      TabOrder = 3
      OnClick = CbAutoBackupClick
    end
    object BtRename: TSevenButton
      Left = 270
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Renommer'
      Enabled = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      TabStop = False
      OnClick = BtRenameClick
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
      Fonts.FontHot.Height = -11
      Fonts.FontHot.Name = 'Arial'
      Fonts.FontHot.Style = []
      Fonts.FontDown.Charset = DEFAULT_CHARSET
      Fonts.FontDown.Color = clWindowText
      Fonts.FontDown.Height = -11
      Fonts.FontDown.Name = 'Arial'
      Fonts.FontDown.Style = []
      Fonts.FontDisabled.Charset = DEFAULT_CHARSET
      Fonts.FontDisabled.Color = clGrayText
      Fonts.FontDisabled.Height = -11
      Fonts.FontDisabled.Name = 'Arial'
      Fonts.FontDisabled.Style = []
      Fonts.FontFocused.Charset = DEFAULT_CHARSET
      Fonts.FontFocused.Color = clWindowText
      Fonts.FontFocused.Height = -11
      Fonts.FontFocused.Name = 'Arial'
      Fonts.FontFocused.Style = []
      Spacing = 5
      Marging = 5
    end
  end
  object PnOptions: TPanel
    Left = 550
    Top = 51
    Width = 207
    Height = 492
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object ListCharacters: TListBox
      Left = 0
      Top = 0
      Width = 207
      Height = 492
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      MultiSelect = True
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnClick = ListCharactersClick
    end
  end
  object ListBackup: TListBox
    Left = 0
    Top = 51
    Width = 550
    Height = 492
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 2
    OnClick = ListBackupClick
  end
end