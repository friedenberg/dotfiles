
" Softtabs, 2 spaces
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab

let &l:equalprg = "shfmt -s -i=2 %"
let &l:makeprg = "shellcheck -x -f gcc % >&1"
