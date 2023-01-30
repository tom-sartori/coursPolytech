package com.company.part7Pokemon.src;

public abstract class PokemonEarth extends Pokemon {
    private final int nbLeg;
    private final double size;

    public PokemonEarth(String name, double weight, int nbLeg, double size) {
        super(name, weight);
        this.nbLeg = nbLeg;
        this.size = size;
    }

    @Override
    public double speed() {
        return this.nbLeg * this.size * 3;
    }


    public double getSize() {
        return size;
    }


    @Override
    public String toString() {
        return super.toString() + "number ofLeggs : " + this.nbLeg + "\n" + "size : " + this.getSize() + "\nMoveOn : " + "\n";
    }
}
