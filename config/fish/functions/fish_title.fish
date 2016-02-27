function fish_title
  if test -n "$TMUX" -a -n "$ssh_config_current_alias"
    echo $ssh_config_current_alias
  else
    echo $_
  end
end
