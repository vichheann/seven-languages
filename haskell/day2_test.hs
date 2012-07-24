module Day2_test where

import Day2
import Test.HUnit

main = runTestTT allTests
allTests = TestList (sort_list_tests ++ convert_tests ++ every_tests ++ partial_tests)

-- http://stackoverflow.com/questions/5410919/hunit-testcase-with-a-type-error
test_insert_sort_empty = TestCase (assertEqual "Should return empty list" ([]::[Int]) (insert_sort (<=) []) )
test_insert_sort = TestCase (assertEqual "Should return sorted list" [1,2,3] (insert_sort (<=) [3,1,2]) )

sort_list_tests = [test_insert_sort_empty, test_insert_sort]

test_convert_empty = TestCase (assertEqual "Should be zero" 0 (convert ""))
test_convert_with_leading_zeros = TestCase (assertEqual "Should be ok with leading zeros" 2345678.99 (convert "$00002,345,678.99"))
test_convert_lesser_than_thousand = TestCase (assertEqual "Should be ok" 123 (convert "$123"))
test_convert_thousand = TestCase (assertEqual "Should be ok" 2345678.99 (convert "$2,345,678.99"))

convert_tests= [test_convert_empty, test_convert_thousand, test_convert_lesser_than_thousand]

test_every_third = TestCase (assertEqual "Should get every third number" [5,8,11,14,17,20] (take 6 (every_third 5)) )
test_every_fifth = TestCase (assertEqual "Should get every fifth number" [5,10,15,20,25,30] (take 6 (every_fifth 5)) )
test_every_eighth = TestCase (assertEqual "Should get every eighth number" [8,16,24,32,40,48] (take 6 (every_eighth 3 5)) )

every_tests = [test_every_third, test_every_fifth, test_every_eighth]


test_partial_half = TestCase (assertEqual "Should be half" 5 (half 10) )
test_partial_endline = TestCase (assertEqual "Should be half" "string\n" (endline "string") )

partial_tests = [test_partial_half, test_partial_endline]
