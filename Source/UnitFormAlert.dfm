object FormAlert: TFormAlert
  Left = 345
  Top = 282
  Width = 708
  Height = 438
  Caption = 'Personnages'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object RichEditAlert: TRichEdit
    Left = 0
    Top = 28
    Width = 692
    Height = 372
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      
        '2010-06-08 | Misugi (room) : la durabilit'#233' de l'#39'objet XXXXXXXXX ' +
        'est en dessous du seuil de surveillance (4/5)'
      
        '2010-06-08 | Misugi (room) : la quantit'#233' de l'#39'objet XXXXXXXXX es' +
        't en dessous du seuil de surveillance (18/20)'
      
        '2010-06-08 | Misugi (room) : l'#39'objet sous surveillance XXXXXXXXX' +
        ' n'#39'existe plus'
      
        '2010-06-08 | Les champions de la Flamme : la quantit'#233' de l'#39'objet' +
        ' XXXXXXXXX est en dessous du seuil de surveillance (18/20)'
      ''
      
        '2010-06-08 | Les champions de la Flamme : l'#39'objet XXXXXXXXX a '#233't' +
        #233' ajout'#233
      
        '2010-06-08 | Les champions de la Flamme : l'#39'objet XXXXXXXXX a '#233't' +
        #233' retir'#233
      
        '2010-06-08 | Les champions de la Flamme : la quantit'#233' de l'#39'objet' +
        ' XXXXXXXXX a chang'#233' (12 -> 17) (+5)'
      ''
      
        '2010-06-08 | Misugi (ventes) : l'#39'objet XXXXXXX sera automatiquem' +
        'ent vendu au marchand dans 3 jours/heures/minutes (Fyros)'
      
        '2010-06-08 | Misugi : le volume de la pi'#232'ce est au dessus du seu' +
        'il limite (1994/1990)'
      
        '2010-06-08 | Les champions de la Flamme : le volume du coffre es' +
        't au dessus du seuil limite (9996/10000)'
      
        '2010-06-08 | prochain changement de saison dans 3 jours/heures/m' +
        'inutes (Et'#233')')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object BtClear: TButton
      Left = 0
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Vider'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtClearClick
    end
    object BtSave: TButton
      Left = 90
      Top = 0
      Width = 85
      Height = 23
      Caption = 'Enregistrer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtSaveClick
    end
  end
  object TimerUpdate: TTimer
    Interval = 60000
    OnTimer = TimerUpdateTimer
    Left = 656
    Top = 36
  end
  object SaveAlert: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 'RTF (*.rtf)|*.rtf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 624
    Top = 36
  end
end
