#! /bin/bash -e

tester="$(mktemp)"
trap "rm '$out'" EXIT

out="$(mktemp)"
trap "rm '$out'" EXIT

err="$(mktemp)"
trap "rm '$err'" EXIT

if ! go test -c "$@" -o "$tester" >"$out" 2>&1; then
  cat "$out"
  exit 1
fi

if ! "$tester" -test.v -test.timeout 1s >"$out" 2>&1; then
  cat "$out"
  exit 1
fi
