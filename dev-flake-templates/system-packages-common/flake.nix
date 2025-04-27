{
  inputs = {
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.22.tar.gz";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.717296.tar.gz";
    utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.102.tar.gz";

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

    pa6e = {
      url = "github:friedenberg/peripage-A6-bluetooth";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };
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
    , pa6e
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let

        pkgs = import nixpkgs
          {
            inherit system;
          };

        pkgs-stable = import nixpkgs-stable
          {
            inherit system;
          };

      in
      {
        packages = {
          default = with pkgs; symlinkJoin {
            failOnMissing = true;
            name = "system-packages";
            paths = [
              age
              asdf
              asdf-vm
              bashInteractive
              bats
              # cdparanoia
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
              fh
              gawk
              pkgs-stable.gftp
              git
              git-secret
              glibcLocales
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
              lftp
              libcdio
              # moreutils
              neovim
              nix-direnv
              nixpkgs-fmt
              ocrmypdf
              openssh
              pandoc
              paperkey
              # pinentry
              parallel
              plantuml
              rcm
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
              # yubikey-manager
              zstd
            ] ++ [
              # pa6e-markdown-to-html
              # html-to-pdf
              chrest.packages.${system}.default
              fh.packages.${system}.default
              chromium-html-to-pdf.packages.${system}.html-to-pdf
              pa6e.packages.${system}.pa6e-markdown-to-html
              zit.packages.${system}.default
            ];
          };
        };
      })
    );
}
