program FaceDetection;

{$APPTYPE CONSOLE}

uses
  SysUtils, cvtypes, cxtypes, cxcore, highgui, cv;

var
  cascade: PCvHaarClassifierCascade;
  storage: PCvMemStorage;
  file1: PAnsiChar;
  dummyImage: PIplImage;
  filename: PAnsiChar;
  image: PIplImage;

  windowName: PAnsiChar;

procedure detectFaces(img: PIplImage);
var
  i: Integer;
  faces: PCvSeq;
  face: PCvRect;

begin
  { detect faces }
  faces := cvHaarDetectObjects(
        img,
        cascade,
        storage,
        1.1,
        3,
        0,                            // CV_HAAR_DO_CANNY_PRUNNING
        cvSize(40, 40));

  if (faces <> nil) then begin
    for i := 0 to faces.total - 1 do begin
      face := PCvRect(cvGetSeqElem(faces, i));
      cvRectangle(img, cvPoint(face.x, face.y),
                          cvPoint(face.x + face.Width, face.y + face.Height),
                          CV_RGB(0, 255, 0), 1, 8, 0);
    end;
  end;
end;

begin
  try
    // !!! Workaround - this code need for correct work cvLoad fuction
    dummyImage := cvCreateImage(cvSize(1, 1), IPL_DEPTH_8U, 1);
    cvErode(dummyImage, dummyImage);
    cvReleaseImage(@dummyImage);
    // !!! Workaround - this code need for correct work cvLoad fuction

    // load cascade for detect face
    file1 := 'data/haarcascades/haarcascade_frontalface_alt.xml';
    cascade := cvLoad(file1, nil, nil, nil);

    storage := cvCreateMemStorage(0);

    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'lena.jpg';

    // load image
    image := cvLoadImage(filename, 1);

    windowName := 'DetectFaces';
    cvNamedWindow(windowName, CV_WINDOW_AUTOSIZE);

    // Detect faces
    detectFaces(image);

    cvShowImage(windowName, image);

    cvWaitKey(0);

    cvReleaseImage(@image);
    cvReleaseHaarClassifierCascade(@cascade);
    cvReleaseMemStorage(@storage);
    cvDestroyAllWindows();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
