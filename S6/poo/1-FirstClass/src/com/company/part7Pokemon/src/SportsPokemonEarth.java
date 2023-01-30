package com.company.part7Pokemon.src;

public class SportsPokemonEarth extends PokemonEarth {
    private final double heartRate;
    
    public SportsPokemonEarth(String name, double weight, int numberOfLeggs, double size, double heartRate) {
        super(name, weight, numberOfLeggs, size);
        this.heartRate = heartRate;
    }

    public double getHeartRate(){
        return this.heartRate;
    }

    @Override
    public String toString(){
        return super.toString() + "Heart rate : " + this.getHeartRate();
    }
}
