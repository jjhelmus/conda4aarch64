pushd build\cmake

cmake -G"%CMAKE_GENERATOR%"                      ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"  ^
      -DCMAKE_BUILD_TYPE=Release                 ^
      -DCMAKE_C_FLAGS_RELEASE="%CFLAGS% -I"      ^
      -DCMAKE_CXX_FLAGS_RELEASE="%CXXFLAGS%"     ^
      -DCMAKE_VERBOSE_MAKEFILE=On                ^
      .

:: Build.
if "%c_compiler%" == "vs2008" goto skip_2015
  cmake --build . --config Release -- -verbosity:detailed
  if not errorlevel 0 exit 1
  cmake --build . --config Release --target install -- -verbosity:detailed
  if not errorlevel 0 exit 1
  goto skip_2008
:skip_2015
  cmake --build . --config Release --target install
  if not errorlevel 0 exit 1
:skip_2008

:: Not working since switching from jom to vc generator.
:: Test.
:: ctest -C Release
::  if not errorlevel 0 exit 1
