package com.company.part9.fileattente;

public class EtiquetteBouteille {
    private double degre;
    private String nomProducteur;
    private String adresse;
    private String descriptif;
    private double quantite;

    public EtiquetteBouteille(double degre, String nomProducteur, String adresse, String descriptif, double quantite) {
        this.degre = degre;
        this.nomProducteur = nomProducteur;
        this.adresse = adresse;
        this.descriptif = descriptif;
        this.quantite = quantite;
    }

    @Override
    public String toString() {
        return "EtiquetteBouteille{" +
                "degre=" + degre +
                ", nomProducteur='" + nomProducteur + '\'' +
                ", adresse='" + adresse + '\'' +
                ", descriptif='" + descriptif + '\'' +
                ", quantite='" + quantite + '\'' +
                '}';
    }
}
