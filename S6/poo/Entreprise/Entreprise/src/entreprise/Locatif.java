package entreprise;

public class Locatif extends Logement {

    private double loyer;
    private String nomLocataire;

    public Locatif(Categorie categorie, int superficie, EmployeTmp gerant, double loyer, String nomLocataire) {
        super(categorie, superficie, gerant);
        this.loyer = loyer;
        this.nomLocataire = nomLocataire;
    }

    @Override
    public double fraisAgence() {
        throw new RuntimeException("Not implemented. ");
    }

    public double getLoyer() {
        return loyer;
    }

    public String getNomLocataire() {
        return nomLocataire;
    }
}
