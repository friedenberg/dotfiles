#! /usr/bin/env -S awk -F: -f

/# Files/ {
  searching = 1
}

/^[^ \t%#\.]+:/ {
  if (searching && previous_line != "# Not a target")
    printf "%s\ttarget\n", $1
}

/^#/ {
  previous_line = $1
}
