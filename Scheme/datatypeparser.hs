import Control.Monad
import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment

symbol :: Parser Char
symbol = oneOf "!$%&|*+-/:<=>?@^_~"

readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of 
                   Left err -> "No match. " ++ show err
                   Right val -> "Found Val " ++ show val

main :: IO()
main = do
  (expr:_) <- getArgs
  putStrLn (readExpr expr)

spaces :: Parser()
spaces = skipMany1 space

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool
            deriving Show

escapedChars :: Parser Char
escapedChars = do char '\\'
                  x <- oneOf "\\\"rnt"
                  return $ case x of
                             '\\' -> x
                             '"' -> x
                             'n' -> '\n'
                             'r' -> '\r'
                             't' -> '\t'

parseBool :: Parser LispVal
parseBool = do
  char '#'
  (char 'f' >> return (Bool False)) <|> (char 't' >> return (Bool True))

parseString :: Parser LispVal
parseString = do
                char '"'
                x <- many (escapedChars <|> noneOf "\"\\")
                char '"'
                return $ String x

parseAtom :: Parser LispVal
parseAtom = do 
              first <- letter <|> symbol
              rest <- many (letter <|> digit <|> symbol)
              return $ Atom $ first:rest

parseNumber :: Parser LispVal
parseNumber = many1 digit >>= return . Number . read

parseExpr :: Parser LispVal
parseExpr = parseAtom
         <|> parseString
         <|> parseNumber
         <|> parseBool
