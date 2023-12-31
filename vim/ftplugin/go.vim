
" Invisible tabs for Go
setlocal list listchars=tab:\ \ ,trail:·,nbsp:·

let &l:equalprg = "$HOME/.vim/ftplugin/go-format.bash %"
let b:testprg = "$HOME/.vim/ftplugin/go-test.bash %"

" pipes have to be escaped in makeprg
let &l:makeprg = "bash -c '( go vet ./... 2>&1 \\| sed \"s/^vet: //g\" ) && go build -o /dev/null'"
