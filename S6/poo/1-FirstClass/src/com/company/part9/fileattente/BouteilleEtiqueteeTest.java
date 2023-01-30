package com.company.part9.fileattente;

import org.junit.Test;

import static org.junit.Assert.*;

public class BouteilleEtiqueteeTest {

    @Test
    public void testBouteilleEtiquetee () {
        EtiquetteBouteille etiquetteBouteille = new EtiquetteBouteille(14, "Mas des Armes", "Montpellier", "Vin rouge. ", 0.75);
        BouteilleEtiquetee<EtiquetteBouteille> bouteilleBouteilleEtiquetee = new BouteilleEtiquetee<>("365", etiquetteBouteille);

        System.out.println(bouteilleBouteilleEtiquetee);
    }
}
