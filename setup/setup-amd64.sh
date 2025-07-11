#!/bin/bash

set -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

export DEBIAN_FRONTEND=noninteractive

apt-get update &&
  yes | unminimize

apt-get -y install passwd sudo
which useradd

# install GCC-related packages
apt-get update && apt-get -y install binutils-doc cpp-doc gcc-doc g++ g++-multilib gdb gdb-doc gdbserver glibc-doc libblas-dev liblapack-dev liblapack-doc libstdc++-11-doc make make-doc

# Do main setup
$SCRIPT_DIR/setup-common.sh
rm -f /root/.bash_logout
