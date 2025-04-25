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
          } // {
          chrest = chrest.packages.${system}.default;
          fh = fh.packages.${system}.default;
          html-to-pdf = chromium-html-to-pdf.packages.${system}.html-to-pdf;
          pa6e-markdown-to-html = pa6e.packages.${system}.pa6e-markdown-to-html;
          # kmonad = kmonad.packages.${system}.default;
          zit = zit.packages.${system}.default;
        };

      in
      {
        packages = {
          default = with pkgs; buildEnv {
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
              # pa6e-markdown-to-html
              # pinentry
              parallel
              plantuml
              rcm
              html-to-pdf
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
            ];
          };
        };
      })
    );
}
