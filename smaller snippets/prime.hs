primes = filterPrime [2..] 
  where filterPrime (p:xs) = 
            p : filterPrime [x | x <- xs, x `mod` p /= 0]

main = print (primes !! 10000)