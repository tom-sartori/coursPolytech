package entreprise;

public class AVendre extends Logement {

    private int prixVente;
    private String nomAcheteur;

    public AVendre(Categorie categorie, int superficie, EmployeTmp gerant, int prixVente, String nomAcheteur) {
        super(categorie, superficie, gerant);
        this.prixVente = prixVente;
        this.nomAcheteur = nomAcheteur;
    }

    @Override
    public double fraisAgence() {
        throw new RuntimeException("Not implemented. ");
    }

    public int getPrixVente() {
        return prixVente;
    }

    public String getNomAcheteur() {
        return nomAcheteur;
    }
}
