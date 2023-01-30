package com.company.part9.fileattente;

public class Personne {

    private String prenom;

    public Personne(String prenom) {
        this.prenom = prenom;
    }

    @Override
    public String toString() {
        return "Personne{" +
                "prenom='" + prenom + '\'' +
                '}';
    }
}
