{*******************************************************************************
Container for item images
*******************************************************************************}
unit ScrollRoom;

interface

uses
  SysUtils, Classes, Controls, Forms, Contnrs, Graphics, Messages, Windows;

type
  TMyControl = class(TControl);
  
  TScrollRoom = class(TScrollBox)
  private
    FAdjust: Boolean;
    FSpacing: Integer;
    FColCount: Integer;
    FCol: Integer;
    FRow: Integer;

    FControlWidth: Integer;
    FControlHeight: Integer;
    
    procedure EvtMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure EvtClick(Sender: TObject);
    procedure EvtPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddControl(AControl: TControl);
    procedure Clear;
    procedure Adjust;
  published
    property Spacing: Integer read FSpacing write FSpacing default 10;
    property ColCount: Integer read FColCount write FColCount default 10;
    property ControlWidth: Integer read FControlWidth write FControlWidth default 48;
    property ControlHeight: Integer read FControlHeight write FControlHeight default 48;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Zyroom', [TScrollRoom]);
end;

{ TScrollRoom }

{*******************************************************************************
Creates the component
*******************************************************************************}
constructor TScrollRoom.Create(AOwner: TComponent);
begin
  inherited;
  FSpacing := 10;
  FColCount := 10;
  FControlWidth := 48;
  FControlHeight := 48;
  FCol := 0;
  FRow := 0;
end;

{*******************************************************************************
Add a new item image
*******************************************************************************}
procedure TScrollRoom.AddControl(AControl: TControl);
begin
  if FCol < FColCount then begin
    AControl.Top := FSpacing + ((FControlHeight + FSpacing) * FRow);
    AControl.Left := FSpacing + ((FControlWidth + FSpacing) * FCol);
  end else begin
    FCol := 0;
    FRow := FRow + 1;
    AControl.Top := FSpacing + ((FControlHeight + FSpacing) * FRow);
    AControl.Left := FSpacing;
  end;
  
  FCol := FCol + 1;

  if not FAdjust then begin
    AControl.Width := FControlWidth;
    AControl.Height := FControlHeight;
    AControl.Cursor := crHandPoint;
    TMyControl(AControl).OnMouseMove := EvtMouseMove;
    TMyControl(AControl).OnContextPopup := EvtPopup;
    TMyControl(AControl).OnClick := EvtClick;
    AControl.Parent := Self;
  end;
end;

{*******************************************************************************
Mouse over the component
*******************************************************************************}
procedure TScrollRoom.EvtMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Assigned(OnMouseMove) then
    OnMouseMove(Sender, Shift, X, Y);
end;

{*******************************************************************************
Clear all item images
*******************************************************************************}
procedure TScrollRoom.Clear;
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do begin
    Controls[0].Free;
  end;
  FCol := 0;
  FRow := 0;
end;

{*******************************************************************************
Click on an item image
*******************************************************************************}
procedure TScrollRoom.EvtClick(Sender: TObject);
begin
  if Assigned(OnClick) then
    OnClick(Sender);
end;

{*******************************************************************************
Adjust images
*******************************************************************************}
procedure TScrollRoom.Adjust;
var
  i: Integer;
begin
  VertScrollBar.Position := 0;
  FColCount := (Self.Width - 22) div (Self.ControlWidth + Self.Spacing);
  FCol := 0;
  FRow := 0;

  FAdjust := True;
  try
    for i := 0 to ControlCount - 1 do begin
      AddControl(Controls[i]);
    end;
  finally
    FAdjust := False;
  end;
end;

procedure TScrollRoom.EvtPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if Assigned(OnContextPopup) then
    OnContextPopup(Sender, MousePos, Handled);
end;

end.
