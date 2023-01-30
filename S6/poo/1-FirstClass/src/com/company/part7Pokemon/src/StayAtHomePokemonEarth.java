package com.company.part7Pokemon.src;

public class StayAtHomePokemonEarth extends PokemonEarth {
    private final double nbHourPerDay;


    public StayAtHomePokemonEarth(String name, double weight, int numberOfLeggs, double size, double numberOfHourPerDayOnTV) {
        super(name, weight, numberOfLeggs, size);
        this.nbHourPerDay = numberOfHourPerDayOnTV;

    }

    public double getNbHourPerDay(){
        return this.nbHourPerDay;
    }

    @Override
    public String toString(){
        return super.toString() + "numberOfHourPerDayOnTV : " + this.getNbHourPerDay();
    }



}
