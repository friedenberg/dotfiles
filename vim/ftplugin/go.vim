
" Invisible tabs for Go
setlocal list listchars=tab:\ \ ,trail:·,nbsp:·

let &l:equalprg = "goimports %"

let b:testprg = "set -o pipefail && go test -v -timeout 5s %:h/*.go"

" pipes have to be escaped in makeprg
let &l:makeprg = "bash -c '( go vet ./... 2>&1 \\| sed \"s/^vet: //g\" ) && go build -o /dev/null'"
