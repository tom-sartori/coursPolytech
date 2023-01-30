package com.company.part3.Root.src;

import java.util.Random;

public class Labyrinth {
    // we consider square labyrinths as for now
    private int size; // size must not be modified from the outside

    // Cells of the labyrinth
    //... cells ... // cells should not be accessed from the outside
    private Cell[][] cells;

    private Minotaur minotaur;
    private Human human;

    private Random random;

    // Constructor
    public Labyrinth(int size) {
        this.size = size;

        cells = new Cell[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                cells[i][j] = new Cell();
            }
        }

        // Create a new minotaur at a random place and visit this place.
        random = new Random();
        int x = random.nextInt(size);
        int y = random.nextInt(size);
        minotaur = new Minotaur(x, y);
        cells[x][y].visit();

        human = new Human();
        cells[human.getX()][human.getY()].visit();
    }

    // Open the wall of a cell at line l, col c in the given direction: 'N', 'S', 'E' or 'W'
    public void openWall(int l, int c, char direction) {
        cells[l][c].openWall(direction);
        // We need to also open the adjacent cell (if it exists).
        switch (direction) {
            case 'N':
                if (l - 1 >= 0) {
                    cells[l - 1][c].openWall(getOppositeDirection(direction));
                }
                break;
            case 'S':
                if (l + 1 < size) {
                    cells[l + 1][c].openWall(getOppositeDirection(direction));
                }
                break;
            case 'E':
                if (c + 1 < size) {
                    cells[l][c + 1].openWall(getOppositeDirection(direction));
                }
                break;
            case 'W':
                if (c - 1 >= 0) {
                    cells[l][c - 1].openWall(getOppositeDirection(direction));
                }
                break;
            default:
                throw new Error("Direction error. ");
        }
    }

    // Return the oposite direction of the one in params.
    private static char getOppositeDirection(char direction) {
        switch (direction) {
            case 'N':
                return 'S';
            case 'S':
                return 'N';
            case 'E':
                return 'W';
            case 'W':
                return 'E';
            default:
                throw new Error("Direction error. ");
        }
    }

    // Checks whether some wall of a cell at line l, col c is opened
    public boolean isOpened(int l, int c,char direction) {
        return cells[l][c].isOpened(direction);
    }

    // copy of a cell so that cell of the lab is not modified
    public Cell getCopyOfCell(int l, int c) {
        return cells[l][c].copy();
    }

    // Get a new position and then, open a wall, move the minautor and visit the cell.
    public void moveMinotaur () {
        int newL = minotaur.getX();
        int newC = minotaur.getY();
        char direction;

        if (random.nextInt(2) == 0) {
            // Get a new l.
            newL = getNewPosition(newL);
            direction = minotaur.getX() < newL ? 'S' : 'N';
        }
        else {
            // Get a new c.
            newC = getNewPosition(newC);
            direction = minotaur.getY() < newC ? 'E' : 'W';
        }

        openWall(minotaur.getX(), minotaur.getY(), direction);
        minotaur.setXY(newL, newC);
        cells[newL][newC].visit();
    }

    // Randomly incermente or decrement the int in params. Respect values between 0 : size -1.
    // Used to get a new randomized l or c.
    private int getNewPosition (int point) {
        if (point + 1 >= size) {     // Current is at the right.
            return point - 1;
        }
        else if (point - 1 < 0) {   // Current is at the left.
            return point + 1;
        }
        else {  // Current is not at an extremity.
            return point + (random.nextInt(2) == 0 ? -1 : 1);
        }
    }

    // If it is possible, move the human.
    public void moveHuman () {
        int newL = human.getX();
        int newC = human.getY();
        char direction;

        if (human.getX() != 0 && isOpened(human.getX(), human.getY(), 'N')) {
            newL--;
            direction = 'N';
        }
        else if (human.getX() != size - 1 && isOpened(human.getX(), human.getY(), 'S')) {
            newL++;
            direction = 'S';
        }
        else if (human.getY() != 0 && isOpened(human.getX(), human.getY(), 'W')) {
            newC--;
            direction = 'W';
        }
        else if (human.getY() != size - 1 && isOpened(human.getX(), human.getY(), 'E')) {
            newC++;
            direction = 'E';
        }
        else {
            System.out.println("Human can't move. ");
            return;
        }

        openWall(human.getX(), human.getY(), direction);
        human.traverse(newL, newC);
        cells[newL][newC].visit();
    }

    // Return true if the human and the minotaur are at the same cell.
    public boolean isHumanMinotaurSamePlace () {
        return human.getX() == minotaur.getX() && human.getY() == minotaur.getY();
    }

    // Return true if every cell of the labyrinth are visited.
    public boolean isFullyVisited() {
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                if (!cells[i][j].isVisited()) {
                    return false;
                }
            }
        }
        return true;
    }

    // pretty print of labyrinth
    public String toString() {
        String redSquare = "\ud83d\udfe5";

        String s="";
        // 1st line
        for (int c = 0; c<this.size;c++) {
            s += "+---";
        }
        s+= "+\n";
        // Each line of cells:
        for (int l = 0; l<this.size;l++) {
            s+= "|"; // beginning of line    
            for (int c = 0; c<this.size;c++) {
                s += ' ';
                if (minotaur.isHere(l, c)) {
                    if (human.isHere(l, c)) {
                        s += redSquare;
                    }
                    else {
                        s += minotaur.toString();
                    }
                }
                else if (human.isHere(l, c)) {
                    s += human.toString();
                }
                else {
                    s += cells[l][c].toString();
                }
                s += ' ';

                if (!cells[l][c].isOpened('E')) {
                    s += "|";
                }
                else {
                    s += ' ';
                }
            }
            s+="\n+";// end west to east walls line    
            for (int c=0; c<this.size;c++) {
                if (! cells[l][c].isOpened('S')) {
                    s += "---+";
                }
                else {
                    s += "   +";
                }
            }
            s+="\n"; // end of south walls line    
        }
        return s;
    }
}
