
setlocal equalprg=shfmt\ %

let &makeprg = "shellcheck -f gcc % && bats --tap %"

setlocal comments=b:#
setlocal commentstring=#%s

setlocal efm=%Enot\ ok\ %.\ %m,
setlocal efm+=%-C#\ (in\ test\ file\ %f\\,\ line\ %l)
setlocal efm+=%-C#\ %m
setlocal efm+=%-G%.%#

augroup BatsSyntax
  au!
  autocmd Syntax <buffer> setlocal syntax=bash
augroup END
