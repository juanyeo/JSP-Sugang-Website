package com.example.sugangserver.dto;

public class Lecture {
    int class_id;
    int class_no;
    String course_id;
    String course_name;
    int major_id;
    String major_name;
    int year;
    int credit;
    int lecturer_id;
    String lecturer_name;
    int person_max;
    int opened;
    int room_id;
    String building_name;
    String day_of_week;
    String begin;
    String end;
    int person_enroll;
    int re_enroll = 0; // 1, 0
    String validation_message;

    public Lecture(int class_id, int class_no, String course_id, String course_name, int major_id, String major_name, int year, int credit, int lecturer_id, String lecturer_name, int person_max, int opened, int room_id, String building_name, String day_of_week, String begin, String end, int person_enroll) {
        this.class_id = class_id;
        this.class_no = class_no;
        this.course_id = course_id;
        this.course_name = course_name;
        this.major_id = major_id;
        this.major_name = major_name;
        this.year = year;
        this.credit = credit;
        this.lecturer_id = lecturer_id;
        this.lecturer_name = lecturer_name;
        this.person_max = person_max;
        this.opened = opened;
        this.room_id = room_id;
        this.building_name = building_name;
        this.day_of_week = day_of_week;
        this.begin = begin;
        this.end = end;
        this.person_enroll = person_enroll;
    }

    public int getRe_enroll() {
        return re_enroll;
    }

    public void setRe_enroll(int re_enroll) {
        this.re_enroll = re_enroll;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getClass_no() {
        return class_no;
    }

    public void setClass_no(int class_no) {
        this.class_no = class_no;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }

    public int getMajor_id() {
        return major_id;
    }

    public void setMajor_id(int major_id) {
        this.major_id = major_id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
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

    public int getPerson_max() {
        return person_max;
    }

    public void setPerson_max(int person_max) {
        this.person_max = person_max;
    }

    public int getOpened() {
        return opened;
    }

    public void setOpened(int opened) {
        this.opened = opened;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getBuilding_name() {
        return building_name;
    }

    public void setBuilding_name(String building_name) {
        this.building_name = building_name;
    }

    public String getDay_of_week() {
        return day_of_week;
    }

    public void setDay_of_week(String day_of_week) {
        this.day_of_week = day_of_week;
    }

    public String getBegin() {
        return begin;
    }

    public void setBegin(String begin) {
        this.begin = begin;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getMajor_name() {
        return major_name;
    }

    public void setMajor_name(String major_name) {
        this.major_name = major_name;
    }

    public int getPerson_enroll() {
        return person_enroll;
    }

    public void setPerson_enroll(int person_enroll) {
        this.person_enroll = person_enroll;
    }

    public String getValidation_message() {
        return validation_message;
    }

    public void setValidation_message(String validation_message) {
        this.validation_message = validation_message;
    }
}
