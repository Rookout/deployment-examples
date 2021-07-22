package example

import scala.language.experimental.macros
import scala.reflect.macros.Context
import scala.collection.mutable.{ListBuffer, Stack}

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

  private def AA(point: Point) {
    import exampless._
    Macross.printf("hello %s!\n", "macrooooooooooooooooo")
    //fun[String]("length")
    val xy: Option[Int] = new Some(123)
    trace("in private")
    //trace(toInt("200").getOrElse(10))
    trace("value for x is :: " + xy.getOrElse(0))

    val decodedMessage = "decodedMessage"
    val mySpecialString = Seq("Nidhi", "Singh")
    val specificParserOpt = mySpecialString.flatMap(_.toLowerCase)
    println(specificParserOpt)
    val mmapp =Map("mimeType" -> Option(mySpecialString).filter(_.nonEmpty).getOrElse(List(1,2,3)))
    println(mmapp)

    val resultContent = specificParserOpt match {
      //case resultContent if decodedMessage.isEmpty && this != null =>
      //  println(resultContent1)
      case _ =>
        println("2")

    }
return " 3"
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
