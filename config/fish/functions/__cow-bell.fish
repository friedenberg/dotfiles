
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
