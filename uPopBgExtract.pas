unit uPopBgExtract;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Registry;

type
  TPopBgExtract = class(TForm)
    image: TImage;
    image_full: TImage;
    btnImg1: TButton;
    btnImg2: TButton;
    btnImg3: TButton;
    btnImg4: TButton;
    btnSave: TButton;
    About: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnImg1Click(Sender: TObject);
    procedure btnImg2Click(Sender: TObject);
    procedure btnImg3Click(Sender: TObject);
    procedure btnImg4Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
  public
    strPopPath: string;
    function UserFind(f: string): string;
    procedure LoadImage(pal: string; img: string);
  end;

var
  PopBgExtract: TPopBgExtract;

implementation

{$R *.DFM}

procedure TPopBgExtract.FormCreate(Sender: TObject);
var
  reg: TRegistry;
begin
  image_full.Width := 640;
  image_full.Height := 480;

  strPopPath := ExtractFilePath(Application.ExeName);

  reg := TRegistry.Create;
  with reg do try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('Software\Bullfrog Productions Ltd\Populous: The Beginning', False) then
    begin
      if ValueExists('InstallPath') then
        strPopPath := ReadString('InstallPath');
    end;
  finally
    reg.Free;
  end;

  SetCurrentDir(strPopPath);
end;

function TPopBgExtract.UserFind(f: string): string;
var
  dlg: TOpenDialog;
begin
  Result := '';

  dlg := TOpenDialog.Create(Self);
  with dlg do try
    InitialDir := GetCurrentDir;
    Title := f;
    Filter := ExtractFileName(f);
    Filter := Filter + '|' + Filter;
    if Execute then Result := FileName;
  finally
    dlg.Free;
  end;
end;

procedure TPopBgExtract.LoadImage(pal: string; img: string);
var
  h: THandle;
  dwSize, dw: DWORD;
  bufPal: array[0..256] of DWORD;
  bufImg: array[0..307199] of BYTE;
  x, y: integer;
  b: BYTE;
begin
  SetCurrentDir(strPopPath);

  // load pallete

  if not FileExists(pal) then
  begin
    MessageBox(Handle, PChar('Cannot Find File "' + pal + '" !'),
      PChar(Application.Title), MB_ICONEXCLAMATION);
    pal := UserFind(pal);
    if Length(pal) = 0 then Exit;
  end;

  h := CreateFile(PChar(pal), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  if h = INVALID_HANDLE_VALUE then
  begin
    MessageBox(Handle, PChar('Cannot Open File "' + pal + '" !'),
      PChar(Application.Title), MB_ICONHAND);
    Exit;
  end;

  dwSize := SetFilePointer(h, 0, nil, 2);
  if dwSize <> 1024 then
  begin
    CloseHandle(h);
    MessageBox(Handle, 'File Size Mismatch !', PChar(Application.Title), MB_ICONHAND);
    Exit;
  end;

  SetFilePointer(h, 0, nil, 0);
  ReadFile(h, bufPal, 1024, dw, nil);

  CloseHandle(h);

  // load image

  if not FileExists(img) then
  begin
    MessageBox(Handle, PChar('Cannot Find File "' + img + '" !'),
      PChar(Application.Title), MB_ICONEXCLAMATION);
    img := UserFind(img);
    if Length(img) = 0 then Exit;
  end;

  h := CreateFile(PChar(img), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  if h = INVALID_HANDLE_VALUE then
  begin
    MessageBox(Handle, PChar('Cannot Open File "' + img + '" !'),
      PChar(Application.Title), MB_ICONHAND);
    Exit;
  end;

  dwSize := SetFilePointer(h, 0, nil, 2);
  if dwSize <> 307200 then
  begin
    CloseHandle(h);
    MessageBox(Handle, 'File Size Mismatch !', PChar(Application.Title), MB_ICONHAND);
    Exit;
  end;

  SetFilePointer(h, 0, nil, 0);
  ReadFile(h, bufImg, 307200, dw, nil);

  CloseHandle(h);

  // draw image

  for y := 0 to 479 do
  for x := 0 to 639 do
  begin
    b := bufImg[y * 640 + x];
    dw := bufPal[b];
    SetPixel(image_full.Canvas.Handle, x, y, dw);
  end;

  image.Canvas.StretchDraw(image.ClientRect, image_full.Picture.Graphic);

  // enable save

  btnSave.Enabled := True;  
end;

procedure TPopBgExtract.btnImg1Click(Sender: TObject);
begin
  LoadImage('data\fenew\fepal0.dat', 'data\fenew\febackg0.dat');
end;

procedure TPopBgExtract.btnImg2Click(Sender: TObject);
begin
  LoadImage('data\fenew\fepal1.dat', 'data\fenew\febackg1.dat');
end;

procedure TPopBgExtract.btnImg3Click(Sender: TObject);
begin
  LoadImage('data\fenew\fepal0.dat', 'data\plsbackg.dat');
end;

procedure TPopBgExtract.btnImg4Click(Sender: TObject);
begin
  LoadImage('data\backpal.dat', 'data\backpic.dat');
end;

procedure TPopBgExtract.btnSaveClick(Sender: TObject);
var
  dlg: TSaveDialog;
begin
  dlg := TSaveDialog.Create(Self);
  with dlg do try
    InitialDir := GetCurrentDir;
    Filter := 'Bimap (*.bmp)|*.bmp';
    DefaultExt := '*.bmp';
    if Execute then
      image_full.Picture.SaveToFile(FileName);
  finally
    dlg.Free;
  end;
end;

end.
