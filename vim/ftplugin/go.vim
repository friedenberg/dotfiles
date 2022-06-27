
setlocal noexpandtab

" Invisible tabs for Go
" setlocal list listchars=tab:\ \ ,trail:·,nbsp:·

setlocal equalprg=goimports\ %
let &makeprg = "go build && go test -v ./..."
let &makeprg = "go build"
