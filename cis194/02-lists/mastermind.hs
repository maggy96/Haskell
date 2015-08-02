data Peg = Red | Green | Blue | Yellow | Orange | Purple
  deriving (Eq, Show)
type Code = [Peg]
data Move = Move Code Int Int 
  deriving (Eq, Show)


colors = [Red, Green, Blue, Yellow, Orange, Purple]

exactMatches :: Code -> Code -> Int
exactMatches [] [] = 0
exactMatches (x:xs) (y:ys)
  | x == y = 1 + exactMatches xs ys
  | otherwise = exactMatches xs ys

countColors :: Code -> [Int]
countColors xs = map (\x -> exactMatches (replicate (length xs) x) xs) colors

matches :: Code -> Code -> Int
matches xs ys = min (countColors xs) (countColors ys)
  where min (x:xs) (y:ys) = minimum [x, y] + min xs ys
        min [] [] = 0

getMove :: Code -> Code -> Move
getMove x y = Move y (exactMatches x y) (matches x y - exactMatches x y)

isConsistent :: Move -> Code -> Bool
isConsistent m@(Move xs a b) ys = getMove ys xs == m
