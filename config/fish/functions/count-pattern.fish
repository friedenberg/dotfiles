# vim: set syntax=fish:

function count-pattern
  ag $argv \
  --only-matching \
  --nofile \
  --nocolor \
  --nobreak \
  | sort \
  | uniq -c \
  | sort -r
end
