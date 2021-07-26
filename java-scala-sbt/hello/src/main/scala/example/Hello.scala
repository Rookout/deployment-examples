package example

import scala.language.experimental.macros
import scala.reflect.macros.Context
import scala.collection.mutable.{ListBuffer, Stack}
import scala.collection.mutable.Map
import java.io.{IOException, FileNotFoundException}

object Hello extends Greeting with App {
  def trace(msg: String) = println(msg)

  def toInt(integer: String): Int = return integer.toInt
  //#def Some(point: Point) = println(point.x)

/*
  def funImpl[T: c.WeakTypeTag](c: Context)(method: c.Expr[String]): c.Expr[Any] = {
    import c.universe._

    val T = weakTypeOf[T]

    val methodName: TermName = method.tree match {
      case Literal(Constant(s: String)) => newTermName(s)
      case _ => c.abort(c.enclosingPosition, "Must provide a string literal.")
    }

    c.Expr(q"(t: $T) => t.$methodName")
  }

  def fun[T](method: String) = macro funImpl[T]
*/
  abstract class Monoid[A] {
    def add(x: A, y: A): A
    def unit: A
  }

  implicit val stringMonoid: Monoid[String] = new Monoid[String] {
    def add(x: String, y: String): String = x concat y
    def unit: String = ""
  }

  implicit val intMonoid: Monoid[Int] = new Monoid[Int] {
    def add(x: Int, y: Int): Int = x + y
    def unit: Int = 0
  }

  private def FACT(
                    i: Int,
                    name: Option[String],
                    lastName: Option[String],
                    mmm: Map[String, String],
                    point: Point)(implicit m: Point): Point = {
    import exampless._
    try {

      val xy: Option[Int] = new Some(123)
      trace("in private")
      //trace(toInt("200").getOrElse(10))
      trace("value for x is :: " + xy.getOrElse(0))

      val decodedMessage = "decodedMessage"
      val mySpecialString = Seq("Nidhi", "Singh")
      val specificParserOpt = mySpecialString.flatMap(_.toLowerCase)
      println(specificParserOpt)
      val mmapp = Map("mimeType" -> Option(mySpecialString).filter(_.nonEmpty).getOrElse(List(1, 2, 3)))
      println(mmapp)

      val resultContent = specificParserOpt match {
        //case resultContent if decodedMessage.isEmpty && this != null =>
        //  println(resultContent1)
        case _ =>
          if (point.x == 5) {
            AA(point)
            return new Point(2, 3)
          }
      }

      if (this.point1.x != 6) {
        if (i <= 1) {
          lazy val lazzzy = name getOrElse "lazy"
          //Macross.printf("hello %s %s %s!\n", "macrooooooooooooooooo", lazzzy, lastName getOrElse "1")
          //point
        }
        else
          FACT(i - 1, name, lastName, mmm, point)(m)

        return new Point(2, 3)
      }
    }
    catch {
      case e: FileNotFoundException => println("Couldn't find that file.")
      case e: IOException => println("Had an IOException trying to read that file")
      }
    return new Point(2, 3)
  }

  private def AA(point: Point) {
    import exampless._
    //Macross.printf("hello %s!\n", "macrooooooooooooooooo")


    //fun[String]("length")
    FACT(5, Some("5"), Some("5"), Map(
      "AK" -> "Alaska",
      "AL" -> "Alabama",
      "AR" -> "Arizona"
    ), new Point(2, 3))(new Point(1, 1))

    //" 3"
  }

  val point1 = new Point(2, 3)
  AA(point1)
  val i = 11
  i match {
    case a if 0 to 9 contains a =>
      println("0-9 range: " + a)
    case b if 10 to 19 contains b =>
      println("10-19 range: " + b)
    case c if 20 to 29 contains c =>
      println("20-29 range: " + c)
    case _ => println("Hmmm...")
  }

  var LEN1 = greeting.length();
  /*val y = point1 match {
	case Some(point) if point.x == 2 => 
		ppppp("111")
		println("one, a lonely number")
	case Some(point) if point.y == 3 => 
		ppppp("222")
		println(x)
	case _ => 
		ppppp("!2")
		println("some other value")
  }*/

  println(greeting)
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
