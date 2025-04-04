object FormRoom: TFormRoom
  Left = 345
  Top = 282
  Width = 725
  Height = 425
  Caption = 'Room'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object PnRoom: TPanel
    Left = 365
    Top = 0
    Width = 344
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object PnInvent: TPanel
      Left = 0
      Top = 52
      Width = 344
      Height = 334
      Align = alClient
      BevelWidth = 2
      BorderWidth = 2
      ParentColor = True
      TabOrder = 1
      object GuildRoom: TScrollRoom
        Left = 4
        Top = 4
        Width = 336
        Height = 326
        HorzScrollBar.Tracking = True
        VertScrollBar.Increment = 44
        VertScrollBar.Tracking = True
        Align = alClient
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        TabStop = True
        OnClick = GuildRoomClick
        OnContextPopup = GuildRoomContextPopup
        OnMouseMove = GuildRoomMouseMove
        OnMouseWheelDown = GuildRoomMouseWheelDown
        OnMouseWheelUp = GuildRoomMouseWheelUp
        OnResize = GuildRoomResize
        Spacing = 2
        ColCount = 16
        ControlWidth = 40
        ControlHeight = 40
      end
    end
    object PnTop: TPanel
      Left = 0
      Top = 0
      Width = 344
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        344
        52)
      object LbValueGuildName: TLabel
        Left = 2
        Top = 0
        Width = 6
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LbValueVolume: TLabel
        Left = 225
        Top = 4
        Width = 100
        Height = 17
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object ImgVolume: TImage
        Left = 328
        Top = 4
        Width = 16
        Height = 16
        Anchors = [akTop, akRight]
        ParentShowHint = False
        Picture.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
          00001008060000001FF3FF610000002E744558744372656174696F6E2054696D
          65006A65752E20313120616FFB7420323031312032313A31353A3431202B3031
          3030628F8FFB0000000774494D4507DB080B130F38E2A633F400000009704859
          7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
          02284944415478DA6364A010300E4A03189D2B18847EF3321BFDE06092E467E1
          7CC1CDF4FFEC86DCCF6F091AA095C5C023A2C29F252AAB98212DAC24CEC1C2C9
          FAE3F7EF3F5F3F3EBE7769876AD62FD60E8D070FDEACFEB855EF3D360398EDFA
          049B4DCCAC0BE50514385899998042FF1918FF31335C7BB9F7DBF5BDADE715A5
          3D8C6EDD7F3EEF60B7671103C3B55F2806483B31E8F9D71BED561153136363FD
          C7C0C20C917EFEF116C3CD7BBAFF599EF63070B089327EF8F6F3FD81955303DF
          9C283E886280692E73AB7B86519908172F0B27C77F067636068667CF5E31DCF9
          F8F5DFDF7B3B1805B8D5197F01EDFCFCF9EFDF837B8F2E7FBCD23E16C500AB22
          86E5A6A9ECE1D2427C8C22BC5C0CDCAC5C0C5F7F7C6598DDAC7950C37283A5A8
          3007DBA72F0C0C0F1EFFFBF7F4CAA5BD97271BBAA118A01AC6D01ED4C550222B
          CEC422CC2EC9C0CBA8C8C0CCC0C670FBC0FFF557EEF5C8D8B91899DE78CDC070
          F3D1EFDFCF0F2CEE3B3229B902C5006E35063DB74E86BDFE5E4222926C660C42
          0C460C2C0C5C0CEF7F5EFFBE76DE9FF9EE5E3342EFFDE0173D70ECF9FDD39372
          DD9F5E58771B2316E463191AEC22448A022DDCB8B4F85C18381805185E319C60
          3877F3E0C57347B2CE3FFB6AE37C66E7C6EA173B8B9602D5FFC34C48EA0CBCD2
          064CD98A6642F1FA1AAA526242822C3F195EFF79F4F8CE8DF31B9573EE5EB063
          FD71B5EF1450E51F7C2991895F8D419E431588C518388126FCF87295E1FECB8B
          0C8F60B6D23C2F9004001DFFC811411725700000000049454E44AE426082}
        ShowHint = True
      end
      object ImgDappers: TImage
        Left = 193
        Top = 4
        Width = 16
        Height = 16
        Anchors = [akTop, akRight]
        ParentShowHint = False
        Picture.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
          00001008060000001FF3FF610000002E744558744372656174696F6E2054696D
          65006A65752E20313120616FFB7420323031312032313A30323A3535202B3031
          303079386FCF0000000774494D4507DB080B130C38C98B603700000009704859
          7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
          036E4944415478DA6593D94F5B4718C5BF993BF77A03BC84DA869A2DC63181D8
          262E814042D2452189DAD0245222A5EA43D597FE1D7DEB7B9FFB58A9AFAD9AA5
          AA48A3D298B844EC76B0310430D871F106B17DF7995EA7126ADAEF6DA439E7CC
          CCF90D82FF4C707C0A610E388B15F1363BE2114620D64195EA48A51AD613B33F
          B37FEF476F89CF5F69AE39B31559DEF1414BE0AC624544879D355BA3904535B1
          864446414FFEF180FDCFA0294608636222E63617B80686A9C77F3BE38CDF2F43
          AF69B4B2360F85D22B5C566526314AE98BD823F696C1C0F855436CE24D166CF7
          746B5D6393D047EEFCE679F2AD0A63DED1426AA1F5E5769A64E53A3E640CD4D5
          273FD26383663A11CC1C6F22D6163BED0C46D46074BA38580BCDFBEE7FC3C02F
          9CDAB3217F72390EA9EA01CA690A6B1832FDC5D3870C1DA7F3C698A9B3A357EB
          BFF0111771DC9A0B9748B5EBE1D7004EA53D7BE9BD9195D88CBEBCB3011945C4
          15E32DD4F5B95F283A3D710D514631C6CCE66887CEC8383E13B89B19C1BD9BE1
          BD2274C4BF033848433EE0F1AE9CF40C3F5F7A86D6AA453EC7745437B20D830B
          D71130462CADC4E1F333FFC5291485E907E708D0A1F43A78933F0194B6E19554
          4289AFEE4DCD3F9D610BFB5BC2A62C91AA61A0A1A1C94FB0D1B5D0EA429EC128
          1DF45DDC18D52652515D8253A959701756018A19F80B1A908E0EF42DB4F1C13F
          97E768B27E642A18C028E8CCE51B4677C86C7751DFC825162E7A6363E4DDCAB0
          5885FEC33C380F73088A6956E90E43666B965BBA73E36A3CFE18560EF6E81E00
          9150E8FD4FB1419ED9E1665DE726692849674614413CABD4A14FAAC109F510A0
          B60FA5C814BC8C7D0F8B5F7C76FDF9B3C764B59883AC2CCA120A7F78AB696032
          EAEB889CD78265B2389CCAE7423A839346592ED0007A22503ED880AD16D9BB3A
          D81F5D5A8CE1D45185E4758DCA28F4C14D833FC49B6DD4D513D4BA4F478F067E
          78341B3459A1C7EA04973B00B09F80F2FE12EC7CF9F9446A33E158DF5EE7761B
          3554A63A539B2768B28039C2AC4E37750586B42EBBBBD8FDEBEF89CEBAD86893
          65069C261C4D7F1CCA49AF3DBBA9659CAD96B8B222D286A648F40D48FF9830C2
          0BCCD2764273787CD4E5E940EDB61664C518A05E638D428E15F3BBA8FCBACA57
          1511445551B463129BD3BC8AC105E178C60B0235F32666250404C419CC2AA048
          126BC8229274D5F8D63A7D236EEAFE06733F9CD2B2C034A70000000049454E44
          AE426082}
        ShowHint = True
      end
      object LbValueDappers: TLabel
        Left = 100
        Top = 4
        Width = 90
        Height = 17
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object CmbChest: TComboBox
        Left = 0
        Top = 24
        Width = 344
        Height = 28
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 0
        OnChange = TabChestChange
      end
    end
  end
  object PnFilter: TPanel
    Left = 0
    Top = 0
    Width = 365
    Height = 386
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
  end
  object PopupWatch: TPopupMenu
    Left = 297
    Top = 58
    object MenuEdit: TMenuItem
      Caption = 'Modifier'
      OnClick = MenuGuardClick
    end
    object MenuGuard: TMenuItem
      Caption = 'Surveiller'
      OnClick = MenuGuardClick
    end
    object MenuCopy: TMenuItem
      Caption = 'Copier'
      OnClick = MenuCopyClick
    end
  end
end
