# vim: set syntax=fish:

function reset-gpg --description "Restarts GPG and tests access to GitHub"
  gpgconf --kill gpg-agent; \
    and gpg-connect-agent /bye; \
    and string match -r "Hi \S+! You've successfully authenticated, but GitHub does not provide shell access." (ssh -T git@github.com 2>&1)
end
