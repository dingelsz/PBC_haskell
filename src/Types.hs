module Types where
-------------------------------------------------------------------------------
-- CHATPER 3 START

-- Thoughts:
-- # Theres two "languages" to haskell, a function language and a type langauge
-- # Polymorphism transcends OOP. The difference between OOP and FP is
--   whether you use recursion or not.
-- # Records are sweet, not sure why they aren't covered first.
--   
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- TYPE SYSTEM REVIEW
-------------------------------------------------------------------------------
-- Haskell lets us define our own types using the data keyword:
data BookInfo = Book Int String [String]
                deriving (Show)

-- # In this case, BookInfo is the type constructor. It's only used in type
--   type declreations
-- # Book is the value constructor, it's used in actual code
-- # The type constructor and value constructor usually have the same name...
-- # Int String [String] are the components of the type (also known as fields)
--   Unlike other languages they aren't named, just typed

-- We can create an instance of this type:
aBook = Book 123456789 "GEB" ["author 1", "author 2"]

-- It's nice to have accesors for each component
data Point = Point Int Int
           deriving(Show)

xCoord :: Point -> Int
xCoord (Point x _) = x

yCoord :: Point -> Int
yCoord (Point _ y) = y

-- We can reduce this boilerplate by using Haskell's record syntax:
data Vector' = Vector' {
  coords :: [Float]
  } deriving (Show)
-- This automatically generates a coords accessor function
-- We can use a different constructor syntax
u = Vector' {
  coords = [1,2,3]
  }
  
-- Types can be paramatized. Below is a type that has two components that are
-- constrained to the same type
data Pair a  = Pair a a
  deriving (Show)

-- There is a concept of Algebraic data types. These are types that have
-- multiple value constructors. It is similiar to structs/enums/unions in C/++
data Boolean = True | False

data Number = Int Int
            | Float Float
            deriving (Show)
            
-- We can use type synonyms to alias existing types:
type Person = ([Char], [Char])
