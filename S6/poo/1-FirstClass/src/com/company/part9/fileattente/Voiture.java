package com.company.part9.fileattente;

public class Voiture {

    private String modele;

    public Voiture(String modele) {
        this.modele = modele;
    }

    @Override
    public String toString() {
        return "Voiture{" +
                "modele='" + modele + '\'' +
                '}';
    }
}
