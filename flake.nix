{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/fe370c252d033f31e138582a8c5d4d8d2e3d8897";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";

    zit = {
      url = "github:friedenberg/zit?dir=go/zit";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    # kmonad = {
    #   url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };


    #     brew-api = {
    #       url = "github:BatteredBunny/brew-api";
    #       flake = false;
    #     };

    #     brew = {
    #       url = "github:BatteredBunny/brew-nix";
    #       inputs.brew-api.follows = "brew-api";
    #     };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, utils, zit }:
    (utils.lib.eachDefaultSystem
      (system:
        let

          pkgs = import nixpkgs {
            inherit system;
          };

        in
        rec {
          packages = {
            all = pkgs.symlinkJoin {
              name = "all";
              paths =
                with
                pkgs;
                [
                  age
                  asdf
                  asdf-vm
                  bashInteractive
                  bats
                  # cdparanoia
                  coreutils
                  # csvkit
                  curl
                  curlftpfs
                  dash
                  ddrescue
                  direnv
                  ffmpeg
                  figlet
                  fish
                  fontconfig
                  fswatch
                  gawk
                  gftp
                  git
                  git-secret
                  gnumake
                  gnuplot
                  gnupg
                  gpgme
                  graphviz
                  hostess
                  httpie
                  hub
                  imagemagick
                  isolyzer
                  jq
                  just
                  # kmonad
                  # keyd
                  lftp
                  libcdio
                  moreutils
                  neovim
                  nix-direnv
                  nixpkgs-fmt
                  ocrmypdf
                  openssh
                  pandoc
                  paperkey
                  # pinentry
                  # pinentry-mac
                  parallel
                  plantuml
                  rcm
                  # reattach-to-user-namespace
                  rsync
                  shellcheck
                  shfmt
                  silver-searcher
                  socat
                  sshfs-fuse
                  thefuck
                  timidity
                  timg
                  tldr
                  tmux
                  tree
                  vim
                  wget
                  yubico-piv-tool
                  zstd
                  # kmonad.packages.${system}.default
                  # zit.packages.${system}.default
                ];
            };

            default = packages.all;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = packages.all.paths;
          };
        })
    );
}
