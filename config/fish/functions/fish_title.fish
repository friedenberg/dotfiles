function fish_title
  if test -n "$ssh_config_current_alias"; and test -n "$TMUX"
    echo $ssh_config_current_alias
  else
    echo $_
  end
end
