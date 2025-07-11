#!/bin/bash

set -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

apt-get update &&
  yes | unminimize

# include multiarch support
apt-get -y install binfmt-support &&
  dpkg --add-architecture amd64 &&
  apt-get update &&
  apt-get upgrade

# install GCC-related packages
apt-get -y install binutils-doc cpp-doc gcc-doc g++ gdb gdb-doc gdbserver glibc-doc libblas-dev liblapack-dev liblapack-doc libstdc++-11-doc make make-doc

# install GCC-related packages for amd64
apt-get -y install g++-11-x86-64-linux-gnu gdb-multiarch libc6:amd64 libstdc++6:amd64 libasan8:amd64 libtsan2:amd64 libubsan1:amd64 libreadline-dev:amd64 libblas-dev:amd64 liblapack-dev:amd64 qemu-user

# link x86-64 versions of common tools into /usr/x86_64-linux-gnu/bin
mkdir -p /usr/example/x86_64-linux-gnu/bin
for i in addr2line c++filt cpp-13 g++-11 gcc-13 gcov-13 gcov-dump-13 gcov-tool-13 size strings; do
  ln -sf /usr/bin/x86_64-linux-gnu-$i /usr/example/x86_64-linux-gnu/bin/$i
done &&
  ln -sf /usr/bin/x86_64-linux-gnu-cpp-11 /usr/example/x86_64-linux-gnu/bin/cpp &&
  ln -sf /usr/bin/x86_64-linux-gnu-g++-11 /usr/example/x86_64-linux-gnu/bin/c++ &&
  ln -sf /usr/bin/x86_64-linux-gnu-g++-11 /usr/example/x86_64-linux-gnu/bin/g++ &&
  ln -sf /usr/bin/x86_64-linux-gnu-gcc-11 /usr/example/x86_64-linux-gnu/bin/gcc &&
  ln -sf /usr/bin/x86_64-linux-gnu-gcc-11 /usr/example/x86_64-linux-gnu/bin/cc &&
  ln -sf /usr/bin/gdb-multiarch /usr/example/x86_64-linux-gnu/bin/gdb

# Do main setup
$SCRIPT_DIR/setup-common.sh
rm -f /root/.bash_logout
