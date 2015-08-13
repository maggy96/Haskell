module HW03 where

data Expression =
    Var String                   -- Variable
  | Val Int                      -- Integer literal
  | Op Expression Bop Expression -- Operation
  deriving (Show, Eq)

-- Binary (2-input) operators
data Bop = 
    Plus     
  | Minus    
  | Times    
  | Divide   
  | Gt
  | Ge       
  | Lt  
  | Le
  | Eql
  deriving (Show, Eq)

data Statement =
    Assign   String     Expression
  | Incr     String
  | If       Expression Statement  Statement
  | While    Expression Statement       
  | For      Statement  Expression Statement Statement
  | Sequence Statement  Statement        
  | Skip
  deriving (Show, Eq)

type State = String -> Int

-- Exercise 1 -----------------------------------------

extend :: State -> String -> Int -> State
extend s x v y
  | x == y = v
  | otherwise = s y

empty :: State
empty _ = 0

-- Exercise 2 -----------------------------------------
bToI :: Bool -> Int
bToI x = if x then 1 else 0

evalE :: State -> Expression -> Int
evalE s (Var x) = s x
evalE _ (Val x) = x
evalE s (Op x bop y) =
  case bop of
    Plus   -> expr + expr2
    Minus  -> expr - expr2
    Times  -> expr * expr2
    Divide -> div expr expr2
    Gt  -> bToI $ expr >  expr2
    Ge  -> bToI $ expr >= expr2
    Lt  -> bToI $ expr <  expr2
    Le  -> bToI $ expr <= expr2
    Eql -> bToI $ expr == expr2
  where expr  = evalE s x
        expr2 = evalE s y

-- Exercise 3 -----------------------------------------

data DietStatement = DAssign String Expression
                   | DIf Expression DietStatement DietStatement
                   | DWhile Expression DietStatement
                   | DSequence DietStatement DietStatement
                   | DSkip
                     deriving (Show, Eq)

desugar :: Statement -> DietStatement
desugar (Assign x e) = DAssign x e
desugar (Incr x) = DAssign x (Op (Var x) Plus (Val 1))
desugar (If e st1 st2) = DIf e (desugar st1) (desugar st2)
desugar (While e st) = DWhile e (desugar st)
desugar (For st1 e st2 x) = 
  DSequence (desugar st1) (DWhile e (DSequence (desugar x) (desugar st2)))
desugar (Sequence st1  st2) = DSequence (desugar st1) (desugar st2)
desugar Skip = DSkip


-- Exercise 4 -----------------------------------------

evalSimple :: State -> DietStatement -> State
evalSimple s (DAssign x e) = extend s x (evalE s e)
evalSimple s (for)
evalSimple s (whi)
evalSimple s if

run :: State -> Statement -> State
run = undefined

-- Programs -------------------------------------------

slist :: [Statement] -> Statement
slist [] = Skip
slist l  = foldr1 Sequence l

{- Calculate the factorial of the input

   for (Out := 1; In > 0; In := In - 1) {
     Out := In * Out
   }
-}
factorial :: Statement
factorial = For (Assign "Out" (Val 1))
                (Op (Var "In") Gt (Val 0))
                (Assign "In" (Op (Var "In") Minus (Val 1)))
                (Assign "Out" (Op (Var "In") Times (Var "Out")))


{- Calculate the floor of the square root of the input

   B := 0;
   while (A >= B * B) {
     B++
   };
   B := B - 1
-}
squareRoot :: Statement
squareRoot = slist [ Assign "B" (Val 0)
                   , While (Op (Var "A") Ge (Op (Var "B") Times (Var "B")))
                       (Incr "B")
                   , Assign "B" (Op (Var "B") Minus (Val 1))
                   ]

{- Calculate the nth Fibonacci number

   F0 := 1;
   F1 := 1;
   if (In == 0) {
     Out := F0
   } else {
     if (In == 1) {
       Out := F1
     } else {
       for (C := 2; C <= In; C++) {
         T  := F0 + F1;
         F0 := F1;
         F1 := T;
         Out := T
       }
     }
   }
-}
fibonacci :: Statement
fibonacci = slist [ Assign "F0" (Val 1)
                  , Assign "F1" (Val 1)
                  , If (Op (Var "In") Eql (Val 0))
                       (Assign "Out" (Var "F0"))
                       (If (Op (Var "In") Eql (Val 1))
                           (Assign "Out" (Var "F1"))
                           (For (Assign "C" (Val 2))
                                (Op (Var "C") Le (Var "In"))
                                (Incr "C")
                                (slist
                                 [ Assign "T" (Op (Var "F0") Plus (Var "F1"))
                                 , Assign "F0" (Var "F1")
                                 , Assign "F1" (Var "T")
                                 , Assign "Out" (Var "T")
                                 ])
                           )
                       )
                  ]
