#!/bin/bash

echo $PKG_VERSION > conda/.version
. utils/functions.sh && install_conda_full
