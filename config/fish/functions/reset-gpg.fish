# vim: set syntax=fish:

function reset-gpg --description "Reloads GPG Agent"
  function __reset-gpg_run
    set -l cmd $argv
    set -l output ($cmd 2>&1)

    if test $status -ne 0
      echo "failed to run command: $cmd" >&2
      echo "$output"
      return 1
    end
  end

  # set -e SSH_AGENT_PID
  set -gx GPG_TTY (tty)

  ln -sf (gpgconf --list-dirs agent-ssh-socket) $HOME/.local/state/ssh/ssh_auth_sock_gpg

  __reset-gpg_run gpg-connect-agent "scd serialno" "learn --force" /bye; or return
  __reset-gpg_run gpgconf --reload gpg-agent; or return
  __reset-gpg_run gpg-connect-agent updatestartuptty /bye; or return
  __reset-gpg_run gpg --card-status >/dev/null 2>&1; or return

  return $status
end
