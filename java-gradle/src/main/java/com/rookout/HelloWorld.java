package com.rookout;
import io.javalin.Context;
import io.javalin.Handler;
import io.javalin.Javalin;

public class HelloWorld {
    public static void main(String[] args) {
        Javalin app = Javalin.start(7000);
        app.get("/", new Handler() {
            public void handle(Context ctx) throws Exception {
                ctx.result("Hello World");
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