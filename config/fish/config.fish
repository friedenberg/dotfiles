# starting up rbenv
if command -s rbenv > /dev/null
  source (rbenv init -|psub)
end

set fish_greeting

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

# hushing motd unless it has changed
cmp -s ~/.hushlogin /etc/motd
if test $status -ne 0
  tee ~/.hushlogin < /etc/motd
end

# loading local fish config, if it exists
set -l local_config ~/.config/fish/config.fish.local

if test -e local_config
  source local_config
end

