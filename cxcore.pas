unit cxcore;

interface

uses
  cxtypes;

const
  CX_Core_DLL = 'cxcore210.dll';

  { basic font types }
  CV_FONT_HERSHEY_SIMPLEX        = 0;
  CV_FONT_HERSHEY_PLAIN          = 1;
  CV_FONT_HERSHEY_DUPLEX         = 2;
  CV_FONT_HERSHEY_COMPLEX        = 3;
  CV_FONT_HERSHEY_TRIPLEX        = 4;
  CV_FONT_HERSHEY_COMPLEX_SMALL  = 5;
  CV_FONT_HERSHEY_SCRIPT_SIMPLEX = 6;
  CV_FONT_HERSHEY_SCRIPT_COMPLEX = 7;

  CV_AA = 16;

type
  TCvFont = record
    font_face: Integer;         // =CV_FONT_*
    ascii: PInteger;            // font data and metrics
    greek: PInteger;
    cyrillic: PInteger;
    hscale: Single;
    vscale: Single;
    shear: Single;              // slope coefficient: 0 - normal, >0 - italic
    thickness: Integer;         // letters thickness
    dx: Single;                 // horizontal interval between letters
    line_type: Integer;
  end;
  PCvFont = ^TCvFont;

{ Creates IPL image (header and data) }
function cvCreateImage(size: TCvSize; depth, channels: Integer): PIplImage; cdecl;

{ Copies source array to destination array }
procedure cvCopy(const src: PCvArr; dst: PCvArr; const mask: PCvArr = nil); cdecl;

{ Releases (i.e. deallocates) IPL image header }
procedure cvReleaseImage(image: P2PIplImage); cdecl;

{ Sets all or "masked" elements of input array to the same value }
procedure cvSet(arr: PCvArr; value: TCvScalar; const mask: PCvArr); cdecl;

{ Initializes font structure used further in cvPutText }
procedure cvInitFont( font: PCvFont; font_face: Integer; hscale: Double; vscale: Double; shear: Double = 0;
    thickness: Integer = 1; line_type: Integer = 8); cdecl;

{ Renders text stroke with specified font and color at specified location.  CvFont should be initialized with cvInitFont }
procedure cvPutText(img: PCvArr; const text: PAnsiChar; org: TCvPoint; const font: PCvFont; color: TCvScalar); cdecl;

{ Creates a copy of IPL image (widthStep may differ) }
function cvCloneImage(const image: PIplImage): PIplImage; cdecl;

{ Draws a circle with specified center and radius. Thickness works in the same way as with cvRectangle }
procedure cvCircle(img: PCvArr; center: TCvPoint; radius: Integer; color: TCvScalar; thickness: Integer = 1;
                   line_type: Integer = 8; shift: Integer = 0); cdecl;

{ Draws 4-connected, 8-connected or antialiased line segment connecting two points }
procedure cvLine(img: PCvArr; pt1, pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8;
                 shift: Integer = 0); cdecl;

{ Returns width and height of array in elements }
function cvGetSize(const arr: PCvArr): TCvSize; cdecl;

{ Sets image ROI (region of interest) (COI is not changed) }
procedure cvSetImageROI(image: PIplImage; rect: TCVrect); cdecl;

{ dst(mask) = src(mask) + value }
procedure cvAddS(const src: PCvArr; value: TCvScalar; dst: PCvArr; const mask: PCvArr = nil); cdecl;

{ Resets image ROI and COI }
procedure cvResetImageROI(image: PIplImage); cdecl;

{ Clears all the array elements (sets them to 0) }
procedure cvSetZero(arr: PCvArr); cdecl;

{ Mirror array data around horizontal (flip=0),
   vertical (flip=1) or both(flip=-1) axises:
   cvFlip(src) flips images vertically and sequences horizontally (inplace) }
procedure cvFlip(const src: PCvArr; dst: PCvArr = nil; flip_mode: Integer = 0); cdecl;

function CV_RGB(r, g, b: Double): TCvScalar;

{ simple API for reading/writing data }
function cvLoad( filename: PAnsiChar; memstorage: PCvMemStorage = nil;
                    name: PAnsiChar = nil;
                    real_name: PPAnsiChar = nil): Pointer; cdecl;

{ Creates new memory storage.
   block_size == 0 means that default,
   somewhat optimal size, is used (currently, it is 64K) }
function cvCreateMemStorage(block_size: Integer = 0): PCvMemStorage; cdecl;

{ Releases memory storage. All the children of a parent must be released before
   the parent. A child storage returns all the blocks to parent when it is released }
procedure cvReleaseMemStorage(storage: PPCvMemStorage); cdecl;

{ Retrieves pointer to specified sequence element.
   Negative indices are supported and mean counting from the end
   (e.g -1 means the last sequence element) }
function cvGetSeqElem(seq: PCvSeq; index: Integer): PSmallInt; cdecl;

{ Draws a rectangle given two opposite corners of the rectangle (pt1 & pt2),
   if thickness<0 (e.g. thickness == CV_FILLED), the filled box is drawn }
procedure cvRectangle(img: PCvArr; pt1: TCvPoint; pt2: TCvPoint;
                          color: TCvScalar; thickness: Integer = 1;
                          line_type: Integer = 8;
                          shift: Integer = 0); cdecl;

implementation

function cvCreateImage; external CX_Core_DLL name 'cvCreateImage';
procedure cvCopy; external CX_Core_DLL name 'cvCopy';
procedure cvReleaseImage; external CX_Core_DLL name 'cvReleaseImage';
procedure cvSet; external CX_Core_DLL name 'cvSet';
procedure cvInitFont; external CX_Core_DLL name 'cvInitFont';
procedure cvPutText; external CX_Core_DLL name 'cvPutText';
function cvCloneImage; external CX_Core_DLL name 'cvCloneImage';
procedure cvCircle; external CX_Core_DLL name 'cvCircle';
procedure cvLine; external CX_Core_DLL name 'cvLine';
function cvGetSize; external CX_Core_DLL name 'cvGetSize';
procedure cvSetImageROI; external CX_Core_DLL name 'cvSetImageROI';
procedure cvAddS; external CX_Core_DLL name 'cvAddS';
procedure cvResetImageROI; external CX_Core_DLL name 'cvResetImageROI';
procedure cvSetZero; external CX_Core_DLL name 'cvSetZero';
procedure cvFlip; external CX_Core_DLL name 'cvFlip';
function cvLoad; external CX_Core_DLL name 'cvLoad';
function cvCreateMemStorage; external CX_Core_DLL name 'cvCreateMemStorage';
procedure cvReleaseMemStorage; external CX_Core_DLL name 'cvReleaseMemStorage';
function cvGetSeqElem; external CX_Core_DLL name 'cvGetSeqElem';
procedure cvRectangle; external CX_Core_DLL name 'cvRectangle';

function CV_RGB(r, g, b: Double): TCvScalar;
begin
  Result.val[0] := b;
  Result.val[1] := g;
  Result.val[2] := r;
end;

end.
