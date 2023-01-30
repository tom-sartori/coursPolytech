package com.company.part5A;

public class B extends A {
    private int j;

    public B(int x, int y) {
        super(x);
        j = y;
    }

    public String whoAreYou() {
        return "I’m a B";
    }

    public String toString() {
        return super.toString() + "\n j = " + j;
    }
} // End class B
