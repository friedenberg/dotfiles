
set -l SSH_OLD_AUTH_SOCK $SSH_AUTH_SOCK

if not test -L $HOME/.local/state/ssh/ssh_auth_sock_ssh
  eval (ssh-agent -c) >/dev/null
  ln -s $SSH_AUTH_SOCK $HOME/.local/state/ssh/ssh_auth_sock_ssh
  set -e SSH_AUTH_SOCK
end

set -gx SSH_AUTH_SOCK $SSH_OLD_AUTH_SOCK
