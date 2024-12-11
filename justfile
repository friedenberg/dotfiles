preview-zit-object target format:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  zit format-blob {{target}} {{format}} | timg -pk -I -U --center --clear -W -

mr-build-and-watch method target *ARGS:
  #! /bin/bash -e
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  just "{{method}}" "{{target}}" {{ARGS}}
  fswatch "{{target}}" -o | xargs -L1 -I{} just {{method}} {{target}} {{ARGS}}

CMD_CHROME := '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

chrome-html-to-pdf target:
  #! /usr/bin/env bash -xe
  pushd "{{invocation_directory()}}" >/dev/null 2>&1
  coproc chrome ({{CMD_CHROME}} \
    --headless \
    --remote-debugging-port=9222 \
    --remote-allow-origins=http://127.0.0.1:9222 \
    --remote-allow-origins=http://localhost:9222 \
    "$(realpath {{target}})" 2>&1)

  trap 'kill $chrome_PID' EXIT
  read -r output <&"${chrome[0]}"

  url="$(http GET localhost:9222/json/list | jq -r '.[] | select(.type == "page") | .webSocketDebuggerUrl')"
  echo 'Page.printToPDF {"paperWidth": 2.2409, "marginLeft": 0, "marginRight": 0}' |
    websocat -n1 --jsonrpc --jsonrpc-omit-jsonrpc "$url" |
    jq -r '.result.data' | base64 -d -i - > "{{target}}.pdf"

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
