#!/usr/bin/env bash

set -ex

mkdir build
cd build

# enable components explicitly so we get build error when unsatisfied
# FREESRP needs libfreesrp
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
    -DENABLE_FILE=ON
    -DENABLE_FREESRP=OFF
    -DENABLE_HACKRF=ON
    -DENABLE_IQBALANCE=ON
    -DENABLE_MIRI=ON
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

if [[ $target_platform == linux* ]] ; then
    cmake_config_args+=(
        -DENABLE_FCD=ON
    )
else
    cmake_config_args+=(
        -DENABLE_FCD=OFF
    )
fi

cmake ${CMAKE_ARGS} .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install
