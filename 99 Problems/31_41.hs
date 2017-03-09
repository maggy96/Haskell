isPrime :: Int -> Bool
isPrime n =  all (== False) $ map (\x -> n `mod` x == 0) $ reverse [2,3..(n - 1)]

myGCD :: Integer -> Integer -> Integer
myGCD a b
  | b == 0    = a
  | otherwise = myGCD b (a `mod` b)

coprime :: Integer -> Integer -> Bool
coprime a b = 1 == myGCD a b

totient :: Integer -> Int
totient a = length $ filter (coprime a) [1..a]

primesR :: Int -> Int -> [Int]
primesR a b = filter isPrime [a..b]

-- this is modified, instead of one pair of prime numbers, this function shows all pairs
goldbach :: Int -> [Int]
goldbach a = filter (\n -> isPrime $ a - n) $ filter isPrime [1..a]

goldbachList a b = map goldbach $ filter even [a..b]

main = do
  print $ isPrime 7
  print $ myGCD 36 63
  print $ coprime 35 64
  print $ totient 10
  print $ primesR 10 20
  print $ goldbach 28
  print $ goldbachList 9 20
