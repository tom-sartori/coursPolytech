package com.company.part9.fileattente;

public class Bouteille {

    private String nom;

    public Bouteille(String nom) {
        this.nom = nom;
    }

    @Override
    public String toString() {
        return "Bouteille{" +
                "nom='" + nom + '\'' +
                '}';
    }
}
