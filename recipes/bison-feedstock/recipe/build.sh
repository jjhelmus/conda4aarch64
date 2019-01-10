#!/bin/bash

export PERL=${BUILD_PREFIX}/bin/perl

M4=m4 \
  ./configure --prefix="$PREFIX" --host=${HOST}
make -j${CPU_COUNT} ${VERBOSE_AT}

make check
make install

strings $PREFIX/bin/bison | grep ${BUILD_PREFIX}/bin/m4 || exit 0
echo "ERROR :: BUILD_PREFIX of ${BUILD_PREFIX}/bin/m4 found in $PREFIX/bin/bison"
exit 1
