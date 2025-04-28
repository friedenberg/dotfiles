{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, nixpkgs-stable }:
    (utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          packages.default = pkgs.symlinkJoin {
            name = "ssh";

            paths = [
              pkgs.openssh
              pkgs.sshfs
            ];

            buildInputs = [
              pkgs.makeWrapper
            ];

            postBuild = "
              wrapProgram $out/bin/ssh --add-flags -F --add-flags \\\"\\\$SSH_CONFIG\\\" --prefix PATH : $out/bin
              wrapProgram $out/bin/sshfs --add-flags -F --add-flags \\\"\\\$SSH_CONFIG\\\" --prefix PATH : $out/bin
            ";
          };
        }
      )
    );
}
