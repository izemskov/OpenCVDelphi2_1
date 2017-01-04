program OpenCVHelloWorld;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  cv,
  highgui,
  cxtypes,
  cxcore;

var
  width, height: Integer;
  pt: TCvPoint;
  hw: PIplImage;
  font: TCvFont;

begin
  try
    width := 620;
    height := 440;

    pt := cvPoint(height div 4, width div 2);
    hw := cvCreateImage(cvSize(Height, Width), 8, 3);
    cvSet(hw, cvScalar(0, 0, 0), nil);
    cvInitFont(@font, CV_FONT_HERSHEY_COMPLEX, 1.0, 1.0, 0, 1, CV_AA);
    cvPutText(hw, PAnsiChar('OpenCV Step By Step'), pt, @font, CV_RGB(150, 0, 150));

    cvNamedWindow(PAnsiChar('Hello World'), 0);

    cvShowImage(PAnsiChar('Hello World'), hw);

    cvWaitKey(0);

    cvReleaseImage(@hw);
    cvDestroyWindow(PAnsiChar('Hello World'));

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
