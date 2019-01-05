#!/bin/bash
set -x

./configure \
  --enable-openssl \
  --prefix=$PREFIX \
  --enable-lib-static \
  --enable-lib-shared \
  --extra-cflags="$CFLAGS -I$PREFIX/include" \
  --extra-ldflags="$LDFLAGS"

make install
make check

if [[ ${HOST} =~ .*darwin.* ]]; then
  ${INSTALL_NAME_TOOL:-install_name_tool} -id @rpath/librhash.0.dylib ${PREFIX}/lib/librhash.0.dylib
fi
