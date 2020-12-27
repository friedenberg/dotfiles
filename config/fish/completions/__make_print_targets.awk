#! /usr/bin/env awk -F: -f
#
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
