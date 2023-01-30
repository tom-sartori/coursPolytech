package com.company.part7Pokemon.src;

import java.util.ArrayList;
import java.util.List;

public class CollectionPokemon {

    private List<Pokemon> pokemonList;

    public CollectionPokemon(List<Pokemon> pokemonList) {
        pokemonList = pokemonList;
    }

    public CollectionPokemon() {
        pokemonList = new ArrayList<>();
    }

    public void add (Pokemon pokemon) {
        pokemonList.add(pokemon);
    }

    public void clear () {
        pokemonList.clear();
    }

    public double getAverageSpeed () {
        double sum = 0;
        for (Pokemon pokemon : pokemonList) {
            sum += pokemon.speed();
        }
        return sum / pokemonList.size();
    }

    public double getSportsAverageSpeed () {
        double sum = 0;
        int nb = 0;
        for (Pokemon pokemon : pokemonList) {
            if (pokemon instanceof SportsPokemonEarth) {
                sum += pokemon.speed();
                nb++;
            }
        }
        return nb != 0 ? 0 : sum/nb;
    }

    public int getSize () {
        return pokemonList.size();
    }

    @Override
    public String toString() {
        return "CollectionPokemon{" +
                "pokemonList=" + pokemonList +
                '}';
    }
}
