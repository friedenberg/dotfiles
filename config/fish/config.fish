# vim: set syntax=fish:

reset-gpg

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

fish_add_path $HOME/.dotfiles/result/bin

__source_if_exists $ASDF_DIR/asdf.fish

for file in (find ~/.config/fish -iname '*-config.fish' -print0 | string split0)
  __source_if_exists $file
end

function on_process_exit --on-event fish_postexec
  set -l postexec_status $status

  if not set -q bell_on_exit
    return
  end

  begin
    if test $postexec_status -eq 0
      bell
    else
      bell Sosumi
    end
  end
end
