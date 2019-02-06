package com.rookout;
import io.javalin.Context;
import io.javalin.Handler;
import io.javalin.Javalin;

import com.rookout.rook.API;
import com.rookout.rook.RookOptions;

public class HelloWorld {
    public static void main(String[] args) {
        Javalin app = Javalin.start(7000);

        RookOptions opts = new RookOptions();
        opts.token = "<Your-Token>";
        API.start(opts);

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
    }
}