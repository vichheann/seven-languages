module Seven_languages (
  factorial
, fib
, fibo
) where

factorial :: Integer -> Integer
factorial x
  | x > 1 = x * factorial(x - 1)
  | otherwise = 1

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib x = fib(x-1) + fib(x-2)

fibTuple :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
fibTuple (x, y, 0) = (x, y, 0)
fibTuple (x, y, index) = fibTuple (y, x + y, index - 1)

fibResult :: (Integer, Integer, Integer) -> Integer
fibResult (x, y, z) = x

fibo :: Integer -> Integer
fibo x = fibResult (fibTuple(0, 1, x))

data Suit = Spades | Hearts deriving (Show)
data Rank = Ten | Jack | Queen | King | Ace

type Card = (Rank, Suit)
type Hand = [Card]

value :: Rank -> Integer
value Ten = 1
value Jack = 2
value Queen = 3
value King = 4
value Ace = 5
cardValue :: Card -> Integer
cardValue (rank, suit) = value rank
