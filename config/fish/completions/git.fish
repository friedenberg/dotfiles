source /usr/local/Cellar/fish/2.3.1/share/fish/completions/git.fish

function __fish_git_get_commits_matching_query --description "Prints commit SHA's and messages matching a given query"
  command git log --format='%h%x09%<(50,trunc)%s' -1000
end

function __fish_git_get_authors --description "Prints author emails"
  command git log --format="%ae" | sort -u
end

function __fish_git_needs_sha
  __fish_git_last_arg_matching_list show fixup f
  return $status
end

function __fish_git_last_arg_matching_list
  set -l cmd (commandline -opc)
  set -l last_arg $cmd[-1]
  set -l list $argv
  contains -- (string trim -l -c - -- "$last_arg") $argv
  return $status
end

function __fish_git_needs_author
  __fish_git_using_command log
  set -l using_log $status

  __fish_git_last_arg_matching_list author
  set -l using_author $status

  test $using_author -eq 0 -a $using_log -eq 0
  return $status
end

function __fish_git_needs_options
  set -l cmd (commandline -opc)
  set -l last_arg $cmd[-1]
end

complete -c git -n "__fish_git_needs_sha" -f -x -a "(__fish_git_get_commits_matching_query)"
complete -c git -n "__fish_git_needs_author" -f -x -a "(__fish_git_get_authors)"
