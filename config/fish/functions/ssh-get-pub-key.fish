
function ssh-get-pub-key
  switch (count $argv)
    case 0
      echo "No domains entered"
      exit 1

    case 1
      ssh-keygen -lf (ssh-keyscan -t rsa $argv 2>&1 | psub) 2>&1

    case '*'
      for domain in $argv
        ssh-get-pub-key $domain
      end
  end
end
