#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/hipify
cd $ROCM_BUILD_DIR/hipify
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_PREFIX_PATH=$ROCM_INSTALL_DIR/llvm/ \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR/hip/bin \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_PACKAGING_INSTALL_PREFIX=$ROCM_INSTALL_DIR/hip/bin \
    -DCPACK_GENERATOR=DEB \
    -G Ninja \
    $ROCM_GIT_DIR/HIPIFY
ninja
ninja install
ninja package_hipify-clang
dpkg -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

