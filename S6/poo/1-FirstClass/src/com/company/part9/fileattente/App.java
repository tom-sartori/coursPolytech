package com.company.part9.fileattente;

public class App {

    public static void main(String[] args) {
        Personne personne1 = new Personne("Jean");
        Personne personne2 = new Personne("Baptiste");
        Personne personne3 = new Personne("Bernard");

        FileAttente<Personne> personneFileAttente = new FileAttente<>();
        personneFileAttente.entre(personne1);
        personneFileAttente.entre(personne2);
        personneFileAttente.entre(personne3);

        System.out.println(personneFileAttente);
        personneFileAttente.sort();
        System.out.println(personneFileAttente);


        System.out.println();


        Voiture voiture1 = new Voiture("Audi");
        Voiture voiture2 = new Voiture("Peugeot");

        FileAttente<Voiture> voitureFileAttente = new FileAttente<>();
        voitureFileAttente.entre(voiture1);
        voitureFileAttente.entre(voiture2);

        System.out.println(voitureFileAttente);
        voitureFileAttente.sort();
        System.out.println(voitureFileAttente);


        // Question sur equals : voir tests.
    }
}
