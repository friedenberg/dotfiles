#! /bin/bash -e

PATH="$HOME/.nix-profile/bin:$PATH"
PATH="$HOME/.dotfiles/result/bin:$PATH"
PATH="$HOME/eng/zit/go/zit/build:$PATH"

ZIT_DIR="${ZIT_DIR/#\~/$HOME}"

export EDITOR=nvim
exec /Applications/kitty.app/Contents/MacOS/kitty -d "$ZIT_DIR" "$@"
