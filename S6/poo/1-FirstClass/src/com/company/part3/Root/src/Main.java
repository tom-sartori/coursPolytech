package com.company.part3.Root.src;

/**
 * Main class of the Java program.
 *
 */
public class Main {

    public static void main(String[] args) {
        int size = 3;
        Labyrinth labyrinth = new Labyrinth(size);
        System.out.println(
                "Not visited cell : " + new Cell().toString() +"\n" +
                        "Visited cell : "+ labyrinth.getCopyOfCell(0, 0).toString() +"\n" +
                        "Minotaur cell : "+ new Minotaur(-1, -1).toString() + "\n" +
                        "Human cell : "+ new Human().toString() + "\n" +
                        "Human and minotaur on same cell : \uD83D\uDFE5");

        System.out.println("Laby after its creation:\n"+labyrinth);

        // opens some wall
        labyrinth.openWall(0,0,'E');
        System.out.println("Laby after opening East wall of cell 0,0:\n"+labyrinth);
        System.out.print("West wall of cell l=1,c=2 should be opened. Is opened: ");
        System.out.println(labyrinth.isOpened(0,2,'W'));


        boolean isMinotaurMove = true;
        while (!labyrinth.isHumanMinotaurSamePlace() && !labyrinth.isFullyVisited()) {
            if (isMinotaurMove) {
                labyrinth.moveMinotaur();
            }
            else {
                labyrinth.moveHuman();
            }
            isMinotaurMove = !isMinotaurMove;
            System.out.println(labyrinth);
        }

        System.out.println("The labyrinth is finished. ");
        System.out.println(labyrinth.isFullyVisited() ? "Because it is fully visited. " : "Because the human found the minotaur. ");
    }
}
