unit cv;

interface

uses
  cxtypes, cvtypes;

const
  CV_DLL = 'cv210.dll';

  { Image Processing  }
  CV_BLUR_NO_SCALE = 0;
  CV_BLUR = 1;
  CV_GAUSSIAN = 2;
  CV_MEDIAN = 3;
  CV_BILATERAL = 4;

  CV_SHAPE_RECT = 0;
  CV_SHAPE_CROSS = 1;
  CV_SHAPE_ELLIPSE = 2;
  CV_SHAPE_CUSTOM = 100;

  CV_INPAINT_NS = 0;
  CV_INPAINT_TELEA = 1;

  CV_SCHARR = -1;
  CV_MAX_SOBEL_KSIZE = 7;

  { Constants for color conversion }
  CV_BGR2BGRA   = 0;
  CV_RGB2RGBA   = CV_BGR2BGRA;

  CV_BGRA2BGR   = 1;
  CV_RGBA2RGB   = CV_BGRA2BGR;

  CV_BGR2RGBA   = 2;
  CV_RGB2BGRA   = CV_BGR2RGBA;

  CV_RGBA2BGR   = 3;
  CV_BGRA2RGB   = CV_RGBA2BGR;

  CV_BGR2RGB    = 4;
  CV_RGB2BGR    = CV_BGR2RGB;

  CV_BGRA2RGBA  = 5;
  CV_RGBA2BGRA  = CV_BGRA2RGBA;

  CV_BGR2GRAY   = 6;
  CV_RGB2GRAY   = 7;
  CV_GRAY2BGR   = 8;
  CV_GRAY2RGB   = CV_GRAY2BGR;
  CV_GRAY2BGRA  = 9;
  CV_GRAY2RGBA  = CV_GRAY2BGRA;
  CV_BGRA2GRAY  = 10;
  CV_RGBA2GRAY  = 11;

  CV_BGR2BGR565 = 12;
  CV_RGB2BGR565 = 13;
  CV_BGR5652BGR = 14;
  CV_BGR5652RGB = 15;
  CV_BGRA2BGR565 = 16;
  CV_RGBA2BGR565 = 17;
  CV_BGR5652BGRA = 18;
  CV_BGR5652RGBA = 19;

  CV_GRAY2BGR565 = 20;
  CV_BGR5652GRAY = 21;

  CV_BGR2BGR555 = 22;
  CV_RGB2BGR555 = 23;
  CV_BGR5552BGR = 24;
  CV_BGR5552RGB = 25;
  CV_BGRA2BGR555 = 26;
  CV_RGBA2BGR555 = 27;
  CV_BGR5552BGRA = 28;
  CV_BGR5552RGBA = 29;

  CV_GRAY2BGR555 = 30;
  CV_BGR5552GRAY = 31;

  CV_BGR2XYZ    = 32;
  CV_RGB2XYZ    = 33;
  CV_XYZ2BGR    = 34;
  CV_XYZ2RGB    = 35;

  CV_BGR2YCrCb  = 36;
  CV_RGB2YCrCb  = 37;
  CV_YCrCb2BGR  = 38;
  CV_YCrCb2RGB  = 39;

  CV_BGR2HSV    = 40;
  CV_RGB2HSV    = 41;

  CV_BGR2Lab    = 44;
  CV_RGB2Lab    = 45;

  CV_BayerBG2BGR = 46;
  CV_BayerGB2BGR = 47;
  CV_BayerRG2BGR = 48;
  CV_BayerGR2BGR = 49;

  CV_BayerBG2RGB = CV_BayerRG2BGR;
  CV_BayerGB2RGB = CV_BayerGR2BGR;
  CV_BayerRG2RGB = CV_BayerBG2BGR;
  CV_BayerGR2RGB = CV_BayerGB2BGR;

  CV_BGR2Luv    = 50;
  CV_RGB2Luv    = 51;
  CV_BGR2HLS    = 52;
  CV_RGB2HLS    = 53;

  CV_HSV2BGR    = 54;
  CV_HSV2RGB    = 55;

  CV_Lab2BGR    = 56;
  CV_Lab2RGB    = 57;
  CV_Luv2BGR    = 58;
  CV_Luv2RGB    = 59;
  CV_HLS2BGR    = 60;
  CV_HLS2RGB    = 61;

  CV_COLORCVT_MAX = 100;

  CV_INTER_NN = 0;
  CV_INTER_LINEAR = 1;
  CV_INTER_CUBIC = 2;
  CV_INTER_AREA = 3;

  CV_WARP_FILL_OUTLIERS = 8;
  CV_WARP_INVERSE_MAP   = 16;

  CV_MOP_ERODE    = 0;
  CV_MOP_DILATE   = 1;
  CV_MOP_OPEN     = 2;
  CV_MOP_CLOSE    = 3;
  CV_MOP_GRADIENT = 4;
  CV_MOP_TOPHAT   = 5;
  CV_MOP_BLACKHAT = 6;

  { Methods for comparing two array }
  CV_TM_SQDIFF        = 0;
  CV_TM_SQDIFF_NORMED = 1;
  CV_TM_CCORR         = 2;
  CV_TM_CCORR_NORMED  = 3;
  CV_TM_CCOEFF        = 4;
  CV_TM_CCOEFF_NORMED = 5;

(****************************************************************************************\
*                                    Image Processing                                    *
\****************************************************************************************)
{ Copies source 2D array inside of the larger destination array and
   makes a border of the specified type (IPL_BORDER_*) around the copied area. }
procedure cvCopyMakeBorder(const src: PCvArr; dst: PCvArr; offset: TCvPoint;
   bordertype: Integer; value: TCvScalar); cdecl;

{ Smoothes array (removes noise) }
procedure cvSmooth(const src: PCvArr; dst: PCvArr; smoothtype: Integer = CV_GAUSSIAN;
   size1: Integer = 3; size2: Integer = 0; sigma1: Double = 0; sigma2: Double = 0); cdecl;

{ Convolves the image with the kernel }
procedure cvFilter2D(const src: PCvArr; dst: PCvArr; const kernel: PCvMat; anchor: TCvPoint); cdecl;

{ Finds integral image: SUM(X,Y) = sum(x<X,y<Y)I(x,y) }
procedure cvIntegral(const image: PCvArr; sum: PCvArr; sqsum: PCvArr = nil;
   tilted_sum: PCvArr = nil); cdecl;

{
   Smoothes the input image with gaussian kernel and then down-samples it.
   dst_width = floor(src_width/2)[+1],
   dst_height = floor(src_height/2)[+1]
}
procedure cvPyrDown(const src: PCvArr; dst: PCvArr; filter: Integer = CV_GAUSSIAN_5x5); cdecl;

{
   Up-samples image and smoothes the result with gaussian kernel.
   dst_width = src_width*2,
   dst_height = src_height*2
}
procedure cvPyrUp(const src: PCvArr; dst: PCvArr; filter: Integer = CV_GAUSSIAN_5x5); cdecl;

{ Builds pyramid for an image }
function cvCreatePyramid(const img: PCvArr; extra_layers: Integer; rate: Double;
   const layer_sizes: PCvSize = nil; bufarr: PCvArr = nil; calc: Integer = 1;
   filter: Integer = CV_GAUSSIAN_5x5): P2CvMat; cdecl;

{ Releases pyramid }
procedure cvReleasePyramid(pyramid: P3CvMat; extra_layers: Integer); cdecl;

{ Segments image using seed "markers" }
procedure cvWatershed(const image: PCvArr; markers: PCvArr); cdecl;

{ Inpaints the selected region in the image }
procedure cvInpaint(const src: PCvArr; const inpaint_mask: PCvArr;
   dst: PCvArr; inpaintRange: Double; flags: Integer); cdecl;

{ Calculates an image derivative using generalized Sobel
   (aperture_size = 1,3,5,7) or Scharr (aperture_size = -1) operator.
   Scharr can be used only for the first dx or dy derivative }
procedure cvSobel(const src: PCvArr; dst: PCvArr; xorder, yorder: Integer;
   aperture_size: Integer = 3); cdecl;

{ Calculates the image Laplacian: (d2/dx + d2/dy)I }
procedure cvLaplace(const src: PCvArr; dst: PCvArr; aperture_size: Integer = 3); cdecl;

{ Converts input array pixels from one color space to another }
procedure cvCvtColor(const src: PCvArr; dst: PCvArr; code: Integer); cdecl;

{ Resizes image (input array is resized to fit the destination array) }
procedure cvResize(const src: PCvArr; dst: PCvArr; interpolation: Integer = CV_INTER_LINEAR); cdecl;

{ Warps image with affine transform }
{! Variable flags have to have default value is CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS !}
procedure cvWarpAffine(const src: PCvArr; dst: PCvArr; const map_matrix: PCvMat;
   flags: Integer; fillval: TCvScalar); cdecl;

{ Computes affine transform matrix for mapping src[i] to dst[i] (i=0,1,2) }
function cvGetAffineTransform(const src: PCvPoint2D32f; const dst: PCvPoint2D32f;
   map_matrix: PCvMat): PCvMat; cdecl;

{ Computes rotation_matrix matrix }
function cv2DRotationMatrix(center: TCvPoint2D32f; angle: Double;
   scale: Double; map_matrix: PCvMat): PCvMat; cdecl;

{ Warps image with perspective (projective) transform }
{! Variable flags have to have default value is CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS !}
procedure cvWarpPerspective(const src: PCvArr; dst: PCvArr; const map_matrix: PCvMat;
   flags: Integer; fillval: TCvScalar); cdecl;

{ Computes perspective transform matrix for mapping src[i] to dst[i] (i=0,1,2,3) }
function cvGetPerspectiveTransform(const src: PCvPoint2D32f; const dst: PCvPoint2D32f;
   map_matrix: PCvMat): PCvMat; cdecl;

{ Performs generic geometric transformation using the specified coordinate maps }
{! Variable flags have to have default value is CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS !}
procedure cvRemap(const src: PCvArr; dst: PCvArr; const mapx: PCvArr; const mapy: PCvArr;
   flags: Integer; fillval: TCvScalar); cdecl;

{ Converts mapx & mapy from floating-point to integer formats for cvRemap }
procedure cvConvertMaps(const mapx: PCvArr; const mapy: PCvArr;
   mapxy: PCvArr; mapalpha: PCvArr); cdecl;

{ Performs forward or inverse log-polar image transform }
procedure cvLogPolar(const src: PCvArr; dst: PCvArr; center: TCvPoint2D32f; M: Double;
   flags: Integer = (CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS)); cdecl;

{ Performs forward or inverse linear-polar image transform }
procedure cvLinearPolar(const src: PCvArr; dst: PCvArr;
   center: TCvPoint2D32f; maxRadius: Double;
   flags: Integer = (CV_INTER_LINEAR + CV_WARP_FILL_OUTLIERS)); cdecl;

{ creates structuring element used for morphological operations }
function cvCreateStructuringElementEx(cols, rows: Integer; anchor_x, anchor_y: Integer;
   shape: Integer; values: PInteger = nil): PIplConvKernel; cdecl;

{ releases structuring element }
procedure cvReleaseStructuringElement(element: P2PIplConvKernel); cdecl;

{ erodes input image (applies minimum filter) one or more times.
   If element pointer is NULL, 3x3 rectangular element is used }
procedure cvErode(const src: PCvArr; dst: PCvArr; element: PIplConvKernel = nil;
   iterations: Integer = 1); cdecl;

{ dilates input image (applies maximum filter) one or more times.
   If element pointer is NULL, 3x3 rectangular element is used }
procedure cvDilate(const src: PCvArr; dst: PCvArr; element: PIplConvKernel = nil;
  iterations: Integer = 1); cdecl;

{ Performs complex morphological transformation }
procedure cvMorphologyEx(const src: PCvArr; dst: PCvArr; temp: PCvArr; element: PIplConvKernel;
   operation: Integer; iterations: Integer = 1); cdecl;

{ Calculates all spatial and central moments up to the 3rd order }
procedure cvMoments(const arr: PCvArr; moments: PCvMoments; binary: Integer = 0); cdecl;

{ Retrieve particular spatial, central or normalized central moments }
function cvGetSpatialMoment(moments: PCvMoments; x_order, y_order: Integer): Double; cdecl;
function cvGetCentralMoment(moments: PCvMoments; x_order, y_order: Integer): Double; cdecl;
function cvGetNormalizedCentralMoment(moments: PCvMoments; x_order, y_order: Integer): Double; cdecl;

{ Calculates 7 Hu's invariants from precalculated spatial and central moments }
procedure cvGetHuMoments(moments: PCvMoments; hu_moments: PCvHuMoments); cdecl;

(*********************************** data sampling **************************************)

{ Fetches pixels that belong to the specified line segment and stores them to the buffer.
   Returns the number of retrieved points. }
function cvSampleLine(const image: PCvArr; pt1, pt2: TCvPoint; buffer: Pointer;
   connectivity: Integer = 8): Integer; cdecl;

{ Retrieves the rectangular image region with specified center from the input array.
 dst(x,y) <- src(x + center.x - dst_width/2, y + center.y - dst_height/2).
 Values of pixels with fractional coordinates are retrieved using bilinear interpolation }
procedure cvGetRectSubPix(const src: PCvArr; dst: PCvArr; center: TCvPoint2D32f); cdecl;

{ Retrieves quadrangle from the input array.
    matrixarr = ( a11  a12 | b1 )   dst(x,y) <- src(A[x y]' + b)
                ( a21  a22 | b2 )   (bilinear interpolation is used to retrieve pixels
                                     with fractional coordinates)
}
procedure cvGetQuadrangleSubPix(const src: PCvArr; dst: PCvArr; const map_matrix: PCvMat); cdecl;

{ Measures similarity between template and overlapped windows in the source image
   and fills the resultant image with the measurements }
procedure cvMatchTemplate(const image: PCvArr; const templ: PCvArr; result: PCvArr; method: Integer); cdecl;

{ Computes earth mover distance between
   two weighted point sets (called signatures) }
function cvCalcEMD2(const signature1, signature2: PCvArr; distance_type: Integer;
   distance_func: TCvDistanceFunction = nil; const cost_matrix: PCvArr = nil;
   flow: PCvArr = nil; lower_bound: PSingle = nil; userdata: Pointer = nil): Single; cdecl;

{ Runs canny edge detector }
procedure cvCanny(const image: PCvArr; edges: PCvArr; threshold1, threshold2: Double;
   aperture_size: Integer = 3); cdecl;

{ equalizes histogram of 8-bit single-channel image }
procedure cvEqualizeHist(const src: PCvArr; dst: PCvArr); cdecl;

(************************ Haar-like Object Detection functions **************************)

function cvHaarDetectObjects(const image: PCvArr;
                     cascade: PCvHaarClassifierCascade;
                     storage: PCvMemStorage; scale_factor: Double;
                     min_neighbors: Integer; flags: Integer;
                     min_size: TCvSize): PCvSeq; cdecl;

procedure cvReleaseHaarClassifierCascade(cascade: PPCvHaarClassifierCascade); cdecl;

implementation

{ Image Processing  }
procedure cvCopyMakeBorder; external CV_DLL name 'cvCopyMakeBorder';
procedure cvSmooth; external CV_DLL name 'cvSmooth';
procedure cvFilter2D; external CV_DLL name 'cvFilter2D';
procedure cvIntegral; external CV_DLL name 'cvIntegral';
procedure cvPyrDown; external CV_DLL name 'cvPyrDown';
procedure cvPyrUp; external CV_DLL name 'cvPyrUp';
function cvCreatePyramid; external CV_DLL name 'cvCreatePyramid';
procedure cvReleasePyramid; external CV_DLL name 'cvReleasePyramid';
procedure cvWatershed; external CV_DLL name 'cvWatershed';
procedure cvInpaint; external CV_DLL name 'cvInpaint';
procedure cvSobel; external CV_DLL name 'cvSobel';
procedure cvLaplace; external CV_DLL name 'cvLaplace';
procedure cvCvtColor; external CV_DLL name 'cvCvtColor';
procedure cvResize; external CV_DLL name 'cvResize';
procedure cvWarpAffine; external CV_DLL name 'cvWarpAffine';
function cvGetAffineTransform; external CV_DLL name 'cvGetAffineTransform';
function cv2DRotationMatrix; external CV_DLL name 'cv2DRotationMatrix';
procedure cvWarpPerspective; external CV_DLL name 'cvWarpPerspective';
function cvGetPerspectiveTransform; external CV_DLL name 'cvGetPerspectiveTransform';
procedure cvRemap; external CV_DLL name 'cvRemap';
procedure cvConvertMaps; external CV_DLL name 'cvConvertMaps';
procedure cvLogPolar; external CV_DLL name 'cvLogPolar';
procedure cvLinearPolar; external CV_DLL name 'cvLinearPolar';
function cvCreateStructuringElementEx; external CV_DLL name 'cvCreateStructuringElementEx';
procedure cvReleaseStructuringElement; external CV_DLL name 'cvReleaseStructuringElement';
procedure cvErode; external CV_DLL name 'cvErode';
procedure cvDilate; external CV_DLL name 'cvDilate';
procedure cvMorphologyEx; external CV_DLL name 'cvMorphologyEx';
procedure cvMoments; external CV_DLL name 'cvMoments';
function cvGetSpatialMoment; external CV_DLL name 'cvGetSpatialMoment';
function cvGetCentralMoment; external CV_DLL name 'cvGetCentralMoment';
function cvGetNormalizedCentralMoment; external CV_DLL name 'cvGetNormalizedCentralMoment';
procedure cvGetHuMoments; external CV_DLL name 'cvGetHuMoments';
procedure cvGetQuadrangleSubPix; external CV_DLL name 'cvGetQuadrangleSubPix';
procedure cvMatchTemplate; external CV_DLL name 'cvMatchTemplate';
function cvCalcEMD2; external CV_DLL name 'cvCalcEMD2';

{ data sampling }
function cvSampleLine; external CV_DLL name 'cvSampleLine';
procedure cvGetRectSubPix; external CV_DLL name 'cvGetRectSubPix';

procedure cvEqualizeHist; external CV_DLL name 'cvEqualizeHist';
procedure cvCanny; external CV_DLL name 'cvCanny';

function cvHaarDetectObjects; external CV_DLL name 'cvHaarDetectObjects';
procedure cvReleaseHaarClassifierCascade; external CV_DLL name 'cvReleaseHaarClassifierCascade';

end.
