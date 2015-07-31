import System.Environment

makeargsalist :: [String] -> [Integer]
makeargsalist = map read

main = do
input <- getArgs
print . sum $ makeargsalist input