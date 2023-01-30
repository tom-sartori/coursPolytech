package com.company.part2;


import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        MyDate myDate2 = new MyDate();
        System.out.println("Current date : " + myDate2 + " => " + myDate2.dateInLetters());

        MyDate myDate1 = new MyDate(31, 5, 2000);
        System.out.println("Other date : " + myDate1 + " => " + myDate1.dateInLetters());

        System.out.println("Smallest : " + myDate1.smallest(myDate2).dateInLetters());


        int n = 30;
        int[] listInt = new int[n];
        MyDate[] listMyCurrentDate = new MyDate[n];
        MyDate[] listMyDate = new MyDate[n];

        for (int i = 0; i < n; i++) {
            listInt[i] = -1;
            listMyCurrentDate[i] = new MyDate();
            listMyDate[i] = new MyDate(i, 4, 2069);
        }

        System.out.println(Arrays.toString(listInt));
        System.out.println(Arrays.toString(listMyCurrentDate));
        System.out.println(Arrays.toString(listMyDate));
    }
}
