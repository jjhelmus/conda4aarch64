MOVE usr %LIBRARY_PREFIX%\
MOVE etc %LIBRARY_PREFIX%\
MOVE cmd\git.exe %LIBRARY_PREFIX%\bin\git.exe
MOVE mingw%ARCH% %LIBRARY_PREFIX%\
DEL %LIBRARY_PREFIX%\mingw%ARCH%\bin\busybox.exe
MOVE busybox.exe %LIBRARY_PREFIX%\mingw%ARCH%\bin\
