all: clean update build

reset-gpg:
  gpgconf --kill all
  gpgconf --reload gpg-agent
  gpg-connect-agent updatestartuptty /bye
  gpg-connect-agent "learn --force" /bye
  gpg-connect-agent "scd serialno" /bye
  gpg --card-status >/dev/null 2>&1

timg-preview:
  timg -pk -I -U --center --clear -W -

preview-zit-object-timg target format:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  zit format-blob {{target}} {{format}} | timg -pk -I -U --center --clear -W -

preview-zit-object target format:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  zit format-blob {{target}} {{format}}

mr-build-and-watch target script:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  fswatch --event Updated -o {{target}} | xargs -I {} bash -c '{{script}}'

git-add-and-commit *PATHS:
  #! /usr/bin/fish
  set -l argv {{PATHS}}
  if test (count $argv) -gt 0
    git add $argv
  end

  set -l diff_status (git diff --cached 2>&1)

  if test -n "$diff_status"
    echo "committing..." >&2

    if not git commit -m update
      return 1
    end
  else
    echo "no changes, just pushing" >&2
  end

  echo "pushing..." >&2
  git push

clean-nix:
  nix-store --gc

clean: clean-nix

update-nix:
  nix flake update

update: update-nix

build-nix:
  nix build

build-rcm:
  rcup

build: build-nix build-rcm
