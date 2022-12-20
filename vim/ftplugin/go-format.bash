#! /bin/bash -e

in="$1"

out="$(mktemp)"
trap "rm '$out'" EXIT

err="$(mktemp)"
trap "rm '$err'" EXIT

if ! goimports "$in" >"$out" 2>"$err"; then
	cat "$err" >&2
	exit 1
fi

out1="$(mktemp)"
trap "rm '$out1'" EXIT

if ! gofmt -s -e "$out" >"$out1" 2>"$err"; then
	sed "s/<standard input>/$in/g" <"$err" >&2
	exit 1
fi

cat "$out1"
