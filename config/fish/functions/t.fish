function t --description "create and attach to tmux sessions easily"
  if not __t_in_main_session
    echo 'Not in main session. Refusing to create or join a new one.'
    return 1
  end

  switch (count $argv)
  case '0'
    __t_create_session $argv

  case '1'
    __t_create_or_join "$argv"

  case '*'
    echo 'Incorrect number of arguments passed to t. Expected 0 or 1'
    return 1
  end
end

function __t_create_or_join
  if tmux has-session -t "$argv"
    __t_join_session "$argv"
  else
    cd
    __t_create_session "$argv"
  end
end

function __t_create_session
  set session_name (__t_get_session_name_from_path)
  env -u TMUX tmux -L sessions -f ~/.tmux.conf new-session -s "$session_name" > /dev/null
end

function __t_join_session
  env -u TMUX tmux -L sessions attach -t "$argv" > /dev/null
end

function __t_get_session_name_from_path
  if test (count $argv) -eq 0
    set DIR (pwd)
  else
    set DIR "$argv"
  end

  echo (basename $DIR | tr ".[:upper:]" "_[:lower:]")
end

function __t_in_main_session
  if test -z $TMUX
    return 1
  end

  tmux -L termtabs has-session -t "termtabs" > /dev/null ^ /dev/null
  return $status
end

function __t_get_session_completions --description "Prints tmux session tab completion info"
  set -l FORMAT "#{session_name}|#{pane_current_path} #{?session_attached,(attached),}"
  tmux -L sessions list-sessions -F "$FORMAT" | tr '|' "\t" ^ /dev/null
  __fish_complete_directories
end

function __t_needs_sessions
  set -l cmd (commandline -opc)
  if test (count $cmd) -eq 1
    return 0
  end

  return 1
end
