package com.uniassist.model;

public class ApplicationState {

    private int ApplicationStateID;
    private String Name;
    private String Information;

    public ApplicationState(int applicationStateID, String name, String information) {
        ApplicationStateID = applicationStateID;
        Name = name;
        Information = information;
    }

    public int getApplicationStateID() {
        return ApplicationStateID;
    }

    public void setApplicationStateID(int applicationStateID) {
        ApplicationStateID = applicationStateID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getInformation() {
        return Information;
    }

    public void setInformation(String information) {
        Information = information;
    }
}
