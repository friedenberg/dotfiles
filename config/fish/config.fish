# vim: set syntax=fish:

set -l SSH_OLD_AUTH_SOCK $SSH_AUTH_SOCK

if test -n $SSH_SSH_AUTH_SOCK
  eval (ssh-agent -c) >/dev/null
  set -gx SSH_SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -e SSH_AUTH_SOCK
end

if test -n $GPG_SSH_AUTH_SOCK
  reset-gpg
  set -gx GPG_SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -e SSH_AUTH_SOCK
end

set -gx SSH_AUTH_SOCK $SSH_OLD_AUTH_SOCK

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

# hushing motd unless it has changed
# TODO change to using XDG
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


env PATH=$HOME/.dotfiles/result/bin direnv hook fish | source
fish_add_path $HOME/.result/bin
fish_add_path $HOME/.local/bin

set -Ux EDITOR $HOME/.local/bin/editor

for file in (find ~/.config/fish -iname '*-config.fish' -print0 | string split0)
  __source_if_exists $file
end

function __cow_bell_on_process_exit --on-event fish_postexec
  set -l postexec_status $pipestatus

  if not set -q bell_on_exit
    return
  end

  __cow-bell $postexec_status
end
