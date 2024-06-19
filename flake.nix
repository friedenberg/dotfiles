{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";

    zit = {
      url = "github:friedenberg/zit?dir=go/zit";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

#     brew-api = {
#       url = "github:BatteredBunny/brew-api";
#       flake = false;
#     };

#     brew = {
#       url = "github:BatteredBunny/brew-nix";
#       inputs.brew-api.follows = "brew-api";
#     };
  };

  outputs = { self, nixpkgs, nixpkgs-master, utils, zit}:
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
            bats
            cdparanoia
            coreutils
            csvkit
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
            git-secret
            gnumake
            gnuplot
            gpgme
            graphviz
            hostess
            httpie
            hub
            imagemagick
            isolyzer
            jq
            lftp
            libcdio
            moreutils
            neovim
            nix-direnv
            nixpkgs-fmt
            ocrmypdf
            pandoc
            paperkey
            pinentry
            plantuml
            rcm
            reattach-to-user-namespace
            rsync
            shellcheck
            shfmt
            silver-searcher
            socat
            sshfs-fuse
            thefuck
            timidity
            tldr
            tmux
            tree
            vim
            wget
            yubico-piv-tool
            zit.packages.${system}.default
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
