Feature: Tic-tac-toe
  In order to complete day2 of 7 languages in 7 weeks
  As a developper
  I want to play tic-tac-toe

Background:
  Given a tic-tac-toe board

Scenario Outline: Play one move
  When player one puts <token> in the cell <x> <y>
  Then the board should have a <token> in the cell <x> <y>

	Examples:
		| token | x | y |
		| X	| 1 | 1 |
		| O	| 1 | 1 |

Scenario Outline: Can't play twice in the same cell
  When player one puts <move1> in the cell <x> <y>
  Then the board should have a <move1> in the cell <x> <y>
  When player two puts <move2> in the same cell <x> <y>
  Then the board should have a <value> in the cell <x> <y>

	Examples:
		| move1 | move2 | value | x | y |
		| X	| O     | X     | 1 | 1 |
		| O	| X     | O     | 1 | 1 |

Scenario: Display board
  When player one puts X in the cell 1 1
  And player two puts O in the cell 0 0
  And player one puts X in the cell 0 1
  And player two puts O in the cell 2 1
  Then the board should be:
	"""
	-------------
	| O | X |   |
	-------------
	|   | X |   |
	-------------
	|   | O |   |
	-------------
	"""

Scenario Outline: Player wins horizontal
  When player one puts <a1> in the cell 1 1
  And player two puts <b1> in the cell 0 0
  And player one puts <a2> in the cell 0 1
  And player two puts <b2> in the cell 1 0
  And player one puts <a3> in the cell 2 1
  Then player <winner> should win

	Examples:
		| a1 | b1 | a2 | b2 | a3 | winner |
		| X  | O  | X  | O  | X  | one    |
		| O  | X  | O  | X  | O  | two    |


Scenario Outline: Player wins vertical
  When player one puts <a1> in the cell 1 1
  And player two puts <b1> in the cell 2 2
  And player one puts <a2> in the cell 0 1
  And player two puts <b2> in the cell 1 0
  And player one puts <a3> in the cell 2 1
  Then player <winner> should win

	Examples:
		| a1 | b1 | a2 | b2 | a3 | winner |
		| X  | O  | X  | O  | X  | one    |
		| O  | X  | O  | X  | O  | two    |


Scenario Outline: Player wins cross left
  When player one puts <a1> in the cell 1 1
  And player two puts <b1> in the cell 2 1
  And player one puts <a2> in the cell 0 0
  And player two puts <b2> in the cell 1 0
  And player one puts <a3> in the cell 2 2
  Then player <winner> should win

	Examples:
		| a1 | b1 | a2 | b2 | a3 | winner |
		| X  | O  | X  | O  | X  | one    |
		| O  | X  | O  | X  | O  | two    |

Scenario Outline: Player wins cross right
  When player one puts <a1> in the cell 1 1
  And player two puts <b1> in the cell 2 1
  And player one puts <a2> in the cell 2 0
  And player two puts <b2> in the cell 1 0
  And player one puts <a3> in the cell 0 2
  Then player <winner> should win

	Examples:
		| a1 | b1 | a2 | b2 | a3 | winner |
		| X  | O  | X  | O  | X  | one    |
		| O  | X  | O  | X  | O  | two    |

Scenario Outline: No winner yet
  When player one puts <a1> in the cell 1 1
  And player two puts <b1> in the cell 2 1
  Then no winner yet

	Examples:
		| a1 | b1 |
		| X  | O  |
		| O  | X  |

Scenario: Tie
	When player one puts X in the cell 0 0
	And player two puts O in the cell 0 1
	And player one puts X in the cell 0 2
	And player two puts O in the cell 2 2
	And player one puts X in the cell 1 0
	And player two puts O in the cell 1 1
	And player one puts X in the cell 1 2
	And player two puts O in the cell 2 0
	And player one puts X in the cell 2 1
  Then it's a tie game
