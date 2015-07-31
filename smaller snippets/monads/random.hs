import Data.Random

f :: a -> StdGen -> (b, StdGen)

g :: b -> StdGen -> (c, StdGen)

h :: a -> StdGen -> (c, StdGen)
h a gen = let (fres, fmes) = f a gen in g fres fmes