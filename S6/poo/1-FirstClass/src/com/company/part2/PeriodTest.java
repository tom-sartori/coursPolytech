package com.company.part2;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;


class PeriodTest {

    private Period period1;
    private Period period2;
    private Period period3;
    private Period period4;
    private Period period5;

    @BeforeEach
    void init () {
        period1 = new Period(new MyDate(1, 1, 2000), new MyDate(1, 1, 2001));
        period2 = new Period(new MyDate(1, 1, 2006), new MyDate(1, 1, 2011));
        period3 = new Period(new MyDate(1, 1, 2005), new MyDate(1, 1, 2015));
        period4 = new Period(new MyDate(1, 1, 2010), new MyDate(1, 1, 2011));
        period5 = new Period(new MyDate(1, 1, 2010), new MyDate(1, 1, 2020));
    }

    @Test
    void testIntersectsWith1() {
        assertFalse(period1.intersectsWith(period2));
    }

    @Test
    void testIntersectsWith2() {
        assertTrue(period2.intersectsWith(period3));
    }

    @Test
    void testIntersectsWith3() {
        assertTrue(period3.intersectsWith(period4));
    }

    @Test
    void testIntersectsWith4() {
        assertTrue(period3.intersectsWith(period5));
    }

    @Test
    void testisBefore1() {
        assertTrue(period1.isBefore(period5));
    }

    @Test
    void testisBefore2() {
        assertFalse(period5.isBefore(period1));
    }
}
