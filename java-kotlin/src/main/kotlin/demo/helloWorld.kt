package demo

import com.sun.net.httpserver.HttpServer
import java.io.PrintWriter
import java.net.InetSocketAddress

/**
 * Minimal embedded HTTP server in Kotlin using Java built in HttpServer
 */
fun main(args: Array<String>) {
    HttpServer.create(InetSocketAddress(9090), 0).apply {

        createContext("/hello") { http ->
            http.responseHeaders.add("Content-type", "text/plain")
            http.sendResponseHeaders(200, 0)
            PrintWriter(http.responseBody).use { out ->
                out.println("Hello ${http.remoteAddress.hostName}!")
            }
        }

        start()
    }
}