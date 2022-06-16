
" setlocal equalprg="npx eslint --fix-dry-run --fix-type layout --format unix --config $HOME/.vim/ftplugin/eslint.json %"
" let &equalprg = "npx eslint --fix --fix-type layout --format unix %"
let &equalprg = "npx --quiet prettier %"

let &makeprg = "npx eslint --format unix %"
