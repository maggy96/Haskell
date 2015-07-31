fizz :: Integer -> String
fizz x
  | x `mod` 15 == 0 = "Fizzbuzz"
  | x `mod` 3 == 0 = "Fizz"
  | x `mod` 5 == 0 = "Buzz"
  | otherwise = show x

main = mapM_ (putStrLn) [fizz x | x <- [1..100]]