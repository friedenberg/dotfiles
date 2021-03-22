# vim: set syntax=fish:

if test (tt display -p '#{?session_attached,TRUE,FALSE}' 2>&1) = TRUE
  exit 0
end

if test (t display -p '#{?session_attached,TRUE,FALSE}' 2>&1) = TRUE
  exit 0
end

if tt has-session -t termtabs 2>&1 > /dev/null
  tt attach
else
  tt new-session -s termtabs
end
