package com.company.part9.fileattente;

import org.junit.Test;

import static org.junit.Assert.*;

public class PaireEtiqueteeTest {

    @Test
    public void testPaireEtiquetee() {
        String etiquette = "M";
        String pareFst = "MPL";
        String paireSnd = "Montpellier";
        PaireEtiquetee<String, String, String> paireEtiquetee = new PaireEtiquetee<>(etiquette, pareFst, paireSnd);

        System.out.println(paireEtiquetee);

        assertEquals(etiquette, paireEtiquetee.getEtiquette());
        assertEquals(pareFst, paireEtiquetee.getFst());
        assertEquals(paireSnd, paireEtiquetee.getSnd());
    }
}
