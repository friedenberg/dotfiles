#! /bin/bash -e

test_one() (
	pkg="$1"
	tmp="$(mktemp -d)"
	trap "rm -r '$tmp'" EXIT

	if ! go test -c $pkg/*.go -o "$tmp/tester" >"$tmp/out" 2>&1; then
    echo "$pkg: failed to build tester" >&2
		cat "$tmp/out"
		exit 1
	fi

  if [[ ! -e "$tmp/tester" ]]; then
    echo "$pkg: no tests" >&2
    exit 0
  fi

	if ! "$tmp/tester" -test.v -test.timeout 1s >"$tmp/out" 2>&1; then
    echo "$pkg: failed tests" >&2
		cat "$tmp/out"
		exit 1
	fi

  echo "$pkg: passed tests" >&2
)

export -f test_one
n_prc="$(sysctl -n hw.logicalcpu)"
parallel "-j$n_prc" test_one ::: "$@"
