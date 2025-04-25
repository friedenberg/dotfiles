all: clean update build

clean-nix:
  nix-store --gc

clean: clean-nix

update-nix:
  nix flake update

update: update-nix

build-nix:
  nix build

[working-directory: "rcm"]
build-rcm:
  rcup

[working-directory: "rcm"]
build-rcm-rcrc:
  # TODO
  cp rcrc ~/.rcrc

build: build-nix build-rcm
