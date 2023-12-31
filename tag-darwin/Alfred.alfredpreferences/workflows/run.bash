#! /bin/bash -e

PATH="$HOME/.dotfiles/result/bin:$PATH"

ZIT_DIR="${ZIT_DIR/#\~/$HOME}"

pushd "$ZIT_DIR" >/dev/null
exec "$@"
