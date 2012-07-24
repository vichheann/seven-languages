package info.hhnn.sevenlanguages

import Array._

class TicTacToeBoard() {
  protected var board = ofDim[Int](3, 3)
  val X = "X"
  val O = "O"
  val NA ="?"
  val TIE = "tie"

  val values = Map(X -> 1, O -> -1)
  val swap_values = values.map(_.swap) + (0 -> " ")

  def play(token:String, x:Int, y:Int) : Boolean = {
    if (board(x)(y) == 0) {
      board(x)(y) = values(token)
      return true
    }
    return false
  }

  def value(x:Int, y:Int) : String = swap_values(board(x)(y))

  def winner() : String = {
    for (x <- 0 to 2) {
      if (board(x)(0) != 0 && board(x)(0) == board(x)(1) && board(x)(1) == board(x)(2)) return swap_values(board(x)(0))
    }

    for (y <- 0 to 2) {
      if (board(0)(y) != 0 && board(0)(y) == board(1)(y) && board(1)(y) == board(2)(y)) return swap_values(board(0)(y))
    }

    if (board(0)(0) != 0 && board(0)(0) == board(1)(1) && board(1)(1) == board(2)(2)) return swap_values(board(1)(1))

    if (board(0)(2) != 0 && board(0)(2) == board(1)(1) && board(1)(1) == board(2)(0)) return swap_values(board(1)(1))

    if (board.forall(y => y.forall(n => n != 0))) return TIE

    return NA
  }

  override def toString : String = {
    val hr = "-------------"
    var result = hr +"\n"
    for (x <- 0 to 2) {
      for ( y <- 0 to 2) {
        result += "| " + swap_values(board(x)(y)) + " "
      }
      result += "|\n" + hr
      if (x < 2) result += "\n"
    }
    return result
  }
}

import scala.util.control._

object TicTacToe {
  def main(args: Array[String]) {
    var board = new TicTacToeBoard
    val loop = new Breaks;
    println(board)
    loop.breakable {
      do {
        play(board, board.X)
        if (board.winner() != board.NA) loop.break
        play(board, board.O)
      } while (board.winner() == board.NA)
    }
    if (board.winner() == board.TIE) println("Tie game")
    else println("Winner is " + board.winner())
  }

   def play(board:TicTacToeBoard, player:String) {
     var done = false
     while(!done) {
       done = board.play(player, readPlayerMove(player, "x"), readPlayerMove(player, "y"))
       if (!done) println("Already done, retry!")
     }
     println(board)
   }

   def readPlayerMove(player:String, value:String) : Int = {
     var input = -1
     do {
       print("Player " + player + " enter your " + value + " position (0,1,2): " )
       try {
         input = Console.readInt
       } catch {
          case e => println("Don't know what to do")
       }
     } while (input == -1)
     return input
   }
}