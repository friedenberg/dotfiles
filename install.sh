#! /bin/bash -e

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo /nix/var/nix/profiles/default/bin/nix build
cp rcrc ~/.rcrc
pwd >> ~/.rcrc
./result/bin/rcup
env
pwd
# TODO bootstrap nix
# build nix
# boostrap RCM
