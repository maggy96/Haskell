isPrime :: Int -> Bool
isPrime n =  all (== False) $ map (\x -> n `mod` x == 0) $ reverse [2,3..(n - 1)]

main = do
  print $ isPrime 7
