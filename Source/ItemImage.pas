{*******************************************************************************
Image component to display an item
*******************************************************************************}
unit ItemImage;

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, pngimage;

type
  TItemImage = class(TGraphicControl)
  private
    FPngImage: TPNGObject;
    FData: TObject;
    FItemName: String;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;

    procedure LoadFromStream(AStream: TStream);
    procedure LoadFromFile(AFileName: String);
    procedure LoadFromResourceName(AResourceName: String);
    procedure Assign(Source: TPersistent); override;

    property Data: TObject read FData write FData;
    property PngObject: TPNGObject read FPngImage write FPngImage;
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
  FData := nil;
  FItemName := '';
  ShowHint := True;
  FPngImage := TPNGObject.Create;
end;

{*******************************************************************************
Destroys the component
*******************************************************************************}
destructor TItemImage.Destroy;
begin
  if Assigned(FData) then FData.Free;
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
  
  with Canvas do begin
    if FPngImage.Width > 0 then Draw(0, 0, FPngImage);
  end;
end;

{*******************************************************************************
Copy image from another component
*******************************************************************************}
procedure TItemImage.Assign(Source: TPersistent);
begin
  FPngImage.Assign(TItemImage(Source).PngObject);
  Hint := TItemImage(Source).Hint;
  Refresh;
end;

end.
