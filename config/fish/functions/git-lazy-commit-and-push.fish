function git-lazy-commit-and-push
  set -l diff_status (git diff --cached 2>&1)

  if test -n "$diff_status"; and not git commit -m update
    return 1
  else
    echo "no changes, just pushing" >&2
  end

  git push
end
