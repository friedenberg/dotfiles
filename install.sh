#! /bin/bash -e

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
env
# TODO bootstrap nix
# build nix
# boostrap RCM
