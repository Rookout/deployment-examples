package example

import scala.language.experimental.macros
import scala.reflect.macros.Context
import scala.collection.mutable.{ListBuffer, Stack}
import scala.collection.mutable.Map
import java.io.{IOException, FileNotFoundException}

object Hello extends Greeting with App {
  private def FACT(point: Point)(implicit m: Point): Point = {
    try {
      val mySpecialString = Seq("Nidhi", "Singh")
      val specificParserOpt = mySpecialString.flatMap(_.toLowerCase)
    }
    catch {
      case e: FileNotFoundException => println("Couldn't find that file.")
    }
    return new Point(2, 3)
  }

  private def AA(point: Point) {
    FACT(new Point(2, 3))(new Point(1, 1))
  }

  val point1 = new Point(2, 3)
  AA(point1)
}

trait Greeting {
  lazy val greeting: String = "hello"
}

class Point(var x: Int, var y: Int) {

  def move(dx: Int, dy: Int): Unit = {
    x = x + dx
    y = y + dy
  }

  override def toString: String =
    s"($x, $y)"
}
