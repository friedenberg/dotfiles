# vim: set syntax=fish:

if test "$TERM_PROGRAM" = "Apple_Terminal" -a -z "$TMUX"
  if tt has-session -t termtab > /dev/null ^ /dev/null
    tt attach -t termtabs
  else
    tt new-session -s termtabs
  end
end

#gpg
set -x GPG_TTY (tty)

if command -s gpg-connect-agent > /dev/null
  gpg-connect-agent /bye > /dev/null ^ /dev/null
  set SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

# aliasing `thefuck` to `fuck`
if command -s thefuck > /dev/null
  eval (thefuck --alias | tr '\n' ';')
end

set -l asdf /usr/local/opt/asdf/asdf.fish
if test -e $asdf > /dev/null
  source $asdf
end

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

if test -f ~/.gpg-agent-info
  posix_source ~/.gpg-agent-info
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
