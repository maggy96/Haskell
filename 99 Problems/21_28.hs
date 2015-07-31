import System.Random
insertAt :: a -> [a] -> Int -> [a]
insertAt x xs pos = (take (pos - 1) xs) ++ x : (drop (pos - 1) xs)

range :: Enum a => a -> a -> [a]
range a b = [a..b]

rnd_select :: [a] -> Int -> IO [a]
rnd_select xs n = do
  gen <- getStdGen
  return $ take n [ xs !! x | x <- randomRs (0, (length xs) - 1) gen]

diff_select :: (Enum a, Num a) => Int -> a -> IO [a]
diff_select n p = rnd_select [1..p] n

rnd_permu :: [a] -> IO [a]
rnd_permu xs = rnd_select xs (length xs)

main = do
    print $ insertAt 'X' "abcd" 2
    print $ range 4 9
    rnd_select "abcdefgh" 3 >>= putStrLn
    -- putStrLn $ diff_select 6 49 
