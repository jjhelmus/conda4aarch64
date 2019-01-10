#!/bin/bash

export C_INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"

if [[ ${HOST} =~ .*darwin.* ]]; then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath,${LIBRARY_PATH}"
elif [[ ${HOST} =~ .*linux.* ]]; then
    export CFLAGS="${CFLAGS} -I${C_INCLUDE_PATH}"
    export LDFLAGS="${LDFLAGS} -Wl,-rpath,${LIBRARY_PATH} -L${LIBRARY_PATH}"
fi

# NO_GETTEXT disables internationalization (localized message translations)
# NO_INSTALL_HARDLINKS uses symlinks which makes the package 85MB slimmer (8MB instead of 93MB!)

# Add a place for git config files.
mkdir -p "${PREFIX}/etc"
make configure
./configure \
    --prefix="${PREFIX}" \
    --host=${HOST} \
    --with-gitattributes="${PREFIX}/etc/gitattributes" \
    --with-gitconfig="${PREFIX}/etc/gitconfig" \
    --with-iconv="${PREFIX}/lib" \
    --with-perl="${PREFIX}/bin/perl" \
    --with-tcltk="${PREFIX}/bin/tclsh"
make \
    --jobs=${CPU_COUNT} \
    NO_GETTEXT=1 \
    NO_INSTALL_HARDLINKS=1 \
    all strip install \
    ${VERBOSE_AT}

git config --system http.sslVerify true
git config --system http.sslCAPath "${PREFIX}/ssl/cacert.pem"
git config --system http.sslCAInfo "${PREFIX}/ssl/cacert.pem"

# Install completion files
mkdir -p $PREFIX/share/bash-completion/completions
cp contrib/completion/git-completion.bash $PREFIX/share/bash-completion/completions/git
