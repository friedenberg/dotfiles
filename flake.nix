{
  inputs = {
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.21.tar.gz";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.712007.tar.gz";
    nixpkgs-stable.url = "nixpkgs/release-24.11";
    utils.url = "github:numtide/flake-utils";

    zit = {
      url = "github:friedenberg/zit?dir=go/zit";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    chrest = {
      url = "github:friedenberg/chrest?dir=go";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    chromium-html-to-pdf = {
      url = "github:friedenberg/chromium-html-to-pdf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    nix = {
      url = "github:friedenberg/dev-flake-templates?dir=nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    pa6e = {
      url = "github:friedenberg/peripage-A6-bluetooth";
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

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , utils
    , zit
    , chrest
    , chromium-html-to-pdf
    , fh
    , nix
    , pa6e
    }:
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
            paths = with pkgs; [
              age
              asdf
              asdf-vm
              bashInteractive
              bats
              chrest.packages.${system}.default
              chromium-html-to-pdf.packages.${system}.html-to-pdf
              # cdparanoia
              coreutils
              # csvkit
              curl
              curlftpfs
              dash
              ddrescue
              direnv
              ffmpeg
              fh.packages.${system}.default
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
              pa6e.packages.${system}.pa6e-markdown-to-html
              parallel
              plantuml
              rcm
              # reattach-to-user-namespace
              rsync
              shellcheck
              shfmt
              silver-searcher
              socat
              sshpass
              sshfs-fuse
              thefuck
              timidity
              timg
              tldr
              tmux
              tree
              uv
              vim
              watchexec
              websocat
              wget
              yubico-piv-tool
              yt-dlp
              zstd
              # kmonad.packages.${system}.default
              zit.packages.${system}.default
            ];
          };

          default = packages.all;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            nix.devShells.${system}.default
          ];
        };
      })
    );
}
