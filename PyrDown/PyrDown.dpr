program PyrDown;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image, outimg: PIplImage;
  filename: PAnsiChar;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    // получаем картинку
    image := cvLoadImage(filename, 1);

    if image.Width mod 2 <> 0 then
    begin
      cvReleaseImage(@image);
      Exit;
    end;

    if image.Height mod 2 <> 0 then
    begin
      cvReleaseImage(@image);
      Exit;
    end;

    outimg := cvCreateImage(cvSize(image.Width div 2, image.Height div 2), image.Depth, image.NChannels);

    cvPyrDown(image, outimg);

    cvNamedWindow('original', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('PyrDown', CV_WINDOW_AUTOSIZE);

    cvShowImage('original', image);
    cvShowImage('PyrDown', outimg);

    // ждём нажатия клавиши
    cvWaitKey(0);

    // освобождаем ресурсы
    cvReleaseImage(@image);
    cvReleaseImage(@outimg);

    cvDestroyAllWindows();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
