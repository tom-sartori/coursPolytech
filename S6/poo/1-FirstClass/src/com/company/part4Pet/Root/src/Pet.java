package com.company.part4Pet.Root.src;

public class Pet {
    // attributes
    String name;
    Boolean collar;
    // constructor
    public Pet(String name) {
        this.name = name;
        this.collar=true;
    }
    // methods
    public String getName() {
        return name;

    }
    void says() {
        System.out.println(name);
    }
}
