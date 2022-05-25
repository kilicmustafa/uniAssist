package com.uniassist.model;

import java.sql.Date;

public class User {


    private int userId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String gender;
    private String country;
    private String city;
    private String phoneNumber;
    private int roleId;
    private int requestId;
    private int appType;
    private Date registrationDate;
    private Date birthDate;
    private int agencyId;

    private static final int DEFAULT_ROLE = 2;


    public User() {
        this.roleId = DEFAULT_ROLE;
    }

    public User(int userId, String firstName, String lastName, String email, int requestId, int appType, Date registrationDate, int roleId) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.appType = appType;
        this.registrationDate = registrationDate;
        this.requestId = requestId;
        this.roleId = roleId;
    }

    public User(int userId, String firstName, String lastName, String email, int requestId, int appType, Date registrationDate, int roleId, int agencyId) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.appType = appType;
        this.registrationDate = registrationDate;
        this.requestId = requestId;
        this.roleId = roleId;
        this.agencyId = agencyId;
    }

    public User(int userId, String firstName, String lastName, String email, String password, int roleId, int requestId, int appType, Date registrationDate, Date birthDate, int agencyId) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.requestId = requestId;
        this.appType = appType;
        this.registrationDate = registrationDate;
        this.agencyId = agencyId;
        this.birthDate = birthDate;
    }

    public User(int userId, String firstName, String lastName, String email, String password, int roleId, int requestId, int appType, Date registrationDate, Date birthDate, int agencyId, String gender, String country, String city, String phoneNumber) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.requestId = requestId;
        this.appType = appType;
        this.registrationDate = registrationDate;
        this.agencyId = agencyId;
        this.birthDate = birthDate;
        this.gender = gender;
        this.city = city;
        this.country = country;
        this.phoneNumber = phoneNumber;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public static int getDefaultRole() {
        return DEFAULT_ROLE;
    }

    public int getAppType() {
        return appType;
    }

    public void setAppType(int appType) {
        this.appType = appType;
    }

    public int getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(int agencyId) {
        this.agencyId = agencyId;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
