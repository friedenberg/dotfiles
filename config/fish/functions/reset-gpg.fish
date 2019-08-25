# vim: set syntax=fish:

function reset-gpg --description "Restarts GPG and tests access to GitHub"
  gpgconf --kill gpg-agent; \
    and gpg-connect-agent /bye; \
    and ssh-add -l; \
    and ssh -T git@github.com
end
