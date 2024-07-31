#! /bin/bash -e

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo /nix/var/nix/profiles/default/bin/nix build
bin_result="$(pwd)/result/bin"
export PATH="$bin_result:$PATH"
cp rcrc ~/.rcrc
printf "DOTFILES_DIRS=\"%s\"" "$(pwd)" >> ~/.rcrc
./result/bin/rcup
fish -c "fish_add_path $bin_result"
env
pwd
# TODO bootstrap nix
# build nix
# boostrap RCM
