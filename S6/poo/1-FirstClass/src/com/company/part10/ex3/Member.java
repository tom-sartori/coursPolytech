package com.company.part10.ex3;

import java.util.stream.Stream;

public class Member {
    private String lastname = "unknown", firstname = "unknown";
    private boolean isSubscriptionUpToDate;
    private int birthYear;

    public Member(String lastname, String firstname, boolean isSubscriptionUpToDate, int birthYear) {
        this.lastname = lastname;
        this.firstname = firstname;
        this.isSubscriptionUpToDate = isSubscriptionUpToDate;
        this.birthYear = birthYear;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public boolean isSubscriptionUpToDate() {
        return isSubscriptionUpToDate;
    }

    public void setIsSubscriptionUpToDate(boolean isSubscriptionUpToDate) {
        this.isSubscriptionUpToDate = isSubscriptionUpToDate;
    }

    public int getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(int birthYear) {
        this.birthYear = birthYear;
    }

    @Override
    public String toString() {
        return "Member [firstname=" + firstname + ", lastname=" + lastname
                + ", isSubscriptionUpToDate=" + isSubscriptionUpToDate + "]";
    }

    public static void main(String[] args) {

        AssociationLaw1901 assoc = new AssociationLaw1901("Paris", 2004);
        assoc.setPresident(new Member("Sara", "Pierre", true, 1990));
        assoc.setSecretary(new Member("Ahmed", "Saada", true, 1990));
        assoc.setTreasurer(new Member("Camille", "Lemaire", false, 1994));
        assoc.subscribeMember(new Member("Jeanne", "Marc", true, 1995));
        assoc.subscribeMember(new Member("Marie", "Deschamps", false, 1967));
        assoc.subscribeMember(new Member("Astre", "Chateau", true, 1967));
        assoc.subscribeHonorary(new Member("Hector", "Dujardin", false, 1966));
        assoc.subscribeHonorary(new Member("Arthur", "Legrand", true, 1967));
        assoc.subscribeHonorary(new Member("Jacques", "Dubois", true, 1966));
        assoc.subscribeHonorary(new Member("Estelle", "Dubois", true, 1962));
        System.out.println(assoc);

        System.out.println("--- Members having paid their subscription ----");
        // To complete ....
//        assoc.getMembers().stream()
//                .filter(x -> x.isSubscriptionUpToDate)
//                .forEach(System.out::println);
//
//        assoc.getHonoraryMembers().stream()
//                .filter(x -> x.isSubscriptionUpToDate)
//                .forEach(System.out::println);
        // Is equivalent to :
        Stream.concat(assoc.getMembers().stream(), assoc.getHonoraryMembers().stream())
                .distinct()
                .filter(x -> x.isSubscriptionUpToDate)
                .forEach(System.out::println);




        System.out.println("--- Year of birth of the oldest honorary member ----");
        // To complete ....
        assoc.getHonoraryMembers().stream()
                .map(x -> x.birthYear)
                .min(Integer::compare)
                .ifPresent(System.out::println);
    }
}
