toList input = read ("[" ++ input ++ "]")

main = do
  putStrLn "Enter a list of nubers separated by commata: "
  input <- getLine
  print . sum $ toList input
