#!/bin/sh

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}            \
            PERL='/usr/bin/env perl'

make -j${CPU_COUNT} ${VERBOSE_AT}
# If CONFIG_SITE is not specified, it will pick up your system's default one
# and if you are running a 64-bit system that uses /usr/lib64, then test 231
# in base.at, called "configure directories" will fail since it is hardcoded
# to look for "/prefix/lib":
#
# dnl check that extra slashes are stripped, and that defaults are not expanded
# AT_CHECK_CONFIGURE([--prefix=/usr//])
# AT_CHECK([cat foo], [0], [[prefix=/usr
# exec_prefix=${prefix}
# libdir=${exec_prefix}/lib
# ]])
#
# On fedora 26, /usr/share/config.site contains:
# if test -n "$host"; then
#     # skip when cross-compiling
#     return 0
# fi
#
# if test "$prefix" = /usr \
#    || { test "$prefix" = NONE && test "$ac_default_prefix" = /usr ; }
# then
#     test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
#     test "$sharedstatedir" = '${prefix}/com' && sharedstatedir=/var
#     test "$localstatedir" = '${prefix}/var' && localstatedir=/var
#
#     ARCH=`uname -m`
#     for i in x86_64 ppc64 s390x aarch64; do
#         if test $ARCH = $i; then
#             test "$libdir" = '${exec_prefix}/lib' && libdir='${exec_prefix}/lib64'
#             break
#         fi
#     done
# fi
#
# CONFIG_SITE=/dev/null \
#   make check -j${CPU_COUNT}
#
# To run a single test:
# pushd tests
#   make testsuite
#   /bin/sh ./testsuite -k "configure directories"
# popd

make install
