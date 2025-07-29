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

# Do main setup
$SCRIPT_DIR/setup-common.sh
rm -f /root/.bash_logout
