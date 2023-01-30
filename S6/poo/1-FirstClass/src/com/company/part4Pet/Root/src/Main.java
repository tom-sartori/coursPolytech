package com.company.part4Pet.Root.src;

/**
 * Main class of the Java program.
 *
 */

public class Main {

    public static void main(String[] args) {
        Pet[] myLittleFriends = new Pet[3];
        // using a specialization of Pets instead of a Pet object
        myLittleFriends[0] = new Cat("Tom");
        myLittleFriends[1] = new Dog("Milou");
        myLittleFriends[2] = new Dog("Rintintin");

        // We can send the same says() message to all the objects
        // each one will do according to its specialization
//        for(int i = 0; i < 3; i++) {
//            myLittleFriends[i].says();
//        }

        // TO DO : replace the above loop by a loop with the new syntax:
        // which type should the loop variable be given?
        for (Pet pet : myLittleFriends) {
            pet.says();
        }
    }
}
