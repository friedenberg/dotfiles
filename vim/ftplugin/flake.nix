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
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              fish
              go
              gopls
              gotools
            ];
          };
        })
    );
}
