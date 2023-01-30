package com.company.part2;

import java.util.Objects;

public class Period {
    private final MyDate startingDate;
    private final MyDate endingDate;

    public Period(MyDate startingDate, MyDate endingDate) {
        if (startingDate.compare(endingDate) >= 0) {
            this.startingDate = startingDate;
            this.endingDate = endingDate;
        }
        else {
            this.endingDate = startingDate;
            this.startingDate = endingDate;
        }
    }

    public Period(MyDate startingDate) {
        this.startingDate = startingDate;
        this.endingDate = new MyDate();
    }

    // returns true if the two periods overlap, else it returns false
    public boolean intersectsWith(Period otherPeriod) {
        return otherPeriod.startingDate.compare(endingDate) >= 0 && startingDate.compare(otherPeriod.endingDate) >= 0;
    }

    // returns true if the current period precedes the one received as a parameter, else returns false
    public boolean isBefore (Period otherPeriod) {
        return startingDate.compare(otherPeriod.endingDate) >= 0 && endingDate.compare(otherPeriod.endingDate) >= 0;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Period period = (Period) o;
        return Objects.equals(startingDate, period.startingDate) &&
                Objects.equals(endingDate, period.endingDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(startingDate, endingDate);
    }

    @Override
    public String toString() {
        return startingDate + " - " + endingDate;
    }
}
