object FormCharacter: TFormCharacter
  Left = 345
  Top = 282
  Width = 708
  Height = 438
  Caption = 'Personnages'
  Color = 12631988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object GridChar: TStringGrid
    Left = 0
    Top = 28
    Width = 692
    Height = 372
    Align = alClient
    ColCount = 3
    DefaultColWidth = 36
    DefaultRowHeight = 60
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnDblClick = GridCharDblClick
    OnDrawCell = GridCharDrawCell
    OnMouseWheelDown = GridCharMouseWheelDown
    OnMouseWheelUp = GridCharMouseWheelUp
    OnSelectCell = GridCharSelectCell
    ColWidths = (
      36
      36
      36)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object BtNew: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 23
      Caption = 'Ajouter'
      TabOrder = 0
      OnClick = BtNewClick
    end
    object BtUpdate: TButton
      Left = 83
      Top = 0
      Width = 75
      Height = 23
      Caption = 'Modifier'
      Enabled = False
      TabOrder = 1
      OnClick = BtUpdateClick
    end
    object BtDelete: TButton
      Left = 166
      Top = 0
      Width = 75
      Height = 23
      Caption = 'Supprimer'
      Enabled = False
      TabOrder = 2
      OnClick = BtDeleteClick
    end
    object BtRoom: TButton
      Left = 249
      Top = 0
      Width = 75
      Height = 23
      Caption = 'Inventaire'
      Enabled = False
      TabOrder = 3
      OnClick = BtRoomClick
    end
  end
end
