function try
  if test -e ./bin/jenkins/try > /dev/null
    ./bin/jenkins/try
  else
    try
  end
end

