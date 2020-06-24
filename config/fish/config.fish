# vim: set syntax=fish:

if command -s minikube > /dev/null ^ /dev/null
  set docker_eval (minikube docker-env --shell fish ^ /dev/null)

  if test 0 -eq $status
    eval $docker_eval
  end
end

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

set -x LESSOPEN "| "(realpath ~/.bin/src-hilite-lesspipe.sh)" %s"
set -x LESS " -R "

# starting virtualfish
if command -s python > /dev/null
  python -c "__import__('virtualfish')" ^ /dev/null > /dev/null

  set -l VIRTUAL_FISH_INSTALLED $status

  if test 0 -eq "$VIRTUAL_FISH_INSTALLED"
    eval (python -m virtualfish)
  end
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

# loading remote fish config, if it exists
set -l remote_config ~/.config/fish/remote_config.fish

if test -e $remote_config -a -n "$SSH_CLIENT"
  source $remote_config
end

# loading local fish config, if it exists
set -l local_config ~/.config/fish/config.fish.local

if test -e $local_config
  source $local_config
end
