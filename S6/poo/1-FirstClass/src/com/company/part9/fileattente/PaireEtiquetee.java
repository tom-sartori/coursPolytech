package com.company.part9.fileattente;


public class PaireEtiquetee<T, A, B> extends Paire<A, B> {

    private final T etiquette;

    public PaireEtiquetee(T etiquette, Paire<A, B> paire) {
        super(paire.getFst(), paire.getSnd());
        this.etiquette = etiquette;
    }

    public PaireEtiquetee(T etiquette, A f, B s) {
        super(f, s);
        this.etiquette = etiquette;
    }

    @Override
    public String toString() {
        return "PaireEtiquetee{" +
                "etiquette=" + etiquette +
                ", Paire={" + super.toString() +
                "}}";
    }

    public T getEtiquette() {
        return etiquette;
    }
}
