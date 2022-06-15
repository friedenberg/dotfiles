
setlocal equalprg=shfmt\ %

let &makeprg = "shellcheck -f gcc %"
