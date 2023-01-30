package td1.exercise3;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;

public class App2 {

    /**Params
     *
     * @param p : tableau de p.length elements représentant la valeur des planches de taille i
     * @param i : position actuelle dans le tableau p pour la réccursion
     * @param n : taille de la planche disponible
     * @return le valeur maximale que l'on peut tirer d'une planche de taille n
     */
    public static int decoupeAux(int[] p, int i, int n){
        if(n==0){
            return 0;
        }
        else if(i==1){
            return p[0] * n;
        }
        else if(i>n){
            return decoupeAux(p, i-1,n);
        }
        return Math.max(p[i-1] + decoupeAux(p, i,n-(i)), decoupeAux(p, i-1,n));
    }

    /**Params
     *
     * @param p : tableau de p.length elements représentant la valeur des planches de taille i
     * @param n : taille de la planche disponible au départ
     * @return le résultat de découpeAux avec les paramètres p, p.length, n
     */
    public static int decoupe(int[] p, int n){
        return decoupeAux(p,p.length,n);
    }

    public static int decoupeAuxDp(int[] p, int i, int n) {
        if (n == 0){
            return 0;
        }

        if (proxy[n] != null) {
            return proxy[n];
        }

        if(i == 1) {
            proxy[n] = p[0] * n;
            return proxy[n];
        }
        else if (i > n){
            proxy[n] = decoupeAuxDp(p, i-1, n);
            return proxy[n];
        }
        proxy[n] = Math.max(
                p[i - 1] + decoupeAuxDp(p, i, n - i),
                decoupeAuxDp(p, i - 1, n)
        );
        return proxy[n];
    }

    public static int decoupeDp(int[] p, int n){
        return decoupeAuxDp(p, p.length, n);
    }

    private static Integer[]  proxy;

    public static void main(String[] args) {
        int[] tab = { 1, 5, 8, 9 };
        int n = 10;

        long now;

        now = System.nanoTime();
        System.out.println(decoupe(tab, n));
        System.out.println("Timer brut force : " + TimeUnit.MILLISECONDS.convert(System.nanoTime() - now, TimeUnit.NANOSECONDS));

        proxy = new Integer[n + 1];
        now = System.nanoTime();
        System.out.println(decoupeDp(tab, n));
        System.out.println("Timer prog dyn : " + TimeUnit.MILLISECONDS.convert(System.nanoTime() - now, TimeUnit.NANOSECONDS));
    }



//    public static int decoupeAuxDp(int[] p, int i, int n, Integer[] proxy) {
//        System.out.println(Arrays.stream(proxy).map(String::valueOf).reduce((a, b) -> a + " | " + b).orElse("null"));
//
//        if (n == 0){
//            return 0;
//        }
//
//        if (proxy[n - 1] != null) {
//            return proxy[n - 1];
//        }
//
//        if(i == 1) {
//            proxy[n - 1] = p[0] * n;
//            return proxy[n - 1];
//        }
//        else if (i > n){
//            proxy[n - 1] = decoupeAuxDp(p, i-1, n, proxy);
//            return proxy[n - 1];
//        }
//        proxy[n - 1] = Math.max(
//                p[i - 1] + decoupeAuxDp(p, i, n - i, proxy),
//                decoupeAuxDp(p, i - 1, n, proxy)
//        );
//        return proxy[n - 1];
//    }
}
