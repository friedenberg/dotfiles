{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.712007.tar.gz";
    nixpkgs-stable.url = "nixpkgs/release-24.11";
    utils.url = "github:numtide/flake-utils";

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
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let

        pkgs = import nixpkgs
          {
            inherit system;
          };

      in
      {
        packages = {
          default = with pkgs; buildEnv {
            name = "system-packages";
            paths = [
              # pinentry-mac
              reattach-to-user-namespace
            ];
          };
        };
      })
    );
}
