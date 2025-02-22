object FormFilter: TFormFilter
  Left = 580
  Top = 112
  Width = 508
  Height = 775
  ActiveControl = PnTitle
  Caption = 'Filtre'
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 360
    Height = 736
    ActivePage = TabInfo
    Align = alLeft
    MultiLine = True
    TabOrder = 0
    TabStop = False
    OnChange = PageControlChange
    object TabInfo: TTabSheet
      Caption = 'Informations'
      ImageIndex = 1
      DesignSize = (
        352
        701)
      object PnTitle: TPanel
        Left = 0
        Top = 1
        Width = 352
        Height = 26
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        BorderWidth = 5
        BorderStyle = bsSingle
        Caption = 'Fragment de Carapace Supr'#234'me/Kidinak des Primes Racines'
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = True
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
      object PnInfo: TPanel
        Left = 0
        Top = 29
        Width = 352
        Height = 209
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Constraints.MinHeight = 53
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          352
          209)
        object LbQuality: TLabel
          Left = 5
          Top = 25
          Width = 55
          Height = 20
          Caption = 'Qualit'#233' :'
        end
        object LbVolume: TLabel
          Left = 5
          Top = 85
          Width = 57
          Height = 20
          Caption = 'Volume :'
        end
        object LbCraft: TLabel
          Left = 5
          Top = 125
          Width = 66
          Height = 20
          Caption = 'Artisanat :'
        end
        object ImgItem: TItemImage
          Left = 305
          Top = 7
          Width = 40
          Height = 40
          ShowHint = True
          StickerPosX = 0
          StickerPosY = 0
        end
        object LbValueQuality: TLabel
          Left = 101
          Top = 25
          Width = 27
          Height = 20
          Caption = '250'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueVolume: TLabel
          Left = 101
          Top = 85
          Width = 31
          Height = 20
          Caption = '10.5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueCraft: TLabel
          Left = 101
          Top = 125
          Width = 91
          Height = 20
          Caption = 'Lame, Pointe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbClass: TLabel
          Left = 5
          Top = 45
          Width = 48
          Height = 20
          Caption = 'Classe :'
        end
        object LbValueClass: TLabel
          Left = 101
          Top = 45
          Width = 62
          Height = 20
          Caption = 'Excellent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbDura: TLabel
          Left = 5
          Top = 105
          Width = 73
          Height = 20
          Caption = 'Durabilit'#233' :'
        end
        object LbValueDura: TLabel
          Left = 101
          Top = 105
          Width = 61
          Height = 20
          Caption = '156/220'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ImgSkin1: TImage
          Left = 308
          Top = 50
          Width = 10
          Height = 10
          Anchors = [akTop, akRight]
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000A00
            00000A08060000008D32CFBD0000000774494D4507DA051800251A37AD4C7400
            0000097048597300000AF000000AF00142AC34980000000467414D410000B18F
            0BFC6105000001694944415478DA63644003738AA5635FBEFEF6B37AD1FB55C8
            E28CC81C7B350691AEB6B005FFFEFCFAB568CA86E4E94718DE6328AC0F656063
            E3940B8BCD0A9FC1CCC4F477EBE255C9FF8FDDDF987E96E1375861B3277791A1
            91AC362B0F9BACB28CB0A1A2859D08C33FD6FF4F2E9D7B75EBD6F38B9F9EBF7F
            72E5CAC38B8C956E9C6D51FE5AE93A96DA42600BFE333130FC05D2FF80F8C75F
            861BA7AFBCD971E2F25490D54C19E6CC81995E525374F445259858400AFF33FC
            FBF5E7FFCDCB6F9EEDBAF922A360E5DFAD60375AA933F0961BB02FF4B0160C64
            E3616760F8FD8FE1F77F86FF078EBE59D9BDEB7BCAEE970C5FC10AF3ED190442
            24D8369AA9F1D9DD7DF5F327F3DFFF8C4AF25C6CA7AE7DDEDDBCF37BC88E770C
            9FC00AA77B33486BB2B26F79FE83E9DDC1173F17A9C83130EB7371C4FDFDF497
            EBE0A39FBEED57185E8215F6C73308BC7CC51073EB39C3CE7517186E8342A3CC
            8B41E3FB370627866F0C8B279F62F804006CBD93AD796C62D70000000049454E
            44AE426082}
          ShowHint = True
        end
        object ImgSkin2: TImage
          Left = 320
          Top = 50
          Width = 10
          Height = 10
          Anchors = [akTop, akRight]
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000A00
            00000A08060000008D32CFBD0000000774494D4507DA051800251A37AD4C7400
            0000097048597300000AF000000AF00142AC34980000000467414D410000B18F
            0BFC6105000001694944415478DA63644003738AA5635FBEFEF6B37AD1FB55C8
            E28CC81C7B350691AEB6B005FFFEFCFAB568CA86E4E94718DE6328AC0F656063
            E3940B8BCD0A9FC1CCC4F477EBE255C9FF8FDDDF987E96E1375861B3277791A1
            91AC362B0F9BACB28CB0A1A2859D08C33FD6FF4F2E9D7B75EBD6F38B9F9EBF7F
            72E5CAC38B8C956E9C6D51FE5AE93A96DA42600BFE333130FC05D2FF80F8C75F
            861BA7AFBCD971E2F25490D54C19E6CC81995E525374F445259858400AFF33FC
            FBF5E7FFCDCB6F9EEDBAF922A360E5DFAD60375AA933F0961BB02FF4B0160C64
            E3616760F8FD8FE1F77F86FF078EBE59D9BDEB7BCAEE970C5FC10AF3ED190442
            24D8369AA9F1D9DD7DF5F327F3DFFF8C4AF25C6CA7AE7DDEDDBCF37BC88E770C
            9FC00AA77B33486BB2B26F79FE83E9DDC1173F17A9C83130EB7371C4FDFDF497
            EBE0A39FBEED57185E8215F6C73308BC7CC51073EB39C3CE7517186E8342A3CC
            8B41E3FB370627866F0C8B279F62F804006CBD93AD796C62D70000000049454E
            44AE426082}
          ShowHint = True
        end
        object ImgSkin3: TImage
          Left = 332
          Top = 50
          Width = 10
          Height = 10
          Anchors = [akTop, akRight]
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000A00
            00000A08060000008D32CFBD0000000774494D4507DA051800251A37AD4C7400
            0000097048597300000AF000000AF00142AC34980000000467414D410000B18F
            0BFC6105000001694944415478DA63644003738AA5635FBEFEF6B37AD1FB55C8
            E28CC81C7B350691AEB6B005FFFEFCFAB568CA86E4E94718DE6328AC0F656063
            E3940B8BCD0A9FC1CCC4F477EBE255C9FF8FDDDF987E96E1375861B3277791A1
            91AC362B0F9BACB28CB0A1A2859D08C33FD6FF4F2E9D7B75EBD6F38B9F9EBF7F
            72E5CAC38B8C956E9C6D51FE5AE93A96DA42600BFE333130FC05D2FF80F8C75F
            861BA7AFBCD971E2F25490D54C19E6CC81995E525374F445259858400AFF33FC
            FBF5E7FFCDCB6F9EEDBAF922A360E5DFAD60375AA933F0961BB02FF4B0160C64
            E3616760F8FD8FE1F77F86FF078EBE59D9BDEB7BCAEE970C5FC10AF3ED190442
            24D8369AA9F1D9DD7DF5F327F3DFFF8C4AF25C6CA7AE7DDEDDBCF37BC88E770C
            9FC00AA77B33486BB2B26F79FE83E9DDC1173F17A9C83130EB7371C4FDFDF497
            EBE0A39FBEED57185E8215F6C73308BC7CC51073EB39C3CE7517186E8342A3CC
            8B41E3FB370627866F0C8B279F62F804006CBD93AD796C62D70000000049454E
            44AE426082}
          ShowHint = True
        end
        object LbColor: TLabel
          Left = 5
          Top = 165
          Width = 58
          Height = 20
          Caption = 'Couleur :'
        end
        object LbValueColor: TLabel
          Left = 101
          Top = 165
          Width = 45
          Height = 20
          Caption = 'Rouge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbRace: TLabel
          Left = 5
          Top = 145
          Width = 39
          Height = 20
          Caption = 'Race :'
        end
        object LbValueRace: TLabel
          Left = 101
          Top = 145
          Width = 110
          Height = 20
          Caption = 'Toutes les races'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbWeight: TLabel
          Left = 5
          Top = 65
          Width = 42
          Height = 20
          Caption = 'Poids :'
        end
        object LbValueWeight: TLabel
          Left = 101
          Top = 65
          Width = 54
          Height = 20
          Caption = '10.5 Kg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbEcosys: TLabel
          Left = 5
          Top = 5
          Width = 84
          Height = 20
          Caption = 'Ecosyst'#232'me :'
        end
        object LbValueEcosys: TLabel
          Left = 101
          Top = 5
          Width = 64
          Height = 20
          Caption = 'Commun'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbGuard: TLabel
          Left = 5
          Top = 185
          Width = 86
          Height = 20
          Caption = 'Surveillance :'
        end
        object LbValueGuard: TLabel
          Left = 101
          Top = 185
          Width = 27
          Height = 20
          Caption = '999'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object PnInfo2: TPanel
        Left = 0
        Top = 244
        Width = 352
        Height = 462
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 2
        DesignSize = (
          352
          462)
        object LbAutoSpeed: TLabel
          Left = 5
          Top = 18
          Width = 53
          Height = 20
          Caption = 'Vitesse :'
        end
        object LbValueSpeed: TLabel
          Left = 294
          Top = 18
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '250'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueDodge: TLabel
          Left = 294
          Top = 48
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoRange: TLabel
          Left = 5
          Top = 33
          Width = 49
          Height = 20
          Caption = 'Port'#233'e :'
        end
        object LbValueRange: TLabel
          Left = 294
          Top = 33
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueParry: TLabel
          Left = 294
          Top = 64
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueAdvDodge: TLabel
          Left = 294
          Top = 80
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueAdvParry: TLabel
          Left = 294
          Top = 96
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoSlashingProt: TLabel
          Left = 5
          Top = 128
          Width = 177
          Height = 20
          Caption = 'Protect. max/cp tranchant :'
        end
        object LbValueSlashingProt: TLabel
          Left = 294
          Top = 128
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoSmashingProt: TLabel
          Left = 5
          Top = 144
          Width = 191
          Height = 20
          Caption = 'Protect. max/cp contondant :'
        end
        object LbValueSmashingProt: TLabel
          Left = 294
          Top = 144
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoPiercingProt: TLabel
          Left = 5
          Top = 160
          Width = 177
          Height = 20
          Caption = 'Protect. max/cp perforant :'
        end
        object LbValuePiercingProt: TLabel
          Left = 294
          Top = 160
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ImgHpb: TImage
          Left = 18
          Top = 431
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909360AF85CA41700000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A54944415478DAB596FF4B137118C73FE7DDCE69F376DB2C6CED5CCD885891
            4DA96C8EC42031CAA0D23283CA0A11FA35F087FE02FB358A0882FA218A8A8A64
            563F848DCE6A5138BFCCA810F56643AECE36F7CD6DDEAEE7DA69A3B672421F78
            F3D9E7793E3CAFE7F33C779F1B86FEF3C0F2D97CA6AB4BDE8F8348499270C52C
            62189690E7EBDDDDD2B2014AF042502904671291082DDB09B55A28C0F1498008
            00985F162023B811826F8F8E7FB6170778266C5A1F975485432534FD0C00A300
            882D1740C0540672240233FB77BD7B5C331411698ED9348D33154FB57AFD5D38
            C5F0B2004AF61A902D1C08B4967A5E34D47E1F63DCB3A2E851E93DC603ADB7D4
            45454E004CE55DA28CD230A006A3DB79F454E8B3CD1D12350008038035379FB8
            A622C917E00FE4D5E4CCBA83EC2BBDFD4DFB046FAD31112D0300AE005C96A3ED
            57217B17040F658BF33740BAEEA99443F48F371D537DB5EF31E98D1F1EF69223
            51118D84C5F02841B1F489CE6BB02FBF1364D63D159C69B54C0E345CA866E432
            9100400A20365AB0C2439F3A770BEC4ED0D27BA0646F4ACECD354A832FDB6E3A
            CC3619E89EF882A88141748797DF2B247A13055344EB59273CA632C40380E83F
            0119D95745FDBE369BEF7DE37987750DACF1DF006824260503F54D7D16AB552E
            139BAD0FD9003FB3073532ECA3B69386B8CDBC63A726E4E7D0D49B7EF4294AA0
            117EB112E1DB3A0BBBF3704BCE3E640314C3B435297C3D7EDADBB36F6BD50613
            652CC7BFBC61D1ACDF87581E437C341D63553116BB1CA73DDBDA3B72F6211BA0
            0426476CEC6347D7A79E7ABDD9A8A5CACBD12CC7FD01D8BDB6506C1F8A4F55B6
            7738299D2E6B1F7201EA4ABDAF3BDBB8FE3A42256A32FD0F267EFDDEBC8A4017
            C7E783D481237DA675EBB2F62127A060F85DE7B681BEBA7942D218D4E99B5998
            1311974CEF731848C4C54474693A15A6EDBB5DD6EAEAAB60762D15E00871131D
            BAA7F7EA4D644A6B20D3DB8484842218B608608504BA226041FBC1E6BE35799C
            406E726524143A463DBBBF9709F3E5B02617FC326021F8644C4AB8483D577BA8
            E50945D3B7C13DB8941E2C5ECD00D9BFB1F7460D1E8B966DA008B581C4F13939
            4D253822703F4BAF7DD5D0DCDC239B41D34B798A322FB9ED333CBF6BF2F993CD
            8501DE0C6B6D308EE1B31212258AFEA6B354B82B6B6A7AE1BA7E0D3E3F28FECF
            F7E0374829C802B202688BC0F3AB93F1B80A3E30C9129DCE07657905BEB7B982
            E7046440E4C7A70864504EA4556C222800F281BEE50AFE57401610A9CC0B4386
            E4FC37B1307E008EE2D7280B2D36670000000049454E44AE426082}
          ShowHint = True
        end
        object ImgFob: TImage
          Left = 277
          Top = 431
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909380F16B57D1600000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A64944415478DAB596DB4F134114C6673BED02D2EE6EA122D6B65EAA11888A
            48D45A1B41A22D22A85111C5471363F40F3026BE1B9F7DD098F842424C7C3046
            53AF51A856085EA978C3884A6991545ABBBDD06EE9BA9EAD5B524D5729899B7C
            99EDCCD9F33BF39DEDB404FACF175148F0919327C5780C220541C0D2344F1044
            4A1C2F9D3D2BCC1920252F02E920B931914C32E27C914A1554603C0A902000D2
            7302E424D743F20DA3C1B035A4208D2694E24805F14A43D37700F0160089B902
            943054826C6C3CDEDA5BB1D202F7CC92578F268C94E63653A6BD02BB189A1340
            AA5E0DAA8B4622079F2F5861F7AD6E30A62E9FE729DFFBC196FADAEEE2921227
            007C055B94638D11647F98263BBCD63D752210003100B8776F5A7F514592BD30
            172EA8C9B9BE83AC2F7955DB48B575739259205A8525806BAFCD7201AA7741F2
            68BE3C7F03647CFF2108363F3BD536B5659775FEA66DFA9B4FFB49FEF35BC40F
            BF8B958E8FB83BD6565D84B8C27690EB3B9B4C1DFCA0D4D9CD274E8936910040
            122051E2FF3878A8AEBA1BE69DA0D9F740AADEC0715CF388B2ACB3F2F8E98CEF
            FE17FDC8C3A32C80578C0EFBF6AD3038350C2342060130F54F404EF5EB26426C
            27DBB8B719AC5924FAFE0700095FDEB38D6A658FB9A65AB4C99DAF0F845CF5A0
            E6FB04DD293475D659979BD45E368A1E7FF2A1A2F057C40D3DC886C70CF79D6E
            474BB36C1FF201E6C1B036144F1CEEB51ED85953B5CA6062289C0528BD1E941E
            7DFDEB61AA22A1B9DE35D8EED82EDB877C000D0CB6CFDFC2475D6D27B6EA355A
            DA544E216F3082C6D808223CF790100964628B5637F1DC99E3BEF6A64627A5D5
            E6ED831CA0C143941E7BB9714F03FF03AB7F7B400240F5086B2B50BAFB1CEB58
            66EC312C5D9AB70FB28037B1C4B101FDF2064CD26A4C9567D6F84810A1C9AF99
            7B5C61407CC087F82B5D318B59EFAAA9AFBF00D3AED9026CFE6FC1A377CC6BB6
            A2789AC65A09F03D88309F9A01A43C03085DED621D2D8E9E4505EC406C726D3C
            1A3D74772ABD23A4D699E033995D57965233D5A73D03297AE899D7DEDA728B62
            98CBB0EC994D0F668E6680B45EC38C2529A04A82D215C34E3056E04CE542C097
            C20A625C3FECE9B3EFDF7F43AC1E34319BB728F790DB100A04B63C72F7AD0A21
            B41831E5348A8731F2FB794AA99C3498CD03B516CB4D38AEFB21761CC4FDF37B
            F00744075A06AA01D09A6020B0709AE3547459D9B446AB1D035BFA60ED895C72
            59400E44FC612F01954B3BA2A5393830501834069A944BFE57401E10298DD94B
            84C8FE9BC85E3F01984BCA284B4581840000000049454E44AE426082}
          ShowHint = True
        end
        object ImgStb: TImage
          Left = 189
          Top = 431
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35323A3339202B3031
            3030E412D5570000000774494D4507D90A1909351ACEC6E7B000000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03B54944415478DAB596EF4F526114C7CFE522A25DE1822E412105ABA56BA156
            4668596D19A5AE376666ADD68F315B2FDA7A917F436BBDA937D6E6EA8DABF563
            737364AD96B128A335C252C97EACCC6B3A52E397FCEC42E712386A50E2D6C3BE
            7B78CE79763EE739E7721F08F8CF83C864F3F1CE4E6E3F891244A351326E6609
            82087173F7B973D12503E2C1B35105185C199A0FD09C9D2FCC9AE591E4384266
            11F0634980A4E04518BCC6F7DEA9CB750894DE95A1206413AF295A7C1F01A308
            F02F15C0C74986AA0BCCCD376DEE556BF13BDD5FF17C3ABB8CBA27964A6FE229
            DE2C0910CF9E4255799DEEB60D2655C39EF7B5CA8B6C373B94FFCEA66AD3F408
            73728C0860322E51526994A886E546DEFE43F6A62A0E88002F02CCAB0F6FBC92
            25103C469B33A32627D71DA5933CE535EB4736D6CADD85324BD44A5A22AF3880
            A9FCA8B60BB33761704FAA387F03FCAA7B04EAE093BF79ED7091EE74A5A1E8D5
            2DBB60383A0AC311BBD72EFE682EEC587305F7657682E4BAC35CB86D952DBFE1
            6CD949AE4C0204401CE0B7531F6C85A7CA7BD06E442DBE07F1EC15E14050CF7F
            E26BEFC86DADDAA0A8A65E3256200773120076841C63A8130A631E4D73101B02
            7CFF0424655FED9B70B5D7584BF5589A625C935D4FBA61D3B40E6EB077627B87
            E1AD2BD0CC1F505794736532A7EA432A402C7B945ED9BBACFD48B8B9AA644709
            E5F9EC06E6E124D8791FC01A194B6CF7F6AA8DE6CDFBF469FB900A908B5365F8
            9BFFE0B1BEBD8D951AB542542A26271F30E01EF7FC06904381FFBCE4926DA7A1
            356D1F5201F270AAF38F7D3774F69DD82E5508C5091F07780416988299D8BA91
            D4B147D9338CC6B0CD28924852F6211DA0BE6050D8D1FEB4B19ECF86A9647F4F
            2CD158F620E7E5C38548974BD4AA1C50A85429FB9016002FFD1D9A8195F552A0
            289A10C57C9F5806BEE0871B9BC86A60A2537019AE7AE91D45A68AF5EBBBD06C
            5A2CA0CEFD79D6B0E5D6BAED4424B250222778C00DDFA19827070521070B6B85
            CBBC6E97AE65D740710627E09AAC99F7780EE4DEFEB15BE550AEC0B560A10F08
            48646F89584326A9F94BEDBE3DFD229ABE8EEEA1C5F460E1D58C90A635D7645A
            D247C854BC6221968A0C402096390353212089AFE652CBB38696963E2E7BD4F4
            629EA2E4975CCD9CC3B175BC7F646DB6835F826BB18B70929330C9E225332329
            9359345AED5D7C5D0FA2EF2B2AF8CFDFC11F9002941A5581A075B30E873C1C0C
            66E10513CE934826B02CCFD0F7225DF0B480240877B1E7A0F2E32712C76D6CAC
            E70013A89974C1FF0A480112C4E7C4E02069FF4D24C64FC286BB2845B614E500
            00000049454E44AE426082}
          ShowHint = True
        end
        object ImgSab: TImage
          Left = 106
          Top = 431
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909371AFCF0853200000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A94944415478DAB5967D4813611CC79FF3DCF97ABB735ACDB94DCD5E60BD9A
            21638DCCA8692F12A5961A04518811FDDDBFF5677FF547FF84104420417F0562
            F6EA5CCD85BDB98A32492B4F2732B6B973AF77DB79FD6EDE62C5564EE8812FCF
            F63CBFFB7DBECFEFB77B1886FEF3C0B2093E77F9B2148F83085114717959C030
            8C97E65BD7AE89AB06C8C9F34065905C170985680995A7C8F7E6E0F83440BC00
            88AF0A90925C03C9EBA7D949938FF0EAF45C354760C40792A21F01E0330022AB
            05E4C2A40699D9B0EFE8F0D641237CA6AB866AE67545350F6995EA1E9CE2E3AA
            00B2FB62506D60D1DFF1D6E0B0CC36303AFE4648504E50CEC3DB3AFAF20B0A06
            00309B7589524AA303599E173E3DC51C9FAC9580000802C07EACEE4CAF822086
            61CD9F559353EB0E328DE5BF6E99327FDB135DB7A016DEC57061849700B613F5
            676F827B1B240FA4CBF33740A2EE4BE292D915986E618F074DAA036ACD90B38F
            10C60524388560D194D27E6A634F2FC4657782D4BAB3DC42C717E5678BEECA26
            A94C0400900C88144C16393B375DEC83F501D0CA7B20BBD7725CB4F92B39D1A5
            BAAAA99581280520E44CE4CCB6969F1F20695A82380110FE2720C5FDAE79BFAB
            CBD3EA6B86D254A0E5373801E0EFF28958F18BC8EE432DD61A83412A933D5D1F
            D20112EE41CDCF4A07BBC456ACD654BDA798596410E39F46EE2906715636191E
            D4F6AFB73735B767EC433A40214C3B7D11CFE9E193D623862D06AD9ED2E31260
            84798172C76328FE71B91258596E84BC433ADB0F7667EC433A000993F9FBC2D7
            6EDB255BA386D4507ABA32E17E0620D85008899EE51C798D94C05D6067DBF775
            0F284B4AD2F62113A0E13DF9A667EC98B34110E3C5BF3D2003C03DC2CB0914BF
            1E669BF427ADDAEAEAB47DC808F8C4BFEB19DD3CD28093A818A715893D7E3284
            10B31C47988A90E08A21E1463468ACDC6F33D4D5DD8465DB4A016697F747F7A3
            DDFD8D88E3A9E49EE807E78BE0BC9240788502F10E00F62EB14D87DAAC15599C
            406AF28E5020D0F938E7FE21DF9A39BD64F8D7030048BA8F3BC23C6557319623
            ED834A9ABE0BDBEF57D2835F5733408EDE5F7BDB18C5C2EADC0D85F9502A1C45
            51C2B9E88AF33886CF695E55392C6D6DFD927BD0FC4A7E45A9975CBDCFEDDEFB
            62FCC9569FC25709DF29E4E57014408212A33D5A75CDE80EA3F1015CD72F616F
            0EC4FDF33DF80352065A0F320068BBD7ED2E8F719C8252A9626449C90C94C501
            7BAF3225CF08488148D74301A8543E1125AF09203F6806E4C994FCAF80342042
            9E93438264FC37911C3F0106F0D0281230DB170000000049454E44AE426082}
          ShowHint = True
        end
        object LbValueHpb: TLabel
          Left = 46
          Top = 433
          Width = 27
          Height = 20
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueSab: TLabel
          Left = 134
          Top = 433
          Width = 27
          Height = 20
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueStb: TLabel
          Left = 217
          Top = 433
          Width = 27
          Height = 20
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueFob: TLabel
          Left = 305
          Top = 433
          Width = 27
          Height = 20
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoDodge: TLabel
          Left = 5
          Top = 49
          Width = 115
          Height = 20
          Caption = 'Modif. d'#39'Esquives'
        end
        object LbAutoParry: TLabel
          Left = 5
          Top = 64
          Width = 119
          Height = 20
          Caption = 'Modif. de Parades'
        end
        object LbAutoAdvDodge: TLabel
          Left = 5
          Top = 79
          Width = 177
          Height = 20
          Caption = 'Modif. Esquives Adversaire'
        end
        object LbAutoAdvParry: TLabel
          Left = 5
          Top = 94
          Width = 172
          Height = 20
          Caption = 'Modif. Parades Adversaire'
        end
        object LbAutoFactorProt: TLabel
          Left = 5
          Top = 112
          Width = 148
          Height = 20
          Caption = 'Facteur de protection :'
        end
        object LbValueFactorProt: TLabel
          Left = 294
          Top = 112
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoDmg: TLabel
          Left = 5
          Top = 3
          Width = 54
          Height = 20
          Caption = 'D'#233'g'#226'ts :'
        end
        object LbValueDmg: TLabel
          Left = 294
          Top = 3
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '250'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueProtect1: TLabel
          Left = 294
          Top = 231
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoProtect3: TLabel
          Left = 5
          Top = 263
          Width = 105
          Height = 20
          Caption = 'Ondes de choc :'
        end
        object LbValueProtect3: TLabel
          Left = 294
          Top = 263
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoProtect1: TLabel
          Left = 5
          Top = 229
          Width = 176
          Height = 20
          AutoSize = False
          Caption = 'Froid :'
        end
        object LbAutoProtect2: TLabel
          Left = 5
          Top = 247
          Width = 50
          Height = 20
          Caption = 'Poison :'
        end
        object LbValueProtect2: TLabel
          Left = 294
          Top = 247
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoResist1: TLabel
          Left = 5
          Top = 179
          Width = 50
          Height = 20
          Caption = 'D'#233'sert :'
        end
        object LbValueResist1: TLabel
          Left = 294
          Top = 179
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoResist2: TLabel
          Left = 5
          Top = 195
          Width = 41
          Height = 20
          Caption = 'For'#234't :'
        end
        object LbValueResist2: TLabel
          Left = 294
          Top = 195
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoResist3: TLabel
          Left = 5
          Top = 210
          Width = 35
          Height = 20
          Caption = 'Lacs :'
        end
        object LbValueResist3: TLabel
          Left = 294
          Top = 210
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoElementalSpeed: TLabel
          Left = 5
          Top = 284
          Width = 180
          Height = 20
          Caption = 'Vitesse magie destructrice :'
        end
        object LbValueElementalSpeed: TLabel
          Left = 294
          Top = 284
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoElementalPower: TLabel
          Left = 5
          Top = 300
          Width = 197
          Height = 20
          Caption = 'Puissance magie destructrice :'
        end
        object LbValueElementalPower: TLabel
          Left = 294
          Top = 300
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueHealPower: TLabel
          Left = 294
          Top = 371
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoDefensivePower: TLabel
          Left = 5
          Top = 403
          Width = 205
          Height = 20
          Caption = 'Puissance magie neutralisante :'
        end
        object LbValueDefensivePower: TLabel
          Left = 294
          Top = 403
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoHealPower: TLabel
          Left = 5
          Top = 369
          Width = 172
          Height = 20
          Caption = 'Puissance magie curative :'
        end
        object LbAutoDefensiveSpeed: TLabel
          Left = 5
          Top = 387
          Width = 188
          Height = 20
          Caption = 'Vitesse magie neutralisante :'
        end
        object LbValueDefensiveSpeed: TLabel
          Left = 294
          Top = 387
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoOffensiveSpeed: TLabel
          Left = 5
          Top = 319
          Width = 175
          Height = 20
          Caption = 'Vitesse magie d'#233'bilitante :'
        end
        object LbValueOffensiveSpeed: TLabel
          Left = 294
          Top = 319
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoOffensivePower: TLabel
          Left = 5
          Top = 335
          Width = 192
          Height = 20
          Caption = 'Puissance magie d'#233'bilitante :'
        end
        object LbValueOffensivePower: TLabel
          Left = 294
          Top = 335
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbAutoHealSpeed: TLabel
          Left = 5
          Top = 350
          Width = 155
          Height = 20
          Caption = 'Vitesse magie curative :'
        end
        object LbValueHealSpeed: TLabel
          Left = 294
          Top = 350
          Width = 50
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object TabFilter: TTabSheet
      Caption = 'Filtre'
      DesignSize = (
        352
        701)
      object GbSorting: TGroupBox
        Left = 0
        Top = -4
        Width = 352
        Height = 53
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Tri'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        DesignSize = (
          352
          53)
        object EdSorting: TComboBox
          Left = 5
          Top = 20
          Width = 340
          Height = 28
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Type'
          Items.Strings = (
            'Type'
            'Ecosyst'#232'me'
            'Classe'
            'Qualit'#233
            'Volume'
            'Quantit'#233
            'Prix'
            'Temps')
        end
      end
      object GbType: TGroupBox
        Left = 0
        Top = 49
        Width = 173
        Height = 134
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object CbTypeMat: TCheckBox
          Left = 5
          Top = 21
          Width = 125
          Height = 17
          Caption = 'Mati'#232'res'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CbTypeMatClick
        end
        object CbTypeCata: TCheckBox
          Left = 5
          Top = 57
          Width = 125
          Height = 17
          Caption = 'Cristaux'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CbTypeOthers: TCheckBox
          Left = 5
          Top = 93
          Width = 125
          Height = 17
          Caption = 'Autres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CbTypeEquipment: TCheckBox
          Left = 5
          Top = 39
          Width = 125
          Height = 17
          Caption = 'Equipement'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = CbTypeMatClick
        end
        object CbTypeTeleporter: TCheckBox
          Left = 5
          Top = 75
          Width = 125
          Height = 17
          Caption = 'T'#233'l'#233'porteurs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
      end
      object GbEcosys: TGroupBox
        Left = 179
        Top = 49
        Width = 173
        Height = 134
        Caption = 'Ecosyst'#232'me'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object CbEcoPrime: TCheckBox
          Left = 5
          Top = 39
          Width = 125
          Height = 17
          Caption = 'Primes racines'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CbEcoCommon: TCheckBox
          Left = 5
          Top = 21
          Width = 125
          Height = 17
          Caption = 'Commun'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CbEcoDesert: TCheckBox
          Left = 5
          Top = 75
          Width = 125
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'D'#233'sert'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
        end
        object CbEcoForest: TCheckBox
          Left = 5
          Top = 57
          Width = 125
          Height = 17
          Caption = 'For'#234't'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object CbEcoLakes: TCheckBox
          Left = 5
          Top = 93
          Width = 125
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Lacs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 4
        end
        object CbEcoJungle: TCheckBox
          Left = 5
          Top = 111
          Width = 125
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Jungle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 5
        end
      end
      object BtDefault: TSevenButton
        Left = 134
        Top = 643
        Width = 105
        Height = 23
        Caption = 'D'#233'faut'
        TabOrder = 10
        OnClick = BtDefaultClick
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
      object BtOK: TSevenButton
        Left = 244
        Top = 643
        Width = 105
        Height = 23
        Caption = 'Appliquer'
        TabOrder = 11
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
        Default = True
        Spacing = 5
        Marging = 5
      end
      object GbClass: TGroupBox
        Left = 0
        Top = 183
        Width = 352
        Height = 52
        Caption = 'Classe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object LbClassMin: TLabel
          Left = 5
          Top = 23
          Width = 32
          Height = 20
          Caption = 'Min :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LbClassMax: TLabel
          Left = 184
          Top = 23
          Width = 35
          Height = 20
          Caption = 'Max :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object EdClassMin: TComboBox
          Left = 45
          Top = 19
          Width = 120
          Height = 28
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Base'
          Items.Strings = (
            'Base'
            'Fin'
            'Choix'
            'Excellent'
            'Supr'#234'me')
        end
        object EdClassMax: TComboBox
          Left = 224
          Top = 19
          Width = 120
          Height = 28
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 4
          ParentFont = False
          TabOrder = 1
          Text = 'Supr'#234'me'
          Items.Strings = (
            'Base'
            'Fin'
            'Choix'
            'Excellent'
            'Supr'#234'me')
        end
      end
      object GbQuality: TGroupBox
        Left = 0
        Top = 235
        Width = 352
        Height = 52
        Caption = 'Qualit'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object LbQualityMin: TLabel
          Left = 5
          Top = 23
          Width = 32
          Height = 20
          Caption = 'Min :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LbQualityMax: TLabel
          Left = 184
          Top = 23
          Width = 35
          Height = 20
          Caption = 'Max :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object EdQualityMin: TSpinEdit
          Left = 45
          Top = 20
          Width = 120
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 270
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 250
        end
        object EdQualityMax: TSpinEdit
          Left = 224
          Top = 20
          Width = 120
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 300
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 250
        end
      end
      object GbQuantity: TGroupBox
        Left = -1
        Top = 287
        Width = 352
        Height = 52
        Caption = 'Quantit'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        object LbQuantityMin: TLabel
          Left = 5
          Top = 23
          Width = 32
          Height = 20
          Caption = 'Min :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LbQuantityMax: TLabel
          Left = 185
          Top = 23
          Width = 35
          Height = 20
          Caption = 'Max :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object EdQuantityMin: TSpinEdit
          Left = 45
          Top = 20
          Width = 120
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 999
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 250
        end
        object EdQuantityMax: TSpinEdit
          Left = 225
          Top = 20
          Width = 120
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 999
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 250
        end
      end
      object GbEquipment: TGroupBox
        Left = 0
        Top = 339
        Width = 352
        Height = 53
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Equipement'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        DesignSize = (
          352
          53)
        object EdEquipment: TComboBox
          Left = 5
          Top = 20
          Width = 340
          Height = 28
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Tout '#233'quipement'
          Items.Strings = (
            'Tout '#233'quipement'
            'Armures l'#233'g'#232'res'
            'Armures moyennes'
            'Armures lourdes'
            'Armes de m'#233'l'#233'e'
            'Armes de tir'
            'Amplificateurs'
            'Bijoux'
            'Boucliers'
            'Outils'
            'Autres')
        end
      end
      object GbCategory: TGroupBox
        Left = 0
        Top = 392
        Width = 352
        Height = 53
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Cat'#233'gorie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        DesignSize = (
          352
          53)
        object EdCategory: TComboBox
          Left = 5
          Top = 20
          Width = 340
          Height = 28
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Toute cat'#233'gorie'
          Items.Strings = (
            'Toute cat'#233'gorie'
            'Lame'
            'Pointe'
            'Marteau'
            'Contrepoids'
            'Fl'#232'che'
            'Balle de munitions'
            'Canon'
            'Carapace pour armures'
            'Cartouche de munitions'
            'Doublure'
            'Explosif'
            'Rembourrage'
            'Percuteur'
            'Fixation pour armures'
            'D'#233'tente'
            'Configuration des bijoux'
            'Prise'
            'V'#234'tements'
            'Bijou'
            'Concentration magique')
        end
      end
      object GbSales: TGroupBox
        Left = 0
        Top = 445
        Width = 352
        Height = 66
        Caption = 'Ventes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        object LbPriceMin: TLabel
          Left = 197
          Top = 13
          Width = 71
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Prix min'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LbPriceMax: TLabel
          Left = 274
          Top = 13
          Width = 71
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Prix max'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object EdContinent: TComboBox
          Left = 5
          Top = 33
          Width = 184
          Height = 28
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Atys'
          Items.Strings = (
            'Atys'
            'Fyros'
            'Zorai'
            'Tryker'
            'Matis')
        end
        object EdPriceMin: TSpinEdit
          Left = 197
          Top = 32
          Width = 71
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 0
        end
        object EdPriceMax: TSpinEdit
          Left = 274
          Top = 32
          Width = 71
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
        end
      end
      object GbBonus: TGroupBox
        Left = 0
        Top = 511
        Width = 352
        Height = 52
        Caption = 'Bonus'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        object ImgHpbF: TImage
          Left = 10
          Top = 22
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909360AF85CA41700000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A54944415478DAB596FF4B137118C73FE7DDCE69F376DB2C6CED5CCD885891
            4DA96C8EC42031CAA0D23283CA0A11FA35F087FE02FB358A0882FA218A8A8A64
            563F848DCE6A5138BFCCA810F56643AECE36F7CD6DDEAEE7DA69A3B672421F78
            F3D9E7793E3CAFE7F33C779F1B86FEF3C0F2D97CA6AB4BDE8F8348499270C52C
            62189690E7EBDDDDD2B2014AF042502904671291082DDB09B55A28C0F1498008
            00985F162023B811826F8F8E7FB6170778266C5A1F975485432534FD0C00A300
            882D1740C0540672240233FB77BD7B5C331411698ED9348D33154FB57AFD5D38
            C5F0B2004AF61A902D1C08B4967A5E34D47E1F63DCB3A2E851E93DC603ADB7D4
            45454E004CE55DA28CD230A006A3DB79F454E8B3CD1D12350008038035379FB8
            A622C917E00FE4D5E4CCBA83EC2BBDFD4DFB046FAD31112D0300AE005C96A3ED
            57217B17040F658BF33740BAEEA99443F48F371D537DB5EF31E98D1F1EF69223
            51118D84C5F02841B1F489CE6BB02FBF1364D63D159C69B54C0E345CA866E432
            9100400A20365AB0C2439F3A770BEC4ED0D27BA0646F4ACECD354A832FDB6E3A
            CC3619E89EF882A88141748797DF2B247A13055344EB59273CA632C40380E83F
            0119D95745FDBE369BEF7DE37987750DACF1DF006824260503F54D7D16AB552E
            139BAD0FD9003FB3073532ECA3B69386B8CDBC63A726E4E7D0D49B7EF4294AA0
            117EB112E1DB3A0BBBF3704BCE3E640314C3B435297C3D7EDADBB36F6BD50613
            652CC7BFBC61D1ACDF87581E437C341D63553116BB1CA73DDBDA3B72F6211BA0
            0426476CEC6347D7A79E7ABDD9A8A5CACBD12CC7FD01D8BDB6506C1F8A4F55B6
            7738299D2E6B1F7201EA4ABDAF3BDBB8FE3A42256A32FD0F267EFDDEBC8A4017
            C7E783D481237DA675EBB2F62127A060F85DE7B681BEBA7942D218D4E99B5998
            1311974CEF731848C4C54474693A15A6EDBB5DD6EAEAAB60762D15E00871131D
            BAA7F7EA4D644A6B20D3DB8484842218B608608504BA226041FBC1E6BE35799C
            406E726524143A463DBBBF9709F3E5B02617FC326021F8644C4AB8483D577BA8
            E50945D3B7C13DB8941E2C5ECD00D9BFB1F7460D1E8B966DA008B581C4F13939
            4D253822703F4BAF7DD5D0DCDC239B41D34B798A322FB9ED333CBF6BF2F993CD
            8501DE0C6B6D308EE1B31212258AFEA6B354B82B6B6A7AE1BA7E0D3E3F28FECF
            F7E0374829C802B202688BC0F3AB93F1B80A3E30C9129DCE07657905BEB7B982
            E7046440E4C7A70864504EA4556C222800F281BEE50AFE57401610A9CC0B4386
            E4FC37B1307E008EE2D7280B2D36670000000049454E44AE426082}
          ShowHint = True
        end
        object ImgSabF: TImage
          Left = 100
          Top = 22
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909371AFCF0853200000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A94944415478DAB5967D4813611CC79FF3DCF97ABB735ACDB94DCD5E60BD9A
            21638DCCA8692F12A5961A04518811FDDDBFF5677FF547FF84104420417F0562
            F6EA5CCD85BDB98A32492B4F2732B6B973AF77DB79FD6EDE62C5564EE8812FCF
            F63CBFFB7DBECFEFB77B1886FEF3C0B2093E77F9B2148F83085114717959C030
            8C97E65BD7AE89AB06C8C9F34065905C170985680995A7C8F7E6E0F83440BC00
            88AF0A90925C03C9EBA7D949938FF0EAF45C354760C40792A21F01E0330022AB
            05E4C2A40699D9B0EFE8F0D641237CA6AB866AE67545350F6995EA1E9CE2E3AA
            00B2FB62506D60D1DFF1D6E0B0CC36303AFE4648504E50CEC3DB3AFAF20B0A06
            00309B7589524AA303599E173E3DC51C9FAC9580000802C07EACEE4CAF822086
            61CD9F559353EB0E328DE5BF6E99327FDB135DB7A016DEC57061849700B613F5
            676F827B1B240FA4CBF33740A2EE4BE292D915986E618F074DAA036ACD90B38F
            10C60524388560D194D27E6A634F2FC4657782D4BAB3DC42C717E5678BEECA26
            A94C0400900C88144C16393B375DEC83F501D0CA7B20BBD7725CB4F92B39D1A5
            BAAAA99581280520E44CE4CCB6969F1F20695A82380110FE2720C5FDAE79BFAB
            CBD3EA6B86D254A0E5373801E0EFF28958F18BC8EE432DD61A83412A933D5D1F
            D20112EE41CDCF4A07BBC456ACD654BDA798596410E39F46EE2906715636191E
            D4F6AFB73735B767EC433A40214C3B7D11CFE9E193D623862D06AD9ED2E31260
            84798172C76328FE71B91258596E84BC433ADB0F7667EC433A000993F9FBC2D7
            6EDB255BA386D4507ABA32E17E0620D85008899EE51C798D94C05D6067DBF775
            0F284B4AD2F62113A0E13DF9A667EC98B34110E3C5BF3D2003C03DC2CB0914BF
            1E669BF427ADDAEAEAB47DC808F8C4BFEB19DD3CD28093A818A715893D7E3284
            10B31C47988A90E08A21E1463468ACDC6F33D4D5DD8465DB4A016697F747F7A3
            DDFD8D88E3A9E49EE807E78BE0BC9240788502F10E00F62EB14D87DAAC15599C
            406AF28E5020D0F938E7FE21DF9A39BD64F8D7030048BA8F3BC23C6557319623
            ED834A9ABE0BDBEF57D2835F5733408EDE5F7BDB18C5C2EADC0D85F9502A1C45
            51C2B9E88AF33886CF695E55392C6D6DFD927BD0FC4A7E45A9975CBDCFEDDEFB
            62FCC9569FC25709DF29E4E57014408212A33D5A75CDE80EA3F1015CD72F616F
            0EC4FDF33DF80352065A0F320068BBD7ED2E8F719C8252A9626449C90C94C501
            7BAF3225CF08488148D74301A8543E1125AF09203F6806E4C994FCAF80342042
            9E93438264FC37911C3F0106F0D0281230DB170000000049454E44AE426082}
          ShowHint = True
        end
        object ImgStbF: TImage
          Left = 190
          Top = 22
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35323A3339202B3031
            3030E412D5570000000774494D4507D90A1909351ACEC6E7B000000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03B54944415478DAB596EF4F526114C7CFE522A25DE1822E412105ABA56BA156
            4668596D19A5AE376666ADD68F315B2FDA7A917F436BBDA937D6E6EA8DABF563
            737364AD96B128A335C252C97EACCC6B3A52E397FCEC42E712386A50E2D6C3BE
            7B78CE79763EE739E7721F08F8CF83C864F3F1CE4E6E3F891244A351326E6609
            82087173F7B973D12503E2C1B35105185C199A0FD09C9D2FCC9AE591E4384266
            11F0634980A4E04518BCC6F7DEA9CB750894DE95A1206413AF295A7C1F01A308
            F02F15C0C74986AA0BCCCD376DEE556BF13BDD5FF17C3ABB8CBA27964A6FE229
            DE2C0910CF9E4255799DEEB60D2655C39EF7B5CA8B6C373B94FFCEA66AD3F408
            73728C0860322E51526994A886E546DEFE43F6A62A0E88002F02CCAB0F6FBC92
            25103C469B33A32627D71DA5933CE535EB4736D6CADD85324BD44A5A22AF3880
            A9FCA8B60BB33761704FAA387F03FCAA7B04EAE093BF79ED7091EE74A5A1E8D5
            2DBB60383A0AC311BBD72EFE682EEC587305F7657682E4BAC35CB86D952DBFE1
            6CD949AE4C0204401CE0B7531F6C85A7CA7BD06E442DBE07F1EC15E14050CF7F
            E26BEFC86DADDAA0A8A65E3256200773120076841C63A8130A631E4D73101B02
            7CFF0424655FED9B70B5D7584BF5589A625C935D4FBA61D3B40E6EB077627B87
            E1AD2BD0CC1F505794736532A7EA432A402C7B945ED9BBACFD48B8B9AA644709
            E5F9EC06E6E124D8791FC01A194B6CF7F6AA8DE6CDFBF469FB900A908B5365F8
            9BFFE0B1BEBD8D951AB542542A26271F30E01EF7FC06904381FFBCE4926DA7A1
            356D1F5201F270AAF38F7D3774F69DD82E5508C5091F07780416988299D8BA91
            D4B147D9338CC6B0CD28924852F6211DA0BE6050D8D1FEB4B19ECF86A9647F4F
            2CD158F620E7E5C38548974BD4AA1C50A85429FB9016002FFD1D9A8195F552A0
            289A10C57C9F5806BEE0871B9BC86A60A2537019AE7AE91D45A68AF5EBBBD06C
            5A2CA0CEFD79D6B0E5D6BAED4424B250222778C00DDFA19827070521070B6B85
            CBBC6E97AE65D740710627E09AAC99F7780EE4DEFEB15BE550AEC0B560A10F08
            48646F89584326A9F94BEDBE3DFD229ABE8EEEA1C5F460E1D58C90A635D7645A
            D247C854BC6221968A0C402096390353212089AFE652CBB38696963E2E7BD4F4
            629EA2E4975CCD9CC3B175BC7F646DB6835F826BB18B70929330C9E225332329
            9359345AED5D7C5D0FA2EF2B2AF8CFDFC11F9002941A5581A075B30E873C1C0C
            66E10513CE934826B02CCFD0F7225DF0B480240877B1E7A0F2E32712C76D6CAC
            E70013A89974C1FF0A480112C4E7C4E02069FF4D24C64FC286BB2845B614E500
            00000049454E44AE426082}
          ShowHint = True
        end
        object ImgFobF: TImage
          Left = 280
          Top = 22
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002E744558744372656174696F6E2054696D
            650064696D2E203235206F63742E20323030392031303A35333A3334202B3031
            30306A07DFA90000000774494D4507D90A1909380F16B57D1600000009704859
            7300000AF000000AF00142AC34980000000467414D410000B18F0BFC61050000
            03A64944415478DAB596DB4F134114C6673BED02D2EE6EA122D6B65EAA11888A
            48D45A1B41A22D22A85111C5471363F40F3026BE1B9F7DD098F842424C7C3046
            53AF51A856085EA978C3884A6991545ABBBDD06EE9BA9EAD5B524D5729899B7C
            99EDCCD9F33BF39DEDB404FACF175148F0919327C5780C220541C0D2344F1044
            4A1C2F9D3D2BCC1920252F02E920B931914C32E27C914A1554603C0A902000D2
            7302E424D743F20DA3C1B035A4208D2694E24805F14A43D37700F0160089B902
            943054826C6C3CDEDA5BB1D202F7CC92578F268C94E63653A6BD02BB189A1340
            AA5E0DAA8B4622079F2F5861F7AD6E30A62E9FE729DFFBC196FADAEEE2921227
            007C055B94638D11647F98263BBCD63D752210003100B8776F5A7F514592BD30
            172EA8C9B9BE83AC2F7955DB48B575739259205A8525806BAFCD7201AA7741F2
            68BE3C7F03647CFF2108363F3BD536B5659775FEA66DFA9B4FFB49FEF35BC40F
            BF8B958E8FB83BD6565D84B8C27690EB3B9B4C1DFCA0D4D9CD274E8936910040
            122051E2FF3878A8AEBA1BE69DA0D9F740AADEC0715CF388B2ACB3F2F8E98CEF
            FE17FDC8C3A32C80578C0EFBF6AD3038350C2342060130F54F404EF5EB26426C
            27DBB8B719AC5924FAFE0700095FDEB38D6A658FB9A65AB4C99DAF0F845CF5A0
            E6FB04DD293475D659979BD45E368A1E7FF2A1A2F057C40D3DC886C70CF79D6E
            474BB36C1FF201E6C1B036144F1CEEB51ED85953B5CA6062289C0528BD1E941E
            7DFDEB61AA22A1B9DE35D8EED82EDB877C000D0CB6CFDFC2475D6D27B6EA355A
            DA544E216F3082C6D808223CF790100964628B5637F1DC99E3BEF6A64627A5D5
            E6ED831CA0C143941E7BB9714F03FF03AB7F7B400240F5086B2B50BAFB1CEB58
            66EC312C5D9AB70FB28037B1C4B101FDF2064CD26A4C9567D6F84810A1C9AF99
            7B5C61407CC087F82B5D318B59EFAAA9AFBF00D3AED9026CFE6FC1A377CC6BB6
            A2789AC65A09F03D88309F9A01A43C03085DED621D2D8E9E4505EC406C726D3C
            1A3D74772ABD23A4D699E033995D57965233D5A73D03297AE899D7DEDA728B62
            98CBB0EC994D0F668E6680B45EC38C2529A04A82D215C34E3056E04CE542C097
            C20A625C3FECE9B3EFDF7F43AC1E34319BB728F790DB100A04B63C72F7AD0A21
            B41831E5348A8731F2FB794AA99C3498CD03B516CB4D38AEFB21761CC4FDF37B
            F00744075A06AA01D09A6020B0709AE3547459D9B446AB1D035BFA60ED895C72
            59400E44FC612F01954B3BA2A5393830501834069A944BFE57401E10298DD94B
            84C8FE9BC85E3F01984BCA284B4581840000000049454E44AE426082}
          ShowHint = True
        end
        object CbHpb: TCheckBox
          Left = 40
          Top = 26
          Width = 13
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CbTypeMatClick
        end
        object CbSab: TCheckBox
          Left = 130
          Top = 26
          Width = 13
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = CbTypeMatClick
        end
        object CbStb: TCheckBox
          Left = 220
          Top = 26
          Width = 13
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = CbTypeMatClick
        end
        object CbFob: TCheckBox
          Left = 310
          Top = 26
          Width = 13
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = CbTypeMatClick
        end
      end
      object GbName: TGroupBox
        Left = 0
        Top = 563
        Width = 352
        Height = 72
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Nom'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        DesignSize = (
          352
          72)
        object EdName: TEdit
          Left = 5
          Top = 20
          Width = 340
          Height = 28
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RbAllWords: TRadioButton
          Left = 5
          Top = 50
          Width = 167
          Height = 17
          Caption = 'Tous les mots'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = True
        end
        object RbOneWord: TRadioButton
          Left = 178
          Top = 50
          Width = 167
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Un des mots'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object TabMaterial: TTabSheet
      Caption = 'Mati'#232're'
      ImageIndex = 2
      DesignSize = (
        352
        701)
      object PnCat1: TPanel
        Left = 0
        Top = 3
        Width = 352
        Height = 258
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          352
          258)
        object LbCat1Spec1: TLabel
          Left = 5
          Top = 31
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Durabilit'#233
        end
        object LbCat1Spec2: TLabel
          Left = 5
          Top = 51
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'L'#233'geret'#233
        end
        object LbCat1Spec3: TLabel
          Left = 5
          Top = 71
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Charge en s'#232've'
        end
        object LbCat1Spec4: TLabel
          Left = 5
          Top = 91
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'DMG'
        end
        object LbCat1Spec5: TLabel
          Left = 5
          Top = 111
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Vitesse'
        end
        object LbCat1Spec6: TLabel
          Left = 5
          Top = 131
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. d'#39'Esquives'
        end
        object LbCat1Spec7: TLabel
          Left = 5
          Top = 151
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. de Parades'
        end
        object LbCat1Spec8: TLabel
          Left = 5
          Top = 171
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. Esquives Adversaire'
        end
        object LbCat1Spec9: TLabel
          Left = 5
          Top = 191
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. Parades Adversaire'
        end
        object LbCat1Spec10: TLabel
          Left = 5
          Top = 211
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Temps restant'
        end
        object LbCat1Spec11: TLabel
          Left = 5
          Top = 231
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Temps restant'
        end
        object GaugeCat1Spec1: TGauge
          Left = 226
          Top = 37
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec2: TGauge
          Left = 226
          Top = 57
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec3: TGauge
          Left = 226
          Top = 77
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec4: TGauge
          Left = 226
          Top = 97
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec5: TGauge
          Left = 226
          Top = 117
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 50
          ShowText = False
        end
        object GaugeCat1Spec7: TGauge
          Left = 226
          Top = 157
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec6: TGauge
          Left = 226
          Top = 137
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec8: TGauge
          Left = 226
          Top = 177
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec10: TGauge
          Left = 226
          Top = 217
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec11: TGauge
          Left = 226
          Top = 237
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object GaugeCat1Spec9: TGauge
          Left = 226
          Top = 197
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          ForeColor = clWhite
          MaxValue = 60
          Progress = 30
          ShowText = False
        end
        object ImgCat1: TImage
          Left = 4
          Top = 5
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF800000006624B4744000000000000F943BB7F0000
            00097048597300000048000000480046C96B3E0000053E4944415478DA855569
            6C5455143E6F9F799D99B622942E81288240215D08680A5D6CAC82D808550CB1
            24262A49955AFC65FC63F8E31FA33F8C450B4612231150102255ABD2D6A2B204
            4AD18ADD9C4E3BD865F6A1B3BF65663CF74DDF385DC0D39CCC7DF79EFB9D73BE
            73CE2D651478482693004081C12040341A059AA6816C25920948261240511410
            2176FABA626B454D5151117477F7F4B85D4EBC6B8424FEC992040CC3403C1E07
            966581E259068C461162B128703C0F522CA63948203011024834F37B57C3EEBA
            83AFBFF29DCD66854F8F9D68B87CE9EAB7BA6322DA7D0C86E738A0B24423D014
            0DB22C412A0F48836980684CCD464F14C11F6F7C61D7B9BEDE6B2687731A0687
            6E770F0DD97663E48148249CCA9028DA0A06035016930901E35A4A44752AF468
            C95ACFA8AABA6AE7BEC6E74E5FECE9324E3BA6C1E3F683CB3D7383628413CF36
            EC8C5DF8A9AB6F78F8EFAB7AD61A4522F24E3E5455D54033A39F9332EED7D456
            BF1B97C36F0683018844255064150481C57A6C8BEC797EB7E8F5FA665A5ADEDA
            EBF3FA7ED09D50665316A88AB220FAFFC019DC4B3925C5B358CC5F723C5BCBB1
            742E3A66D6AE5D0DE5E5251008DC812D8F6C417BCEBF7FFFC14629267568F4DE
            979B03A16050E32DB363E6674002983D2B3518C5169EE737E72FCF5D9F936DA1
            130915CC16333CBC6635545655C2952BBDBF1E3DFAD93E49926E6B19E89D4340
            743A74FEF554498729B28C6B9AB364679759B22DFB18509B109C239989D82C85
            85F950BCA1180A0A0A92274F9D3F64B58EBE4F65190D1A10A941263DA9594815
            38451D68CD4064C9D23CD8B83AAFC5EB717FE08F242886A1B582E6649B21BF20
            1F36A0939E5FAE774C4E3A0E51069E4B17391DF5BCD6CC148E17A061FBA3AF55
            972DFDA8BDF3A6AB7F2C105213C907798E09093C6FCACEB140516101DC1AB05D
            BFE39F79873267893803F29CEE21852574EB85D71D67992D505F5BDEDC50FB40
            EB379D7FB82EF64D5F9B9C724868928734D1CB972FD98273C59A4CA23436EEB8
            341308BC478948518A5B6A4151F5CE216B2C2C6C2D5FD394C387DB285E707CFF
            9B6D20128EFC8EB6C3F812F8A2D1C866314B7C223F2FB714D3774C4C7A7A1459
            3942091C9B2EAA3E8158488D6FBDE02CCBC19355A50784B8F7F090DDEB1E73CA
            A3F8669D412A3B5986F947519430DA9A10E3E0AA55856FCFCC44069D4E4F077E
            1FA138869E334C3A1DA468A42E647F47CDA66683EA691D9EF07BC75DAA35140A
            1D170443BBAA2A4ECC4E9ABD23AC5859D4CBD0898730FA9F9195F3B8FFB9E620
            F3B5D40AC9614B2A3230E8A46E6B499399BED33638EEF18C3AE45B18F9398EE3
            CEA28D0BDF1E39A3FE4FAF5C59D01E0EC72E7B3CBE619C930F31B3FE740669FE
            91F3049907FC7DAA66D30163C27B78D0EEF5DADDF15BC160904CE75718C9049A
            2A996F16EA1BCB96DDBFD3E17091B32BC8C049642038C70179FDC8D0B1F8CC6E
            AF2C6B1693BED601BBC763F7C4FB8381E00534F91A2FDAF1A2BC4850CB70B916
            B51E1BE313A46E0CD7EAC20C90F3BACAB2A65C2ED8F697CDE51D998CFE8923FF
            231E9D45259794BB3D86281B5149B17B313BCD6E8E0392EADE67AA0FB051E7E1
            BE9169B7752A3A86E0E767C14751655844F4C6401171ADE23A6D9776C0E384BE
            FAE28EE675855C6BDB175D0EEB94341A0E87BBF1E8D42CB8342FDAC51C2C744E
            1C90C96D7EB9FEA58AF539C73E3EDE357163C43F140E85AE1270E4D34A5A5107
            D2BB2DF331BC1B78DA41796931EC796CC5D94B376CDB2EDE9C6AC76E99C4B3D3
            A8237AE48B453ABFBDEF91013A2959B76AD43E55E1F7F9F371BF633EF8FF5171
            4F071952320B3A8E1A5BAC98BACCFFBF7DB700FE05F75AC4B0D12A230A000000
            0049454E44AE426082}
          ShowHint = True
        end
        object LbCat1: TLabel
          Left = 32
          Top = 7
          Width = 59
          Height = 20
          Caption = 'Marteau'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object PnCat2: TPanel
        Left = 0
        Top = 268
        Width = 352
        Height = 253
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          352
          253)
        object LbCat2Spec1: TLabel
          Left = 5
          Top = 31
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Durabilit'#233
        end
        object LbCat2Spec2: TLabel
          Left = 5
          Top = 51
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'L'#233'geret'#233
        end
        object LbCat2Spec3: TLabel
          Left = 5
          Top = 71
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Charge en s'#232've'
        end
        object LbCat2Spec4: TLabel
          Left = 5
          Top = 91
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'DMG'
        end
        object LbCat2Spec5: TLabel
          Left = 5
          Top = 111
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Vitesse'
        end
        object LbCat2Spec6: TLabel
          Left = 5
          Top = 131
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. d'#39'Esquives'
        end
        object LbCat2Spec7: TLabel
          Left = 5
          Top = 151
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. de Parades'
        end
        object LbCat2Spec8: TLabel
          Left = 5
          Top = 171
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. Esquives Adversaire'
        end
        object LbCat2Spec9: TLabel
          Left = 5
          Top = 191
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Modif. Parades Adversaire'
        end
        object LbCat2Spec10: TLabel
          Left = 5
          Top = 211
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Temps restant'
        end
        object LbCat2Spec11: TLabel
          Left = 5
          Top = 231
          Width = 200
          Height = 19
          AutoSize = False
          Caption = 'Temps restant'
        end
        object GaugeCat2Spec1: TGauge
          Left = 226
          Top = 37
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec2: TGauge
          Left = 226
          Top = 57
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec3: TGauge
          Left = 226
          Top = 77
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec4: TGauge
          Left = 226
          Top = 97
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec5: TGauge
          Left = 226
          Top = 117
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 50
          ShowText = False
        end
        object GaugeCat2Spec7: TGauge
          Left = 226
          Top = 157
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec6: TGauge
          Left = 226
          Top = 137
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec8: TGauge
          Left = 226
          Top = 177
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec10: TGauge
          Left = 226
          Top = 217
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec11: TGauge
          Left = 226
          Top = 237
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object GaugeCat2Spec9: TGauge
          Left = 226
          Top = 197
          Width = 120
          Height = 9
          Anchors = [akTop, akRight]
          BackColor = 3158064
          Color = clBlack
          ForeColor = clWhite
          MaxValue = 60
          ParentColor = False
          Progress = 30
          ShowText = False
        end
        object ImgCat2: TImage
          Left = 4
          Top = 5
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF800000006624B4744000000000000F943BB7F0000
            00097048597300000048000000480046C96B3E000004704944415478DAA5966D
            4C5B6514C7CF6D2163039D6E25E01016314B0C898611EA1295C529266684C118
            4333109D7E31267E58A64667FCA61F4C7C4F245313B36C261A4322560D30748C
            4D2875611664B095B6636DB7BEDC5E6EDF5B4A7B1FFFB7BDED6E37DF564F38F4
            DEE739CFF9DDFF79CE735BAE54AB21D9743A1DEDEFE921CB92355C5F5F5FF6C5
            6747CB302CC119FD8B1D3FF11511C799FAFB7A1FC16D4ABD86CB01643BF6FAC1
            74321ED520187FDCCD9918CBAC942446A9B444C9D41A45E3AB148187E3098AC6
            12944CA6692D95A20D1515E9E33FFF56A2065476E9B7D991B642CEC2711A2621
            55F6BA500753FE83830889D28C346B6989C33583C9B2394C874F2D3A37AB010D
            883FF4E8AEC75E4826939C71F2D709841B316E93B3297A722808E4720BB9236F
            BE51357F61F1886168488E9FC6BA4B087461CAAC06D4C0FB0F1D7EE51D8BC5C2
            FDF483E12C027FC4D8020A967BFE1C8069B55A264969F6A0BE61F8B68A520A47
            D648588990CDE6781B2A6610EA46B4450D2881DFDDDED1694B24129AB1D11103
            009F23F9A42C58A580540593F675B484B66D2DA1056B80E62D02D9AD8E9751A5
            214406111C2BD864D90EBFFA5A2A1A8D6A8F0E7C3A08C08728C5D45F6C77DE9E
            ED7D9CEDD46FA6B133763299BD74D9EE7C09806FB06FE24D5D24DB93BBDBA478
            3CC64D8C8F7F8DDB4FE026F83AB81C98505A376F077B5BD9CE1D95343CBE44E7
            66338017313C08170A002D0F37B09AAA72D2E0763529510835E5853809628442
            A1280503A11684CDC3030580BE56D6A2D7D1C86900CC3EEC43E0F950303C8C29
            4F01A0B3AD913DD45C4D1BCBB5148BA7C8E989D3FC52902E3B45E27D410A88C1
            B7207D10D22FAA01FD0776B11D0FDC4113D30E3A37C7932088CF01701253EE02
            C0539D4DACBBFD7EAAD2AD474248758569EABC88CD5B21DE1F24815F1940777C
            89069D51EDC9BA8EF696446D75095DB20964BB2292DDE67C1A0FF20B1EC45F00
            E8D9DBC49EE9D6D396EADBC9E5B493E35A842667049A5B14C8C707C9CFAF9C00
            6000806915A012FE04BC119E8447E168519A82470A0150D0D7DD4C35776DCC00
            5C9E0819CF07C87C81270F1F20BF6FC500C0C7009C520136E069EFC30BA40ED7
            69B8A8E1382B3E79E55E0DD80E80FE3AC01DA169B30CF093DB27CA803100DE07
            605405904F60294E45A972C0E5A4499427DF6979C07E19B0AF996AB7DC494E87
            8D9C0098CC22CD2E08E48602DE2B8C02F0110023FF742E6EB4EB808E46D68B12
            D5D56C22E71515007BE0F602E01364051FFC0FC07615C09A299111259ABDE827
            8F37A3E02400EFDEB007B7AA409F01B832250A936936902D9157249F5730280A
            268A07600FEA6A75190557019806604E2991D7E3FF56E9A2A9A200DD7B1AD981
            AE26BA676B25BAC8861285C9F87B80FE00E05A16F0BDB2C9A78B01ACDFB3BB31
            D6D59605381D0EF47E9416ED31B22E87C96A73D05597FB3B00DE2B56413916B7
            A2933B71703651F6CDC9299F726FE3FC900903C7F0FA76DC42FE3C8043621D4E
            E4BDB82E535C9E905FD3AB0A64195F3ECB00AD1603C87E45FDFD0F148DA2224D
            FFE1678CDAFE04237B72506D0C4B920000000049454E44AE426082}
          ShowHint = True
        end
        object LbCat2: TLabel
          Left = 32
          Top = 7
          Width = 85
          Height = 20
          Caption = 'Contrepoids'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object PnSales: TPanel
        Left = 0
        Top = 528
        Width = 352
        Height = 97
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 2
        object LbPrice: TLabel
          Left = 5
          Top = 31
          Width = 31
          Height = 20
          Caption = 'Prix :'
        end
        object LbContinent: TLabel
          Left = 5
          Top = 71
          Width = 71
          Height = 20
          Caption = 'Continent :'
        end
        object LbValuePrice: TLabel
          Left = 86
          Top = 31
          Width = 27
          Height = 20
          Caption = '250'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbValueContinent: TLabel
          Left = 86
          Top = 71
          Width = 64
          Height = 20
          Caption = 'Commun'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LbTime: TLabel
          Left = 5
          Top = 51
          Width = 50
          Height = 20
          Caption = 'Temps :'
        end
        object LbValueTime: TLabel
          Left = 86
          Top = 51
          Width = 250
          Height = 20
          Caption = '3 Tage, 22 Stunden und 45 Minuten'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Image1: TImage
          Left = 4
          Top = 5
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            650064696D2E203136206D616920323031302031333A33303A3230202B303130
            3043FA90F00000000774494D4507DA05100B2017FD8A03820000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000003
            BC4944415478DAC5946B6C145514C7FFB38F99D9D9997D946D4BB65A6D915721
            880901634213638418AD21217C51A2B135316AFCE0838FA58A8909861642485B
            1202124314488345D08058DA42ACE09AEADA6D2B05DC9676675D96EE839D7D4C
            E7E19D2E1B1EC52569259EE49F99E49E737EF79E7BCFA1F0908DFA5F01FE4365
            D5B2EC5C7AA167C46FE3F026C7E13586854AA2DA7F1BC39E4F0E223B27C0E9ED
            36EFC29ADAC12BC3170471226EB25A01969D5ED263718C6432089DF5A3FEE845
            FC35EB1275ED7EF4AD52B7DE168B8E53F1382049402A05280AB4CB617CD77C02
            9B895B62D68026C0B4BE55F0ABF2CD65C924606854C495BE4BD8DAF90B3A884B
            6ED625322C26F63DAE478F0D067F3DC8C6A212CC6C39453FB6E1C43375CD2F1B
            A59AD31D1836317CC8E3365D1C354F05385DC980A23DDAD0B58ADE95EB5A9F23
            CBDA9C013FB7F26B1DEEB21E3B6F21BE19483713088BC94860086BDFDB874B73
            02F8F6B2954ECF8AD30C57B258D735287212B9F4DFC84822B98B6C2818C2AB6F
            34A37B5680FE03F337B93C4BDB7867D53C8B5580AE2910AF4761334D209D0C92
            9384C88BD2E470048DAF7C8E1DFF56AEFB027C7B8517DDE5CBBE11DC4B2C76A1
            0A66A604BE4111074E06F1D2AA0C187D0CE56C0069298B741A7A388A5DAFB7E0
            43DCE7D26700069A402B55DE2177694D35EF5A0CC1B50887BB42180A4EE285D5
            0E74F65E83838EA06EB90F126908D26CD3909171D47FB41F5F3C1070AE0575AE
            526F27EF5A4409AE85B03B1660D7D1514C2632D858EB20250A213179153C354C
            4E902E0070238ECBF5BBB11CF7F4C50CC0F99DD8C73B9D0D7667353847156C76
            2F26530C8E9F17F1FB4802B1A48CF54F46B0BA72802457A701B720DA711FD67C
            DD035F51407733FA39BB7925679F0F96AF8095F1E0CB6E0ECFAE5051E14AE0AB
            2E0967FAAD68DAF01379551AB2D93CC0F80646F1F6671D682F0AF8613BC23616
            E50C6B01C39640A1E6A1F1C802B86D59547A52182063CDC926D1503B881C499A
            CBE5931BBA2A62C7C747B0A528E0FB4F314E46728531390D51661AD1940013A5
            A1FDCC126C7EFA0F940929C8723E7901607C8361B46EEBC0BB4501C71AD1C3D0
            A8A569C06CCE8BBAE5A5EBD35314535379DD0931FE8743D8D6F2AD311F8B000E
            6FC1FB3483168B05306432DD0668A49554350F3164242D684A81D2D187E77F0C
            DCDDD933004D9BC03FF1087A59064F19BBBF1760A800289C4451A1FAC7B0BFED
            14DE216E4A5180610DEB5052E3C5079419AB487086EC3A421ECC0D5581A4E9D0
            08932681364D05975390FD7302E73A7D384542E50736DA7F6D0F1DF00F3AF0AC
            28629CFCBC0000000049454E44AE426082}
          ShowHint = True
        end
        object LbSale: TLabel
          Left = 32
          Top = 7
          Width = 40
          Height = 20
          Caption = 'Vente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
end
