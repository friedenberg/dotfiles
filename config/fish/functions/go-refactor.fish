function go-refactor
  set -l rewrite $argv[1]
  set -l files $argv[2..-1]
  gofmt -r $rewrite -d $files &| less

  echo "Proceed with refactor? (Y/n):" >&2
  if test (string lower (read -n 1 -l)) = y
    gofmt -r $rewrite -w $files
  end
end

