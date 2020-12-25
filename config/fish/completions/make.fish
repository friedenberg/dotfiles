complete \
 --command make \
  --no-files \
  --arguments "(__make_complete_targets)"

function __make_complete_targets
  make -rpn \
  | awk -F: '
/# Files/ {
    searching = 1
  }

/^[^#.][^%]+:/ {
    if (searching && previous_line != "# Not a target")
      print $1
  }

/^#/ {
    previous_line = $1
  }
  '
end
