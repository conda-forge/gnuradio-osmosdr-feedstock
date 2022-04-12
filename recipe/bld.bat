setlocal EnableDelayedExpansion
@echo on

:: Make a build folder and change to it
mkdir build
cd build

:: configure
:: enable components explicitly so we get build error when unsatisfied
cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DPYTHON_EXECUTABLE:PATH="%PYTHON%" ^
    -DGR_PYTHON_DIR:PATH="%SP_DIR%" ^
    -DENABLE_AIRSPY=ON ^
    -DENABLE_AIRSPYHF=ON ^
    -DENABLE_BLADERF=ON ^
    -DENABLE_DOXYGEN=OFF ^
    -DENABLE_FILE=ON ^
    -DENABLE_FREESRP=OFF ^
    -DENABLE_HACKRF=ON ^
    -DENABLE_IQBALANCE=OFF ^
    -DENABLE_NONFREE=OFF ^
    -DENABLE_PYTHON=ON ^
    -DENABLE_REDPITAYA=OFF ^
    -DENABLE_RFSPACE=OFF ^
    -DENABLE_RTL=ON ^
    -DENABLE_RTL_TCP=ON ^
    -DENABLE_SOAPY=ON ^
    -DENABLE_UHD=ON ^
    ..
if errorlevel 1 exit 1

:: build
cmake --build . --config Release -- -j%CPU_COUNT%
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
