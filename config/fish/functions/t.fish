function t --description "create and attach to tmux sessions easily"
  switch (count $argv)
    case '0'
      if test -z $TMUX
        set -l SESSION_NAME (__t_get_session_name_from_path)
        tmux new-session -s "$SESSION_NAME" > /dev/null
      else
        tmux detach
      end

    case '1'
      set -l SESSION_NAME (__t_get_session_name_from_path $argv)

      if test -z $TMUX
        if tmux has-session -t "$SESSION_NAME" > /dev/null ^ /dev/null
          tmux attach -t $argv > /dev/null
        else
          if test ! -d "$argv"
            mkdir -p $argv
          end

          cd $argv
          tmux new-session -s "$SESSION_NAME" > /dev/null
        end
      else
        tmux switch -t "$SESSION_NAME" > /dev/null
      end

    case '*'
      echo 'Incorrect number of arguments passed to t. Expected 0 or 1'
      return 1
  end
end

function __t_get_session_name_from_path
  if test (count $argv) -eq 0
    echo (basename (pwd) | tr "[:upper:]" "[:lower:]")
  else
    echo (basename $argv | tr "[:upper:]" "[:lower:]")
  end
end
