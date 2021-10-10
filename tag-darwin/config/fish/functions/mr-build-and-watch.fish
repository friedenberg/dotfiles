
function mr-build-and-watch
  set -l exclude $argv[1]
  set -l command $argv[2]

  fswatch -ro --exclude $exclude . \
  | xargs -I_ fish -c "echo; and $command; and echo done | ts; and bell; or bell Sosumi"
end
