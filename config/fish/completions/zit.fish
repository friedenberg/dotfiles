
complete \
  --command zit \
  --arguments "(__zit_complete)"

function __zit_complete
  set -l cmd (commandline -p --tokenize)
  set cmd $cmd[1..2] -complete $cmd[3..]
  $cmd
end
