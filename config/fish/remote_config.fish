
set -e SSH_AUTH_SOCK
set -Ux SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock.$HOSTNAME

if test -z "$ssh_config_current_alias"
  echo 'No $ssh_config_current_alias is set for this ssh session.'
end
