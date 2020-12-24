# Defined in - @ line 1
function vim --wraps='mvim -v' --description 'alias vim=mvim -v'
  mvim -v $argv;
end
