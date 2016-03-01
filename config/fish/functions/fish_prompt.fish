function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
end

# PWD
set_color $fish_color_cwd
echo -n (prompt_pwd)
set_color normal

set -g __fish_git_prompt_showuntrackedfiles true
set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_showdirtystate true
printf '%s ' (__fish_git_prompt)

if not test $last_status -eq 0
  set_color $fish_color_error
end

echo -n '$ '

set_color normal
end
