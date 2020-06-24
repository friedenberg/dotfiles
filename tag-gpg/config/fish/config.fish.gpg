# vim: set syntax=fish:

set -x GPG_TTY (tty)

if command -s gpg-connect-agent > /dev/null ^ /dev/null
  gpg-connect-agent /bye > /dev/null ^ /dev/null
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

