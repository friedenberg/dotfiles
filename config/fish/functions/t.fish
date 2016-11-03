function t
  switch (count $argv)
    case '0'
      set -l SESSION_NAME (basename (pwd))
      if test -z $TMUX
        if not tmux attach -t $SESSION_NAME
          tmux new-session -s $SESSION_NAME
        end
      else
        tmux detach
      end

    case '1'
      if test -z $TMUX
        if not tmux attach -t $argv
          tmux new-session -s $argv
        end
      else
        tmux switch -t $argv
      end

    case '*'
      echo 'Incorrect number of arguments passed to t. Expected 0 or 1'
      exit 1
  end
end

