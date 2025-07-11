#!/bin/bash

set -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# install clang-related packages
apt-get -y install clang clang-14-doc lldb clang-format

# install qemu for WeensyOS (sadly, this pulls in a lot of crap)
apt-get -y --no-install-recommends install qemu-system-x86 qemu-system-gui

# install programs used for system exploration
apt-get -y install blktrace linux-tools-generic strace tcpdump

# install interactive programs
apt-get -y install bc dc git-doc man micro psmisc file

# install rust
RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust \
  bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -E sh -s -- -y"

# set up libraries
apt-get -y install libreadline-dev locales wamerican libssl-dev

# install programs used for networking
apt-get -y install dnsutils inetutils-ping iproute2 net-tools netcat telnet time traceroute

# remove unneeded .deb files
rm -r /var/lib/apt/lists/*
