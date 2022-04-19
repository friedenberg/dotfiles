
function mr-build-and-watch
  function __mr-build-and-watch-echo
    echo (date) $argv
  end

  if test (count $argv) -eq 0
    set -l awk_script (dirname (status -f))/mr-build-and-watch-file.awk
    set argv ($awk_script MR_BUILD_AND_WATCH | string unescape)
  end

  argparse --name=mr-build-and-watch \
    'changed_files=+' \
    'c/clear=?' \
    'e/exclude=+' \
    'i/includes=+' \
    -- $argv
  or return

  if set -q _flag_c
    clear
  end

  if test (count $_flag_changed_files) -gt 0
    __mr-build-and-watch-echo changes detected: $_flag_changed_files
  end

  __mr-build-and-watch-echo running "'$argv'"

  eval $argv
  echo
  set -l success $status

  if test $success -eq 0
    bell
  else
    bell Sosumi
  end

  if set -q _MR_BUILD_AND_WATCH_ONCE
    return $success
  end

  set -l excludes

  for f in $_flag_e
    set -a excludes --exclude (string trim $f)
  end

  set -l includes

  if test (count $_flag_i) -eq 0
    set includes (pwd)
  else
    set includes $_flag_i
  end

  echo watching $includes >&2
  echo excluding $excludes >&2

  set -lx _MR_BUILD_AND_WATCH_ONCE 1
  fswatch -r $excludes $includes \
    | xargs -I{} -L1 fish -c "mr-build-and-watch --changed_files {} -- $argv"
end
