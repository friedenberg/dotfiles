
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

if test -f ~/.gpg-agent-info
  posix-source ~/.gpg-agent-info
end

function clear_screen --on-event fish_postexec
  if test (string sub --length 3 $argv) = 'ssh'
    clear
  end
end

# loading remote fish config, if it exists
set -l remote_config ~/.config/fish/remote_config.fish

if test -e $remote_config -a -n "$SSH_CLIENT"
  source $remote_config
end

# loading local fish config, if it exists
set -l local_config ~/.config/fish/config.fish.local

if test -e local_config
  source local_config
end
