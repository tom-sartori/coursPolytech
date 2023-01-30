package com.company.part9.fileattente;

public class BouteilleEtiquetee<T> extends Bouteille {

    private T etiquette;

    public BouteilleEtiquetee(String nom, T etiquette) {
        super(nom);
        this.etiquette = etiquette;
    }
}
