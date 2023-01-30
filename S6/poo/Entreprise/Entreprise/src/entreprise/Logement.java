package entreprise;

public abstract class Logement {

    protected Categorie categorie;
    protected int superficie;
    protected EmployeTmp gerant;


    public Logement(Categorie categorie, int superficie, EmployeTmp gerant) {
        this.categorie = categorie;
        this.superficie = superficie;
        this.gerant = gerant;
    }


    public abstract double fraisAgence ();

    public Categorie getCategorie() {
        return categorie;
    }

    public int getSuperficie() {
        return superficie;
    }

    public EmployeTmp getGerant() {
        return gerant;
    }
}
