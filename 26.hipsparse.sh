#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/hipsparse
cd $ROCM_BUILD_DIR/hipsparse
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_SET_DESTDIR=OFF \
    -DCPACK_PACKAGING_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DBUILD_CUDA=OFF \
    -DCMAKE_INSTALL_PREFIX=hipsparse-install \
    -G Ninja \
    $ROCM_GIT_DIR/hipSPARSE
ninja
ninja package
dpkg -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

