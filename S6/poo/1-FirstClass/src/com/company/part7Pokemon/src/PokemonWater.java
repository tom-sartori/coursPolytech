package com.company.part7Pokemon.src;

public abstract class PokemonWater extends Pokemon{
    private final int nbFin;

    public PokemonWater(String name, double weight, int nbFin) {
        super(name, weight);
        this.nbFin = nbFin;
    }


    @Override
    public double speed() {
        return this.getWeight() / 25 * this.getNbFin();
    }

    public int getNbFin(){
        return this.nbFin;
    }

    @Override
    public String toString(){
        return super.toString() + "number of fins : " + this.getNbFin() + "\n";
    }


}
