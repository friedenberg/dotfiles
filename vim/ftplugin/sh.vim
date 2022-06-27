
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

setlocal equalprg=shfmt\ %

let &makeprg = "shellcheck -f gcc % >&1"
