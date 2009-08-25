unit MisuDevKit;

interface

uses
  Windows, Messages, SHLObj, SysUtils, Classes, Masks;

type
  TFileVersionInfo = (fviCompanyName, fviFileDescription, fviFileVersion,
    fviInternalName, fviLegalCopyright, fviLegalTradeMarks, fviOriginalFileName,
    fviProductName, fviProductVersion, fviComments);

function MdkGetFileContent(AFileName: String): String;
function MdkGetSystemDir(AFolder: Cardinal = CSIDL_DRIVES): String;
function MdkGetFileDate(FileName: String): TDateTime;
function MdkListFiles(ADirectory: String; AFilter: String; SubDir: Boolean; AList: TStringList): Integer;
function MdkRemoveFiles(ADirectory: String; AFilter: String; SudDir: Boolean): Boolean;
function MdkRemoveDir(ADirectory: String): Boolean;
function MdkBoolToInteger(AValue: Boolean): Integer;
function MdkFileVersionInfo(FileName: String; InfoType: TFileVersionInfo): String;

procedure MdkWriteFile(AFileName: String; ABuffer: String; ANewLine: Boolean = True; AOverwrite: Boolean = False);

implementation

{*******************************************************************************
Read file content
*******************************************************************************}
function MdkGetFileContent(AFileName: String): String;
var
  wFile: file;
  wBuffer: array[1..2048] of Char;
  wBytesRead: Integer;
begin
  Result := '';

  AssignFile(wFile, AFileName);
  Reset(wFile, 1);
  try
    wBytesRead := 0;
    BlockRead(wFile, wBuffer, SizeOf(wBuffer), wBytesRead);
    while wBytesRead > 0 do begin
      Result := Result + Copy(wBuffer, 1, wBytesRead);
      BlockRead(wFile, wBuffer, SizeOf(wBuffer), wBytesRead);
    end;
  finally
    CloseFile(wFile);
  end;
end;

{*******************************************************************************
Return system directory
*******************************************************************************}
function MdkGetSystemDir(AFolder: Cardinal = CSIDL_DRIVES): String;
var
  wBuffer : array[1..MAX_PATH] of Char;
begin
  SHGetSpecialFolderPath(0, PChar(@wBuffer), AFolder, False);
  Result := wBuffer;
end;

{*******************************************************************************
Return file date
*******************************************************************************}
function MdkGetFileDate(FileName: String): TDateTime;
begin
  Result := FileDateToDateTime(FileAge(FileName));
end;

{*******************************************************************************
Retourne la liste des fichiers présents dans un répertoire
*******************************************************************************}
function MdkListFiles(ADirectory: String; AFilter: String; SubDir: Boolean; AList: TStringList): Integer;
var
  i: Integer;
  wRec: TSearchRec;
  wDir: String;
  wAttr: Integer;
begin
  if SubDir then wAttr := faAnyFile else wAttr := faAnyFile - faDirectory;
  wDir := IncludeTrailingPathDelimiter(ADirectory);
  Result := 0;
  i := FindFirst(wDir + AFilter, wAttr, wRec);
  while i = 0 do begin
    if SubDir then begin
      if (wRec.Name <> '.') and (wRec.Name <> '..') then begin
        if (wRec.Attr and faDirectory) > 0 then begin
          Result := Result + MdkListFiles(wDir + wRec.Name, AFilter, True, AList);
        end else begin
          AList.Append(wDir + wRec.Name);
          Result := Result + 1;
        end;
      end;
    end else begin
      AList.Append(wDir + wRec.Name);
      Result := Result + 1;
    end;
    i := FindNext(wRec);
  end;
  FindClose(wRec);
  AList.Sort;
end;

{*******************************************************************************
Supprime les fichiers d'un répertoire
*******************************************************************************}
function MdkRemoveFiles(ADirectory: String; AFilter: String; SudDir: Boolean): Boolean;
var
  wList: TStringList;
  i: Integer;
begin
  wList := TStringList.Create;
  try
    Result := True;
    MdkListFiles(ADirectory, AFilter, SudDir, wList);
    for i := 0 to wList.Count - 1 do begin
      Result := Result and DeleteFile(wList[i]);
    end;
  finally
    wList.Free;
  end;
end;

{*******************************************************************************
Supprime un répertoire
*******************************************************************************}
function MdkRemoveDir(ADirectory: String): Boolean;
begin
  MdkRemoveFiles(ADirectory, '*', True);
  Result := RemoveDir(ADirectory);
end;

{*******************************************************************************
Retourne 0 si False et 1 si True
*******************************************************************************}
function MdkBoolToInteger(AValue: Boolean): Integer;
begin
  if AValue then Result := 1 else Result := 0;
end;

{*******************************************************************************
Ecrit dans un fichier texte
*******************************************************************************}
procedure MdkWriteFile(AFileName: String; ABuffer: String; ANewLine: Boolean; AOverwrite: Boolean);
var
  wFile: TextFile;
begin
  AssignFile(wFile, AFileName);
  if AOverwrite then Rewrite(wFile) else
    if FileExists(AFileName) then Append(wFile) else Rewrite(wFile);

  try
    if ANewLine then Writeln(wFile, ABuffer)
      else Write(wFile, ABuffer);
  finally
    Flush(wFile);
    CloseFile(wFile);
  end;
end;

{*******************************************************************************
Retourne les informations de version d'un fichier
*******************************************************************************}
function MdkFileVersionInfo(FileName: String; InfoType: TFileVersionInfo): String;
type
  PTransBuffer = ^TTransBuffer;
  TTransBuffer = array[1..4] of smallint;
var
  iAppSize, iLenOfValue : DWord;
  pcBuf,pcValue         : PChar;
  VerSize               : DWord;
  pTrans                : PTransBuffer;
  TransStr              : string;
  sAppName              : String;
  fvip                  : pointer;
  ft                    : TFileTime;
  st                    : TSystemTime;
  wInfo: String; // information à lire
begin
  Result := '';

  sAppName := Filename;
  // get version information values
  iAppSize:= Windows.GetFileVersionInfoSize(PChar(sAppName),// pointer to filename string
                                    iAppSize);      // pointer to variable to receive zero
   // if GetFileVersionInfoSize is successful
  if iAppSize > 0 then begin
    pcBuf := AllocMem(iAppSize);

    Windows.GetFileVersionInfo(PChar(sAppName),              // pointer to filename string
                       0,                            // ignored
                       iAppSize,                     // size of buffer
                       pcBuf);                       // pointer to buffer to receive file-version info.


    VerQueryValue(pcBuf, '\', fvip, iLenOfValue);

    ft.dwLowDateTime := TVSFixedFileInfo (fvip^).dwFileDateLS;
    ft.dwHighDateTime := TVSFixedFileInfo (fvip^).dwFileDateMS;

    FileTimeToSystemTime(ft,st);

    VerQueryValue(pcBuf, PChar('\VarFileInfo\Translation'),
            pointer(ptrans), verSize);
    TransStr:= IntToHex(ptrans^[1], 4) + IntToHex(ptrans^[2], 4);

    case InfoType of
      fviCompanyName: wInfo := 'CompanyName';
      fviFileDescription: wInfo := 'FileDescription';
      fviFileVersion: wInfo := 'FileVersion';
      fviInternalName: wInfo := 'InternalName';
      fviLegalCopyright: wInfo := 'LegalCopyright';
      fviLegalTradeMarks: wInfo := 'LegalTradeMarks';
      fviOriginalFileName: wInfo := 'OriginalFileName';
      fviProductName: wInfo := 'ProductName';
      fviProductVersion: wInfo := 'ProductVersion';
      fviComments: wInfo := 'Comments';
    end;

    if VerQueryValue(pcBuf,PChar('StringFileInfo\' + TransStr + '\' +
         wInfo), Pointer(pcValue),iLenOfValue) then
          Result := pcValue;
    FreeMem(pcBuf,iAppSize);
  end;
end;

end.
