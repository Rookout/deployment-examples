package example

import com.sun.net.httpserver.HttpServer

import java.net.InetSocketAddress
import scala.collection.mutable

object Main {
  def main(args: Array[String]) {
    val server = HttpServer.create(new InetSocketAddress(8000), 0)
    server.createContext("/", new RootHandler())
    server.setExecutor(null)

    server.start()

    println("Hit any key to exit...")

    System.in.read()
    server.stop(0)
  }
}

class MyClass {
  def matchCaseFunc(): String = {
    Option("a") match {
      case Some(s) => s
      case None => "abc" // SET BP HERE
    }
  }
}