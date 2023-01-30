package com.company.part4Pet.Root.src;

public class Cat extends Pet {
    // TO DO: add an attribut "lives" initialized with 7 by default
    private int lives = 7;

    // constructor
    public Cat(String name) {
        super(name);
    }

    // TO DO: add a constructor accepting a name and a number of lives
    public Cat(String name, int lives) {
        super(name);
        this.lives = lives;
    }

    // methods
    void says() {
        System.out.println("miaouuuu");
    }

    // TO DO : add a getter for the lives attribute
    public int getLives() {
        return lives;
    }
}
