program ROI;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image: PIplImage;
  filename: PAnsiChar;
  x, y: Integer;
  width, height: Integer;
  add: Integer;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    // получаем картинку
    image := cvLoadImage(filename, 1);

    cvNamedWindow(PAnsiChar('origianl'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('ROI'), CV_WINDOW_AUTOSIZE);

    if ParamCount > 1 then
      x := StrToInt(ParamStr(2))
    else
      x := 40;

    if ParamCount > 2 then
      y := StrToInt(ParamStr(3))
    else
      y := 20;

    if ParamCount > 3 then
      width := StrToInt(ParamStr(4))
    else
      width := 40;

    if ParamCount > 4 then
      height := StrToInt(ParamStr(5))
    else
      height := 20;

    if ParamCount > 5 then
      add := StrToInt(ParamStr(6))
    else
      add := 200;

    cvShowImage(PAnsiChar('origianl'), image);
    // устанавливаем ROI
    cvSetImageROI(image, cvRect(x, y, width, height));
    cvAddS(image, cvScalar(add), image);
    // сбрасываем ROI
    cvResetImageROI(image);
    // показываем изображение
    cvShowImage(PAnsiChar('ROI'), image);

    // ждём нажатия клавиши
    cvWaitKey(0);

    // освобождаем ресурсы
    cvReleaseImage( @image );
    cvDestroyAllWindows();

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
