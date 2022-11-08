package com.example.sugangserver.dto;

public class Student {
    int student_id;
    String name;
    String sex;
    String major_name;
    int lecturer_id;
    String lecturer_name;
    int year;
    String status;
    String avg_grade;

    public Student(int student_id, String name, String sex, String major_name, int lecturer_id, String lecturer_name, int year, String status, String avg_grade) {
        this.student_id = student_id;
        this.name = name;
        this.sex = sex;
        this.major_name = major_name;
        this.lecturer_id = lecturer_id;
        this.lecturer_name = lecturer_name;
        this.year = year;
        this.status = status;
        this.avg_grade = avg_grade;
    }

    public String getAvg_grade() {
        return avg_grade;
    }

    public void setAvg_grade(String avg_grade) {
        this.avg_grade = avg_grade;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getMajor_name() {
        return major_name;
    }

    public void setMajor_name(String major_name) {
        this.major_name = major_name;
    }

    public int getLecturer_id() {
        return lecturer_id;
    }

    public void setLecturer_id(int lecturer_id) {
        this.lecturer_id = lecturer_id;
    }

    public String getLecturer_name() {
        return lecturer_name;
    }

    public void setLecturer_name(String lecturer_name) {
        this.lecturer_name = lecturer_name;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
