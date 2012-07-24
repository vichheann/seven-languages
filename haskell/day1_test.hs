module Day1_test where

import Day1

import Test.HUnit

main = runTestTT allTests
allTests = TestList (allEven_tests ++ my_reverse_tests)


test_allEven_empty :: ([Integer] -> [Integer]) -> Test
test_allEven_empty f = TestCase ( assertEqual "Should return empty list" [] (f []) )
test_allEven :: ([Integer] -> [Integer]) -> Test
test_allEven f = TestCase ( assertEqual "Should return a list with even number only" [2,4] (f [1,2,3,4]) )

allEven_tests =  [test_allEven_empty(allEven),
									test_allEven(allEven),
									test_allEven_empty(another_allEven),
									test_allEven(another_allEven),
									test_allEven_empty(yet_another_allEven),
									test_allEven(yet_another_allEven),
									test_allEven_empty(yetyet_another_allEven),
									test_allEven(yetyet_another_allEven)]

test_my_reverse_empty = TestCase ( assertEqual "Should return empty list" ([]::[Int]) (my_reverse []) )
test_my_reverse = TestCase ( assertEqual "Should return reversed list" [3,2,1] (my_reverse [1,2,3]) )

my_reverse_tests = [test_my_reverse_empty, test_my_reverse]

