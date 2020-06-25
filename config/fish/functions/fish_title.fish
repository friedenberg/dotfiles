function fish_title
  if test -n "$SSH_CLIENT" -a -n "$TMUX"
    echo $_
  else if test -n "$TMUX" -a -n "$ssh_config_current_alias"
    echo $ssh_config_current_alias
  else if test -z "$TMUX" -a -n "$ssh_config_current_alias"
    echo "$ssh_config_current_alias: " (prompt_pwd)
  else
    echo $_
  end
end
