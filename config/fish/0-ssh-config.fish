
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
