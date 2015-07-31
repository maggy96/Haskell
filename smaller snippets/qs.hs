quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xy) = (quicksort less) ++ (x : equal) ++ (quicksort more)
  where
    less = filter (<x) xy
    equal = filter (==x) xy
    more = filter (>x) xy
