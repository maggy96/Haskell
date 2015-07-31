doubleMe :: Int -> Int
doubleMe x = x * 2

doubleSmallNumber :: Int -> Int
doubleSmallNumber x = if x > 100
    then x
    else x * 2

ebg :: [Char] -> Bool
ebg x = elem (head x) ['A'..'Z']

circumference :: Double -> Double
circumference r = 2 * pi * r

doubleSmallNumber' :: Int -> Int
doubleSmallNumber' x
    | x > 100 = x
    | otherwise = x * 2

xor :: Bool -> Bool -> Bool
xor x y
    | x == False && y == True = True
    | x == True && y == True = False