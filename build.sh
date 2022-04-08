#!/bin/bash

yum install make automake gcc gcc-c++ openmpi opemmpi-dev cmake zlib -y

git clone https://github.com/graphlab-code/graphlab.git

rm -f graphlab/CMakeLists.txt
cp PowerGraph-build/CMakeLists.txt graphlab
rm -f graphlab/deps/tcmalloc/src/libtcmalloc/src/base/linuxthreads.cc
cp PowerGraph-build/deps/tcmalloc/src/libtcmalloc/src/base/linuxthreads.cc  graphlab/deps/tcmalloc/src/libtcmalloc/src/base/

mkdir graphlab/deps/hadoop/src/hadoop-stamp/hadoop-build -p
mkdir -p graphlab/deps/hadoop/src/hadoop-stamp/hadoop-install

if [ ! -f "graphlab/deps/hadoop/src/hadoop-stamp/hadoop-build/libhdfs.la" ];then
  cp graphlab/deps/hadoop/src/hadoop/c++/Linux-amd64-64/lib/libhdfs.la   graphlab/deps/hadoop/src/hadoop-stamp/hadoop-build
fi

if [ ! -f "graphlab/deps/hadoop/src/hadoop-stamp/hadoop-install/libhdfs.la" ];then
  cp graphlab/deps/hadoop/src/hadoop/c++/Linux-amd64-64/lib/libhdfs.la   graphlab/deps/hadoop/src/hadoop-stamp/hadoop-install
fi

if [ ! -f "/lib64/libhdfs.so" ];then
  cp graphlab/deps/hadoop/src/hadoop/c++/Linux-amd64-64/lib/* /lib64
fi

cd graphlab/
./configure
cd release/
make -j4
