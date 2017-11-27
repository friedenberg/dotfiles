function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  echo ''

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color $fish_color_cwd
  #echo -n (prompt_pwd)
  set_color normal

  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showcolorhints true
  set -g __fish_git_prompt_showdirtystate true
  printf '%s ' (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  end

  #echo '⮐'
  echo ''

  if test "$TERMKIT_HOST_APP" = "Cathode"
    echo -n "> "
  else
    echo -n "\$ "
  end

  set_color normal
end
