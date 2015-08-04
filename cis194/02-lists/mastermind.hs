data Peg = Red | Green | Blue | Yellow | Orange | Purple deriving (Eq, Show)
type Code = [Peg]
data Move = Move Code Int Int deriving (Eq, Show)

colors :: Code
colors = [Red, Green, Blue, Yellow, Orange, Purple]

exactMatches :: Code -> Code -> Int
exactMatches [] [] = 0
exactMatches (x:xs) (y:ys)
  | x == y    = 1 + exactMatches xs ys
  | otherwise = exactMatches xs ys

countColors :: Code -> [Int]
countColors xs = map count colors
  where count x = exactMatches (replicate (length xs) x) xs

matches :: Code -> Code -> Int
matches xs = loop (countColors xs) . countColors
  where loop (x:xs) (y:ys) = min x y + loop xs ys
        loop _      _      = 0

getMove :: Code -> Code -> Move
getMove x y = let exact = exactMatches x y
              in  Move y exact $ matches x y - exact

isConsistent :: Move -> Code -> Bool
isConsistent m@(Move xs _ _) = (==) m . flip getMove xs

allCodes :: Int -> [Code] 
allCodes 2 = sequence [colors, colors]
allCodes n = let codes = allCodes $ n - 1
             in  [ x : y | x <- colors, y <- codes ]

filterCodes :: Move -> [Code] -> [Code]
filterCodes m xs = filter (isConsistent m) xs

solve :: Code -> [Move]
solve code = guess (allCodes $ length code) []
    where guess (x:xs) moves
            | x == code = moves
            | otherwise = guess xs $ moves ++ [getMove x $ head xs]
