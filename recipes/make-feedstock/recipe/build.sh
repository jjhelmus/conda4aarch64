./configure --prefix=${PREFIX} \
            --host=${HOST}
# bootstrap make with their own build script
sh build.sh
#make -j${CPU_COUNT} ${VERBOSE_AT}
./make check
./make install
