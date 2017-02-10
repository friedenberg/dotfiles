function fish_greeting --description 'Write out the greeting'
  if command -s figlet > /dev/null
    set fonts (find (figlet -I2) -name '*.flf')
    set i (math 'scale=0;'(random)'%'(count $fonts)'+1')
    echo fish | figlet -f $fonts[$i]
  else
    set FISH_ASCII_PATH ~/.config/fish/fish.txt

    if test -f "$FISH_ASCII_PATH"
      cat "$FISH_ASCII_PATH"
    end
  end
end
