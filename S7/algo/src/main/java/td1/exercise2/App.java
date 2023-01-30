package td1.exercise2;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;

public class App {

    public static void main(String[] args) {
        int[] t = new int[20];
        randomizeTab(t);
//        int[] t = { 10, 2, 2, 20, 5, 4 };

        System.out.println("tab : " + Arrays.toString(t));
        System.out.println();
        long now;
        int result;

        // Brut force.
        now = System.nanoTime();
        result = P2CMAX(t, 0, 0, 0);
        System.out.println("Result : " + result);
        System.out.println("Timer brut force : " + TimeUnit.MILLISECONDS.convert(System.nanoTime() - now, TimeUnit.NANOSECONDS));
        System.out.println();

        // Dynamic programming.
        now = System.nanoTime();
        result = P2CMaxClient(t);
        System.out.println("Result : " + result);
        System.out.println("Timer dynamic programming : " + TimeUnit.MILLISECONDS.convert(System.nanoTime() - now, TimeUnit.NANOSECONDS));
    }

    public static int P2CMaxClient(int[] t) {
        // Complexity : O( |proxy| * c) = O(n S^2)
        // |proxy| = (n+1)(S+1)(S+1)
        // c = 1
        int[][][] proxy = new int[t.length + 1][getSum(t) + 1][getSum(t) + 1];
        initTab(proxy);
        return P2CMAXAUX(t, 0, 0, 0, proxy);
    }

    //prerequis
    //t contient des entiers positifs
    //0 <= i <= n
    //0 <= load1 <= S et 0 <= load2 <= S
    public static int P2CMAXAUX(int[] t, int i, int load1, int load2, int[][][] proxy) {
        if (proxy[i][load1][load2] == Integer.MIN_VALUE) {

            //retourne la valeur optimale pour ordonnancer les taches de t[i..t.length]
            //en supposant que la machine i contient déjà des tâches entre 0 et loadi
            if (i == t.length) {
                proxy[i][load1][load2] = Math.max(load1, load2);
            } else {
                proxy[i][load1][load2] = Math.min(P2CMAXAUX(t, i + 1, load1 + t[i], load2, proxy), P2CMAXAUX(t, i + 1, load1, load2 + t[i], proxy));
            }
        }
        return proxy[i][load1][load2];


//        if (proxy[i][load1][load2] != Integer.MIN_VALUE) {
//            return proxy[i][load1][load2];
//        }
//        else {
//
//            //retourne la valeur optimale pour ordonnancer les taches de t[i..t.length]
//            //en supposant que la machine i contient déjà des tâches entre 0 et loadi
//            if (i == t.length) {
//                proxy[i][load1][load2] = Math.max(load1, load2);
//            } else {
//                proxy[i][load1][load2] = Math.min(P2CMAXAUX(t, i + 1, load1 + t[i], load2, proxy), P2CMAXAUX(t, i + 1, load1, load2 + t[i], proxy));
//            }
//            return proxy[i][load1][load2];
//        }
    }

    public static int getSum(int[] t) {
        return Arrays.stream(t).sum();
    }

    public static void initTab(int [][][] proxy) {
        for (int[][] ints : proxy) {
            for (int[] anInt : ints) {
                Arrays.fill(anInt, Integer.MIN_VALUE);
            }
        }
    }

    public static void randomizeTab(int[] t) {
        for (int i = 0; i < t.length; i++) {
            t[i] = (int) (Math.random() * 5);
        }
    }

    public static int P2CMAX(int[] t, int i, int load1, int load2) {
        //prerequis
        //t contient des entiers positifs
        //0 <= i <= n
        //0 <= load1 <= S et 0 <= load2 <= S

        //retourne la valeur optimale pour ordonnancer les taches de t[i..t.length]
        //en supposant que la machine i contient déjà des tâches entre 0 et loadi
        if (i == t.length) {
            return Math.max(load1, load2);
        }
        else {
            return Math.min(P2CMAX(t, i + 1, load1 + t[i], load2), P2CMAX(t, i + 1, load1, load2 + t[i]));
        }
    }
}
