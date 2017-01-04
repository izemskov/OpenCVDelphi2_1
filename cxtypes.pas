unit cxtypes;

interface

const
  IPL_DEPTH_SIGN = $80000000;

  IPL_DEPTH_1U = 1;
  IPL_DEPTH_8U = 8;
  IPL_DEPTH_16U = 16;
  IPL_DEPTH_32F = 32;

  IPL_DEPTH_8S = IPL_DEPTH_SIGN or 8;
  IPL_DEPTH_16S = IPL_DEPTH_SIGN or 16;
  IPL_DEPTH_32S = IPL_DEPTH_SIGN or 32;

  CV_CN_MAX = 64;
  CV_CN_SHIFT = 3;
  CV_DEPTH_MAX = 8;
  CV_MAT_DEPTH_MASK = 7;
  CV_MAT_TYPE_MASK = CV_DEPTH_MAX * CV_CN_MAX - 1;
  CV_MAGIC_MASK = $FFFF0000;
  CV_MAT_MAGIC_VAL = $42420000;
  CV_MAT_CONT_FLAG_SHIFT = 14;
  CV_MAT_CONT_FLAG = 1 shl CV_MAT_CONT_FLAG_SHIFT;
  CV_MAT_CN_MASK = ((CV_CN_MAX - 1) shl CV_CN_SHIFT);

  CV_8U  = 0;
  CV_8S  = 1;
  CV_16U = 2;
  CV_16S = 3;
  CV_32S = 4;
  CV_32F = 5;
  CV_64F = 6;
  CV_USRTYPE1 = 7;

  { CvTermCriteria }
  CV_TERMCRIT_ITER = 1;
  CV_TERMCRIT_NUMBER = CV_TERMCRIT_ITER;
  CV_TERMCRIT_EPS = 2;

  CV_NODE_FLOW  = 8;
  CV_NODE_USER  = 16;
  CV_NODE_EMPTY = 32;
  CV_NODE_NAMED = 64;

type
  PPAnsiChar = ^PAnsiChar;

  PIplROI = ^TIplROI;
  TIplROI = record
    Coi     : Integer;
    XOffset : Integer;
    YOffset : Integer;
    Width   : Integer;
    Height  : Integer;
  end;

  PIplTileInfo = ^IplTileInfo;
  IplTileInfo = record
  end;

  PIplImage = ^TIplImage;
  P2PIplImage = ^PIplImage;
  TIplImage = record
    NSize           : Integer;                      // sizeof(IplImage)
    ID              : Integer;                      // version (=0)
    NChannels       : Integer;                      // Most of OpenCV functions support 1,2,3 or 4 channels
    AlphaChannel    : Integer;                      // Ignored by OpenCV
    Depth           : Integer;                      // Pixel depth in bits: IPL_DEPTH_8U, IPL_DEPTH_8S, IPL_DEPTH_16S, IPL_DEPTH_32S, IPL_DEPTH_32F and IPL_DEPTH_64F are supported.
    ColorModel      : array [0..3] of AnsiChar;     // Ignored by OpenCV
    ChannelSeq      : array [0..3] of AnsiChar;     // ditto
    DataOrder       : Integer;                      // 0 - interleaved color channels, 1 - separate color channels. cvCreateImage can only create interleaved images
    Origin          : Integer;                      // 0 - top-left origin, 1 - bottom-left origin (Windows bitmaps style).
    Align           : Integer;                      // Alignment of image rows (4 or 8). OpenCV ignores it and uses widthStep instead.
    Width           : Integer;                      // Image width in pixels.
    Height          : Integer;                      // Image height in pixels.
    Roi             : PIplROI;                      // Image ROI. If NULL, the whole image is selected.
    MaskROI         : PIplImage;                    // Must be NULL.
    ImageId         : Pointer;
    TileInfo        : PIplTileInfo;
    ImageSize       : Integer;                      // Image data size in bytes (==image->height*image->widthStep in case of interleaved data)
    ImageData       : PByte;                        // Pointer to aligned image data.
    WidthStep       : Integer;                      // Size of aligned image row in bytes.
    BorderMode      : array [0..3] of Integer;      // Ignored by OpenCV.
    BorderConst     : array [0..3] of Integer;      // Ditto.
    ImageDataOrigin : PByte;                        // Pointer to very origin of image data (not necessarily aligned) - needed for correct deallocation
  end;

  PCvSize = ^TCvSize;
  TCvSize = record
    width: Integer;
    height: Integer;
  end;

  PCvArr = Pointer;
  P2PCvArr = ^PCvArr;

  TCvPoint = record
    x: Integer;
    y: Integer;
  end;

  TCvScalar = record
    val: array [0..3] of Double;
  end;

  PCvRect = ^TCvRect;
  TCvRect = record
    x, y: Integer;
    Width, Height: Integer;
  end;

  PIplConvKernel = ^TIplConvKernel;
  P2PIplConvKernel = ^PIplConvKernel;
  TIplConvKernel = record
    nCols: Integer;
    nRows: Integer;
    anchorX: Integer;
    anchorY: Integer;
    values: PInteger;
    nShiftR: Integer;
  end;

  P3CvMat = ^P2CvMat;
  P2CvMat = ^PCvMat;
  PCvMat = ^TCvMat;
  TCvMat = record
    _type: Integer;
    step: Integer;

    refcount: PInteger;
    hdr_refcount: Integer;

    data: Pointer;

    rows: Integer;
    cols: Integer;
  end;

  PCvMemBlock = ^CvMemBlock;
  CvMemBlock = record
    prev: PCvMemBlock;
    next: PCvMemBlock;
  end;

  PCvMemStorage = ^CvMemStorage;
  PPCvMemStorage = ^PCvMemStorage;
  CvMemStorage = record
    signature: Integer;
    bottom: PCvMemBlock;          { First allocated block.                   }
    top: PCvMemBlock;             { Current memory block - top of the stack. }
    parent: PCvMemStorage;        { We get new blocks from parent as needed. }
    block_size: Integer;          { Block size.                              }
    free_space: Integer;          { Remaining free space in current block.   }
  end;

  { CvTermCriteria }
  TCvTermCriteria = record
    _type: Integer;     { may be combination of
                          CV_TERMCRIT_ITER
                          CV_TERMCRIT_EPS }
    max_iter: Integer;
    epsilon: Double;
  end;

  TCvPoint2D32f = record
    x: Single;
    y: Single;
  end;
  PCvPoint2D32f = ^TCvPoint2D32f;

  PCvAttrList = ^TCvAttrList;
  TCvAttrList = record
    attr: PPAnsiChar;         { NULL-terminated array of (attribute_name,attribute_value) pairs. }
    next: PCvAttrList;        { Pointer to next chunk of the attributes list.                    }
  end;

  PCvSeqBlock = ^TCvSeqBlock;
  TCvSeqBlock = record
    prev: PCvSeqBlock;        { Previous sequence block.                   }
    next: PCvSeqBlock;        { Next sequence block.                       }
    start_index: Integer;     { Index of the first element in the block +  }
                              { sequence->first->start_index.              }
    count: Integer;           { Number of elements in the block.           }
    data: PShortInt;          { Pointer to the first element of the block. }
  end;

  PCvSeq = ^TCvSeq;
  TCvSeq = record
    flags: Integer;           { Miscellaneous flags.     }
    header_size: Integer;     { Size of sequence header. }
    h_prev: PCvSeq;           { Previous sequence.       }
    h_next: PCvSeq;           { Next sequence.           }
    v_prev: PCvSeq;           { 2nd previous sequence.   }
    v_next: PCvSeq;           { 2nd next sequence.       }
    total: Integer;           { Total number of elements.            }
    elem_size: Integer;       { Size of sequence element in bytes.   }
    block_max: PShortInt;     { Maximal bound of the last block.     }
    ptr: PShortInt;           { Current write pointer.               }
    delta_elems: Integer;     { Grow seq this many at a time.        }
    storage: PCvMemStorage;   { Where the seq is stored.             }
    free_blocks: PCvSeqBlock; { Free blocks list.                    }
    first: PCvSeqBlock;       { Pointer to the first sequence block. }
  end;

function cvPoint(x, y: Integer): TCvPoint;
function cvSize(width, height: Integer): TCvSize;
function cvScalar(val0: Double; val1: Double = 0; val2: Double = 0; val3: Double = 0): TCvScalar;
function cvScalarAll(val0123: Double): TCvScalar;
function cvRect(AX, AY: Integer; AWidth, AHeight: Integer): TCvRect;
function cvMat(rows: Integer; cols: Integer; _type: Integer; data: Pointer = nil): TCvMat;

function CV_MAT_DEPTH(flags: Integer): Integer;
function CV_MAT_TYPE(flags: Integer): Integer;
function CV_ELEM_SIZE(_type: Integer): Integer;
function CV_MAT_CN(flags: Integer): Integer;
function CV_32FC1: Integer;
function CV_MAKETYPE(depth, cn: Integer): Integer;

{ CvTermCriteria }
function cvTermCriteria(_type: Integer; max_iter: Integer; epsilon: Double): TCvTermCriteria;

implementation

function cvPoint(x, y: Integer): TCvPoint;
begin
  Result.x := x;
  Result.y := y;
end;

function cvSize(width, height: Integer): TCvSize;
begin
  Result.width := width;
  Result.height := height;
end;

function cvScalar(val0: Double; val1: Double = 0; val2: Double = 0; val3: Double = 0): TCvScalar;
begin
  Result.val[0] := val0;
  Result.val[1] := val1;
  Result.val[2] := val2;
  Result.val[3] := val3;
end;

function cvRect(AX, AY: Integer; AWidth, AHeight: Integer): TCvRect;
begin
  Result.x := AX;
  Result.y := AY;
  Result.Width := AWidth;
  Result.Height := AHeight;
end;

function cvMat(rows: Integer; cols: Integer; _type: Integer; data: Pointer = nil): TCvMat;
var
  m: TCvMat;
begin
  if not (CV_MAT_DEPTH(_type) <= CV_64F) then
    exit;

  _type := CV_MAT_TYPE(_type);
  m._type := CV_MAT_MAGIC_VAL or CV_MAT_CONT_FLAG or _type;
  m.cols := cols;
  m.rows := rows;
  m.step := m.cols * CV_ELEM_SIZE(_type);
  m.data := data;
  m.refcount := nil;
  m.hdr_refcount := 0;

  Result := m;
end;

function CV_MAT_DEPTH(flags: Integer): Integer;
begin
  Result := flags and CV_MAT_DEPTH_MASK;
end;

function CV_MAT_TYPE(flags: Integer): Integer;
begin
  Result := flags and CV_MAT_TYPE_MASK;
end;

function CV_MAT_CN(flags: Integer): Integer;
begin
  Result := ((((flags) and CV_MAT_CN_MASK) shr CV_CN_SHIFT) + 1);
end;

function CV_ELEM_SIZE(_type: Integer): Integer;
begin
  Result := (CV_MAT_CN(_type) shl ((((sizeof(Integer) div 4 + 1) * 16384 or $3a50) shr CV_MAT_DEPTH(_type) * 2) and 3));
end;

function CV_32FC1: Integer;
begin
  Result := CV_MAKETYPE(CV_32F, 1);
end;

function CV_MAKETYPE(depth, cn: Integer): Integer;
begin
  Result := (CV_MAT_DEPTH(depth) + (((cn)-1) shl CV_CN_SHIFT));
end;

{ CvTermCriteria }
function cvTermCriteria(_type: Integer; max_iter: Integer; epsilon: Double): TCvTermCriteria;
begin
  Result._type := _type;
  Result.max_iter := max_iter;
  Result.epsilon := epsilon;
end;

function cvScalarAll(val0123: Double): TCvScalar;
begin
  Result.val[0] := val0123;
  Result.val[1] := val0123;
  Result.val[2] := val0123;
  Result.val[3] := val0123;
end;

function cvAttrList(attr: PPAnsiChar = nil; next: PCvAttrList = nil): TCvAttrList;
begin
  Result.attr := attr;
  Result.next := next;
end;

end.
