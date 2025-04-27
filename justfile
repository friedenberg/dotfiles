all: clean update build

clean-nix:
  nix-store --gc

clean: clean-nix

update-nix-local:
  nix flake update \
    system-packages-common \
    system-packages-linux \
    system-packages-darwin

update-nix:
  nix flake update

update: update-nix

build-nix: update-nix-local
  nix build

[working-directory: "rcm"]
build-rcm:
  rcup

[working-directory: "rcm"]
build-rcm-rcrc:
  # TODO
  cp rcrc ~/.rcrc

build: build-nix build-rcm
