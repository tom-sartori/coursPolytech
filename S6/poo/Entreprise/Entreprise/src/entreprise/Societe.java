package entreprise;


import java.util.ArrayList;
import java.util.List;

public class Societe {

    private CEOTmp patron;
    private String nom;
    private List<Agence> agences;

    // constructeur
    public Societe(String nom, CEOTmp ceo) {
        this.patron = ceo;
        this.nom = nom;
        this.agences = new ArrayList<>();
    }

    // TO DO : expliquer ici pourquoi le tag @Override ci-dessous
    // Car toString hérite de Object, qui implémente cette méthode. La méthode est donc dite overrided.
    @Override
    public String toString() {
        return "Societe [nom=" + nom + ", patron=" + patron + ", "+ agences.size()+ " agences]";
    }

    // Accesseurs
    public CEOTmp getPatron() {
        return patron;
    }

    public void setPatron(CEOTmp patron) {
        this.patron = patron;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) { this.nom = nom; }

    public List<Agence> getAgences() {
        return agences;
    }

    public void ajoutAgence(Agence agence) throws Exception {
        if (this.agences.contains(agence)) {
            throw new Exception("PBM! agence déjà possédée par la société !");
        }
        else { this.agences.add(agence); }
    }

    public void supprimeAgence(Agence agence) throws Exception {
        if (! this.agences.contains(agence)) {
            throw new Exception("PBM! Impossible de supprimer une agence non possédée par la société !");
        }
        else {
            this.agences.remove(agence);
        }
    }
}
