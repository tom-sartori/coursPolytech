package com.company.part10.ex2;

public class App {

    public static void main(String[] args) {
        Payslip payslip = new Payslip("Jean", 5000., 50, 0.5, 20.);

        for (Object o : payslip) {
            System.out.println(o);
        }
    }
}
