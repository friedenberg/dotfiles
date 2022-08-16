
" Softtabs, 2 spaces
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab

let &l:equalprg = "shfmt %"
let &l:makeprg = "shellcheck -f gcc % >&1"
