# vim: set syntax=fish:

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

set -x LESSOPEN "| "(realpath ~/.bin/src-hilite-lesspipe.sh)" %s"
set -x LESS " -R "

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

# loading remote fish config, if it exists
set -l remote_config ~/.config/fish/remote_config.fish

if test -e $remote_config -a -n "$SSH_CLIENT"
  source $remote_config
end

set -l gpg_config ~/.gpg-config.fish

if test -e $gpg_config
  source $gpg_config
end

set -l termtab_config ~/.termtabs-config.fish

if test -e $termtab_config
  source $termtab_config
end

# loading local fish config, if it exists
set -l local_config ~/.config/fish/config.fish.local

if test -e $local_config
  source $local_config
end
