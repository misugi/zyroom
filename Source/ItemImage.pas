{*******************************************************************************
Image component to display an item
*******************************************************************************}
unit ItemImage;

interface

uses
  SysUtils, Classes, Controls, Graphics, pngimage;

type
  TItemImage = class(TGraphicControl)
  private
    FPngImage: TPNGObject;
    FItemName: String;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;

    procedure LoadFromStream(AStream: TStream);
    procedure LoadFromFile(AFileName: String);
    procedure LoadFromResourceName(AResourceName: String);
  published
    property Width;
    property Height;
    property ShowHint;
    property Hint;
    property OnClick;
    property OnMouseMove;
    property ItemName: String read FItemName write FItemName;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Zyroom', [TItemImage]);
end;

{ TItemImage }

{*******************************************************************************
Creates the component
*******************************************************************************}
constructor TItemImage.Create(AOwner: TComponent);
begin
  inherited;
  FItemName := '';
  ShowHint := True;
  FPngImage := TPNGObject.Create;
end;

{*******************************************************************************
Destroys the component
*******************************************************************************}
destructor TItemImage.Destroy;
begin
  FPngImage.Free;
  inherited;
end;

{*******************************************************************************
Loads from a stream
*******************************************************************************}
procedure TItemImage.LoadFromStream(AStream: TStream);
begin
  AStream.Position := 0;
  FPngImage.LoadFromStream(AStream);
end;

{*******************************************************************************
Loads from a file
*******************************************************************************}
procedure TItemImage.LoadFromFile(AFileName: String);
begin
  FPngImage.LoadFromFile(AFileName);
end;

{*******************************************************************************
Loads from a resource
*******************************************************************************}
procedure TItemImage.LoadFromResourceName(AResourceName: String);
begin
  FPngImage.LoadFromResourceName(HInstance, AResourceName);
end;

{*******************************************************************************
Drawing component
*******************************************************************************}
procedure TItemImage.Paint;
begin
  inherited;
  if FPngImage.Width > 0 then Canvas.Draw(0, 0, FPngImage);
end;

end.
