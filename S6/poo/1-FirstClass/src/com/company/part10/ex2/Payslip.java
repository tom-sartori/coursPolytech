package com.company.part10.ex2;

import java.util.Iterator;
import java.util.stream.Stream;

public class Payslip implements Iterable<Object> {

    private final String employer;
    private final Double salary;
    private final Integer nbHours;
    private final Double taxes;
    private final Double net;

    public Payslip(String employer, Double salary, Integer nbHours, Double taxes, Double net) {
        this.employer = employer;
        this.salary = salary;
        this.nbHours = nbHours;
        this.taxes = taxes;
        this.net = net;
    }

    @Override
    public Iterator<Object> iterator() {
        return new PayslipIterator(employer, salary, nbHours, taxes, net);
    }

    public Stream<Object> values () {
        return Stream.iterate(0, n -> n + 1).limit(4).map(this::value);
    }

    private Object value (int n) {
        return switch (n) {
            case 0 -> employer;
            case 1 -> salary;
            case 2 -> nbHours;
            case 3 -> taxes;
            default -> net;
        };
    }

    private class PayslipIterator implements Iterator<Object> {

        private final Object[] tab;
        private int currentIndex;

        public PayslipIterator(String employer, Double salary, int nbHours, Double taxes, Double net) {
            tab = new Object[]{ employer, salary, nbHours, taxes, net };
        }

        @Override
        public boolean hasNext() {
            return currentIndex < tab.length;
        }

        @Override
        public Object next() {
            Object o = tab[currentIndex];
            currentIndex++;
            return o;
        }
    }
}
