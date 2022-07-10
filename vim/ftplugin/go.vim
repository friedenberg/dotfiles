
" setlocal noexpandtab

" Invisible tabs for Go
setlocal list listchars=tab:\ \ ,trail:·,nbsp:·

setlocal equalprg=goimports\ %

let b:testprg = "set -o pipefail && go test -v %:h/*"

""not ok 1 can_output_organize
"setlocal efm=%Enot\ ok\ %.\ %m,
""# (from function `assert_output' in file zz-test/test_helper/bats-assert/src/assert_output.bash, line 194,
""#  in test file zz-test/failed_organize.bats, line 59)
"setlocal efm+=%Z%.%#\ in\ test\ file\ %f\\,\ line\ %l)
"" setlocal efm+=%-C#\ (in\ test\ file\ %f\\,\ line\ %l)
""#   `assert_output "$(cat "$expected_organize")"' failed
""#
""# -- output differs --
""# expected (5 lines):
""#   ---
""#   * ok
""#   ---
""#
""#   - [one/uno] wow
""# actual (2 lines):
""#   Removed etikett 'ok' from zettel 'one/uno'
""#   [one/uno a6afa0a9dd71704237c33136470573f052c9b4d53584f80e1d2d03ed745cab6d] (updated)
""# --
""#
"setlocal efm+=%C%.%#

" let &l:makeprg = "go build && go test -v ./..."
let &l:makeprg = "go build"
