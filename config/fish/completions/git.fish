
set __git_complete_aliases_commit commit
set __git_complete_aliases_checkout co checkout
set __git_complete_aliases_branch br branch
set __git_complete_aliases_show show


__fish_complete_empty \
  git \
  $__git_complete_aliases_commit \
  $__git_complete_aliases_checkout \
  $__git_complete_aliases_branch \
  $__git_complete_aliases_show \
  rm

complete \
  --command git \
  --no-files \
  --condition "__fish_contains_arg $__git_complete_aliases_checkout; and not __fish_contains_arg --" \
  --arguments "(__git_complete_branches)"

complete \
  --command git \
  --no-files \
  --keep-order \
  --condition "__git_complete_needs_fixup" \
  --arguments "(__git_complete_commits_since_master)"

complete \
  --command git \
  --condition "__fish_contains_arg diff" \
  --long-option "word-diff" \
  --description "Show a word diff"

complete \
  --command git \
  --condition "__fish_contains_arg diff" \
  --long-option "no-index" \
  --description "Compare two paths on the filesystem regardless of working tree"

complete \
  --command git \
  --condition "__fish_contains_arg commit" \
  --long-option "fixup" \
  --exclusive \
  --description "Compare two paths on the filesystem regardless of working tree"

complete \
  --command git \
  --condition "__fish_contains_arg rm" \
  --condition "not __fish_contains_opt cached" \
  --long-option "cached" \
  --exclusive \
  --description "unstage and remove paths only from the index. Working tree files, whether modified or not, will be left alone."

complete \
  --command git \
  --condition "__fish_contains_arg rm" \
  --condition "__fish_contains_opt cached" \
  --short-option "r" \
  --exclusive \
  --description "recursive removal when a leading directory name is given."

__fish_complete_tail_files git

# COMPLETIONS

function __git_complete_commits_since_master
  #set merge_base (git merge-base --fork-point master HEAD)
  git log --format="%h%x09%s"
end

function __git_complete_branches
  git branch \
  --sort=-committerdate \
  --format "%(refname:short)%09%(creatordate:relative)"
end

# CONDITIONS

function __git_complete_needs_branch
  return (__fish_contains_arg \
    merge show \
    $__git_complete_aliases_checkout \
    $__git_complete_aliases_show \
    $__git_complete_aliases_branch; or \
    __fish_contains_opt fixup \
    )
end

