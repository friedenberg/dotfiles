function nie --description 'run $EDITOR after loading a particular dev $flake template on $target'
  set -l flake $argv[1]
  set -l target $argv[2]

  nix develop "github:friedenberg/dev-flake-templates?dir=$flake" --command $EDITOR $target
end
