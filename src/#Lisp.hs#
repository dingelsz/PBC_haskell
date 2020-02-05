-- A basic lisp interpreter
-- Zach Dingels
-- 2-1-2020

type Program = [Char]
program = "(+ 1 (* 3 4))" :: Program

-------------------------------------------------------------------------------
-- TOKENS
-- Parses a string into tokens where each token is a '(', ')', or any
-- combination of symbols
-------------------------------------------------------------------------------
type Token = [Char]

-- Interface for tokenize:
-- 1) Add spaces around parens to make tokenizing easier
-- 2) Tokenize the program
-- 3) Remove empty tokens from the program
tokenize :: Program -> [Token]
tokenize input = tokenize' (spaceParens input) []

-- core logic for tokenizing a program
tokenize' :: Program -> Token -> [Token]
tokenize' [] _ = []
tokenize' (x:xs) currentToken
  | x == ' ' && currentToken == [] = tokenize' xs []                         -- Case: Multiple spaces
  | x == ' '  = [currentToken]          ++ tokenize' xs []                   -- Case: Space ending a token
  | xs == []  = [currentToken ++ [x]]                                        -- Case: End of program
  | otherwise =                           tokenize' xs (currentToken ++ [x]) -- Case: Part of a Token

spaceParens :: Program -> Program
spaceParens [] = []
spaceParens (x: xs)
  | x == '('  = ' ' : '(' : ' ' : (spaceParens xs)
  | x == ')'  = ' ' : ')' : ' ' : (spaceParens xs)
  | otherwise = x     : (spaceParens xs)

-------------------------------------------------------------------------------
-- Sexp (S expression)
-- S expressions are the AST of our program. If our program is:
-- (+ 1 (* 3 4)) Then our S expression looks like:
--
-- (
-- + 1 (
--     * 3 4
--
-- Each ( in is basically a flag to use the evaluated sub expressions value
-------------------------------------------------------------------------------
data Sexp = Sexp Token Sexp Sexp
          | NIL
          deriving (Show, Eq)

-- Accessor functions
token :: Sexp -> Token
token NIL = ""
token (Sexp token _ _) = token

subExp :: Sexp -> Sexp
subExp NIL = NIL
subExp (Sexp _ subexp _) = subexp

nextExp :: Sexp -> Sexp
nextExp NIL = NIL
nextExp (Sexp _ _ next) = next

toInt :: Sexp -> Int
toInt (Sexp token _ _) = read token :: Int
-------------------------------------------------------------------------------
-- Parse
-- Parse tokens into s expressions
-------------------------------------------------------------------------------
parse :: [Token] -> Sexp
parse [] = NIL -- Base Case
parse (x:xs)
  | x == "("  = let idx = matchingParenIndex xs
                in Sexp x (parse (take idx xs)) (parse (drop (idx + 1) xs))
  | otherwise = Sexp x NIL (parse xs)

-- Helper function to find the index of where a parenthesis is closed
-- e.g. "(a b c d)    )" would return the first closing parens index, 8
matchingParenIndex :: [Token] -> Int
matchingParenIndex xs = matchingParenIndex' xs (-1) 1

matchingParenIndex' :: [Token] -> Int -> Int -> Int
matchingParenIndex' [] idx c = c
matchingParenIndex' (x:xs) idx balance
  | balance == 0 = idx
  | x == "("  = matchingParenIndex' xs (idx + 1) (balance + 1)
  | x == ")"  = if (balance - 1) == 0
                then idx+1
                else matchingParenIndex' xs (idx + 1) (balance - 1)
  | otherwise = matchingParenIndex' xs (idx + 1) balance

-------------------------------------------------------------------------------
-- Evaluate
-------------------------------------------------------------------------------
-- Testing
--let plus = Sexp "+" NIL (Sexp "1" NIL (Sexp "2" NIL (Sexp "3" NIL NIL)))

evaluate :: Sexp -> Sexp
evaluate NIL = NIL
evaluate (Sexp token sub next)
  | token == "+" = sumSexp next

sumSexp :: Sexp -> Sexp
sumSexp NIL = Sexp "0" NIL NIL
sumSexp sexp = Sexp (show ((toInt sexp) + (toInt (sumSexp (nextExp sexp))))) NIL NIL

  
isInt :: Token -> Bool
isInt [] = False
isInt (x:xs)
  | isDigit x  = True

isDigit :: Char -> Bool
isDigit x = elem x ['1'..'9']
