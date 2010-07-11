object FormGuildEdit: TFormGuildEdit
  Left = 505
  Top = 457
  BorderStyle = bsDialog
  ClientHeight = 125
  ClientWidth = 320
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    320
    125)
  PixelsPerInch = 96
  TextHeight = 14
  object LbAutoKey: TLabel
    Left = 8
    Top = 12
    Width = 97
    Height = 14
    Caption = 'Cl'#233' de personnage :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object ImgProfilePage: TImage
    Left = 292
    Top = 6
    Width = 24
    Height = 24
    Cursor = crHandPoint
    Hint = 'Acc'#233'der directement '#224' la page de compte Ryzom'
    Anchors = [akTop, akRight]
    ParentShowHint = False
    Picture.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
      0000180806000000E0773DF80000002F744558744372656174696F6E2054696D
      650076656E2E203331206A75696C2E20323030392030303A33303A3038202B30
      3130302CF58C070000000774494D4507D9071E161E102A5EEB82000000097048
      597300000B1200000B1201D2DD7EFC0000000467414D410000B18F0BFC610500
      00032E4944415478DAE5955D48536118C7FF67679E9953E7D7D4329D5806A998
      A9100C9C08F38B6D0A82771AE24DD8452BB06936B1C0A22E42225331D8C22070
      E20742CE89A648496403AF422FBA28270D532849A7671FA7F72C971FB8194610
      F4C09FC378CF797EEFF3FCF73E2F85BF1CD47F0B08226288E803D6382227114B
      E4D90DA076295030C3C3C3B5C9C9C9ED1CC71DF882D3E95CE8E8E82836180C8B
      BE842173737357C833927C1410E0703898F8F8F88B344D47F87B47281482E46B
      55A954AD7C32C66C365F95CBE5F7DD2E67C0AD7BB637ECF178BCF2DBBFA020CC
      CCCC7469341A9D77F77D7D7DBA4279664BB0E50EC18900810B1411E002C71128
      BB066CD8B199770FEEE3170E378800A6A7A7BBD56AF5751E20EEEDED6D2C9167
      E8C32DB700490CDCA4B7A6E87A242748207DDB8CD38BDDC44E0FD6557D702516
      82A202DB44DA87A9A9A9BD00555EA65E6C6E04C2A2B1496C69977641164B43F4
      E62E34AB7A5042D2FF920138E2F2B1BCBCEC37B9402040525212262626F60234
      F959FA63E66BE457241C4E160F9D5A7C96E442F9F112D4E821000E6CD1103C89
      C58756C0AF8F8F8F7713937700E505397A91B90E108931F73D0EAF135BB0BE15
      8695F5AF50AE36A028E8399C85C3D89216C06EB707AC402693C162B1EC0088C9
      8D6505D97AE6450D5EAD9DC1B3B827880A762398E6B0E210E0A4ED311A22EAE1
      568E417022FF5093F920FFCCFD801C3DD39305A3EB320C9C0E51E12248426848
      B7DEA396AA43FAD954B8D35BC08A12B0B4B414B0829494148C8E8E76979696FE
      040C0C0C34A914E79A98A7A7B0203C8F976C1139F00E64847F803C740C744C26
      905203776C31E888D4DFAA606464E45705A1434343CD651AB5CEE5F8063FA7DF
      6B9C90F8430999A301CACBCB75FC027F424D26135896455A5A1A72737303269A
      9D9DC5FCFC3C1886416565A5B745FB01E2FEFEFE1B15151537F9053EB156ABC5
      C6C606944A25AAABAB03028C4623262727219148D0D6D6E69D437C0C0E0E3E20
      396FF3009142A1C8EEECEC7C440E488EAF1D4709DF74B5D96CD6AAAA2AADD56A
      7DC767E26B0A274A229212098F947D27F821F685E813D19A6FABDEA9BAAD3FBD
      E5F832F8CB861FCD9E7FF6CAFC77003F00EDA633E0EF97F22D0000000049454E
      44AE426082}
    ShowHint = True
    OnClick = ImgProfilePageClick
  end
  object LbComment: TLabel
    Left = 8
    Top = 36
    Width = 68
    Height = 14
    Caption = 'Commentaire :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object EdKey: TEdit
    Left = 112
    Top = 8
    Width = 176
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object EdComment: TEdit
    Left = 112
    Top = 32
    Width = 176
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object CbCheckVolume: TCheckBox
    Left = 112
    Top = 56
    Width = 197
    Height = 17
    Caption = 'Surveiller le volume'
    TabOrder = 2
  end
  object CbCheckChange: TCheckBox
    Left = 112
    Top = 73
    Width = 197
    Height = 17
    Caption = 'Surveiller tout changement'
    TabOrder = 3
  end
  object BtOK: TSevenButton
    Left = 159
    Top = 97
    Width = 75
    Height = 23
    Caption = 'OK'
    TabOrder = 4
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
    ModalResult = 1
    Default = True
    Spacing = 5
    Marging = 5
  end
  object BtCancel: TSevenButton
    Left = 241
    Top = 97
    Width = 75
    Height = 23
    Caption = 'Annuler'
    TabOrder = 5
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
    ModalResult = 2
    Cancel = True
    Spacing = 5
    Marging = 5
  end
end
