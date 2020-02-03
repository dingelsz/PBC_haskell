-- This is a comment

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNUmber x = if x > 100
  then x
  else x*2

length' xs = sum [1 | _ <- xs]

removeLowerCase str = [c | c <- str, elem c ['A'..'Z']]

-- Functions can have type declerations
addInt :: Int -> Int -> Int
addInt x y = x + y

-- Type declerations have their own language with variables:
getX :: (a, b) -> a
getX tup = fst tup

-- We can constrain type declerations with type classes
triple :: (Num a) => a -> a
triple x = 3 * x

