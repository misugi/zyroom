object FormCharacter: TFormCharacter
  Left = 345
  Top = 282
  Width = 708
  Height = 432
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
  PixelsPerInch = 96
  TextHeight = 13
  object GridChar: TStringGrid
    Left = 3
    Top = 28
    Width = 694
    Height = 375
    ColCount = 3
    Constraints.MaxHeight = 375
    Constraints.MinHeight = 375
    DefaultColWidth = 36
    DefaultRowHeight = 38
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnDrawCell = GridCharDrawCell
    OnMouseWheelDown = GridCharMouseWheelDown
    OnMouseWheelUp = GridCharMouseWheelUp
    OnSelectCell = GridCharSelectCell
    ColWidths = (
      36
      36
      36)
  end
  object BtNew: TButton
    Left = 7
    Top = 2
    Width = 75
    Height = 23
    Caption = 'Ajouter'
    TabOrder = 1
    OnClick = BtNewClick
  end
  object BtUpdate: TButton
    Left = 90
    Top = 2
    Width = 75
    Height = 23
    Caption = 'Modifier'
    Enabled = False
    TabOrder = 2
    OnClick = BtUpdateClick
  end
  object BtSynchronize: TButton
    Left = 173
    Top = 2
    Width = 75
    Height = 23
    Caption = 'Synchroniser'
    Enabled = False
    TabOrder = 3
    OnClick = BtSynchronizeClick
  end
  object BtDelete: TButton
    Left = 256
    Top = 2
    Width = 75
    Height = 23
    Caption = 'Supprimer'
    Enabled = False
    TabOrder = 4
    OnClick = BtDeleteClick
  end
  object BtRoom: TButton
    Left = 339
    Top = 2
    Width = 75
    Height = 23
    Caption = 'Coffre'
    Enabled = False
    TabOrder = 5
    OnClick = BtRoomClick
  end
end
