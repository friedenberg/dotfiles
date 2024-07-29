# Setup Nix
# save existing path and then prepend it to prefer my shit
# set -l pre_path $PATH
# echo "saving pre path: $PATH"
# fenv "source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
# echo "newly added to path: $PATH"
# set PATH $pre_path $PATH
# echo "newly path: $PATH"
set -e NIX_PATH
fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
