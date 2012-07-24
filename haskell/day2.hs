module Day2 (
  insert_sort
, convert
, every_third
, every_fifth
, every_eighth
, half
, endline
) where

import Data.List
import Data.Char

insert_sort :: (a -> a -> Bool) -> [a] -> [a]
insert_sort comp [] = []
insert_sort comp (h:t) = insertion comp h (insert_sort comp t)

insertion :: (a -> a -> Bool) -> a -> [a] -> [a]
insertion comp x [] = [x]
insertion comp x (h:t)
  | comp x h = x:h:t
  | otherwise = h:(insertion comp x t)


convert :: String -> Float
convert s
  | s == "" = 0
  | otherwise = read parsed :: Float -- I think I'm cheating a little bit here ...
                   where
                     parsed = foldl (\acc  n -> if (n /= ',' && n /='$') then acc ++ [n] else acc) "" s


every_third :: Integer -> [Integer]
every_third x = [x, (x+3) ..]

every_fifth :: Integer -> [Integer]
every_fifth x = [x, (x+5) ..]

every_eighth :: Integer -> Integer -> [Integer]
every_eighth x y = zipWith (+) (every_fifth y) (every_third x)

half = (/2)
endline = (++ "\n")

