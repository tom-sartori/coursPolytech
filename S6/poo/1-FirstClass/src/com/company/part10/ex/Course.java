package com.company.part10.ex;

public class Course {

    private String name;
    private String teacher;
    private String level;

    public Course(String name, String teacher, String level) {
        this.name = name;
        this.teacher = teacher;
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public String getTeacher() {
        return teacher;
    }

    public String getLevel() {
        return level;
    }

    @Override
    public String toString() {
        return "Course{" +
                "name='" + name + '\'' +
                ", teacher='" + teacher + '\'' +
                ", level='" + level + '\'' +
                '}';
    }
}
