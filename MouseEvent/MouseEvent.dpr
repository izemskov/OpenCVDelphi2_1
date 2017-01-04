program MouseEvent;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image, src: PIplImage;
  filename: PAnsiChar;
  c: Integer;
//  callback: TCvMouseCallback;

procedure drawTarget(aimg: pointer; x, y, radius: Integer);
begin
  cvCircle(image, cvPoint(x, y), radius, CV_RGB(250, 0, 0), 1, 8);
  cvLine(image, cvPoint(x - radius div 2, y - radius div 2), cvPoint(x + radius div 2, y + radius div 2),
     CV_RGB(250, 0, 0), 1, 8);
  cvLine(image, cvPoint(x - radius div 2, y + radius div 2), cvPoint(x + radius div 2, y - radius div 2),
     CV_RGB(250, 0, 0), 1, 8);
end;

procedure myMouseCallback(event: Integer; x, y, flags: Integer; param: pointer); cdecl;
var
  lImg: PIplImage;

begin
  lImg := PIplImage(param);

  case Event of
    CV_EVENT_LBUTTONDOWN:
    begin
      writeln(x, ' x ', y);
      drawTarget(limg, x, y, 10);
    end;
  end;
end;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    image := cvLoadImage(filename, 1);

    // клонируем картинку
    src := cvCloneImage(image);

    // окно для отображения картинки
    cvNamedWindow(PAnsiChar('original'), CV_WINDOW_AUTOSIZE);

   // callback := myMouseCallback;
    // вешаем обработчик мышки
    cvSetMouseCallback(PAnsiChar('original'), myMouseCallback, nil);

    while true do
    begin
      // показываем картинку
      cvCopy(image, src, nil);
      cvShowImage(PAnsiChar('original'), src);

      c := cvWaitKey(33);
      if (c = 27) then
        break;
    end;

    // освобождаем ресурсы
    cvReleaseImage(@image);
    cvReleaseImage(@src);
    // удаляем окно
    cvDestroyWindow(PAnsiChar('original'));

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
