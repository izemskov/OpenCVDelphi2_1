program Canny;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxtypes, cxcore;

var
  image, gray, dst: PIplImage;
  filename: PAnsiChar;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    // получаем картинку
    image := cvLoadImage(filename, 1);

    gray := cvCreateImage(cvSize(image.Width, image.Height), IPL_DEPTH_8U, 1);
    dst := cvCreateImage(cvSize(image.Width, image.Height), IPL_DEPTH_8U, 1);

    // окно для отображения картинки
    cvNamedWindow('original', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('gray', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('cvCanny', CV_WINDOW_AUTOSIZE);

    // преобразуем в градации серого
    cvCvtColor(image, gray, CV_RGB2GRAY);

    // получаем границы
    cvCanny(gray, dst, 10, 100, 3);

    // показываем картинки
    cvShowImage('original',image);
    cvShowImage('gray', gray);
    cvShowImage('cvCanny', dst);

    // ждём нажатия клавиши
    cvWaitKey(0);

    // освобождаем ресурсы
    cvReleaseImage(@image);
    cvReleaseImage(@gray);
    cvReleaseImage(@dst);

    // удаляем окна
    cvDestroyAllWindows();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
