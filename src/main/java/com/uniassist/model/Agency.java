package com.uniassist.model;

public class Agency {

    private int agencyId;
    private String agencyName;
    private String agencyAddress;
    private String agencyPhone;
    private String agencyEmail;
    private String agencyShortName;

    public Agency() {

    }

    public Agency(int agencyId, String agencyName, String agencyAddress, String agencyPhone) {
        this.agencyId = agencyId;
        this.agencyName = agencyName;
        this.agencyAddress = agencyAddress;
        this.agencyPhone = agencyPhone;
    }

    public Agency(int agencyId, String agencyName, String agencyAddress, String agencyPhone, String agencyEmail, String agencyShortName) {
        this.agencyId = agencyId;
        this.agencyName = agencyName;
        this.agencyAddress = agencyAddress;
        this.agencyPhone = agencyPhone;
        this.agencyEmail = agencyEmail;
        this.agencyShortName = agencyShortName;
    }

    public String getAgencyEmail() {
        return agencyEmail;
    }

    public void setAgencyEmail(String agencyEmail) {
        this.agencyEmail = agencyEmail;
    }

    public String getAgencyShortName() {
        return agencyShortName;
    }

    public void setAgencyShortName(String agencyShortName) {
        this.agencyShortName = agencyShortName;
    }

    public int getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(int agencyId) {
        this.agencyId = agencyId;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getAgencyAddress() {
        return agencyAddress;
    }

    public void setAgencyAddress(String agencyAddress) {
        this.agencyAddress = agencyAddress;
    }

    public String getAgencyPhone() {
        return agencyPhone;
    }

    public void setAgencyPhone(String agencyPhone) {
        this.agencyPhone = agencyPhone;
    }
}
