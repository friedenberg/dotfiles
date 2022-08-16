
let &l:equalprg = "
      \ pandoc
      \ --columns=80
      \ -f gfm -t gfm
      \ '%' -o -"

let &l:textwidth = 80
