package Test;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.sun.tools.attach.VirtualMachine;

import java.lang.management.ManagementFactory;
import java.util.HashMap;
import java.util.Random;


public class Hello implements RequestHandler<Object, String> {
    @Override
    public String handleRequest(Object myCount, Context context) {
        //call actual logic
        yourLogic();

        return "Hello";
    }

    static private boolean loaded = false;

    static final String PATH = "lib/rook-0.1.10.jar";

    static public String GetPid() {
        String nameOfRunningVM = ManagementFactory.getRuntimeMXBean().getName();
        return nameOfRunningVM.substring(0, nameOfRunningVM.indexOf('@'));
    }

    static private long start;

    public static void Stopwatch() {
        start = System.currentTimeMillis();
    }

    public static double elapsedTime() {
        long now = System.currentTimeMillis();
        return (now - start) / 1000.0;
    }


    public static void copyFile(java.io.File sourceFile, java.io.File destFile) throws java.io.IOException {
        if (!destFile.exists()) {
            destFile.createNewFile();
        }

        java.nio.channels.FileChannel source = null;
        java.nio.channels.FileChannel destination = null;

        try {
            source = new java.io.FileInputStream(sourceFile).getChannel();
            destination = new java.io.FileOutputStream(destFile).getChannel();
            destination.transferFrom(source, 0, source.size());
        } finally {
            if (source != null) {
                source.close();
            }
            if (destination != null) {
                destination.close();
            }
        }
    }

    // https://stackoverflow.com/questions/4817670/how-can-i-add-a-javaagent-to-a-jvm-without-stopping-the-jvm
    private void loadRook() throws Exception {
        if (loaded) {
            return;
        }

        try {
            VirtualMachine vm = null;
            try {
                System.out.printf("1 - (%.2f seconds)\n", elapsedTime());

                vm = VirtualMachine.attach(GetPid());

                System.out.printf("2 - (%.2f seconds)\n", elapsedTime());

                copyFile(new java.io.File(PATH),
                        new java.io.File("/tmp/rook-0.1.10.jar"));

                System.out.printf("3 - (%.2f seconds)\n", elapsedTime());

                vm.loadAgent("/tmp/rook-0.1.10.jar");

                System.out.printf("4 - (%.2f seconds)\n", elapsedTime());

                System.out.println("loaded successfully");

                loaded = true;
            } finally {
                if (null != vm) {
                    vm.detach();
                }
            }
        } catch (Exception e) {
            System.out.println("Failed to load javaagent!");
            e.printStackTrace();

            throw e;
        }
    }

    String[] animals = {
            "Aardvark",
            "Abyssinian",
            "Affenpinscher",
            "Akbash",
            "Akita",
            "Albatross",
            "Wolf",
            "Wolverine",
            "Wombat",
            "Woodcock",
            "Woodlouse",
            "Woodpecker",
            "Worm",
            "Wrasse",
            "Wren",
            "Yak",
            "Zebra",
            "Zebu",
            "Zonkey",
            "Zorse"
    };


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
                Thread.sleep(500);
            } catch (InterruptedException e) {

            }
        }
    }

    private void yourLogic() {
        try {
            Stopwatch();

            loadRook();

            System.out.printf("After load - (%.2f seconds)\n", elapsedTime());

            SleepLoop();

            System.out.printf("AfterSleepLoop - (%.2f seconds)\n", elapsedTime());
        } catch (Exception e) {

        }
    }
}