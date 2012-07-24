#!/bin/sh
exec scala -savecompiled "$0" "$@"
!#
import scala.actors.Actor._
import scala.io._
import scala.xml.XML

object PageLoader {
  def getContent(url : String) = Source.fromURL(url).mkString
  def getPageSize(url : String) = getContent(url).length
  def getPageLinkCount(url : String) : Int = {
    var page = getContent(url)
    /*var html = XML.loadString(page)
    return (html \\ "a").size*/
    return "</a>".r.findAllIn(page).size
  }
}

val urls = List("http://www.amazon.com", "http://www.twitter.com", "http://www.google.com", "http://www.cnn.com")

def timeMethod(method: () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime
  println("Method took " + (end - start)/1000000000.0 + " seconds." )
}

def getPageSizeSequentially() = {
  for(url <- urls) {
    println("Size for " + url + ": " + PageLoader.getPageSize(url))
    println("Links for " + url + ": " + PageLoader.getPageLinkCount(url))
  }
}

def getPageSizeAndLinksConcurrently() = {
  val caller = self

  for(url <- urls) {
    actor { caller ! (url, PageLoader.getPageSize(url)) }
    actor { caller ! (url, PageLoader.getPageLinkCount(url), "links") }
  }

  1.to( urls.size * 2 ).foreach { _ =>
    receive {
      case (url, size) =>
        println("Size for " + url + ": " + size)
      case (url, links, "links") =>
        println("Links for " + url + ": " + links)
    }
  }
}


println("Sequential run:")
timeMethod { getPageSizeSequentially }
println("Concurrent run:")
timeMethod { getPageSizeAndLinksConcurrently }

