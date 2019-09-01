function spaces-to-tabs --description "helper function that uses gsed to separate 2 or more spaces into tabs"
  gsed -E 's/\s{2,}/\t/g'
end
