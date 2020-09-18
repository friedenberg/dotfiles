function wmake
  fswatch -o . | xargs -I {} make
  return $status
end
