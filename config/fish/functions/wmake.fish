function wmake
  make; and fswatch -o . | xargs -I {} make
  return $status
end
