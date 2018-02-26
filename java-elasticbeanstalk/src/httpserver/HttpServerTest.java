package com.rookout.httpserver;

public class HttpServerTest {

    private static final String CONTEXT = "/";
    private static final int PORT = Integer.parseInt(System.getenv().get("PORT"));

    public static void main(String[] args) throws Exception {

        // Create a new SimpleHttpServer
        SimpleHttpServer simpleHttpServer = new SimpleHttpServer(PORT, CONTEXT,
                new HttpRequestHandler());

        // Start the server
        simpleHttpServer.start();
        System.out.println("Server is started and listening on port "+ PORT);
    }

}