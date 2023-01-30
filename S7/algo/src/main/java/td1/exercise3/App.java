package td1.exercise3;

public class App {

    public static void main(String[] args) {
        int [] p = { 1, 5, 8, 9 };
        int n = 4;

        System.out.println(decoupe(p, n));
    }

    public static int decoupe(int[] p, int taille) {
        return decoupeAux(p, taille, 20);
    }

    private static int decoupeAux(int[] p, int tailleRestante, int tailleMaxPlanche) {
        System.out.println("Taille d'entrée : " + tailleRestante + " | tailleMaxPlanche : " + tailleMaxPlanche);
//        System.out.println("| " + tailleRestante + " | " + tailleMaxPlanche + " |");

        if (tailleRestante == 0 || tailleMaxPlanche == 0) {
            return 0;
        }

        if (tailleMaxPlanche == 1) {
            return tailleRestante * p[0];
        }

        for (int j = Math.min(tailleMaxPlanche, p.length); 0 < j; j--) {
            if (j <= tailleRestante) {
                return Math.max(
                        p[j - 1] + decoupeAux(p, tailleRestante - j, j),
                        decoupeAux(p, tailleRestante, j - 1)
                );
            }
        }
        return 0;
    }
}
