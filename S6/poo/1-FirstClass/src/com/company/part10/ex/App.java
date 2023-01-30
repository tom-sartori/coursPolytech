package com.company.part10.ex;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.function.Predicate;

import static java.util.stream.Collectors.toList;

public class App {


    public static List<Course> select(List<Course> courseList, final Predicate<Course> func){
        return courseList.stream()
                .filter(func)
                .collect(toList());
    }

    public static void main(String[] args) {
        Predicate<Course> IG3Selector = (c -> c.getLevel().equals("IG3"));

        Course course1 = new Course("BD", "Jean", "IG3");
        Course course2 = new Course("BDA", "Pierre", "IG4");

        System.out.println(IG3Selector.test(course1));
        System.out.println(IG3Selector.test(course2));

        Function<Course, Boolean> samCourse = (x -> x.getTeacher().equals("Sam"));

        System.out.println(samCourse.apply(course1));

        ArrayList<Course> courseArrayList = new ArrayList<>();
        courseArrayList.add(course1);
        courseArrayList.add(course2);

        System.out.println(select(courseArrayList, IG3Selector).get(0).getTeacher());
        System.out.println(select(courseArrayList, x -> x.getLevel().equals("IG3")));
    }
}
