
#gpg
set -x GPG_TTY (tty)

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

if test -e ~/.asdf/asdf.fish > /dev/null
  source ~/.asdf/asdf.fish
end

# starting virtualfish
if command -s python > /dev/null
  python -c "__import__('virtualfish')" ^ /dev/null > /dev/null
end

set -l VIRTUAL_FISH_INSTALLED $status

if test 0 -eq "$VIRTUAL_FISH_INSTALLED"
  eval (python -m virtualfish)
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

