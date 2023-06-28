#! /usr/bin/env bash

PATH="$(realpath "$(dirname "$(readlink "$0")")/result/bin"):$PATH"

test_one() (
  no="$1"
  pkg="$2"
  tmp="$(mktemp -d)"
  trap "rm -r '$tmp'" EXIT

  if ! go test -c $pkg/*.go -o "$tmp/tester" >"$tmp/out" 2>&1; then
    echo "not ok $no $pkg # failed to build tester" >&2
    cat "$tmp/out"
    exit 1
  fi

  if [[ ! -e "$tmp/tester" ]]; then
    echo "ok $no $pkg # no tests" >&2
    exit 0
  fi

  if ! "$tmp/tester" -test.v -test.timeout 1s >"$tmp/out" 2>&1; then
    echo "not ok $no $pkg" >&2
    cat "$tmp/out"
    exit 1
  fi

  echo "ok $no $pkg" >&2
)

echo "1..$#" >&2

export -f test_one
n_prc="$(sysctl -n hw.logicalcpu)"
parallel -k "-j$n_prc" test_one "{#}" "{}" ::: "$@"
