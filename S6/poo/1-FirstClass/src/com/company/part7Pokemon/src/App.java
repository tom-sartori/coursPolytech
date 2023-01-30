package com.company.part7Pokemon.src;

public class App {


    public static void main(String[] args) {
        SeaPokemonWater carapuce = new SeaPokemonWater("Carapuce", 20, 2);
        StayAtHomePokemonEarth salameche = new StayAtHomePokemonEarth("Salamèche", 25, 2, 155, 6);
        CruisingPokemonWater bulbizar = new CruisingPokemonWater("Bulbizar", 30, 4);
        SportsPokemonEarth pikachu = new SportsPokemonEarth("Pikachu", 11, 2, 177, 144);

        CollectionPokemon collectionPokemon = new CollectionPokemon();
        collectionPokemon.add(carapuce);
        collectionPokemon.add(salameche);
        collectionPokemon.add(bulbizar);
        collectionPokemon.add(pikachu);

        System.out.println(collectionPokemon);
    }
}
