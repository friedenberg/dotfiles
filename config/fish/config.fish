if source rbenv > /dev/null ^ /dev/null
  . (rbenv init -|psub)
end
set fish_greeting

set -l local_config ~/.config/fish/config.fish.local

if test -e local_config
  source local_config
end

cmp -s ~/.hushlogin /etc/motd
if test $status -ne 0
  tee ~/.hushlogin < /etc/motd
end
