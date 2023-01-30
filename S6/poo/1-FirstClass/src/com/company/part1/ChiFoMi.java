package com.company.part1;


import java.util.Random;
import java.util.Scanner;

public class ChiFoMi {

    private static final Random random = new Random();
    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int score = 0;

        do {
            char userMove = getPlayerMove();
            char randomMove = getRandomMove();
            System.out.println("User move = " + toStringMove(userMove) + " | computer move : " + toStringMove(randomMove));
            score += getTurnScore(userMove, randomMove);
            System.out.println("Score for user : " + score);
            System.out.println();
        }
        while (score != -2 && score != 2);

        System.out.println(score == -2 ? "Computer win!" : "You win!");
    }

    private static char getPlayerMove() {
        char move;
        do {
            System.out.print("Enter a move. Type :  ");
            System.out.print("l for leaf | r for rock | s for scissor ");
            move = scanner.nextLine().charAt(0);
        }
        while (move != 'l' && move != 'r' && move != 's');

        return move;
    }

    private static char getRandomMove () {
        return switch (random.nextInt(3)) {
            case 0 -> 'l';
            case 1 -> 'r';
            default -> 's';
        };
    }

    private static int getTurnScore (char playerMove, char computerMove) {
        if (playerMove == computerMove) {
            return 0;
        }

        if (playerMove == 'l') {
            if (computerMove == 's') {
                // Loose.
                return -1;
            }
            else {
                // Win.
                return 1;
            }
        }
        else if (playerMove == 'r') {
            if (computerMove == 'l') {
                // Loose.
                return -1;
            }
            else {
                // Win.
                return 1;
            }
        }
        else {  //  (playerMove == 's')
            if (computerMove == 'r') {
                // Loose.
                return -1;
            }
            else {
                // Win.
                return 1;
            }
        }
    }

    private static String toStringMove (char move) {
        return switch (move) {
            case 'l' -> "\uD83D\uDCC3";     // Leaf.
            case 'r' -> "\uD83E\uDEA8";     // Rock.
            default -> "\u2702";    // scissors.
        };
    }
}
