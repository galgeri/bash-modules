#!/bin/bash
# ~/.bash-modules/bash-modules.sh

BASH_MODULES_ROOT="${HOME}/.bash-modules"

# Load aliases
ALIASES_DIR="${BASH_MODULES_ROOT}/modules/aliases.d"
if [ -d "$ALIASES_DIR" ]; then
  for file in "$ALIASES_DIR"/*.aliases; do
    [ -f "$file" ] && source "$file"
  done
fi

# Load helper functions
HELPERS_DIR="${BASH_MODULES_ROOT}/modules/helpers.d"
if [ -d "$HELPERS_DIR" ]; then
  for file in "$HELPERS_DIR"/*.helper.sh; do
    [ -f "$file" ] && source "$file"
  done
fi

# Add bin/ to PATH
BIN_DIR="${BASH_MODULES_ROOT}/modules/bin"
if [ -d "$BIN_DIR" ]; then
  PATH="$BIN_DIR:$PATH"
fi

export PATH

