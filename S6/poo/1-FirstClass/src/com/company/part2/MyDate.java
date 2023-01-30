package com.company.part2;

import java.time.LocalDate;

public class MyDate {

    private final int day;
    private final int month;
    private final int year;
    private static final String[] listMonth = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

    // Initializes with the current date (of today) public MyDate(int day, int month, int year)
    public MyDate() {
        LocalDate date = LocalDate.now();
        day = date.getDayOfMonth();
        month = date.getMonthValue();
        year = date.getYear();
    }

    // Initializes with the date day/month/year without checking parameters
    public MyDate(int day, int month, int year) {
        this.day = day;
        this.month = month;
        this.year = year;
    }

    public int getDay() {
        return day;
    }

    public int getMonth() {
        return month;
    }

    public int getYear() {
        return year;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MyDate myDate = (MyDate) o;
        return day == myDate.day &&
                month == myDate.month &&
                year == myDate.year;
    }

    // returns 0 if the dates are equal
    // a strictly positive integer if this precedes strictly other
    // a strictly negative integer if other precedes strictly this
    public int compare(MyDate other) {
        return ((other.year * 10000) + (other.month * 100) + other.day) - ((year * 10000) + (month * 100) + day);
    }

    // returns the one of the two dates which precedes the other. If the two dates are equal, it returns this
    public MyDate smallest(MyDate other) {
        return this.compare(other) >= 0 ? this : other;
    }

    // returns a String describing the date as "day month year" where month is in letters (January, ...)
    public String dateInLetters() {
        return day + " " + listMonth[month - 1] + " " + year;
    }

    @Override
    public String toString() {
        return day + "/" + month + "/" + year;
    }
}
