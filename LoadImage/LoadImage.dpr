program LoadImage;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image, src: PIplImage;
  filename: PAnsiChar;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    image := cvLoadImage(filename, 1);
    if Assigned(image) then
    begin
      src := cvCloneImage(image);
      cvNamedWindow(PAnsiChar('original'), CV_WINDOW_AUTOSIZE);
      cvShowImage(PAnsiChar('original'), image);

      writeln('[i] channels:    ', image.nChannels);
      writeln('[i] pixel depth: ', image.depth);
      writeln('[i] width:       ', image.width);
      writeln('[i] height:      ', image.height);
      writeln('[i] image size:  ', image.imageSize);
      writeln('[i] width step:  ', image.widthStep);

      cvWaitKey(0);

      cvReleaseImage(@image);
      cvReleaseImage(@src);

      cvDestroyWindow(PAnsiChar('original'));
    end;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
