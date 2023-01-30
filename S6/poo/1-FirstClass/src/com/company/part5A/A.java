package com.company.part5A;

public class A {
    private int i;
    public A(int x) { i = x; }
    public String whoAreYou (){return "I’m an A";}
    public String toString() { return "i = " + i;}
    public String introduceYourSelf(){ return whoAreYou() + toString(); } }// End class A

