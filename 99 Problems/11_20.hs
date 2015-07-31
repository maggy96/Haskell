dupli :: [a] -> [a]
dupli x = repli x 2

repli :: [a] -> Int -> [a]
repli [] _ = []
repli (x:xs) n = replicate n x ++ repli xs n

dropEvery :: [a] -> Int -> [a]
dropEvery x n = take (n - 1) x ++ dropEvery (drop n x) n

split :: [a] -> Int -> ([a], [a])
split x n = (take n x, drop n x)

slice :: [a] -> Int -> Int -> [a]
slice x a b = drop (a - 1) . take b $ x

rotate :: [a] -> Int -> [a]
rotate x n 
        | (n > 0) = drop n x ++ take n x
        | otherwise = drop realnum x ++ take realnum x
            where realnum = length x + n

removeAt :: Int -> [a] -> (a, [a])
removeAt n x = (x !! (n - 1), take (n - 1) x ++ drop n x)

main = do
    print $ dupli [1, 2, 3]
    print $ repli "abc" 3
    --print $ dropEvery "abcdefghik" 3
    print $ split "abcdefghik" 3
    print $ slice ['a','b','c','d','e','f','g','h','i','k'] 3 7
    print $ rotate ['a','b','c','d','e','f','g','h'] 3
    print $ rotate ['a','b','c','d','e','f','g','h'] (-2)
    print $ removeAt 2 "abcd"