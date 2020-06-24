# vim: set syntax=fish:
#
if tt has-session -t termtab > /dev/null ^ /dev/null
  tt attach -t termtabs
else
  tt new-session -s termtabs
end
