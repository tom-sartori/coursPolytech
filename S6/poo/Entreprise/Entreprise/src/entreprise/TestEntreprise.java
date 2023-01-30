package entreprise;

// Temporary classes
class EmployeTmp { String nom; }
class PartenaireTmp { String nom; }
class LogementTmp { String nom; }
class CEOTmp { String nom; }

public class TestEntreprise {

    public static void main(String[] args) throws Exception {
        CEOTmp ceo = new CEOTmp();
        Societe FNAIM = new Societe("FNAIM", ceo);
        PartenaireTmp Macron = new PartenaireTmp();
        PartenaireTmp Delga = new PartenaireTmp();
        Agence AgMPL = new Agence("MPL",Macron,FNAIM);
        Agence AgTLS = new Agence("TLS",Delga,FNAIM);

        LogementTmp logement = new LogementTmp();
        logement.nom = "logement";

        System.out.println(FNAIM);
        System.out.println(AgMPL);
        System.out.println(AgTLS);
    }
}
