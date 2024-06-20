function __cow-bell
  set -l postexec_status $argv

  begin
    if test $postexec_status -eq 0
      bell
    else
      bell Sosumi
    end
  end
end

function cow-bell
  $argv
  __cow-bell $status
end

function cow_bell_on_process_exit --on-event fish_postexec
  set -l postexec_status $status

  if not set -q bell_on_exit
    return
  end

  __cow-bell $postexec_status
end
