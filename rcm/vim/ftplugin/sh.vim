
" Softtabs, 2 spaces
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab

let s:path_bin = fnamemodify(resolve(expand('<sfile>:p')), ':p:h') . "/result/bin/"
let &l:equalprg = s:path_bin."shfmt -s -i=2 %"
let &l:makeprg = s:path_bin."shellcheck -x -f gcc % >&1"
