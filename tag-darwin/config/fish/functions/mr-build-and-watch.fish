
function mr-build-and-watch
  argparse --name=mr-build-and-watch \
    'e/exclude=+' \
    'p/path=+' \
    -- $argv
  or return

  set -l excludes

  for f in $_flag_e
    set -a excludes --exclude $f
  end

  set -l watch_path (pwd)

  if test (count $_flag_p) -gt 0
    set watch_path $_flag_p
  end

  set -l command $argv

  fswatch -ro $excludes $watch_path \
  | xargs -I{} fish -c "echo; and $command; and echo done | ts; and bell; or bell Sosumi"
end
