#!/bin/bash
set -e

################## System Setup
sudo yum install -y tcsh wget

################## NAMD

COMPILE_THREADS=160


wget http://www.ks.uiuc.edu/Research/namd/2.12/download/832164/NAMD_2.12_Source.tar.gz
tar -xf NAMD_2.12_Source.tar.gz
cd NAMD_2.12_Source

wget http://www.ks.uiuc.edu/Research/namd/libraries/fftw-linux-ppc64le.tar.gz
tar -xf fftw-linux-ppc64le.tar.gz 
mv fftw-linux-ppc64le fftw

wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-ppc64le-threaded.tar.gz
tar -xf tcl8.5.9-linux-ppc64le-threaded.tar.gz
mv tcl8.5.9-linux-ppc64le-threaded tcl-threaded

cp ../Linux-POWER.cuda arch

tar -xf charm-6.7.1.tar
cd charm-6.7.1
./build charm++ multicore-linux-ppc --with-production -j${COMPILE_THREADS}
cd ../


./config Linux-POWER-g++ --charm-arch multicore-linux-ppc --with-cuda
cd Linux-POWER-g++
make -j${COMPILE_THREADS}

cd ../../

echo "success!"
