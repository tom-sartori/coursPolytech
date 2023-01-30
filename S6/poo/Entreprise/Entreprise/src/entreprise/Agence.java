package entreprise;
import java.util.*; 
public class Agence {

    private String nom;
    private Societe societe;
    private PartenaireTmp directeur;
    private Set <EmployeTmp> employes; 
    private Map<LogementTmp,EmployeTmp> logementToGerant;
    private List<LogementTmp> logementsNonGeres;

    public Agence(String nom, PartenaireTmp dir, Societe soc) throws Exception {
        this.nom = nom;
        this.directeur = dir;
        this.societe = soc;
        this.societe.ajoutAgence(this);
        this.employes = new TreeSet<>();
        this.logementToGerant = new HashMap<>();
        this.logementsNonGeres = new ArrayList<>();
    }

    @Override
    public String toString() {
        return "Agence "+this.nom+ " de la société "+this.societe.getNom()+" géréé par "+this.directeur;
    }

    // Ajoute un logement à gérer par l'agence
    public void ajouteLogNonGere(LogementTmp l) {
        this.logementsNonGeres.add(l);
    }

    // Supprime un logement connu de l'agence
    public void supprimerLog(LogementTmp log) throws Exception {
        if (this.logementsNonGeres.contains(log)) {
            this.logementsNonGeres.remove(log);
        }
        else {
            if (this.logementToGerant.containsKey(log)) {
                this.logementToGerant.remove(log);
            }
            else {
                throw new Exception("PBM !!! ne peut supprimer un logement pas connu de l'agence");
            }
        }
    }

    // Attribue logement pas encore géré àç un gérant (employé)
    public void ajouteGerant(LogementTmp l,EmployeTmp e) throws Exception {
        if (! this.logementsNonGeres.contains(l)) {
            throw new Exception("PBM !!! un logement doit d'abord être dans la liste des logements non-gérés pour être attribué en gestion à un employé");
        }
        else {
            this.logementsNonGeres.remove(l);
            this.logementToGerant.put(l, e);
        }
    }

    // Supprime le gérant d'un logement qui redevient non géré du coup
    public void supprimerGerant(LogementTmp l) {
        this.logementToGerant.remove(l); // on l'enleve a son gérant actuel
        this.logementsNonGeres.add(l);   // l rejoint les logements sans gérant
    }
}
