program Morph1;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxcore, cxtypes;

var
  image, dst: PIplImage;
  erode, dilate: PIplImage;
  radius: Integer;
  radius_max: Integer;
  iterations: Integer;
  iterations_max: Integer;
  filename: PAnsiChar;
  Kern: PIplConvKernel;
  c: Integer;

  procedure myTrackbarRadius(Pos: Integer); cdecl;
  begin
    radius := Pos;
  end;

  procedure myTrackbarIterations(Pos: Integer); cdecl;
  begin
    iterations := Pos;
  end;

begin
  try
    radius := 1;
    radius_max := 10;
    iterations := 1;
    iterations_max := 10;

    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    image := cvLoadImage(filename, 1);
    dst := cvCloneImage(image);
    erode := cvCloneImage(image);
    dilate := cvCloneImage(image);

    cvNamedWindow(PAnsiChar('original'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('erode'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('dilate'), CV_WINDOW_AUTOSIZE);

    cvCreateTrackbar(PAnsiChar('Radius'), PAnsiChar('original'), @radius, radius_max, myTrackbarRadius);
    cvCreateTrackbar(PAnsiChar('Iterations'), PAnsiChar('original'), @iterations, iterations_max, myTrackbarIterations);

    while true do
    begin
      // показываем картинку
      cvShowImage(PAnsiChar('original'), image);

      // создаём ядро
      Kern := cvCreateStructuringElementEx(radius*2+1, radius*2+1, radius, radius, CV_SHAPE_ELLIPSE);

      // выполняем преобразования
      cvErode(image, erode, Kern, iterations);
      cvDilate(image, dilate, Kern, iterations);

      // показываем результат
      cvShowImage(PAnsiChar('erode'), erode);
      cvShowImage(PAnsiChar('dilate'), dilate);

      cvReleaseStructuringElement(@Kern);

      c := cvWaitKey(33);
      if c = 27 then
        break;
    end;

    // освобождаем ресурсы
    cvReleaseImage(@image);
    cvReleaseImage(@dst);
    cvReleaseImage(@erode);
    cvReleaseImage(@dilate);

    // удаляем окно
    cvDestroyWindow(PAnsiChar('original'));
    cvDestroyWindow(PAnsiChar('erode'));
    cvDestroyWindow(PAnsiChar('dilate'));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
