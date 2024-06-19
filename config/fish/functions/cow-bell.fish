function cow-bell
  $argv

  set -l postexec_status $status

  begin
    if test $postexec_status -eq 0
      bell
    else
      bell Sosumi
    end
  end
end

# function on_process_exit --on-event fish_postexec
#   set -l postexec_status $status

#   if not set -q bell_on_exit
#     return
#   end

#   begin
#     if test $postexec_status -eq 0
#       bell
#     else
#       bell Sosumi
#     end
#   end
# end
