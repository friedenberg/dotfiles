function __fish_contains_arg --description "Checks if a specific argument has been given in the current commandline"
  for i in $argv
    if test -z "$i"
      continue
    end

    if contains -- $argv[1] (commandline -cpo)
      return 0
    end
  end

  return 1
end

