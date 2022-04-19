#! /usr/bin/awk -f

BEGIN {
  saw_includes = 0
  saw_excludes = 0
  saw_command = 0
  current_section = ""
}

/^INCLUDES:$/ {
  if (saw_includes == 1) {
    print "More than one includes block" > "/dev/stderr"
    exit 1
  }

  current_section = "INCLUDES"
  saw_includes = 1

  next
}

/^EXCLUDES:$/ {
  if (saw_excludes == 1) {
    print "More than one excludes block" > "/dev/stderr"
    exit 1
  }

  current_section = "EXCLUDES"
  saw_excludes = 1

  next
}

/^COMMAND:$/ {
  if (saw_command == 1) {
    print "More than one command block" > "/dev/stderr"
    exit 1
  }

  print "--"
  current_section = "COMMAND"
  saw_command = 1

  next
}

{
  if ($0 == "") {
    next
  }

  if (current_section == "COMMAND") {
    print $0 ";"
  } else if (current_section == "INCLUDES") {
    print "-i", $0
  } else if (current_section == "EXCLUDES") {
    print "-e", $0
  }
}
