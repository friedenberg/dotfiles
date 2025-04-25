{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.712007.tar.gz";
    nixpkgs-stable.url = "nixpkgs/release-24.11";
    utils.url = "github:numtide/flake-utils";

    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , utils
    , kmonad
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let

        pkgs = import nixpkgs
          {
            inherit system;
          } // {
          kmonad = kmonad.packages.${system}.default;
        };

      in
      {
        packages = {
          default = with pkgs; buildEnv {
            name = "system-packages";
            paths = [
              espanso-wayland
              kmonad
              # keyd
            ];
          };
        };
      })
    );
}
