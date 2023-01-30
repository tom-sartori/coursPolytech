package entreprise;

public enum Categorie {
    STUDIO,
    T1,
    LOFT;

    @Override
    public String toString() {
        return switch (this) {
            case STUDIO -> "Studio";
            case T1 -> "T1";
            case LOFT -> "Loft";
        };
    }
}
