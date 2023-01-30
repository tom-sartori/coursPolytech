package com.company.part3.Root.src;

public class Human {

    private int x;
    private int y;

    public Human() {
        x = 0;
        y = 0;
    }

    public void traverse(int xCurrent, int yCurrent) {
        x = xCurrent;
        y = yCurrent;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public boolean isHere(int x, int y) {
        return this.x == x && this.y == y;
    }

    @Override
    public String toString() {
        return "\ud83d\udfe6";  // Blue square.
    }
}
