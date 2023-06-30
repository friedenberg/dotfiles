{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
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
                  fish
                  pinentry
                  rcm
                  tmux
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
