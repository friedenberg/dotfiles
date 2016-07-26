function gist-head
  set repo_name (basename (git rev-parse --show-toplevel))
  set head_commit (git show --oneline --no-patch HEAD)
  set gist_description "$repo_name: $head_commit"
  git show HEAD | gist -t diff -d "$gist_description"
end
