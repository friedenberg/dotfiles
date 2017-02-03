function t
  switch (count $argv)
    case '0'
      set -l SESSION_NAME (basename (pwd))
      if test -z $TMUX
        if not tmux attach -t $SESSION_NAME > /dev/null
          tmux new-session -s $SESSION_NAME > /dev/null
        end
      else
        tmux detach
      end

    case '1'
      if test -z $TMUX
        if not tmux attach -t $argv >/dev/null
          cd $argv
          tmux new-session -s (basename $argv) > /dev/null
        end
      else
        tmux switch -t $argv > /dev/null
      end

    case '*'
      echo 'Incorrect number of arguments passed to t. Expected 0 or 1'
      exit 1
  end
end

