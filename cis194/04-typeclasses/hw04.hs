{-# OPTIONS_GHC -Wall #-}
module HW04 where

newtype Poly a = P [a]

-- Exercise 1 -----------------------------------------

x :: Num a => Poly a
x = P [0, 1]

-- Exercise 2 ----------------------------------------

instance (Num a, Eq a) => Eq (Poly a) where
    (P p1) == (P p2) = p1 == p2
 
-- Exercise 3 -----------------------------------------

instance (Num a, Eq a, Show a) => Show (Poly a) where
    show (P p1) = prettyPrint (reverse p1) (length p1 - 1)
        where prettyPrint []  _  = ""
              prettyPrint [y] 0  = show y
              prettyPrint (y:ys) n 
                | y /= 0    = show y ++ "x^" ++ show n ++ " + " ++ 
                              prettyPrint ys (n - 1)
                | otherwise = prettyPrint ys (n - 1)

-- Exercise 4 -----------------------------------------

plus :: Num a => Poly a -> Poly a -> Poly a
plus (P p1) (P p2) = P (addPoly p1 p2)
    where addPoly (y:ys) (z:zs) = (y + z) : addPoly ys zs
          addPoly []     (y:ys) = y : addPoly [] ys
          addPoly (y:ys) []     = y : addPoly [] ys
          addPoly _      _      = []

-- Exercise 5 -----------------------------------------

times :: Num a => Poly a -> Poly a -> Poly a
times (P p1) (P p2) = foldl (+) (P [0]) $ multiply p1 p2 
    where
    multiply [] _ = []
    multiply (y:ys) zs 
        = (P (map (* y) zs)) : (multiply ys (0 : zs))

-- Exercise 6 -----------------------------------------

instance Num a => Num (Poly a) where
    (+) = plus
    (*) = times
    negate      = undefined
    fromInteger = undefined
    -- No meaningful definitions exist
    abs    = undefined
    signum = undefined

-- Exercise 7 -----------------------------------------

applyP :: Num a => Poly a -> a -> a
applyP = undefined

-- Exercise 8 -----------------------------------------

class Num a => Differentiable a where
    deriv  :: a -> a
    nderiv :: Int -> a -> a
    nderiv = undefined

-- Exercise 9 -----------------------------------------

instance Num a => Differentiable (Poly a) where
    deriv = undefined
