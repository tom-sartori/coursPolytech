package com.company.part2;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;


class MyDateTest {

    private MyDate myDate1;
    private MyDate myDate2;

    @BeforeEach
    void init (){
        myDate1 = new MyDate(31, 5, 2000);
        System.out.println("Other date : " + myDate1 + " => " + myDate1.dateInLetters());

        myDate2 = new MyDate();
        System.out.println("Current date : " + myDate2 + " => " + myDate2.dateInLetters());
    }

    @Test
    void testEquals() {
        assertTrue(myDate1.equals(new MyDate(myDate1.getDay(), myDate1.getMonth(), myDate1.getYear())));
    }

    @Test
    void testCompare1() {
        assertTrue(myDate1.compare(myDate2) > 0);
    }

    @Test
    void testCompare2() {
        assertTrue(myDate2.compare(myDate1) < 0);
    }

    @Test
    void testCompare3() {
        assertEquals(0, myDate1.compare(new MyDate(myDate1.getDay(), myDate1.getMonth(), myDate1.getYear())));
    }

    @Test
    void testSmallest1() {
        assertEquals(myDate1, myDate1.smallest(myDate2));
    }

    @Test
    void testSmallest2() {
        assertEquals(myDate1, myDate1.smallest(new MyDate(myDate1.getDay(), myDate1.getMonth(), myDate1.getYear())));
    }

    @Test
    void testDateInLetters() {
        assertEquals("31 May 2000", myDate1.dateInLetters());
    }
}
