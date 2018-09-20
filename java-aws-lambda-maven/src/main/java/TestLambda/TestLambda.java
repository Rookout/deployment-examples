package TestLambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import java.util.HashMap;
import java.util.Random;

import com.rookout.rook.API;

public class TestLambda implements RequestHandler<Object, String> {
    @Override
    public String handleRequest(Object myCount, Context context) {

        API.Load();

        SleepLoop();

        return "Hello";
    }

    String[] animals = { "Aardvark", "Abyssinian", "Affenpinscher", "Akbash", "Akita", "Albatross", "Ben", "Wolf",
            "Wolverine", "Wombat", "Woodcock", "Woodlouse", "Woodpecker", "Worm", "Wrasse", "Wren", "Yak", "Zebra",
            "Zebu", "Zonkey", "Zorse" };

    private void SleepLoop() {
        System.out.println("Entering sleep loop");

        for (int i = 0; i < 5; ++i) {
            System.out.println("Iteration");

            String animal = animals[new Random().nextInt(animals.length)];
            String g = "dsdsd";
            double y = 9.12;
            HashMap<Integer, Integer> d = new HashMap<Integer, Integer>();
            d.put(1, 2);

            try {
                int a = 1 / 0;
            } catch (Exception e) {

            }

            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {

            }
        }
    }
}