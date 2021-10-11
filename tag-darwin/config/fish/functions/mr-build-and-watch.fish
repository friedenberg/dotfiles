
function mr-build-and-watch
  argparse --name=mr-build-and-watch 'e/exclude=+' -- $argv
  or return

  set -l excludes

  for f in $_flag_e
    set -a excludes --exclude $f
  end

  set -l command $argv

  fswatch -ro $excludes . \
  | xargs -I_ fish -c "echo; and $command; and echo done | ts; and bell; or bell Sosumi"
end
