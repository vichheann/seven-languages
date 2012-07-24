package cucumber.info.hhnn.sevenlanguages

import scala.io.Source
//import scala.collection.JavaConversions._ // convert java List to scala List

import cucumber.table.DataTable
import cucumber.runtime.{ScalaDsl, EN, PendingException}
import junit.framework.Assert._

import info.hhnn.sevenlanguages.Book

class CensorSteps() extends ScalaDsl with EN {
  var book = new Book

  When("""^I load a book "([^"]*)"$"""){ (file:String) =>
    book.load(file)
  }

  When("""^I censor it$"""){ () =>
    book.censoredWords = Map("Shoot" -> "Pucky", "Darn"  -> "Beans" )
    book.censor
  }

  Then("""^there is no bad words any more$"""){ () =>
    var expected = ""
    var file = "src/test/resources/cucumber/info/hhnn/sevenlanguages/censored_book.txt"
    Source.fromFile(file).foreach{ line => expected += line }
    assertEquals(expected, book.censoredContent)
  }
}