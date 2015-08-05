module HW01 where

toDigits :: Integer -> [Integer]
toDigits n
  | n > 0     = toDigits (n `div` 10) ++ [n `mod` 10]
  | otherwise = []

toDigitsRev :: Integer -> [Integer]
toDigitsRev a = reverse (toDigits a)

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:y:xy) = (2 * x) : y : (doubleEveryOther xy)

sumDigits :: [Integer] -> Integer
sumDigits lst = sum $ map (sum . toDigits) lst

validate :: Integer -> Bool
validate x = ((sumDigits $ doubleEveryOther $ toDigits x) `mod` 10) == 0

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 1 a b c = [(a, b)]
hanoi n a b c = (hanoi (n - 1) a c b) ++ (hanoi 1 a b c) ++ (hanoi (n - 1) c b a)
