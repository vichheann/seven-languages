Feature: Censor
  In order to be more polite to my readers
  As a editor
  I want censor some words

Scenario: Censor
	When I load a book "src/test/resources/cucumber/info/hhnn/sevenlanguages/book.txt"
	And I censor it
	Then there is no bad words any more