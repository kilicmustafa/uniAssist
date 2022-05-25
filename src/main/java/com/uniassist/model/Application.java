package com.uniassist.model;


public class Application {

    private int applicationId;
    private int userId;
    private String additional;

    public Application(int userId, String additional) {
        this.userId = userId;
        this.additional = additional;
    }

    public Application(int applicationId, int userId, String additional) {
        this.applicationId = applicationId;
        this.userId = userId;
        this.additional = additional;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAdditional() {
        return additional;
    }

    public void setAdditional(String additional) {
        this.additional = additional;
    }
}
