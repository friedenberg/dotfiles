#! /bin/bash -xe

our_bash="$(readlink ~/.dotfiles/result/bin/bash)"
mkdir -p ~/.config/direnv/
cat - > ~/.config/direnv/direnv.toml <<-EOM
bash_path = "$our_bash"
EOM
