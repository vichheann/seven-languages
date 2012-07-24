module Day3 (
  HashTable(..)
, look_up
, DeepHashTable(..)
, deep_look_up
, find_exits
, find_path
, solveMaze
) where

import Data.List
import Control.Monad

-- Complicated implementation just a way to learn to use 'data'
data HashTable k v = Dict [(k, v)] deriving (Show)

look_up :: Ord a => Eq a => (HashTable a b) -> a -> Maybe b
look_up t x =
  case t of
  (Dict []) -> Nothing
  (Dict ((k,v):xs)) -> if x == k then Just v else look_up (Dict xs) x

-- More complicated solution, not so sure about this one ... I think I'm going the wrong path, bad bad bad
data DeepHashTable k v = DeepDict [(k, DeepHashTable k v)] | Val v deriving (Show)

deep_look_up :: Ord a => Eq a => Eq b => (DeepHashTable a b) -> a -> Maybe b
deep_look_up t k =
  case t of
  (Val _) -> Nothing
  (DeepDict []) -> Nothing
  (DeepDict ((x, Val y):xs)) -> if x == k then Just y else deep_look_up (DeepDict xs) k
  (DeepDict ((_, DeepDict y):xs)) -> let z = (deep_look_up (DeepDict y) k) in
                                       if z == Nothing then deep_look_up (DeepDict xs) k else z


type Node = (Integer, Integer)
type Maze = [(Node, [Node])]

{--
It's like a 2 dimensional array, each node is located as a tuple (x,y)
Each node (cell) contains a list of exit node (cell). You can only go up or down, left or right.
10  ___________
    |  |    __
    |  |__    |
    |   ______|
    |   |__   |
    |____   __|
    |   |   | |
    |   |  ___|
    |      |  |
 1   _________|
 1            10

e.g. matrix 10x10

It seems that we could re-shape the problem to a graph problem, considering exit nodes as node's neighbours,
i.e. node === vertex and exit nodes === edges, thus solving the maze is finding a path in a graph.

Ok, now have to write some test first ...
--}


find_exits :: Maze -> Node -> Maybe [Node]
find_exits maze node = lookup node maze

find_path :: Maze -> Node -> Node -> [Node]
find_path maze start stop = let all_paths = _find_paths maze stop [start]
                                compute_cost = _break_path all_paths stop [] []
                                sorted_paths = _sort_path_by_cost compute_cost
                            in case (head sorted_paths) of
                                 (p, _) -> reverse p

_find_paths :: Maze -> Node -> [Node] -> [Node]
_find_paths maze stop visited =
   case visited of
     [] -> []
     (node:_) ->  if node == stop then reverse visited
                  else
                    let (Just exits) = find_exits maze node
                        filtered_exits = exits \\ visited
                    in do
                        next <- filtered_exits -- kind of loop but all paths will be concated in a single list
                        _find_paths maze stop (next:visited)

_break_path :: [Node] -> Node -> [Node] -> [([Node], Int)] -> [([Node], Int)]
_break_path all_paths node path acc =
  case all_paths of
    [] -> acc
    (n:t) -> if n == node then _break_path t node [] ( ((n:path), length path):acc )
                   else _break_path t node (n:path) acc

_sort_path_by_cost :: [([Node], Int)] -> [([Node], Int)]
_sort_path_by_cost list = sortBy f list
                      where
                        f (_, a) (_, b) = if a < b then LT else GT

{---------------------------------------------------------------------}

solveMaze :: Maze -> Node -> Node -> [Node]
solveMaze maze start end =
  case loop [start] of
    [] -> []
    (n:_) -> n
  where
    loop path@(node:_) =
      if node == end
      then return $ reverse path
      else
        let (Just exits) = find_exits maze node
            poss = exits \\ path
        in do guard (not $ null poss)
              start <- (_sort_by_cost end poss)
              loop (start:path)


_cost :: Node -> Node -> Integer
_cost (x, y) (u, v) = (abs (x - u))^2 + (abs (y - v))^2

_sort_by_cost :: Node -> [Node] -> [Node]
_sort_by_cost start list = sortBy f list
                            where
                              f a b = let costa = _cost start a
                                          costb = _cost start b in if costa < costb then LT else GT