module Day1 (
  allEven
, another_allEven
, yet_another_allEven
, yetyet_another_allEven
, my_reverse
, combinations
) where

allEven :: [Integer] -> [Integer]
allEven [] = []
allEven (h:t) = if even h then h:allEven(t) else allEven(t)

another_allEven :: [Integer] -> [Integer]
another_allEven l = [x | x <- l, even x]

yet_another_allEven :: [Integer] -> [Integer]
yet_another_allEven l = filter even l

_yetyet_another_allEven :: ([Integer], [Integer]) -> [Integer]
_yetyet_another_allEven ([], l) = l
_yetyet_another_allEven (h:t, l) = if even h then _yetyet_another_allEven(t, l++[h]) else _yetyet_another_allEven(t, l)

yetyet_another_allEven :: [Integer] -> [Integer]
yetyet_another_allEven l = _yetyet_another_allEven(l, [])

-- use fold(l|r)

my_reverse :: [a] -> [a]
my_reverse [] = []
my_reverse (h:t) = my_reverse(t) ++ [h]

combinations :: Ord a => [a] -> [(a,a)]
combinations l = [(x,y) | x <- l, y <- l, x < y]

colors = combinations ["black", "white", "blue", "yellow", "red"]

table_multiplication = [(x,y,x*y) | x <- [1..12], y <- [1..12]]

map_colors = ["red", "green", "blue"]
coloring = [(alabama, mississipi, georgia, tennessee, florida) |
						alabama <- map_colors,
						mississipi <- map_colors,
						georgia <- map_colors,
						tennessee <- map_colors,
						florida <- map_colors,
						mississipi /= tennessee,
						mississipi /= alabama,
						alabama /= tennessee,
						alabama /= georgia,
						alabama /= florida,
						georgia /= florida,
						georgia /= tennessee]