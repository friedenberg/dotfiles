
" setlocal equalprg="npx eslint --fix-dry-run --fix-type layout --format unix --config $HOME/.vim/ftplugin/eslint.json %"
" let &equalprg = "npx eslint --fix --fix-type layout --format unix %"
let &l:equalprg = "npx --quiet prettier %"

let &l:makeprg = "npx eslint --format unix %"
