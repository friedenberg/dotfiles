
set __git_complete_aliases_commit commit
set __git_complete_aliases_checkout co checkout
set __git_complete_aliases_branch br branch

complete --command git \
  --no-files \
  --condition "__git_complete_needs_branch" \
  --arguments "(__git_complete_branches)"

complete --command git \
  --no-files \
  --condition "__git_complete_needs_fixup" \
  --arguments "(__git_complete_commits_since_master)"

# COMPLETIONS

function __git_complete_commits_since_master
  set merge_base (git merge-base --fork-point master HEAD)
  git log --format="%h|%s" "$merge_base..HEAD" | tr '|' "\t"
end

function __git_complete_branches
  git branch --format "%(refname:short)|%(creatordate:relative)" | tr '|' "\t"
end

# CONDITIONS

function __git_complete_needs_branch
  __git_complete_is_branch_checkout; or __git_complete_is_branch_deletion
end

function __git_complete_is_branch_checkout
  set current_command_line (commandline | string trim | string split " ")

  if not contains $current_command_line[2] $__git_complete_aliases_checkout
    return 1
  end

  return 0
end

function __git_complete_is_branch_deletion
  set current_command_line (commandline | string trim | string split " ")

  if not contains $current_command_line[2] $__git_complete_aliases_branch
    return 1
  end

  return 0
end

function __git_complete_needs_fixup
  set current_command_line (commandline | string trim | string split " ")

  if test (count $current_command_line) -ne 3
    return 1
  end

  if not contains $current_command_line[2] $__git_complete_aliases_commit
    return 1
  end

  if test $current_command_line[3] != "--fixup"
    return 1
  end

  return 0
end

#source /usr/local/Cellar/fish/2.3.1/share/fish/completions/git.fish
#
#function __fish_git_get_commits_matching_query --description "Prints commit SHA's and messages matching a given query"
#  command git log --format='%h%x09%<(50,trunc)%s' -1000
#end
#
#function __fish_git_get_authors --description "Prints author emails"
#  command git log --format="%ae" | sort -u
#end
#
#function __fish_git_needs_sha
#  __fish_git_last_arg_matching_list show fixup f
#  return $status
#end
#
#function __fish_git_last_arg_matching_list
#  set -l cmd (commandline -opc)
#  set -l last_arg $cmd[-1]
#  set -l list $argv
#  contains -- (string trim -l -c - -- "$last_arg") $argv
#  return $status
#end
#
#function __fish_git_needs_author
#  __fish_git_using_command log
#  set -l using_log $status
#
#  __fish_git_last_arg_matching_list author
#  set -l using_author $status
#
#  test $using_author -eq 0 -a $using_log -eq 0
#  return $status
#end
#
#function __fish_git_needs_options
#  set -l cmd (commandline -opc)
#  set -l last_arg $cmd[-1]
#end
#
#complete -c git -n "__fish_git_needs_sha" -f -x -a "(__fish_git_get_commits_matching_query)"
#complete -c git -n "__fish_git_needs_author" -f -x -a "(__fish_git_get_authors)"
