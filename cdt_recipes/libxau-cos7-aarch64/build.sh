#!/bin/bash

RPM=$(find ${PWD}/binary -name "*.rpm")
mkdir -p ${PREFIX}/aarch64-conda_cos7-linux-gnu/sysroot/usr
pushd ${PREFIX}/aarch64-conda_cos7-linux-gnu/sysroot/usr > /dev/null 2>&1
if [[ -n "${RPM}" ]]; then
  "${RECIPE_DIR}"/rpm2cpio "${RPM}" | cpio -idmv
  popd > /dev/null 2>&1
else
  cp -Rf "${SRC_DIR}"/binary/* .
fi
