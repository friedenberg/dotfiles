#! /bin/bash -xe

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo /nix/var/nix/profiles/default/bin/nix build
bin_result="$(pwd)/result/bin"
bin_fish="$(readlink "$bin_result/fish")"
export PATH="$bin_result:$PATH"

cp rcrc ~/.rcrc
printf "DOTFILES_DIRS=\"%s\"" "$(pwd)" >> ~/.rcrc
"$bin_result/rcup"
"$bin_fish" -c "fish_add_path $bin_result"

sudo echo "$bin_fish" >> /etc/shells
sudo chsh -s "$bin_fish"

# TODO bootstrap nix
# build nix
# boostrap RCM
