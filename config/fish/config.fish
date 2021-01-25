# vim: set syntax=fish:

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

# hushing motd unless it has changed
if test -f /etc/motd
  if not cmp -s ~/.hushlogin /etc/motd
    tee ~/.hushlogin < /etc/motd
  end
end

if set -gq fish_user_paths
  set -l old_fish_user_paths $fish_user_paths
  set -eg fish_user_paths
end

function __source_if_exists
  for some_path in $argv
    if test -e $some_path
      source $some_path
    end
  end
end

__source_if_exists \
  ~/.gpg-config.fish \
  ~/.termtabs-config.fish \
  $ASDF_DIR/asdf.fish \
  ~/.config/fish/config/kernal.fish \
  ~/.config/fish/config/local.fish
