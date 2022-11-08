package com.example.sugangserver;

public class UserInfo {
    private static UserInfo instance = new UserInfo(false, "2022002331", "윤인욱", "건설환경공학과");

    public static UserInfo getInstance() {
        return instance;
    }

    private boolean isAdmin = false;
    private String userId;
    private String name;
    private String major_name;

    private UserInfo(boolean isAdmin, String userId, String name, String major_name) {
        this.isAdmin = isAdmin;
        this.userId = userId;
        this.name = name;
        this.major_name = major_name;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMajor_name() {
        return major_name;
    }

    public void setMajor_name(String major_name) {
        this.major_name = major_name;
    }
}
