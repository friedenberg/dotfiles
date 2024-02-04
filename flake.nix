{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";

    zit = {
      url = "github:friedenberg/zit?dir=go/zit";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };
  };

  outputs = { self, nixpkgs, utils, zit }:
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
                  bats
                  csvkit
                  curl
                  figlet
                  fish
                  git-secret
                  gnuplot
                  gofumpt
                  gpgme
                  graphviz
                  hostess
                  httpie
                  hub
                  neovim
                  ocrmypdf
                  pandoc
                  paperkey
                  pinentry
                  plantuml
                  rcm
                  silver-searcher
                  thefuck
                  tldr
                  tmux
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
