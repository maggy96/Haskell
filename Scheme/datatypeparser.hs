module Main where

data LisVal = Atom String
            | List [LispVal]
            | DottedList [LispVal] LispVal
            | Number Integer
            | String String
            | Bool Bool

parseString :: Parser LispVal
parseString = do char '"'
                 x <- many (nonOf "\"")
                 char '"'
                 return $ String x
