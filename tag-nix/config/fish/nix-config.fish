# Setup Nix
# save existing path and then prepend it to prefer my shit
set -l pre_path $PATH
fenv "source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
set PATH $pre_path $PATH
set -e NIX_PATH
