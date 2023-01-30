package com.company.part9.fileattente;

import org.junit.Test;

import static org.junit.Assert.*;

public class FileAttenteTest {

    @Test
    public void testEqualsPersonne() {
        Personne personne1 = new Personne("Jean");
        Personne personne2 = new Personne("Baptiste");

        FileAttente<Personne> personneFileAttente1 = new FileAttente<>();
        personneFileAttente1.entre(personne1);
        personneFileAttente1.entre(personne2);

        FileAttente<Personne> personneFileAttente2 = new FileAttente<>();
        personneFileAttente2.entre(personne1);

        assertNotEquals(personneFileAttente1, personneFileAttente2);
        assertFalse(FileAttente.equals(personneFileAttente1, personneFileAttente2));

        personneFileAttente2.entre(personne2);

        assertEquals(personneFileAttente1, personneFileAttente2);
        assertTrue(FileAttente.equals(personneFileAttente1, personneFileAttente2));
    }

    @Test
    public void testEqualsPersonneVoiture () {
        Personne personne1 = new Personne("Jean");
        Personne personne2 = new Personne("Baptiste");

        FileAttente<Personne> personneFileAttente1 = new FileAttente<>();
        personneFileAttente1.entre(personne1);
        personneFileAttente1.entre(personne2);


        Voiture voiture1 = new Voiture("Audi");
        Voiture voiture2 = new Voiture("Peugeot");

        FileAttente<Voiture> voitureFileAttente = new FileAttente<>();
        voitureFileAttente.entre(voiture1);
        voitureFileAttente.entre(voiture2);

        assertFalse(personneFileAttente1.equals(voitureFileAttente));
    }

    @Test
    public void testNbElements () {
        Personne personne1 = new Personne("Jean");
        Personne personne2 = new Personne("Baptiste");

        FileAttente<Personne> personneFileAttente = new FileAttente<>();
        personneFileAttente.entre(personne1);
        personneFileAttente.entre(personne2);


        Voiture voiture1 = new Voiture("Audi");
        Voiture voiture2 = new Voiture("Peugeot");

        FileAttente<Voiture> voitureFileAttente = new FileAttente<>();
        voitureFileAttente.entre(voiture1);
        voitureFileAttente.entre(voiture2);

        assertEquals(4, personneFileAttente.getNbElementsEntresTotal());
        assertEquals(4, voitureFileAttente.getNbElementsEntresTotal());
        assertEquals(4, FileAttente.getNbElementsEntresTotal());
    }
}
