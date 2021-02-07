# vim: set syntax=fish:

function reset-gpg --description "Restarts GPG and tests access to GitHub"
  gpgconf --reload gpg-agent >/dev/null 2>&1 \
    and gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
