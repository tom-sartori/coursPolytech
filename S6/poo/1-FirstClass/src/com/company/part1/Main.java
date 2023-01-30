package com.company.part1;

public class Main {

    public static void main(String[] args) {
        // write your code here
        System.out.println("Oui");


        int sarkozyFortune = 50;
        int macronFortune = 50;
        int hollandeFortune = 50;

        // 1.
        sarkozyFortune += macronFortune / 2;
        macronFortune = macronFortune / 2;

        // 2.
        macronFortune += hollandeFortune / 2;
        hollandeFortune = hollandeFortune / 2;

        // 3.
        hollandeFortune += sarkozyFortune / 2;
        sarkozyFortune = sarkozyFortune / 2;


        System.out.println("Sarkozy : " + sarkozyFortune);
        System.out.println("Macron : " + macronFortune);
        System.out.println("Hollande : " + hollandeFortune);
    }
}
