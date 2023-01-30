package com.company.part7Pokemon.src;

public class CruisingPokemonWater extends PokemonWater {


    public CruisingPokemonWater(String name, double weight, int numberOfFins) {
        super(name, weight, numberOfFins);
    }

    @Override
    public double speed() {
        return super.speed() / 2;
    }
}
