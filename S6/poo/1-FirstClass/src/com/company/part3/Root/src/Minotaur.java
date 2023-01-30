package com.company.part3.Root.src;

public class Minotaur {

    private int x;
    private int y;

    public Minotaur(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public boolean isHere(int x, int y) {
        return this.x == x && this.y == y;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public void setXY (int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public String toString() {
        return "\uD83D\uDFE9";  // Green square.
    }
}
