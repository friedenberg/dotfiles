set -l BUILTIN_COMPLETE "/usr/local/share/fish/completions/git.fish"

if test -e $BUILTIN_COMPLETE
  source $BUILTIN_COMPLETE
end

function __fish_git_get_commits_matching_query --description "Prints commit SHA's and messages matching a given query"
  command git log --format='%h%x09%<(50,trunc)%s' -1000
end

function __fish_git_needs_sha
  return 0
  set -l cmd (commandline -opc)
  set -l last_arg $cmd[-1]
  set -l commands_and_options 'show' 'fixup' 'f'
  contains "$last_arg" "$commands_and_options"
  return $status
end

complete -c git -n "__fish_git_needs_sha" -f -x -a "(__fish_git_get_commits_matching_query)"
complete -c git
