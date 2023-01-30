package com.company.part9.fileattente;

import org.junit.Test;

import static org.junit.Assert.*;

public class PaireHomogeneTest {

    @Test
    public void testConstruct () {
        String paireFst = "MPL";
        String paireSnd = "Montpellier";

        PaireHomogene<String> paireHomogene = new PaireHomogene<>(paireFst, paireSnd);

        System.out.println(paireHomogene);

        assertEquals(paireFst, paireHomogene.getFst());
        assertEquals(paireSnd, paireHomogene.getSnd());
    }
}
