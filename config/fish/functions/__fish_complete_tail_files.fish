function __fish_complete_tail_files
  complete \
    --command $argv[1] \
    --condition "__fish_contains_arg --" \
    --force-files
end

