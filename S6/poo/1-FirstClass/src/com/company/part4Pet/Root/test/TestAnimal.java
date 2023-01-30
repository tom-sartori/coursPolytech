package com.company.part4Pet.Root.test;

/**
 * Tests for class Finder.
 *
 * All tests in the folder "test" are executed
 * when the "Test" action is invoked.
 *
 */

import static org.junit.Assert.*;

import com.company.part4Pet.Root.src.Dog;
import com.company.part4Pet.Root.src.Pet;
import org.junit.Test;


public class TestAnimal {

    @Test
    public final void testAnimal() {
        // on cree un Animal et on voit si on recupere bien son nom  par getNom()
        Pet a = new Pet("Daffy");
        String actualResult = a.getName();
        // actualResult doit etre identique au nom donne a la creation de l'animal
        assertTrue("Test with a pet", actualResult.equals("Daffy"));
    }

    @Test
    public final void testInheritance() {
        // a Dog should have its name set by the inherited getName() method
        Pet a = new Dog("Zeus");
        String actualResult = a.getName();

        // actualResult must be identical to the name given when declaring the animal
        assertTrue("Test with a dog", actualResult.equals("Zeus"));
    }

    @Test
    public final void testPolymorphisme() {
        // some animals
        Pet ad;
        Dog d1 = new Dog("Milou");

        ad  = d1; // getting a Dog  (specialization of Pet)
        String actualResult = ad.getName();

        // we call  the Pet method:
        assertTrue("Polymorphism test", actualResult.equals("Milou"));
    }

}
