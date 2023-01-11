#!/usr/bin/env bash

set -ex

mkdir build
cd build

# enable components explicitly so we get build error when unsatisfied
# FCD needs gr-funcube
# FREESRP needs libfreesrp
# IQBALANCE needs gr-iqbalance
# MIRI needs libmirsdr
# XTRX needs libxtrx
cmake_config_args=(
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DLIB_SUFFIX=""
    -DPYTHON_EXECUTABLE=$PYTHON
    -DGR_PYTHON_DIR=$SP_DIR
    -DENABLE_AIRSPY=ON
    -DENABLE_AIRSPYHF=ON
    -DENABLE_BLADERF=ON
    -DENABLE_DOXYGEN=OFF
    -DENABLE_FCD=OFF
    -DENABLE_FILE=ON
    -DENABLE_FREESRP=OFF
    -DENABLE_HACKRF=ON
    -DENABLE_IQBALANCE=OFF
    -DENABLE_MIRI=OFF
    -DENABLE_NONFREE=OFF
    -DENABLE_PYTHON=ON
    -DENABLE_REDPITAYA=ON
    -DENABLE_RFSPACE=ON
    -DENABLE_RTL=ON
    -DENABLE_RTL_TCP=ON
    -DENABLE_SOAPY=ON
    -DENABLE_UHD=ON
    -DENABLE_XTRX=OFF
)

cmake ${CMAKE_ARGS} .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install
