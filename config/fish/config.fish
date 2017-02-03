# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

if test -e ~/.asdf/asdf.fish > /dev/null
  source ~/.asdf/asdf.fish
end

# hushing motd unless it has changed
if test -f /etc/motd
  if not cmp -s ~/.hushlogin /etc/motd
    tee ~/.hushlogin < /etc/motd
  end
end

# loading local fish config, if it exists
set -l local_config ~/.config/fish/config.fish.local

if test -e local_config
  source local_config
end

