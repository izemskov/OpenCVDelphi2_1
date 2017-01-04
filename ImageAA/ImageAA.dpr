program ImageAA;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image, dst: PIplImage;
  filename: PAnsiChar;

begin
  try
    // имя картинки задаётся первым параметром
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    // получаем картинку
    image := cvLoadImage(filename, 1);
    // клонируем картинку
    dst := cvCloneImage(image);

    // окно для отображения картинки
    cvNamedWindow(PAnsiChar('original'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('smooth'), CV_WINDOW_AUTOSIZE);

    // сглаживаем исходную картинку
    cvSmooth(image, dst, CV_GAUSSIAN, 3, 3);

    cvShowImage(PAnsiChar('original'), image);
    cvShowImage(PAnsiChar('smooth'), dst);

     // ждём нажатия клавиши
     cvWaitKey(0);

     // освобождаем ресурсы
     cvReleaseImage(@image);
     cvReleaseImage(@dst);
     // удаляем окно
     cvDestroyWindow(PAnsiChar('original'));
     cvDestroyWindow(PAnsiChar('smooth'));

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
