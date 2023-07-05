#! /bin/bash -e

dir_first_path="$HOME/.dotfiles/result/bin"
PATH="$dir_first_path:$PATH"

ZIT_DIR="${ZIT_DIR/#\~/$HOME}"

pushd "$ZIT_DIR" >/dev/null
exec "$@"
