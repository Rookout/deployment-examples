package com.rookout;
import io.javalin.Context;
import io.javalin.Handler;
import io.javalin.Javalin;

public class HelloWorld {
    public static void main(String[] args) {
        Javalin app = Javalin.start(7000);
        app.get("/", new Handler() {
            public void handle(Context ctx) throws Exception {

                int a = 5;
                byte[] binary;
                a++;
                binary = new byte[5];



                binary = null;
                ctx.result("Hello World");


                binary[0] = 4;
            }
        });
        app.get("/hello/:name", new Handler() {
            public void handle(Context ctx) throws Exception {
                ctx.result("Hello: " + ctx.param("name"));
            }
        });
        app.get("/", new Handler() {
            public void handle(Context ctx) throws Exception {
                ctx.result("Hello World");
            }
        });
    }
}