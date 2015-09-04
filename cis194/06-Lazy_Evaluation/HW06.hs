{-# OPTIONS_GHC -Wall #-}
module HW06 where

import Data.List
import Data.Functor

-- Exercise 1 -----------------------------------------

fib :: Integer -> Integer
fib n
    | n == 0 || n == 1 = 1
    | otherwise = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = fmap fib [0..]

-- Exercise 2 -----------------------------------------

fibs2 :: [Integer]
fibs2 = tail fibs3
  where fibs3 = scanl (+) 0 (1:fibs3)

-- Exercise 3 -----------------------------------------

data Stream a = Cons a (Stream a)

-- Show instance prints the first 20 elements followed by ellipsis
instance Show a => Show (Stream a) where
    show s = "[" ++ intercalate ", " (map show $ take 10 $ streamToList s)
             ++ ",..."

streamToList :: Stream a -> [a]
streamToList (Cons x xs) = x : streamToList xs

-- Exercise 4 -----------------------------------------

instance Functor Stream where
    fmap = undefined

-- Exercise 5 -----------------------------------------

sRepeat :: a -> Stream a
sRepeat x = Cons x $ sRepeat x 

sIterate :: (a -> a) -> a -> Stream a
sIterate f x = Cons x $ sIterate f $ f x 

sInterleave :: Stream a -> Stream a -> Stream a
sInterleave (Cons x xs) b = Cons x $ sInterleave b xs 

sTake :: Int -> Stream a -> [a]
sTake 0 _ = []
sTake n (Cons x xs) = x : sTake (n - 1) xs

-- Exercise 6 -----------------------------------------

nats :: Stream Integer
nats = sIterate (+1) 0 

ruler :: Stream Integer
ruler = undefined

-- Exercise 7 -----------------------------------------

listToStream (x:xs) = Cons x (listToStream xs)

-- | Implementation of C rand
rand :: Int -> Stream Int
rand n = listToStream $ map (prettyRand n) [0..]

prettyRand r 0 = (1103515245 * r + 12345) `mod` 2147483648
prettyRand r n = (1103515245 * (prettyRand r (n - 1)) + 12345) `mod` 2147483648

-- Exercise 8 -----------------------------------------

{- Total Memory in use: ??? MB -}
minMaxSlow :: [Int] -> Maybe (Int, Int)
minMaxSlow [] = Nothing   -- no min or max if there are no elements
minMaxSlow xs = Just (minimum xs, maximum xs)

-- Exercise 9 -----------------------------------------

{- Total Memory in use: ??? MB -}
minMax :: [Int] -> Maybe (Int, Int)
minMax = undefined

main :: IO ()
main = print $ minMaxSlow $ sTake 1000000 $ rand 7666532

-- Exercise 10 ----------------------------------------

fastFib :: Int -> Integer
fastFib = undefined
