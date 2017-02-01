function fish_greeting --description 'Write out the greeting'
  set -l FISH_ASCII_PATH ~/.config/fish/fish.txt

  if test -f "$FISH_ASCII_PATH"
    cat "$FISH_ASCII_PATH"
  end
end
