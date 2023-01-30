package com.company.part1;

/*
THE Z-PATTERN MAZE - step 1 (adapted from the EDX course on learning OOP)

This exercise asks you to print a maze shaped like a 'Z' depending on the number
of cells in the room (size constant).

I - Select main file, click compile button and then run button to see the result.
Initially the displayed labyrtinh contains only walls (' ' character)

II - Modify the code to try to answer the questions below.
Remember to compile again after each change.
If you mess up, you can reload the page and start again as many times as you want.
Every reload restarts form the beginning, unless you have an account and choosed to go to Project->Save changes

Questions:
	1 - Complete the code to obtain a labryrinth (a square array of characters)
	with a single path, printed with '.' characters that draw a 'Z':
	occupying cells of the whole first row, then going diagonally to the last row
	then "." characters occupy all cells of the last raw.

	Other cells of the labyrinth must be space characters (' ')

	2 - Change the value of the "size" variable. Does your program still behaves correctly?
    If not, then patch it.

	3 - What changes would be necessary to print the opposite diagonal (i.e. the "S"-Pattern)?
	Answer here (in comment):

	// Function for "S"-Pattern :
    private static void spattern(char[][] laby) {
    for(int i=0 ; i<size; i++){  // for each row of the labyrinth
        for(int j=0; j<size;j++){  // for each column of the labyrinth
            if((i == 0) || (i == laby[i].length-1) || i == j) {     // The modification is here. i == j
                laby[i][j] = '.';
            }
            else {
                laby[i][j] = ' ';
            }
        }
    }




*/
public class Labyrinth1 {

    private static final int size = 23;

    public static void display(char labyrinth [][]) {
        for(int i=0 ; i<labyrinth.length; i++){  // for each row of the labyrinth
            for(int j=0; j<labyrinth[i].length;j++){  // for each column of the labyrinth
                // complete code here to print a cell of the labyrinth
                System.out.print(labyrinth[i][j]);
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        char laby [][] = new char [size][size];
        System.out.print("Labyrinth: \n");
        spattern(laby);
        display(laby);
        System.out.print("that's it!\n");
    }

    private static void zpattern(char[][] laby) {
        for(int i=0 ; i<size; i++){  // for each row of the labyrinth
            for(int j=0; j<size;j++){  // for each column of the labyrinth
                if((i == 0) || (i == laby[i].length-1) || i == laby[i].length-1-j) {
                    laby[i][j] = '.';
                }
                else {
                    laby[i][j] = ' ';
                }
            }
        }
    }

    private static void spattern(char[][] laby) {
        for(int i=0 ; i<size; i++){  // for each row of the labyrinth
            for(int j=0; j<size;j++){  // for each column of the labyrinth
                if((i == 0) || (i == laby[i].length-1) || i == j) {     // The modification is here. i == j
                    laby[i][j] = '.';
                }
                else {
                    laby[i][j] = ' ';
                }
            }
        }
    }
}
