package com.company.part7Pokemon.src;

public abstract class Pokemon {
    private final String name;
    private final double weight;

    public Pokemon(String name, double weight){
        this.name = name;
        this.weight = weight;
    }

    public abstract double speed();

    public String getName(){
        return this.name;
    }

    public double getWeight(){
        return this.weight;
    }

    @Override
    public String toString() {
        return "Name : " + this.getName() + "\n" + "Weight : " + this.getWeight() + "\n" + "vitesse : " + speed() + "\n";
    }
}
