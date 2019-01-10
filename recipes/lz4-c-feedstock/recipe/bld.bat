:: This rougly follow what projects' appveyor file does.

:: Build
if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)

set CONFIGURATION=Release

:: The vc9 build uses a patch that added CMake support from a fork.
:: We do not want to use it for vc14 since upstream provide a sln.

if "%vc%" == "9" goto vc9_build
goto vc14_build

:vc9_build
set COMPILER=-DCMAKE_C_COMPILER=c99-to-c89-cmake-nmake-wrap.bat
set COMPILER=-DCMAKE_C_COMPILER=cl
set C99_TO_C89_WRAP_DEBUG_LEVEL=1
set C99_TO_C89_WRAP_SAVE_TEMPS=1
set C99_TO_C89_WRAP_NO_LINE_DIRECTIVES=1
set C99_TO_C89_CONV_DEBUG_LEVEL=1
COPY %LIBRARY_INC%\inttypes.h src\common\inttypes.h
COPY %LIBRARY_INC%\stdint.h src\common\stdint.h
:: While iterating on this..
:: copy %RECIPE_DIR%\CMakeLists.txt .
:: copy %RECIPE_DIR%\CMakeLists.txt contrib\cmake_unofficial

::       --debug-trycompile -Wdev --debug-output --trace ^

:: pushd contrib\cmake_unofficial
cmake -G "%CMAKE_GENERATOR%" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      %COMPILER% ^
      -DCMAKE_C_USE_RESPONSE_FILE_FOR_OBJECTS:BOOL=FALSE ^
      -DBUILD_SHARED_LIBS=ON ^
      -DBUILD_STATIC_LIBS=OFF ^
      -DLZ4_BUNDLED_MODE=OFF ^
      contrib\cmake_unofficial
cmake --build . --config %CONFIGURATION%
if %ERRORLEVEL% neq 0 exit 1
cmake --build . --target INSTALL --config %CONFIGURATION%
pushd %LIBRARY_PREFIX%\bin
:: This is the legacy command line interface it seems. The vc>=14
:: package does not contain it so we just get rid of it here.
del lz4c.exe
set "DATAGEN=%SRC_DIR%\%CONFIGURATION%\datagen.exe"
goto common_exit

:vc14_build
cd Windows

set VSPROJ_DIR=%SRC_DIR%\visual\VS2010
set BUILD_DIR=%VSPROJ_DIR%\bin\%PLATFORM%_%CONFIGURATION%
msbuild.exe /m ^
    /p:Configuration=%CONFIGURATION% ^
    /p:Platform=%PLATFORM% ^
    /p:PlatformToolset=v140 ^
    /t:Build ^
    %VSPROJ_DIR%\lz4.sln
if errorlevel 1 exit 1

set DATAGEN=datagen

:: Install.
COPY %SRC_DIR%\lib\lz4.h %LIBRARY_INC%
if errorlevel 1 exit 1
COPY %SRC_DIR%\lib\lz4hc.h %LIBRARY_INC%
if errorlevel 1 exit 1
COPY %SRC_DIR%\lib\lz4frame.h %LIBRARY_INC%
if errorlevel 1 exit 1
COPY %BUILD_DIR%\liblz4_static.lib %LIBRARY_LIB%
if errorlevel 1 exit 1
COPY %BUILD_DIR%\liblz4.dll %LIBRARY_BIN%
if errorlevel 1 exit 1
COPY %BUILD_DIR%\liblz4.lib %LIBRARY_LIB%
if errorlevel 1 exit 1
COPY %BUILD_DIR%\lz4.exe %LIBRARY_BIN%
if errorlevel 1 exit 1
cd %BUILD_DIR%

:common_exit
:: Test.
if errorlevel 1 exit 1
lz4 -i1b lz4.exe
if errorlevel 1 exit 1
lz4 -i1b5 lz4.exe
if errorlevel 1 exit 1
lz4 -i1b10 lz4.exe
if errorlevel 1 exit 1
lz4 -i1b15 lz4.exe
if errorlevel 1 exit 1

:: This is a shorter version of `make lz4-test-basic`.
"%DATAGEN%" -g0     | lz4 -v     | lz4 -t
if errorlevel 1 exit 1
"%DATAGEN%" -g16KB  | lz4 -9     | lz4 -t
if errorlevel 1 exit 1
"%DATAGEN%"         | lz4        | lz4 -t
if errorlevel 1 exit 1
"%DATAGEN%" -g6M -P99 | lz4 -9BD | lz4 -t
if errorlevel 1 exit 1
"%DATAGEN%" -g17M   | lz4 -9v    | lz4 -qt
if errorlevel 1 exit 1
"%DATAGEN%" -g33M   | lz4 --no-frame-crc | lz4 -t
if errorlevel 1 exit 1
"%DATAGEN%" -g256MB | lz4 -vqB4D | lz4 -t
if errorlevel 1 exit 1
