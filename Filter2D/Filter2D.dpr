program Filter2D;

{$APPTYPE CONSOLE}

uses
  SysUtils, cv, highgui, cxcore, cxtypes;

var
  filename: PAnsiChar;
  image, dst: PIplImage;
  kernel: array [0..8] of Single;
  kernel_matrix: TCvMat;
  anchor: TCvPoint;

begin
  try
    if ParamCount > 0 then
      filename := PAnsiChar(AnsiString(ParamStr(1)))
    else
      filename := 'image0.jpg';

    image := cvLoadImage(filename, 1);

    dst := cvCloneImage(image);

    // окно для отображения картинки
    cvNamedWindow(PAnsiChar('original'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('cvFilter2DDefinition'), CV_WINDOW_AUTOSIZE);
    cvNamedWindow(PAnsiChar('cvFilter2DBrightness'), CV_WINDOW_AUTOSIZE);

    kernel[0]:= -0.1;
    kernel[1]:= -0.1;
    kernel[2]:= -0.1;

    kernel[3] := -0.1;
    kernel[4] := 2;
    kernel[5] := -0.1;

    kernel[6] := -0.1;
    kernel[7] := -0.1;
    kernel[8] := -0.1;

    // матрица
    kernel_matrix := cvMat(3, 3, CV_32FC1, @kernel);

    anchor.x := -1;
    anchor.y := -1;

    cvFilter2D(image, dst, @kernel_matrix, anchor);

    cvShowImage(PAnsiChar('original'), image);
    cvShowImage(PAnsiChar('cvFilter2DDefinition'), dst);

    kernel[0]:= -0.1;
    kernel[1]:= 0.2;
    kernel[2]:= -0.1;

    kernel[3] := 0.2;
    kernel[4] := 3;
    kernel[5] := 0.2;

    kernel[6] := -0.1;
    kernel[7] := 0.2;
    kernel[8] := -0.1;

    // матрица
    kernel_matrix := cvMat(3, 3, CV_32FC1, @kernel);

    anchor.x := -1;
    anchor.y := -1;

    cvFilter2D(image, dst, @kernel_matrix, anchor);

    cvShowImage(PAnsiChar('cvFilter2DBrightness'), dst);

    cvWaitKey(0);

    cvReleaseImage(@image);
    cvReleaseImage(@dst);
    // удаляем окна
    cvDestroyAllWindows();

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
