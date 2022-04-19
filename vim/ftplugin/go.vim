
setlocal equalprg=goimports\ %
let &makeprg = "go build && go test -v ./..."
let &makeprg = "go build"
