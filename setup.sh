#!/usr/bin/env bash

# Run direnv allow if .envrc exists
if [[ -f .envrc ]]; then
  direnv allow
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
ARCH="$(uname -m)"
SCRIPT_PATH=

case "$ARCH" in
x86_64)
  SCRIPT_PATH="$SCRIPT_DIR/setup/setup-amd64.sh"
  ;;
arm64 | aarch64)
  SCRIPT_PATH="$SCRIPT_DIR/setup/setup-arm64.sh"
  ;;
*)
  SCRIPT_PATH="$SCRIPT_DIR/setup/setup-amd64.sh"
  ;;
esac

# Check if script exists
if [[ ! -f "$SCRIPT_PATH" ]]; then
  echo "Setup script not found: $SCRIPT_PATH"
  exit 1
fi

# Run the setup script
chmod +x "$SCRIPT_PATH"
chmod +x "$SCRIPT_DIR/setup/setup-common.sh"
"$SCRIPT_PATH"
