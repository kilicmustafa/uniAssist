package com.uniassist.model;

import java.math.BigDecimal;

public class ApplicationType {

    private int ApplicationTypeID;
    private String TypeName;
    private BigDecimal price;

    public ApplicationType(int applicationTypeID, String typeName, BigDecimal price) {
        ApplicationTypeID = applicationTypeID;
        TypeName = typeName;
        this.price = price;
    }

    public int getApplicationTypeID() {
        return ApplicationTypeID;
    }

    public void setApplicationTypeID(int applicationTypeID) {
        ApplicationTypeID = applicationTypeID;
    }

    public String getTypeName() {
        return TypeName;
    }

    public void setTypeName(String typeName) {
        TypeName = typeName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
