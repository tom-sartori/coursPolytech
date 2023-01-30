package com.company.part9.fileattente;

import java.util.ArrayList;
import java.util.Objects;

public class FileAttente<T> {

    private String nomFile;
    private static int nbElementsEntresTotal = 0;
    private ArrayList<T> contenu;

    public FileAttente(){
        contenu = new ArrayList<>();
    }

    public void entre(T t){
        contenu.add(t);
        nbElementsEntresTotal++;
    }

    public T sort() {
        T t = null;
        if (!contenu.isEmpty()) {
            t = contenu.get(0);
            contenu.remove(0);
        }
        return t;
    }

    public int nbElements(){
        return contenu.size();
    }

    public boolean estVide(){
        return contenu.isEmpty();
    }

    public static boolean equals(FileAttente<?> f1, FileAttente<?> f2) {
        return f1.equals(f2);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FileAttente<?> that = (FileAttente<?>) o;
        return Objects.equals(nomFile, that.nomFile) && Objects.equals(contenu, that.contenu);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nomFile, contenu);
    }

    public String toString(){
        StringBuilder resultat = new StringBuilder();
        for (T t : this.contenu) {
            resultat.append(t).append(" ");
        }
        return resultat.toString();
    }

    public static int getNbElementsEntresTotal() {
        return nbElementsEntresTotal;
    }
}
