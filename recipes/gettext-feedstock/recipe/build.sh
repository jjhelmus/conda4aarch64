#!/usr/bin/env bash

./configure --prefix=${PREFIX}  \
            --host=${HOST}
make -j${CPU_COUNT} ${VERBOSE_AT}
make install

# This overlaps with readline:
rm -rf ${PREFIX}/share/info/dir
