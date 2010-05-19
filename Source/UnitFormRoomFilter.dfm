object FormRoomFilter: TFormRoomFilter
  Left = 340
  Top = 184
  Width = 325
  Height = 506
  Caption = 'Filtre'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 280
    Height = 468
    ActivePage = TabFilter
    Align = alLeft
    TabOrder = 0
    object TabFilter: TTabSheet
      Caption = 'Filtre'
      object BtOK: TButton
        Left = 195
        Top = 362
        Width = 75
        Height = 23
        Caption = 'Filtrer'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = BtOKClick
      end
      object GbType: TGroupBox
        Left = 0
        Top = 0
        Width = 132
        Height = 110
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object CbTypeNaturalMat: TCheckBox
          Left = 8
          Top = 34
          Width = 121
          Height = 17
          Caption = 'Forage'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CbTypeAnimalMatClick
        end
        object CbTypeAnimalMat: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Loot'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = CbTypeAnimalMatClick
        end
        object CbTypeCata: TCheckBox
          Left = 8
          Top = 52
          Width = 121
          Height = 17
          Caption = 'Catalyseurs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CbTypeOthers: TCheckBox
          Left = 8
          Top = 88
          Width = 121
          Height = 17
          Caption = 'Autres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object CbTypeEquipment: TCheckBox
          Left = 8
          Top = 70
          Width = 121
          Height = 17
          Caption = 'Equipement'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = CbTypeAnimalMatClick
        end
      end
      object GbQuality: TGroupBox
        Left = 0
        Top = 182
        Width = 132
        Height = 70
        Caption = 'Qualit'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object LbQualityMin: TLabel
          Left = 8
          Top = 20
          Width = 23
          Height = 13
          Caption = 'Min :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbQualityMax: TLabel
          Left = 8
          Top = 47
          Width = 26
          Height = 13
          Caption = 'Max :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object EdQualityMin: TSpinEdit
          Left = 40
          Top = 16
          Width = 85
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 270
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 250
        end
        object EdQualityMax: TSpinEdit
          Left = 40
          Top = 42
          Width = 85
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 300
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 250
        end
      end
      object GbClass: TGroupBox
        Left = 0
        Top = 114
        Width = 132
        Height = 67
        Caption = 'Classe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object LbClassMin: TLabel
          Left = 8
          Top = 20
          Width = 23
          Height = 13
          Caption = 'Min :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbClassMax: TLabel
          Left = 8
          Top = 44
          Width = 26
          Height = 13
          Caption = 'Max :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object EdClassMin: TComboBox
          Left = 40
          Top = 16
          Width = 85
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
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
          Left = 40
          Top = 40
          Width = 85
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
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
      object GbEcosys: TGroupBox
        Left = 138
        Top = 0
        Width = 132
        Height = 128
        Caption = 'Ecosyst'#232'me'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object CbEcoPrime: TCheckBox
          Left = 8
          Top = 34
          Width = 121
          Height = 17
          Caption = 'Primes Racines'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CbEcoCommon: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Commun'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CbEcoDesert: TCheckBox
          Left = 8
          Top = 70
          Width = 121
          Height = 17
          Caption = 'D'#233'sert'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CbEcoForest: TCheckBox
          Left = 8
          Top = 52
          Width = 121
          Height = 17
          Caption = 'For'#234't'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object CbEcoLakes: TCheckBox
          Left = 8
          Top = 88
          Width = 121
          Height = 17
          Caption = 'Lacs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object CbEcoJungle: TCheckBox
          Left = 8
          Top = 106
          Width = 121
          Height = 17
          Caption = 'Jungle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object BtDefault: TButton
        Left = 2
        Top = 362
        Width = 75
        Height = 23
        Caption = 'D'#233'faut'
        ModalResult = 1
        TabOrder = 5
        OnClick = BtDefaultClick
      end
      object GbName: TGroupBox
        Left = 0
        Top = 297
        Width = 270
        Height = 61
        Caption = 'Nom'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        DesignSize = (
          270
          61)
        object EdName: TEdit
          Left = 8
          Top = 16
          Width = 254
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RbAllWords: TRadioButton
          Left = 8
          Top = 40
          Width = 125
          Height = 17
          Caption = 'Tous les mots'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = True
        end
        object RbOneWord: TRadioButton
          Left = 136
          Top = 40
          Width = 125
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Un des mots'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
        end
      end
      object GbEquipment: TGroupBox
        Left = 138
        Top = 131
        Width = 132
        Height = 165
        Caption = 'Equipement'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        object CbEqHeavyArmors: TCheckBox
          Left = 8
          Top = 52
          Width = 121
          Height = 17
          Caption = 'Armures lourdes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CbEqWeaponsMelee: TCheckBox
          Left = 8
          Top = 70
          Width = 121
          Height = 17
          Caption = 'Armes de m'#233'l'#233'e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CbEqMediumArmors: TCheckBox
          Left = 8
          Top = 34
          Width = 121
          Height = 17
          Caption = 'Armures moyennes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CbEqLightArmors: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Armures l'#233'g'#232'res'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object CbEqAmplifier: TCheckBox
          Left = 8
          Top = 106
          Width = 121
          Height = 17
          Caption = 'Amplificateurs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object CbEqWeaponsRange: TCheckBox
          Left = 8
          Top = 88
          Width = 121
          Height = 17
          Caption = 'Armes de tir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object CbEqOthers: TCheckBox
          Left = 8
          Top = 142
          Width = 121
          Height = 17
          Caption = 'Autres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object CbEqJewels: TCheckBox
          Left = 8
          Top = 124
          Width = 121
          Height = 17
          Caption = 'Bijoux'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
      object GbCategory: TGroupBox
        Left = 0
        Top = 253
        Width = 132
        Height = 43
        Caption = 'Cat'#233'gorie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        object EdCategory: TComboBox
          Left = 8
          Top = 16
          Width = 117
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            'Tous'
            'Lame'
            'Marteau'
            'Pointe'
            'Fl'#232'che'
            'Prise'
            'Contrepoids'
            'Concentration magique'
            'D'#233'tente'
            'Percuteur'
            'Canon'
            'Explosif'
            'Cartouche de munitions'
            'Balle de munitions'
            'V'#234'tements'
            'Carapace pour armures'
            'Doublure'
            'Rembourrage'
            'Fixation pour armures'
            'Configuration des bijoux'
            'Bijoux')
        end
      end
    end
    object TabInfo: TTabSheet
      Caption = 'Informations'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object GroupSale: TGroupBox
        Left = 0
        Top = 149
        Width = 270
        Height = 96
        Caption = 'Vente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object ImgTime: TImage
          Left = 8
          Top = 41
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            650064696D2E203136206D616920323031302031333A33343A3432202B303130
            301BE128240000000774494D4507DA05100B26281DB689390000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000004
            834944415478DADD956B6C145514C7FF7377EECC3EBAADDDEDB6DB074B2B6929
            9412888DB6D534FA0110504320920009464A1381104D882262A2D18A40484831
            BC0C684A51204A419A962814B05B1B53A01458C80AA48596B2486BE9CC3E66E7
            B133CE1A3F6E5112FDC2F9301FEE3DF3FFCDBDFF33E730F89F8379B2011F01C4
            63F7643B38CCB210329B105410C09330100DEB89A0A0194DC18474BA31167B60
            A6EB8F05680078BB2BBBC66921B5E9C4F2B29558323886F9EB05C30054F3211A
            DAC321556DBB28C7F6ED8F46CF3D16609F3B7B99DBC27E90C5B2254EC2B24971
            566790503468860ED9FCDE0408649A5042BA7AA72522AC3B28496D482E3F0AB0
            17A07079164CA0DC7E2FE59D76F35E7823797E03B28F83503D09CE1206EECC51
            0C768888FB2360423A4226A73D165DB7372A7E6FCAA8E302BE74B92ADD84DB5D
            64B5CD70100BAC060399D74117E4439C3B1B1DFA524CF504E0739CC3378D7694
            DBBAE0F3F7413CAFE9978DF8A963A3E1557EC8FD2901BB32323233295F9FC7F2
            B5D994E7ED0C8122CBA0EB2BE07D633E6E89A5F0077C28CBE945E7C9F3B8DC13
            C6EABA2026B32104970F6340D542CD7161D57149FA2125E0AB4CCF9C2C8EEE2F
            A07CFE538485AE6BC0F22928AA7F17447742D3554852144D8D1D38D814C08A45
            092C5E5100CD12C2AD85173078490D1F52C50D47A5E8CE94804677CE67B994BE
            EF6539E234B794A94EE436D4C1595C65968E0659D3D172C28F2F769CC4049786
            ADDB5FC4ADF80B1818563075C75ADC3D2B451AE5F087CD52B42125A0C99DD39A
            CFF1F372580E3C31605D5B0EEF9A95B0508F6931C199F62BD8B6F534C2C24DD4
            6F7C16D35F9A89A35DD5D0B4DBA8DABB1AFD9D72B8292E6C38264BA94F70C09D
            1D28E0F8322FCB83A43330B62CC660FE1294E7C7E04A97B16D4B2BDA5A07A1A8
            FD9837BF1C2BEB0A60B78FC012BE841BAFDEC6F541E5DE81B8F0CE1945FA2EB5
            072E4F208FF265A607607259F4ADDF806EE5752CABEA45B14F41FB8F1770B8B1
            0D376FC7CDB2F561EEDC522C59FA1BF80BD730B05630CEA8D15F0F88E25B37A0
            5E4909D89399F5532EE5664DA456901C0B621F2F825E548319452A6C9C59519A
            8AB1D1217477074DA343B0DAA6A3F6353F5C87FB30D4A946BF961EEE3C22453F
            37A5C65202366664BC378D5A3FF17156DECE13647F9A0FEFE26A10ADD0CC644D
            93813B234EA4D97F07623D18ECBE0647EB28E453060E45C7CEEE13C7D609406F
            B29BA404AC7138CA4B79EB9EA7A9B52A87700CADA628DC5482F4C212247FF01B
            F726A1E5FA024CCB3A864AF7218C340C61ECB88A8B1129B4591C79BB3F913861
            26CAE3B68A674C958AB4B4576672F6CDD3795B093177F91A8A89EBF39056EC40
            DFF064F8BB66A0F87E335C3F5F85D26DA04796EE1F91845DEDF1F8765322F2AF
            9ADD144ACBDE4C736E9AC6D96AD2354B3A6337089D40406D0698FB329461D610
            34229D4D442E368785DD415D6F49253E2E2019CF03BE4A67C6A2424A177A41CB
            B804634B5EAC085DB8076D20A0C67F39198B7CFB0770D55C8E8FA7F34F13CD3A
            87E3269AEDFA39428857310790A86A771F185A30A0697D7F578BFE2881277C26
            FF17F127EB8EDE287D1323AE0000000049454E44AE426082}
          ShowHint = True
        end
        object ImgPrice: TImage
          Left = 8
          Top = 16
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
        object ImgContinent: TImage
          Left = 8
          Top = 66
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            650064696D2E203136206D616920323031302031313A33353A3033202B303130
            30B642F31F0000000774494D4507DA05100B260BBFD1F84B0000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000004
            9F4944415478DADD956B6C536518C7FF3DBD9C9EB6EBDA75BDADDDBAAD6C301A
            1B48900D15873858BC60B64421CA0C8C4405A344F48B841007241049BC12BC0C
            70264445502E13040D03218E9B2B03329C63F7B1164ABB76DDBAF6F49CD31EDF
            35EAA74E34D12F3C1FCFFB9CF7F7BCCFF3FFBFAF04FF7348EE69003563C68BE6
            996E67B9DEA07BDA64D6BBB5396A034488E1D05870E476C433323AFA4D87A7AB
            ADA7A72948F2C57F05282F5FBBA87CC19CD5CED2C285569B5527A56464873FD3
            45F03C07DFB037D8D7DD7FFC5CCBE58FDBDB779EFFC780DCDC9ACA95AF2EFDDC
            662FC85733B454CD2820A444C4591EC9640A8290240C1172850CBC20F0BD5D37
            7A767F7868792CD6DC7E3780C4E95C5139FFF1397BAC565B3152020A0B4CB8CF
            65C7C0CD20BABAFD60133C346A1AA54E2B0686020886C6A050D0E8EBE9BAD6FA
            E3B5FAA1A12F2E4F0950AB6B4DF73F5CFA7E81336FA914A2B46CBA03769B91B4
            8387E74A0FA2132CB4DA2CCC7617C35D960F25AD40F30F6DE8EC1A423295E47A
            3BBB775F3FDDB1218233A319012565F55579CEDC2F19A5D4E82CCAC3F3CB1693
            CA033876E21C7CB7FC90CB15585C558187E6B99067D623D7A025A7F2E293A6EF
            31ECBB8370303C30D07D6BD970FF814B1901F6A2673F301765AFA54401ABEA9E
            8428A170F6E72BE8EDED2715A6A0D664A19E7C2F7258C86969380B6D50AB68EC
            3F7C063B771D06CFB1F00F8E6FF00E1ED89A1160CCAF399563CD7A4446014F54
            3F806B1D7D080647108B454151526467EBB06DD36A4808B8BBF726CA4A1D985E
            928F8ECE7EAC59F70E118080115F747FC0DBBC2C234065ACEAC8D22B5D5A8D0A
            8E021B229128E2F138D910481115B95D25F8E8BD37D2B93C2FC07F273C29267C
            77BC157BBF3E4114C5237C277636E43D5A991120CB79B49DA212B38834515D35
            0F0B17CC45EBF9ABB8E4E94CAF1717D9F1F6E6D544452A68340C121C87FD075B
            B0B3F15B8C8F4F20468A49B0D293DCC8C94519014ACB92230A39FB94488EBAB2
            6E09B635ACC1D0B01F8D4D4770EA8C87549D44A1C38A072BDC64FD31D23A160D
            5B1BD1F2535BDA1BC4132487D91DF71F7B212340637F66234DB39B659224E6CE
            7161FB965760CBCB45EB850EBCB5F533B06C22DD125759211AD6D713D9C6B171
            7323AEFFD60781B48C13924936C1BC1CF51E6CCC3C03C773B3344C6A1F2317A6
            4F6AFCA55535A85D321F5BB6EF25831C804C4ADC410826A38E0056E0E22FD771
            A8F934319C9FB48B17639CA42D3E2ED48DFB0EDFC8EC64739DDA6890BCA95551
            AFD3D294CA6E33916A8B89C97AA1523190C9647FFC92225E9889F317AE121F0C
            809248C10A181B8FA7B60478C30EF4EC484C791729CB56394C2A7C9AA3A1AB65
            540A59591AE8743A308C8A184D4E1425493B9B65E308854264B8510849118131
            6EDF6844FADA44FF1EFF5D2F3B4C5B6F745A227BF2F4D90B0C7A8DC690A393A8
            546AD0349D5EE6389E0C788200C262201C8978472247FBC2E635F87553F46E97
            DD5FC154ACB315EB95CB2DB9BADA228B61768E564B4FCE6032C82C111A1B8B0F
            DE0E5EF406C2078702FC5751CFBBC14CFBFCFD8B56B942398DB1DBAC76538582
            96BB298AB288E980978F7157077DBE4B8337953E523937D516F7F69BFC9FC4EF
            CE3302378EC21B730000000049454E44AE426082}
          ShowHint = True
        end
        object LbTime: TLabel
          Left = 37
          Top = 47
          Width = 67
          Height = 13
          Caption = 'Temps restant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbPrice: TLabel
          Left = 37
          Top = 22
          Width = 17
          Height = 13
          Caption = 'Prix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbContinent: TLabel
          Left = 37
          Top = 72
          Width = 45
          Height = 13
          Caption = 'Continent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
      object GroupGeneral: TGroupBox
        Left = 0
        Top = 0
        Width = 270
        Height = 145
        Caption = 'G'#233'n'#233'ral'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object ImgItem: TItemImage
          Left = 8
          Top = 20
          Width = 40
          Height = 40
          ShowHint = True
        end
        object ImgHpb: TImage
          Left = 8
          Top = 114
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
          Left = 212
          Top = 114
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
          Left = 144
          Top = 114
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
          Left = 76
          Top = 114
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
        object LbHpb: TLabel
          Left = 36
          Top = 120
          Width = 18
          Height = 13
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbSab: TLabel
          Left = 104
          Top = 120
          Width = 18
          Height = 13
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbStb: TLabel
          Left = 172
          Top = 120
          Width = 18
          Height = 13
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbFob: TLabel
          Left = 240
          Top = 120
          Width = 18
          Height = 13
          Caption = '125'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ImgDura: TImage
          Left = 188
          Top = 39
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000000774494D4507DA050B170F036768651800
            0000097048597300000B1200000B1201D2DD7EFC0000000467414D410000B18F
            0BFC6105000003264944415478DAED955D48536118C7FFE7EC6C73CCCDE99A73
            464AE86E5C2335C48F8B8CEAC28B2C32904A28E8C22823922895C09B0C6D140A
            A5918A247525991415428675D1074520826DE6665132DDCA4D67A26EE76CBDE7
            EC58229B13A18BA0179E7338EF39CFF37BBEDEE750F8CB8BFA0FD810E0139093
            585ADA203765EDA16432DA3F3131E4EBEBED7AEFF57565131D86A60F280B0A76
            33E96929ACC7EB9A1B18E8C9E4B8E7EB0238B4DA527D6D4D8F32273B4ED8A069
            40428373BBE1E9ECB449D52A4D7C59590AB33583EC4B04F18F7F86ABB5F54EC3
            E08BCA76201015F01130A4569FB326E4E62440A100A45251188021B2B840EEE4
            592E07824180E300964820008E65316AB1B49A5EBF3D13153066343665549DAA
            A1A4A2119908E08D32C45B9A17A2120A11002F228018C7D2127CB651AEEBAAC5
            5C0D5823022676150F6F2E2A340BDE0B00D99F08248C902A50A28A10C1721424
            2B011621DF1C1E37B7D4EDF77A9B22029C3B72BD86BC3C0DE244E372D9AA0856
            00F82804001B8E8000E0F3E149CFFDF67D9393272302BEEA36FDD862366BA1D7
            E33744160BC0858D9328421E0FEEF5F6DD38C6716723024694CA5759C9BA22A8
            E281242DA05685413C40E8980800DEFBF979607A1AF3532E343AC62BAF001D11
            018F800B25C93A8B54A8812C1C415C5CB81E5211428945E63DF7FB49672D86EF
            44865D6EDFCE59DFF659E04B44C05120B14E2E1BD9A6521B84D40845165B74B9
            83A8155DC443B870FE1708E89ACB7DAB3E14AAE2E38B7AD0AE03872A148A1EBD
            2A9E163A45BA323D7458232476112FA42E1CD97CE0745A8FB3EC5E72529CB146
            05454EE3E5728DE65282460390C2095EAF06F01752278EEC3FB53BBE5D64D983
            36E043CC51212EE636D052AED75769D2D3C9FC70082D28807851AB01A3114B33
            33E8B3D9ECF5C160C518F02E92A1B5A629D30C34961B0CE753F3F3294C4E0276
            3B909909A4A5C1333484EEB1B137A4634E4C03B66846628D6BBA16385D919868
            31959428289D0E21E2B5ADBF9FBDE976DF6D036AC837DFD732B0AEFFC111A0F8
            B044D2516832195F5AAD536D8140FD20D04D5EF963E9AEFB8743B29E540A543C
            049EFD5C23251B066C74FDFB805FEEFE3228B945EA7D0000000049454E44AE42
            6082}
          ShowHint = True
        end
        object LbDura: TLabel
          Left = 216
          Top = 45
          Width = 41
          Height = 13
          Caption = '156/220'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbClass: TLabel
          Left = 88
          Top = 20
          Width = 31
          Height = 13
          Caption = 'Classe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ImgVolume: TImage
          Left = 188
          Top = 14
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            65006D65722E203132206D616920323031302030313A31383A3233202B303130
            30551810FC0000000774494D4507DA050B17131B9273A0130000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000003
            EB4944415478DAED956D4C5B5518C7FFE7DEDBDB57DA0202052614C6C6641515
            C64B610E583627D916A38D31D1189084D9C4EC83C916639C9946638CCEC4E807
            976589C9B6640BCCCCC43848816593B10023F2B6325B5C65744229D0965D684B
            6FDBEB29A8F1432731C60F1A4FF2DC0F27CFF3FC9EFFFFE69C43F00F2FF23FE0
            6F01F6BE2933F9746816E5A893581809C370747B46016E2097559FBF64F576D3
            0ED25F06D4B42045DC4C3E25066D5371F6E3AC515704BD221D0C611112839811
            7E4624E493C459E74B6D5DEE5B45D9681E1DC431F493D08680BA26E8838F929E
            2DDBCBCBCA0DB5E0590E84594F4C8C2AC5011E0AD817DB316B670EFB3CB75B4D
            46947E3F89BEDEDE8546DCC810FE1450FD212E9A2AAB2DDBD24BC1B1004B8321
            F89D40A85701C10567D4869F6CEDD35B1EB2E425EAE214DC3781738E93E4E507
            026AAC7832B3D170ADCA584F781920A38EB3747A26A180664A1241686905CEF8
            65F8DC8DE0EF7D0D25CF201603441198F3216E1B0856A1433D9414B0EB04BE28
            DF5561CDD26440CEAF037E539148149642F8F1FE0062AC1681E111A42AB3D654
            45A3402402848240EF58F4C4EC97B2A349014F9DC28D4A73A559AB94434101FC
            1F20513AE2D0A81DB25C019EB16F90C91D00C72554AD4F1F0E03C16560FC4EA4
            D3FE89BC3129E0C069D8732BD8922C6D1AD2547AA4C8955409B30600F57872D1
            893B2371D770FF545EC3CE2C4E215F078468F3453F30ED01BC73C16B8E8FD4F5
            C9157C8EF1927D3069D5400A0D8D92815AA6831C7AB04481583C86FE0BF1E3ED
            1D672CCF36EF28D5EA6410A9FF7E3AB9DF07F816A89DABF77BBA5ED7ED490A30
            1DC195FDAFA1215507AC4164A950911C0A48074BBF31AC22B69831FFDE1B9B0E
            D73E7DF46C4D558E4C1009EE06807BF3C0FC9C0465C475AABDB5E8D5A480C217
            F17EF92B78ABD60CE8552A68492134288012067050514008AB921F7727962FF4
            5C3D1238F49CD91AA136DE9A031CD49E39B720098EAE83DD1F58BE4D0A30EE40
            31B707C32F1C8272BBD1001D79043A14238542786A53044B58C614FCAB2EA9B3
            6DBA65EBD68EE3C6BC4D465780C1D86408E3D747FB6E7E6C6EA0ADC4071EB482
            67F0AEBC1A6F3F7F309FD4955452150514B28D9EDD4C6AD00202B84D6302EE59
            D7F4D0572DEF1456B59CBE391663BEBBE274AF38CFEC15864E3A36BA8BF8CD16
            7CC697A1B5A4F86166FF63FBF044F64EA4297210639621C466E05E1EC788F72A
            06CF797687B94B565BE7520EA6DA5A317BFE870DEFA25F1757508F2675198E29
            8CC857EA18A2D768A0503090D8155A2522EEE57C5E9BD27CFD2C47FF809F1E33
            849235DAE83D48CDAF40BDA608B57C3AC9E764E01891F184A7994147AFD81DF6
            C3BD41FD7FFD45FB57007E014C7B6828D2721ED90000000049454E44AE426082}
          ShowHint = True
        end
        object LbVolume: TLabel
          Left = 216
          Top = 20
          Width = 21
          Height = 13
          Caption = '10,5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbCraft: TLabel
          Left = 36
          Top = 95
          Width = 225
          Height = 13
          AutoSize = False
          Caption = 'Lame, Pointe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbDesc: TLabel
          Left = 8
          Top = 67
          Width = 258
          Height = 13
          AutoSize = False
          Caption = 'Description'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ImgCraft: TImage
          Left = 8
          Top = 89
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            650064696D2E203136206D616920323031302031333A34373A3334202B303130
            30B0F8BA870000000774494D4507DA05100B39322D8E7EDD0000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000003
            E04944415478DAED954F681C7514C7BFF37F7667777632996C7693B8554994E8
            A5208A7F8ABD44B0F4205A424BF5A0A139D443A91735064C0FD1E6208442ED41
            63A1A287505114A52088A014DADAA0B58214298D4DBAC9FE9BDD99D99DD9D9CC
            CEF83647D93445147A70E0CB5CDE7B9FDF7BEFF7DE8FC17FFC31FF03FE15C0CC
            CC8C9CCB8D8C711CF70CC3B03B81280CC3F6C92070BF9F9C9C34FF316061E193
            1D82C04D310C73804C535114612308C0731CDA61089EE70244F8A1DD0EDE9F98
            78E90B7289EE18B0B0F0F10151143F08DA61D2F77DE4D70AE8D15228962AD0F5
            14C23082240A585DCD2393CDA0B7473B77F5EAE57DF3F3F3DEB680B9B9F9D1BE
            74DF15DF6F0996EDA0D56AA1E9F9E0780EB1980C5110603B75B02C8B80322A14
            4A1818E887AEA953478FBE3AB72D6076F6BD9908CCB17614C2B61C5089205050
            FA51F523588E8372A50AAFD94432A14055E248A9092889C4A599B75F7F824284
            5B02A6A7A777B402F172A96C1A4EBD4E0611649E85C44660A360D3A5E1BA28D5
            1C588D26C00BC86432481B065435D138F3D562B672ED9AD315303E3ECE650687
            17D70AA57DEB852210B4309092917256C011881745F03D593AB98FB2DD40C1AC
            C18D0424351D7A3A0B4DD3E07ACED8E2A7A7BFEB0A3878F0D023BC245FBA7E63
            99ADD7CA50F910A34369A86842441BA21C23C5A9FE0EC946C5F150F55A002741
            4EE7C0295AE7861D3FBB78FAADEE19EC7FE5CD200C8FD74BEB68D46DF09E8987
            B31AEE315248C42938C712864531BF02CB2CA21972F018111E1B832F2411C452
            D860A48FBE3D77F65057C0D8B3CFBFABF29812BD2A22BB800DCF41560ED19F4A
            C030FA36AFA55D3351595FA55BE522E06434790516435921065E4D63D5B45E5E
            FAE5A7335D01BB9FDC7D389B104E497472D1AF826F5A886D385025167A8F8EB8
            A260C3F7E035EAD4680FB61FC08C6230A18055F40EECC2371797F65228B32B20
            97C93CB4EB81DC92D434E5A85E01DBB49194B8CD12A569B81459DAB4A3F9408D
            FA70B358C59F560B919CA4FAEB951F97CBCFDDACD6CFDF6E0EC45DC303C71E54
            DAAF716E55EE545C5135183D1AFAF52492D40786D6854BF7BF4AF3912F992857
            2D7082145C71842317F3F6871423D86ED012F725B83D7BB2D13BF7F72646581A
            3023330855372075322080D77061D93594D6D7E1DA56F4B3199CFA72A5FD06F9
            36FE1E6CAB5DC41A02761E797CE0C4D3A3B9A7B2FD06D39BA626530FDAB436CC
            B249BBA98895FC5A74FE8FFCE7277F6B1C269F52B740DBADEBA18947EF7DF185
            C786F70E8F0C0DCAE95E29EEB9B156B912FFFDFA2DFBEB5F973F3B71E1D62CD9
            AD6D15E04EDE038E9422A9A44E9765528CD459073748EEED9CEF8E17EDAE06FC
            0579809D2848C564530000000049454E44AE426082}
          ShowHint = True
        end
        object ImgSkin1: TImage
          Left = 60
          Top = 43
          Width = 16
          Height = 16
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000097048597300000B1300000B1301009A9C
            1800000A4F6943435050686F746F73686F70204943432070726F66696C650000
            78DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A
            2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807
            E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C008
            0C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173
            FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA4299
            5C01808401C07491384B08801400407A8E42A600404601809D98265300A00400
            60CB6362E300502D0060277FE6D300809DF8997B01005B94211501A091002013
            65884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0
            B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2
            573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE4917
            2B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE
            0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C
            2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370
            F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E
            3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FC
            B70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525
            D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F7
            0000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E
            44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC60
            36844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C0
            51688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA88
            01628A58238E08179985F821C14804128B2420C9881451224B91354831528A54
            2055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB5
            43B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA
            8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB0
            56AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8
            201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C
            23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E52
            23E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE4
            21F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52
            DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D3
            1A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D8615
            83C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F
            996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB
            548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67
            A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C21
            6B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B3
            52F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB9
            31655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C7
            4A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB44
            77BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C58
            06B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E1
            8491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4D
            EE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79B
            DFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB3
            46AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D8
            06DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB
            1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B6
            13CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8
            BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F29
            9E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F
            9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7
            C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02
            FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8
            EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C278587855786
            3F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A
            3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBE
            DFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A9640
            4C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D843
            5C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B
            3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC65
            85B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267
            655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5
            864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD5
            4FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED
            5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCA
            BF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB4
            0DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54
            A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BE
            DB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D2
            03FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D
            558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F
            6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C5979
            4AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A
            0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F
            6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDD
            F4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD977
            27EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47
            F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA7
            43CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7C
            A5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4F
            E47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB00000004
            67414D410000B18E7CFB5193000002DF4944415478DA8D927B48D35114C7CFDD
            6FD3FDB614C7748A64069A8F3F7C94216456A8A4532B2C721094098A151A34CA
            4A2B22AD8999652A09116612685A640AA66DF680C252ACF00FD3103235756EF3
            F9739BFB6DBFDB9D83B09CD085C3817BCEFDDCEF79A0CE723FF0F4F2816DC77A
            E0DF537FC93BDFA05B362BEFCF55ADBE57978781442C8069FD04A0F500993B10
            1DBB33A0EBD724C318B45A79A506734E01186370766236530AF5AB334F8C0C03
            F9B9B5C975DD6C87B3BC75014AB9E4D39DA6D268001E14E714AAAF344E27FE17
            40A510F96A7A2D071FDE4BAAF6DF9E06C051F0FD7D335753F5E6B8D483535F6E
            B168FF026445090E07780BC35C3750BEAE345F4651283026501C1C9E9E4E818B
            0F001600980CF04DD3CE7E19D40E8D4E1A87C1CCE997664D63630CFB15152408
            DB768749F7C933E2005C5D01AC56A29A78CA8DE0F904401143602F65C59B4D00
            062DBC6CEC84BEA9F96674241A62978D28EDAAC2FF6C78CA2EBB28924820D806
            602366EF3D47CAE4088025DE6881FEEE7EFC7460B484EFCEB5ADF4203502D19C
            11AE5D3F245346C505F181CF7380003B0036E2AD04C658E073CFCFE5B6715D89
            C00D5485B598FDD3C4FD5B91109BA1B82C4E7C2E748F172981723CB6C7ED0084
            606CC0C09DEF982FDA120CAAA2C7985D3385A4105E7245BCA83D34440C64531C
            92AD8442113544D570AF8E3DDABAB4F7E328F7CEE918F36228656E247D3BD447
            082023A6230D63C847320213F2C034C2406AC362D6EB71AED6294095C8AF29F4
            7539094112D0FE60E0412FA3A769446544B8493C7D69023342C68B859BF543DC
            853580CA6C24944C09BA141E74CC333DBB5837686EA1A5F851C026E04B81CA8C
            44C20372A94054D1B7A09EDAC8A594B5DA47B50A70F714122D4F53B746C6C16F
            60C656239381A6E903B6AC28CB46F48C0EE4DC342F47CFE001EF405C50F6DC11
            435579A4F62A0CD5A711DFB884E227B458247607CD8D06CCAC5ED9D213C88399
            85040B0B731209BCBD586B5F1480DF5D16500F3E0534370000000049454E44AE
            426082}
          ShowHint = True
        end
        object ImgSkin2: TImage
          Left = 77
          Top = 43
          Width = 16
          Height = 16
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000097048597300000B1300000B1301009A9C
            1800000A4F6943435050686F746F73686F70204943432070726F66696C650000
            78DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A
            2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807
            E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C008
            0C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173
            FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA4299
            5C01808401C07491384B08801400407A8E42A600404601809D98265300A00400
            60CB6362E300502D0060277FE6D300809DF8997B01005B94211501A091002013
            65884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0
            B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2
            573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE4917
            2B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE
            0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C
            2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370
            F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E
            3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FC
            B70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525
            D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F7
            0000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E
            44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC60
            36844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C0
            51688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA88
            01628A58238E08179985F821C14804128B2420C9881451224B91354831528A54
            2055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB5
            43B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA
            8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB0
            56AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8
            201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C
            23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E52
            23E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE4
            21F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52
            DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D3
            1A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D8615
            83C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F
            996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB
            548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67
            A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C21
            6B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B3
            52F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB9
            31655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C7
            4A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB44
            77BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C58
            06B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E1
            8491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4D
            EE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79B
            DFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB3
            46AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D8
            06DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB
            1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B6
            13CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8
            BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F29
            9E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F
            9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7
            C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02
            FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8
            EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C278587855786
            3F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A
            3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBE
            DFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A9640
            4C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D843
            5C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B
            3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC65
            85B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267
            655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5
            864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD5
            4FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED
            5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCA
            BF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB4
            0DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54
            A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BE
            DB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D2
            03FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D
            558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F
            6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C5979
            4AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A
            0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F
            6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDD
            F4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD977
            27EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47
            F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA7
            43CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7C
            A5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4F
            E47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB00000004
            67414D410000B18E7CFB5193000002DF4944415478DA8D927B48D35114C7CFDD
            6FD3FDB614C7748A64069A8F3F7C94216456A8A4532B2C721094098A151A34CA
            4A2B22AD8999652A09116612685A640AA66DF680C252ACF00FD3103235756EF3
            F9739BFB6DBFDB9D83B09CD085C3817BCEFDDCEF79A0CE723FF0F4F2816DC77A
            E0DF537FC93BDFA05B362BEFCF55ADBE57978781442C8069FD04A0F500993B10
            1DBB33A0EBD724C318B45A79A506734E01186370766236530AF5AB334F8C0C03
            F9B9B5C975DD6C87B3BC75014AB9E4D39DA6D268001E14E714AAAF344E27FE17
            40A510F96A7A2D071FDE4BAAF6DF9E06C051F0FD7D335753F5E6B8D483535F6E
            B168FF026445090E07780BC35C3750BEAE345F4651283026501C1C9E9E4E818B
            0F001600980CF04DD3CE7E19D40E8D4E1A87C1CCE997664D63630CFB15152408
            DB768749F7C933E2005C5D01AC56A29A78CA8DE0F904401143602F65C59B4D00
            062DBC6CEC84BEA9F96674241A62978D28EDAAC2FF6C78CA2EBB28924820D806
            602366EF3D47CAE4088025DE6881FEEE7EFC7460B484EFCEB5ADF4203502D19C
            11AE5D3F245346C505F181CF7380003B0036E2AD04C658E073CFCFE5B6715D89
            C00D5485B598FDD3C4FD5B91109BA1B82C4E7C2E748F172981723CB6C7ED0084
            606CC0C09DEF982FDA120CAAA2C7985D3385A4105E7245BCA83D34440C64531C
            92AD8442113544D570AF8E3DDABAB4F7E328F7CEE918F36228656E247D3BD447
            082023A6230D63C847320213F2C034C2406AC362D6EB71AED6294095C8AF29F4
            7539094112D0FE60E0412FA3A769446544B8493C7D69023342C68B859BF543DC
            853580CA6C24944C09BA141E74CC333DBB5837686EA1A5F851C026E04B81CA8C
            44C20372A94054D1B7A09EDAC8A594B5DA47B50A70F714122D4F53B746C6C16F
            60C656239381A6E903B6AC28CB46F48C0EE4DC342F47CFE001EF405C50F6DC11
            435579A4F62A0CD5A711DFB884E227B458247607CD8D06CCAC5ED9D213C88399
            85040B0B731209BCBD586B5F1480DF5D16500F3E0534370000000049454E44AE
            426082}
          ShowHint = True
        end
        object ImgSkin3: TImage
          Left = 94
          Top = 43
          Width = 16
          Height = 16
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000097048597300000B1300000B1301009A9C
            1800000A4F6943435050686F746F73686F70204943432070726F66696C650000
            78DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A
            2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807
            E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C008
            0C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173
            FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA4299
            5C01808401C07491384B08801400407A8E42A600404601809D98265300A00400
            60CB6362E300502D0060277FE6D300809DF8997B01005B94211501A091002013
            65884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0
            B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2
            573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE4917
            2B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE
            0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C
            2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370
            F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E
            3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FC
            B70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525
            D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F7
            0000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E
            44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC60
            36844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C0
            51688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA88
            01628A58238E08179985F821C14804128B2420C9881451224B91354831528A54
            2055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB5
            43B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA
            8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB0
            56AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8
            201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C
            23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E52
            23E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE4
            21F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52
            DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D3
            1A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D8615
            83C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F
            996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB
            548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67
            A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C21
            6B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B3
            52F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB9
            31655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C7
            4A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB44
            77BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C58
            06B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E1
            8491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4D
            EE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79B
            DFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB3
            46AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D8
            06DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB
            1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B6
            13CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8
            BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F29
            9E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F
            9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7
            C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02
            FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8
            EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C278587855786
            3F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A
            3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBE
            DFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A9640
            4C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D843
            5C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B
            3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC65
            85B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267
            655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5
            864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD5
            4FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED
            5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCA
            BF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB4
            0DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54
            A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BE
            DB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D2
            03FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D
            558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F
            6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C5979
            4AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A
            0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F
            6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDD
            F4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD977
            27EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47
            F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA7
            43CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7C
            A5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4F
            E47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB00000004
            67414D410000B18E7CFB5193000002DF4944415478DA8D927B48D35114C7CFDD
            6FD3FDB614C7748A64069A8F3F7C94216456A8A4532B2C721094098A151A34CA
            4A2B22AD8999652A09116612685A640AA66DF680C252ACF00FD3103235756EF3
            F9739BFB6DBFDB9D83B09CD085C3817BCEFDDCEF79A0CE723FF0F4F2816DC77A
            E0DF537FC93BDFA05B362BEFCF55ADBE57978781442C8069FD04A0F500993B10
            1DBB33A0EBD724C318B45A79A506734E01186370766236530AF5AB334F8C0C03
            F9B9B5C975DD6C87B3BC75014AB9E4D39DA6D268001E14E714AAAF344E27FE17
            40A510F96A7A2D071FDE4BAAF6DF9E06C051F0FD7D335753F5E6B8D483535F6E
            B168FF026445090E07780BC35C3750BEAE345F4651283026501C1C9E9E4E818B
            0F001600980CF04DD3CE7E19D40E8D4E1A87C1CCE997664D63630CFB15152408
            DB768749F7C933E2005C5D01AC56A29A78CA8DE0F904401143602F65C59B4D00
            062DBC6CEC84BEA9F96674241A62978D28EDAAC2FF6C78CA2EBB28924820D806
            602366EF3D47CAE4088025DE6881FEEE7EFC7460B484EFCEB5ADF4203502D19C
            11AE5D3F245346C505F181CF7380003B0036E2AD04C658E073CFCFE5B6715D89
            C00D5485B598FDD3C4FD5B91109BA1B82C4E7C2E748F172981723CB6C7ED0084
            606CC0C09DEF982FDA120CAAA2C7985D3385A4105E7245BCA83D34440C64531C
            92AD8442113544D570AF8E3DDABAB4F7E328F7CEE918F36228656E247D3BD447
            082023A6230D63C847320213F2C034C2406AC362D6EB71AED6294095C8AF29F4
            7539094112D0FE60E0412FA3A769446544B8493C7D69023342C68B859BF543DC
            853580CA6C24944C09BA141E74CC333DBB5837686EA1A5F851C026E04B81CA8C
            44C20372A94054D1B7A09EDAC8A594B5DA47B50A70F714122D4F53B746C6C16F
            60C656239381A6E903B6AC28CB46F48C0EE4DC342F47CFE001EF405C50F6DC11
            435579A4F62A0CD5A711DFB884E227B458247607CD8D06CCAC5ED9D213C88399
            85040B0B731209BCBD586B5F1480DF5D16500F3E0534370000000049454E44AE
            426082}
          ShowHint = True
        end
        object ImgClass: TImage
          Left = 60
          Top = 14
          Width = 24
          Height = 24
          ParentShowHint = False
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001800
            0000180806000000E0773DF80000002D744558744372656174696F6E2054696D
            650064696D2E203136206D616920323031302031363A34383A3235202B303130
            30360159330000000774494D4507DA05100F04130C068EE10000000970485973
            00000AF000000AF00142AC34980000000467414D410000B18F0BFC6105000004
            484944415478DAE5947F4CD4651CC7DFDFEF7D8F3BEE00B9382E0E480E70E190
            1FEA25E3A7280A154C0D352AB390A6336D594C586BD3C8914D6D9A4BB772ABD5
            98B38515A2CD4D09982E0918483925510E3CE0080EB93BEEBE77DF5FF7BD6F5F
            E8CF02D1D61FADCFF6FCF1ECF33C9FD7F379DEEFE721F02F07F1FF035C7C1769
            1A9DF15844AC594B05854B446014A27F1201BF1B7EDE454CD898FB4535ECBA47
            065C3D129213959A7F2161CD411D492D82E0FB113CD301DE37088EBE8B91368B
            2D63872BF62100C941880D5360A49D999E5D39A4CE8E4AC96B3415ECD353CA85
            609CDFCB857F82C8B964D038463B87AD19AF7B4CF3049895B9051925918F9BB4
            0D5F1F6F007EF75DA95567EB535634C61754EAA920233C6375609DADF2358910
            581AF65F1CD6AC3DDCFC00A5A5DB63376EDE52A70D8E549C3C5557D972E9A3EB
            CD35EAECC8E4B4C6F8D5DBF44A750426EF9D8677FC2A2491042F0870F631D695
            55E2BC00CACAEAA36F5794EFAAEDBF134053EBB58F5B2E7FF3E1C9B23329BAC4
            A4F3F1ABD6EB55DA508CDD6E807BA41392A400CF07400F89D6C2F7A40703E2D2
            772FFDE2E8CEAF4CA6E4F49666167D77FB07DABA7FA8A84E3B28189F4C3C1FB7
            2A4FAF090DC6704F13EEDFBB290308F09C04D1016BC9613C00A07B7EC1F6AD65
            FBAB7617BF6119F0A8DBDB5D601822D0F16BF3B75B22F77CB2C49C78EE895CB3
            5E1BA6C460D7CFB05BEE2020025E1A50B0B0BEF0E9DC0032296B7FE1DED7CA8F
            C718A3922E35DD26BC34078A5262CAEB732B47AA8FBCFAB47397292735461B3E
            0DE8960116596460CA0504F1B0BEF2E51C8005493B4DEB734A8F15E4666EB08D
            D2645F5F3F542A05349A60900A0DC6FABF9BD8683E433EB5665104A552C276AB
            0793438310E50E58D9C894DCC1A613B3029E51AD2CDA549EBB22BF36CA106D18
            B7DBE195FB5628A69749707B58D9962DD85A508FF4CC18B99A4A76510FDC760B
            A40039A3813021598B0FCD027873EFB964B72BECB3B4C5CBF314142967251004
            0196E5E1F17860B73BC0385A51F16C3D162F8B962F532517BF01C6D52F6B4042
            E0A65DE4B7AE9DCD45EF7F70ED80C3AE7927D210A152AB29848452F2E94959E0
            00DC6E06939353105C6D78B9E83412538D90083558F76FE069CB8CC8022FC0D1
            C70CE55789717F0B28D9FCF98B619AE8654683314CA70B25199693021237BD99
            6059113E2F27A9848E906DEB2E16262E89D689D048226B81C00C2020F8E5CF8E
            81FDA6C796F5169B30878B6AC8CCCC30557EFE7341667382E2D6501FE919FD33
            334CD3C272FFBE84A50BBB0EE822D58F49B2EC92C841F27B650DE43710F013AE
            49C1B1E170A0783E2F79267FAAAB8B1ABDA0267A7B7BC5B367CBC4D61AA84550
            69210921469D41A9B05BA740DBF91917713C489E86FBA513B83C5FC05F42AA01
            793D2922CA9052A20F3724C9FF50A7E4B2DD202449907C3E9AE05C8C2F7B07D7
            FFC880E918AACF0C0E595B11A4D3990167F7CC703A9D7062008C87115356F7D2
            FF08F030F1DF07FC01F929F928DC526D030000000049454E44AE426082}
          ShowHint = True
        end
      end
    end
  end
end
