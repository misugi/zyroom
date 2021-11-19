object FormEdit: TFormEdit
  Left = 489
  Top = 395
  BorderStyle = bsDialog
  ClientHeight = 151
  ClientWidth = 514
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    514
    151)
  PixelsPerInch = 96
  TextHeight = 20
  object LbAutoKey: TLabel
    Left = 5
    Top = 12
    Width = 157
    Height = 20
    Caption = 'Cl'#233' API de personnage :'
  end
  object ImgProfilePage: TImage
    Left = 486
    Top = 9
    Width = 24
    Height = 24
    Cursor = crHandPoint
    Hint = 'Gestion des cl'#233's API'
    Anchors = [akTop, akRight]
    ParentShowHint = False
    Picture.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
      0000180806000000E0773DF80000000774494D4507DD0C08120A0C8ECBB30000
      0000097048597300000AF000000AF00142AC34980000000467414D410000B18F
      0BFC6105000004424944415478DA6364200052525264FEFDFB277AF7EEDDCB07
      0F1EFC43483D3A60C425919696C66A6763334D42523291958D8DF9D5AB5737CE
      9D3B17D8DEDE7E832A162C59B4689286A666EEE3274F2EBE7CF972AEA8884810
      2F2FAFEAD265CB74162E5CF881220B80AE57F6F3F5BDF9EAF5EBB3DBB76F7758
      BD7AF5F7989818312F2FAF87EFDEBDABCAC9C9E9A7C882A6A6A652151595AE0B
      172E78747575ED8489B7B6B61E97919179121F1F1F4A8905CCD5A5F9EB651494
      7C18CF95C765CCFDB11428F61F24515E5E7E0C68F1BBD4D4541F722D605A98C7
      33E98FAC77F65F6E630657F9B9FFCFECBF3F35B4E7577E525212B7A4A4E40B61
      61E18545454559245BA0A7A7C71D19E83DD3577D65D44F1E55C6D7EF44186CCD
      5F327C7FFF9EE1C8A6AB7336BF8E7EA0A5A5D5024C4D7E9D9D9D9B49B2001879
      F2C141416BD5B9CE1BEBAB9D65E012E087C8FE87501F5FBE65D8B287E9FF5BFE
      880B1F3E7C34696C6CFC4792055D9D9DBBBC3C5C5D59AE8433A81A294284FF43
      6D805AF2E9ED3B86D3476F6DE99BFB2964C71D869FA458C0181C1CBC24D88A27
      D2D7EC222337BF18DC50B82FFEFF63F8F7F721C3DF7F1F194E1CF9B1A5A5F353
      C4EE970C5F498903FE3C2F9139A97EBF43246444180445851998987981924C40
      F3FF010DBECFF09FF12BC31F6041C1C2CEC270FED4D7D39BB77E486CD9CC7095
      E8480659126EC896ACA22A55AA2AFE5B4241FC1D83B41C1F83B00433038FE05F
      60FA025AF6E72FC3CF1F7F1818D9D818DEBEF8F9F3FC859FD3B6ACFED632F71A
      C33B622C0003515151155B5BDB192EF6564E9A92CC8C3F5F9C66F8F1F2288398
      F06B0609390E066E4136066E6E06865F7FFE33B072B031DCBFF5F5F5F9333F9B
      3BFBBECEBC06142668011470DAD9D995D9DBDB57F8F9F971B0015DFCE9D52386
      E7D7F6329CDD3DEF92ACD0570931412601A7301136664E76601CFD67B87AE1CB
      D50BC7BE97E5CCFDB68D180BC0726A6A6A8ED65656D3DD3D3C54813998919595
      95E1C489E3172B2BAB7C14B83E6A677A31CF575566961490E56450341061F8FC
      E9D7FFAB673FEF3CB6ED5369E3D6DF570859000342EEAEAE8D9A5A5A099E9E9E
      3CD232320C3B77EE58555C5C1225CCC9202E23C4AC1EE3C85E159A28E0C225CA
      C1C0C6C1C1F0E6F9D75F3B56BE49C899F675393116800033D007364545853BAD
      2CADD8199998FEAF5FBFBEBEA1A1A11924A92CCAA0521AC8B5D5DA894FED1FE3
      1F86FFBF99180EEC7ABFAE60D1EF60622D0001263737B76E0B73F35C4F2F2F56
      4646C6BFC0623CACB7B7771D4852849741CD5B8B259493F52FF7AB8F8C0F4EDD
      F9B7F5C97786A7A4580002AC8A8A8AEE13274CD8A4A7AFCF08AC463FCD9F3FDF
      6EC9922517714624891630F0F3F30B9496949C8F888850E0E4E262387BF6CCDD
      AEAE6ECB23478EBCA68A05203D4E0E0E757E0101B51A1A1ACC4A4A8A0CF3E72F
      2807D6D55DD4B20004987574747CE5E4E4BCF9F8F8F45FBC78D17BE0C08195D4
      B40019B00031CEE60C00F8F996288ACEF5650000000049454E44AE426082}
    ShowHint = True
    OnClick = ImgProfilePageClick
  end
  object LbComment: TLabel
    Left = 5
    Top = 43
    Width = 83
    Height = 20
    Caption = 'Description :'
  end
  object EdKey: TEdit
    Left = 195
    Top = 8
    Width = 287
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object EdComment: TEdit
    Left = 195
    Top = 39
    Width = 287
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object CbCheckVolume: TCheckBox
    Left = 195
    Top = 72
    Width = 287
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Surveiller le volume'
    TabOrder = 2
  end
  object CbCheckChange: TCheckBox
    Left = 195
    Top = 94
    Width = 287
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Surveiller tout changement'
    TabOrder = 3
  end
  object BtOK: TSevenButton
    Left = 354
    Top = 123
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
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
    Left = 434
    Top = 123
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
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
end
