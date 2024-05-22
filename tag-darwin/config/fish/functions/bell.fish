function bell
  set -l sound glass

  if test (count $argv) -gt 0
    set sound $argv[1]
  end

  set sound (string sub -l1 (string upper $sound))(string sub -s2 $sound)

  afplay /System/Library/Sounds/$sound.aiff &
end
