package com.company.part1;

import java.util.Scanner;

public class SNCF {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter your age: ");
        int userAge = sc.nextInt();

        System.out.print("Enter the ticket price: ");
        int ticketPrice = sc.nextInt();

        boolean isSubscribed = false;
        if (18 <= userAge && userAge <= 25) {
            System.out.print("Do you have a subscription ? (1 = yes | 2 = no)");
            isSubscribed = sc.nextInt() == 1;
        }

        System.out.println("Best price : " + reduction(userAge, ticketPrice, isSubscribed) + " €. ");
    }

    private static double reduction (int userAge, double ticketPrice, boolean isSubscribed) {
        if (userAge < 10) {
            // Child.
            return ticketPrice * 0.5;
        }
        else if (userAge > 65) {
            // Elder persons.
            return ticketPrice * 0.66;
        }
        else if (18 <= userAge && userAge <= 25) {
            // Students.
            if (isSubscribed) {
                // Student subscribed.
                return ticketPrice * 0.25;
            }
            else if (ticketPrice > 20) {
                // Student not subscribed whit ticket above 20 €.
                return Math.min(ticketPrice - 15, 10 + (ticketPrice * 0.25));
            }
            else {
                // Student not subscribed whit ticket under 20 €.
                return 10 + (ticketPrice * 0.25);
            }
        }
        else {
            // Normal client.
            return ticketPrice;
        }
    }
}
