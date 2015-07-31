-- "Haskell Intensivkurs", Chpt. 17
--f :: String -> Int
--f = length

--g :: Int -> String
--g 1 = "One"
--g 2 = "Two"
--g _ = "Something else"

--f :: String -> (Int, String)
--f s = (length s, "length")

--g :: Int -> (String, String)
--g 1 = ("One", "number")
--g 2 = ("Two", "number")
--g _ = ("Something else", "number")

f x = (x, "called f; ")

g x = (x, "called g; ")

h' x = f x `connect` g `connect` (\x -> (x, "done. "))

h x = let 
    (fres, ftext) = f x
    (gres, gtext) = g fres in (gres, gtext ++ ftext)

connect :: (a, String) -> (a -> (b, String)) -> (b, String)
connect (x, s) f = let (fres, ftext) = f x in (fres, s++ftext)

--h' x = f x `connect` g

identity x = (x, "")
lift x = identity . f
