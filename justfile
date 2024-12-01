preview-zit-object target format:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  zit format-blob {{target}} {{format}} | timg -pk -I --center --clear -W -

mr-build-and-watch method target *ARGS:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  just "{{method}}" "{{target}}" {{ARGS}}
  fswatch "{{target}}" -o | xargs -L1 -I{} just {{method}} {{target}} {{ARGS}}

CMD_CHROME := '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

chrome-html-to-pdf target:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  {{CMD_CHROME}} \
    --headless \
    --disable-gpu \
    '--print-to-pdf={{target}}.pdf' \
    --no-pdf-header-footer \
    --print-to-pdf-no-header \
    {{target}} 2>&1

markdown-to-peri-a6-html target:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  pandoc \
    --output {{target}}.html \
    --standalone \
    --embed-resources \
    --css "$HOME/.local/share/pandoc/peri-a6.css" \
      {{target}}

markdown-to-peri-a6-pdf target: \
    (markdown-to-peri-a6-html target) \
    (chrome-html-to-pdf target + ".html")
