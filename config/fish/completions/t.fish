function __t_get_session_completions --description "Prints tmux session tab completion info"
  set -l FORMAT "#{session_name}|#{pane_current_path} #{?session_attached,(attached),}"
  tmux list-sessions -F "$FORMAT" | tr '|' "\t" ^ /dev/null
end

function __t_needs_sessions
  set -l cmd (commandline -opc)
  if test (count $cmd) -eq 1
    return 0
  end

  return 1
end

complete -f -c t -n '__t_needs_sessions' -a "(__t_get_session_completions)"
