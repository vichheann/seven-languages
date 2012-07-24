module Day2_bonus_test where

import Day2_bonus
import Test.HUnit

main = runTestTT allTests
allTests = TestList (common_denominator_prime_tests ++ text_tests)

test_common_denominator = TestCase (assertEqual "Should get the GCD" 21 (common_denominator 1071 1029))
test_prime_numbers = TestCase (assertEqual "Should get prime numbers" [1,2,3,5,7,11,13] (take 7 (prime_numbers)) )

common_denominator_prime_tests = [test_common_denominator, test_prime_numbers]

first_rime = "La Cigale ayant chanté Tout l’Eté,"
input_text =  first_rime ++ " br Se trouva fort dépourvue br Quand la bise fut venue."
test_boundaries_not_present = TestCase ( assertEqual "Should not change" first_rime (break_text first_rime "br") )
test_boundaries = TestCase ( assertEqual "Should replace the boundary string" "La Cigale ayant chanté Tout l’Eté,\n Se trouva fort dépourvue\n Quand la bise fut venue." (break_text input_text "br") )
test_boundaries_lines = TestCase ( assertEqual "Should put line number" "1 La Cigale ayant chanté Tout l’Eté,\n2 Se trouva fort dépourvue\n3 Quand la bise fut venue.\n" (break_text_line_numbers input_text "br") )

text_tests = [test_boundaries, test_boundaries_lines, test_boundaries_not_present]
