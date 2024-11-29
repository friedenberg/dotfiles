#! /bin/bash -e

PATH="$HOME/eng/zit/go/zit/build:$HOME/.dotfiles/result/bin:$HOME/eng/chrest/go/build:$PATH"

ZIT_DIR="${ZIT_DIR/#\~/$HOME}"
export EDITOR="$HOME/.local/bin/vim"

pushd "$ZIT_DIR" >/dev/null
exec "$@"
