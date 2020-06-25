
function t --description 'attach to or create an existing session for a given directory'
  if test (count "$argv") -ne 1
    __t_tmux_command $argv
    return $status
  end

  set first_arg $argv[1]

  if test ! -d "$first_arg"
    __t_tmux_command $argv
    return $status
  end

  __t_join_or_attach_directory "$first_arg"
  return $status
end

function __t_tmux_command
  tmux -L sessions $argv
  return $status
end

function __t_join_or_attach_directory
  set session_name (__t_get_session_name_for_path $argv)

  if __t_tmux_command has-session -t "$session_name" > /dev/null ^ /dev/null
    __t_tmux_command attach -t "$session_name" -c "$argv"
    return $status
  else
    __t_tmux_command new-session -s "$session_name" -c "$argv"
    return $status
  end
end

function __t_get_session_name_for_path
  echo (basename "$argv" | tr -d ".")
  return $status
end
