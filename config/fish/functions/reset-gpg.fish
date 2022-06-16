# vim: set syntax=fish:

#function reset-gpg --on-event fish_preexec --description "Reloads GPG Agent"
function reset-gpg --description "Reloads GPG Agent"
  set -l output (mktemp)

  function __reset-gpg_run --inherit-variable output
    set -l cmd $argv
    $cmd > "$output" 2>&1

    if test $status -ne 0
      echo "failed to run command: $cmd" >&2
      cat "$output"
      return 1
    end
  end

  set -e SSH_AGENT_PID
  set -gx GPG_TTY (tty)

  set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  __reset-gpg_run gpg-connect-agent "scd serialno" "learn --force" /bye; or return
  __reset-gpg_run gpgconf --reload gpg-agent; or return
  __reset-gpg_run gpg-connect-agent updatestartuptty /bye; or return
  __reset-gpg_run gpg --card-status; or return

  return $status
end
