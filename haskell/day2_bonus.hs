module Day2_bonus (
  common_denominator
, prime_numbers
, break_text
, break_text_line_numbers
) where

import Data.List

denominator :: Integer -> [Integer]
denominator x = [d | d <- [1..x], (mod x d) == 0]

-- could use Euclid algorythm but dont wanna think to much ...
common_denominator :: Integer -> Integer -> Integer
common_denominator x y = maximum [d | d <- intersect (denominator x)  (denominator y)]

prime_numbers = [x | x <- [1..], length (denominator x) <= 2]

break_text :: String -> String -> String
break_text s boundary = drop 1 (_break_text s boundary)

_break_text :: String -> String -> String
_break_text s boundary = concatMap (\w -> if w == boundary then "\n" else " " ++ w) (words s)

break_text_line_numbers :: String -> String -> String
break_text_line_numbers s boundary = _break_text_line_numbers _break_text s boundary

_break_text_line_numbers :: (String -> String -> String) -> String -> String -> String
_break_text_line_numbers break_text s boundary = concat new_line_list
  where new_line_list = zipWith numbering_line [1..(length lines_list)] lines_list
                        where
                          lines_list = lines (break_text s boundary)
                          numbering_line number line = (show number) ++ line ++ "\n"
