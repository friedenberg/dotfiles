function __fish_t_get_session_completions --description "Prints tmux session tab completion info"
  set -l ARGUMENT '#{session_name}'
  set -l DESCRIPTION '#{pane_current_path} #{session_windows}'
  paste -s -d ' ' (tmux list-sessions -F "$ARGUMENT\t'$DESCRIPTION'" | psub)
end

function __fish_t_needs_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

complete -f -c t -n '__fish_t_needs_command' -a (__fish_t_get_session_completions)
