package com.uniassist.model;

import java.util.List;

public class ApplicationFormat {

    private int applicationFormatId;
    private String country;
    private String name;
    private int type;
    private List<Integer> types;

    public ApplicationFormat(String country, String name, int type) {
        this.country = country;
        this.name = name;
        this.type = type;
    }

    public ApplicationFormat(String country, String name, List<Integer> types) {
        this.country = country;
        this.name = name;
        this.types = types;
    }

    public ApplicationFormat() {

    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public List<Integer> getTypes() {
        return types;
    }

    public void setTypes(List<Integer> types) {
        this.types = types;
    }

    public int getApplicationFormatId() {
        return applicationFormatId;
    }

    public void setApplicationFormatId(int applicationFormatId) {
        this.applicationFormatId = applicationFormatId;
    }
}
