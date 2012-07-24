module Day3_test where

import Day3
import Test.HUnit

main = runTestTT allTests
allTests = TestList (hash_table_tests ++ maze_tests)

dict = Dict[("a", 1), ("b", 2), ("c", 3)]

test_look_up = TestCase (assertEqual "Should get the right value" (Just 2) (look_up dict "b") )
test_look_up_nothing = TestCase (assertEqual "Should get nothing" Nothing (look_up dict "z") )

deep_dict = DeepDict[ ("a", Val 1),
                      ("b", Val 2),
                      ("c", DeepDict[("d", Val 3),
                                     ("e", DeepDict[("f", Val 4)]),
                                     ("g", Val 5)]
                                    )]

test_deep_look_up = TestCase (assertEqual "Should get the right value" (Just 4) (deep_look_up deep_dict "f") )
test_deep_look_up_nothing = TestCase (assertEqual "Should get nothing" Nothing (deep_look_up deep_dict "z") )

hash_table_tests = [test_look_up, test_look_up_nothing, test_deep_look_up, test_deep_look_up_nothing]

{--
    __________
  4 | |    __
  3 | |__    |
  2 |    ____|
  1 |____  __|
     1 2 3 4
--}
maze = [((1,1), [(1,2), (2,1)]),
        ((1,2), [(1,1), (2,2), (1,3)]),
        ((1,3), [(1,2), (1,4)]),
        ((1,4), [(1,3)]),

        ((2,1), [(2,2), (1,1), (3,1)]),
        ((2,2), [(1,1), (2,1), (3,2)]),
        ((2,3), [(2,4), (3,3)]),
        ((2,4), [(2,3), (3,4)]),

        ((3,1), [(2,1), (4,1)]),
        ((3,2), [(2,2), (3,3), (4,2)]),
        ((3,3), [(2,3), (3,2), (3,4), (4,3)]),
        ((3,4), [(2,4), (3,3), (4,4)]),

        ((4,1), [(3,1)]),
        ((4,2), [(3,2), (4,3)]),
        ((4,3), [(3,3), (4,2)]),
        ((4,4), [(3,4)])
        ]

expected_path = [(3,1), (2,1), (2,2), (3,2), (3,3), (3,4), (4,4)]
trivial_maze_expected_path = [(3,1), (2,1)]
test_find_path_easy f = TestCase (assertEqual "Should find the easy right path" trivial_maze_expected_path (f maze (3,1) (2,1)) )
test_find_path f = TestCase (assertEqual "Should find the right path" expected_path (f maze (3,1) (4,4)) )

maze_tests = [test_find_path_easy(find_path), test_find_path(find_path), test_find_path_easy(solveMaze), test_find_path(solveMaze)]