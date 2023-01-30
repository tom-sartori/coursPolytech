package com.company.part3.Root.src;

/**
 * This class provides functions to search in arrays.
 *
 */

public class Cell {

    // each direction indicates whether there is a wall on that side of the cell
    private boolean north;
    private boolean south;
    private boolean east;
    private boolean west;

    private boolean visited;


    // Constructor returns a cell initially **closed on all sides**
    public Cell() {
        north = false;
        south = false;
        east = false;
        west = false;
        visited = false;
    }

    private Cell(boolean north, boolean south, boolean east, boolean west) {
        this.north = north;
        this.south = south;
        this.east = east;
        this.west = west;
    }

    public boolean isClosed() {
        return !north && ! south && ! east && !west;
    }

    // Open the cell on an indicated side. 'N', 'S', 'E' or 'W'
    public void openWall(char direction) {
        switch (direction) {
            case 'N':
                north = true;
                break;
            case 'S':
                south = true;
                break;
            case 'E':
                east = true;
                break;
            case 'W':
                west = true;
                break;
            default:
                throw new Error("Direction error. ");
        }
    }

    // TO DO Says whether cell is opened on the asked side
    public boolean isOpened(char direction) {
        switch (direction) {
            case 'N':
                return north;
            case 'S':
                return south;
            case 'E':
                return east;
            case 'W':
                return west;
            default:
                throw new Error("Direction error. ");
        }
    }

    public boolean isVisited() {
        return visited;
    }

    public void visit() {
        this.visited = true;
    }

    public Cell copy() {
        return new Cell(north, south, east, west);
    }

    @Override
    public String toString() {
        String blackSquare = "\u2B1B";
        String whiteSquare = "\u2B1C";
        return visited ? whiteSquare : blackSquare;
    }
}
