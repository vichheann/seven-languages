package info.hhnn.sevenlanguages

import scala.io.Source
import scala.collection.{ mutable, immutable, generic }

trait Censor {
  var censoredContent = ""
  var censoredWords = Map[String, String]()
  def censor {
    censoredContent = censoredWords.foldLeft(censoredContent)( (text, words) => text.replaceAll(words._1, words._2) )
  }
}

class Book extends Censor {
  var content = ""
  def load(filepath: String) {
    Source.fromFile(filepath).foreach{ line => content += line }
    censoredContent = content
  }
}