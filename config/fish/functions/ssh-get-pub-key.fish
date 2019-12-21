
function ssh-get-pub-key
  switch (count $argv)
    case 0
      echo "No domains entered"
      exit 1

    case 1
      set -l pubkey (ssh-keyscan -t rsa $argv 2>&1)
      set -l fingerprint (ssh-keygen -lf (echo $pubkey[2] | psub) 2>&1)
      set -l lines (string split \n $pubkey)
      set lines[1] (echo $lines[1] $fingerprint)
      string join \n $lines

    case '*'
      for domain in $argv
        ssh-get-pub-key $domain
      end
  end
end
