-- -----------------------------------------------------------------------------
-- Lambda.hs
-- Zach Dingels
-- -----------------------------------------------------------------------------
-- This file contains code for Church Encoding. Church encoding is a method for
-- storing information using functions of single arguments.
-- -----------------------------------------------------------------------------
module Lambda where

-- Intro:
-- Lambda calculus is a formal system to express computation based on a couple
-- of simple rules. The system has:
-- 1) Variables:
--    x, y, z, ... any string of characters that represents a value
-- 2) Abstraction
--    Abstraction is the term that refers to function definitions. In haskell
--    you use the syntax
--      \variable -> expression
--    Using lambda calculus terminology, the expression is called a lambda term.
--    Also, we say that the variable is bound in the expression.
-- 3) Application
--    Application is the term that refers to applying a function on an argument.
--    In haskell you apply the function with argument like so:
--      function argument
--    Using lambda calculus terminology, both the function and argument are
--    lambda terms.
--
-- Thats it. There are variables, variables can be bound to lambda terms
-- and lambda terms can be combined. 

-- Example
-- Here is a basic function.
identity :: a -> a
identity = \x -> x

-- What else can we do? How about this
constant :: a -> b -> a
constant = \x -> \y -> x

-- We can combine functions. We are creating a function that returns another
-- function. Notice that the variable bound in the outer function is available
-- in the inner function's lambda term. This is saying that constant is a
-- function that takes an argument x and returns a new function that takes
-- a different argument y. Whenever the new function is called it always returns
-- x, it's the constant function.

-- Notice that we can create functions with multiple arguments this way. Haskell
-- has a shorthand syntax for this:
constant' x y = y

-- One issue with this remains, if everything is made up of functions then where
-- is our data? We can encode data using functions, which is what the next
-- section covers but with haskell we can evaluate our functions with values:
-- constant 1 2

-- Church Encoding
-- Church encoding is a technique for encoding data with functions. Let's start
-- with the basics, true of false values.

true  = \x -> \y -> x
false = \x -> \y -> y

-- Boolean Algebra
and' = \x -> \y -> x y false

-- How this evaluates: first x is evaluated on y and false. If x is true
-- then y will be chosen to evaluate the next arguments. if x is false
-- then false will be selected. So, only if x is true and y is true will
-- the result be true:
-- Cases:
--           y=true                       y=false
-- | x=true  true  true false -> true  | true  false false -> false
-- | x=false false true false -> false | false false false -> false
--

or' = \x -> \y -> x true y

if' = \x -> \y -> x y true

xor' = \x -> \y -> x



