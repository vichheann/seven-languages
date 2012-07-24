package cucumber.info.hhnn.sevenlanguages

import cucumber.runtime.{ScalaDsl, EN}
import junit.framework.Assert._

import info.hhnn.sevenlanguages.TicTacToeBoard

class TicTacToeBoardSteps() extends ScalaDsl with EN {
  var board = new TicTacToeBoard

  Given("a tic-tac-toe board") {
    board = new TicTacToeBoard
  }

  // """ is raw String, so no need to escape
  When("""^player (one|two) puts (X|O) in the cell (\d+) (\d+)$""") { (player:String, token: String, x: Int, y: Int) =>
    assertTrue(board.play(token, x, y))
    //throw new PendingException()
  }

  When("""^player (one|two) puts (X|O) in the same cell (\d+) (\d+)$""") { (player: String, token: String, x: Int, y: Int) =>
    assertFalse(board.play(token, x, y))
  }


  Then("""^the board should have a (X|O) in the cell (\d+) (\d+)$""") { (token: String, x: Int, y: Int) =>
    assertEquals(token, board.value(x, y))
  }

  Then("""^the board should be:""") { (display: String) =>
    assertEquals(display, board.toString())
  }

  Then("""^player (one|two) should win$""") { (player: String) =>
    var winner = board.X
    if (player == "two") winner = board.O
    assertEquals(winner, board.winner())
  }

  Then("""^no winner yet$""") {
    assertEquals(board.NA, board.winner())
  }

  Then("""^it's a tie game$""") {
    assertEquals(board.TIE, board.winner())
  }
}