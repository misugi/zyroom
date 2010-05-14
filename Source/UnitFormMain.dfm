object FormMain: TFormMain
  Left = 382
  Top = 270
  Width = 788
  Height = 606
  Caption = 'zyRoom'
  Color = 12631988
  Constraints.MinHeight = 606
  Constraints.MinWidth = 788
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnContainer: TPanel
    Left = 0
    Top = 28
    Width = 772
    Height = 540
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
  end
  object PnHeader: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      772
      28)
    object ImgAniro: TImage
      Left = 564
      Top = 8
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
    end
    object LbAniro: TLabel
      Left = 585
      Top = 10
      Width = 24
      Height = 13
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Aniro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = LbServerClick
    end
    object LbTime: TLabel
      Left = 330
      Top = 10
      Width = 226
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '-'
    end
    object ImgLeanon: TImage
      Left = 623
      Top = 8
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
    end
    object LbLeanon: TLabel
      Left = 644
      Top = 10
      Width = 36
      Height = 13
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Leanon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = LbServerClick
    end
    object ImgArispotle: TImage
      Left = 695
      Top = 8
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
    end
    object LbArispotle: TLabel
      Left = 717
      Top = 10
      Width = 40
      Height = 13
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Arispotle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = LbServerClick
    end
    object ImgUpdate: TImage
      Left = 272
      Top = 4
      Width = 24
      Height = 24
      Cursor = crHandPoint
      ParentShowHint = False
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
        0000180806000000E0773DF80000000774494D4507DA050C151A144D5DEA1C00
        0000097048597300000B1200000B1201D2DD7EFC0000000467414D410000B18F
        0BFC6105000004114944415478DAE5957B4C5B551CC7BFF7D9969622103A0605
        BA618663640F5E1A60994E4D5842C2DC74CC6D716816A62C12B7844D42140989
        33388D89664E339991613618AE388835CACC14593786AF05C90A16222F81024D
        4BE9EBDED6D35B20BA157C24264B3CF77EFFB8E7FCEEF7737EE7FCEEB914FEE3
        46FD1F00F9B29894FB33B4F7EAF2A26322B47EBF9FB24C5887466F0D7E3B69EE
        BA0118DCFF16402765D5166E2DC87B392733394D171FC92A385A1A7079449887
        67840EA3A9E772ABB17AF8C7A32DA4DBF70F005BE43945CF9DD8B9FB916757C7
        463164D25220F58768BF9F3CD37EF40D4D8A8D0DEDEF75E93F3A122A9B50002A
        BBA8F1ADC2C7B73D1F2E53510BC634D1BA248067819B8380570C50A41B33B336
        7FF3C7AD277FB8B4B7ECF64CEE00ACCA3A5190FFF41EBD8A533381619AB85344
        6BB40C8A1FE524D8A74601C65E713E133F02D7946D4A6CAB3BBB73EC6645CB32
        8012EEE1B27D1DF12BE3B305B7089AA617A58BE551B16F051886C229BD05DD26
        67D09CC8E7F391E502FAFBFBBB3BCF9CCE019A3C2101096955996B0BB6773A27
        A7B98029C33092162049B172C8789AACBB73D138205114259141EFAD3643EE6F
        03355D2101A905670EF19AA477ACC3BF82E338B02C8B0550F43D0A1CD8910286
        6CC6F9CFCD1818B12F02044190245347C0313E5636F855C9DB2101EB775F786D
        6666E698C3EA002F934BC60B90F4540D2EBC992FC595BFD1898BEDE63FCD3E00
        E0546AC859EAF5FE4B7B8E86046CD8DBFCEA48CF171516731798701D38651C38
        7914585E89EC0D89309C2E92E20ED57C8926432F44C10BC1EB84E0B641704E42
        AEE011B33AA7F697D6FDC7422FD1AE8683F6A9915343DD7A8055014C189182D4
        A802B919F7A1435F2EC53D75B81EF59F5C2505E904444750C22CA2933622222E
        BDD4DC56FC6E48407C5EED7AF5AA355DA6F60F79D147CA82514AE6A079E46E4A
        46C7C5178280230D04708DD4282916D1454073A07C2E24641678E6A6A71FB05C
        ADF87E8932AD6237956EB93C70FDCA66EBD8401020652023001D3A9A4A8280F2
        66D4EBBF23E69EF92CE6104636589BF150A7A9BEED41E07DEF921F5AE263755B
        D52B920D7D5F1B38B7D3232D13C5B0C8DDA8C537E79E9162F6BFD882B32D3FC1
        270A52062CEB476246AED765B76C1B6D3DD0FE9747C5BAD2B657044F78E5E08D
        6B8CD7E5944A36215E83E21DE9C48C46D3673DE8ED1B86DBED02CDF2884B4DF3
        714AF1787F5DE14BC103647900694F3069870F56327474E5F8CF263E8CF22256
        A3416464A454B2369B0DE31313B0BA044424EBBC3ED88EF79D34D600D5C21DB3
        C5D28DD2969CDBBC32716D558C429513A752CA356AA504B0D81D18B2DA5D63B3
        56E3C890A97AFC8327AFDC3EF3BF03984FA691898A72A768B4BA2C75B85217E8
        B2D91D8313A3C3D7A72D8C094DBBC4E55EBF1B7E997739E077753CAF2889AEF5
        C90000000049454E44AE426082}
      ShowHint = True
      Visible = False
      OnClick = ImgUpdateClick
    end
    object BtOptions: TButton
      Left = 5
      Top = 5
      Width = 75
      Height = 23
      Caption = 'Options'
      TabOrder = 0
      OnClick = BtOptionsClick
    end
    object BtGuild: TButton
      Left = 88
      Top = 5
      Width = 75
      Height = 23
      Caption = 'Guildes'
      TabOrder = 1
      OnClick = BtGuildClick
    end
    object BtCharacter: TButton
      Left = 171
      Top = 5
      Width = 94
      Height = 23
      Caption = 'Personnages'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = BtCharacterClick
    end
  end
  object TimerStatus: TTimer
    Interval = 60000
    OnTimer = TimerStatusTimer
    Left = 660
    Top = 52
  end
  object TimerUpdate: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TimerUpdateTimer
    Left = 628
    Top = 52
  end
end
