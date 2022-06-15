# vim: set syntax=fish:

#function reset-gpg --on-event fish_preexec --description "Reloads GPG Agent"
function reset-gpg --description "Reloads GPG Agent"
  set -e SSH_AGENT_PID
  set -gx GPG_TTY (tty)

  set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  gpg-connect-agent "scd serialno" "learn --force" /bye \
    and gpgconf --reload gpg-agent >/dev/null 2>&1 \
    and gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 \
    and gpg --card-status >/dev/null 2>&1

  return $status
end
