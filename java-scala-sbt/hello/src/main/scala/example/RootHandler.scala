package example

import com.sun.net.httpserver.{HttpExchange, HttpHandler}

import java.io.{InputStream, OutputStream}

class RootHandler extends HttpHandler {

  def handle(t: HttpExchange) {
    displayPayload(t.getRequestBody)
    sendResponse(t)
  }

  private def displayPayload(body: InputStream): Unit ={
    println()
    println("******************** REQUEST START ********************")
    println()
    copyStream(body, System.out)
    println()
    println("********************* REQUEST END *********************")
    println()
  }

  private def copyStream(in: InputStream, out: OutputStream) {
    Iterator
      .continually(in.read)
      .takeWhile(-1 !=)
      .foreach(out.write)
  }

  private def sendResponse(t: HttpExchange) {
    val response = "Ack!"
    val c = new MyClass()
    c.matchCaseFunc()
    t.sendResponseHeaders(200, response.length())
    val os = t.getResponseBody
    os.write(response.getBytes)
    os.close()
  }

}