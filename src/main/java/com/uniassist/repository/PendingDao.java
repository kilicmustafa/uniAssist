package com.uniassist.repository;

public interface PendingDao {
    boolean isActivationExist(int userId);
    void deleteActivation(String verificationKey);
    boolean isActivationExist(String verificationKey);
    void createActivation(int userId, String verificationKey);
    int getUserIdByVerificationKey(String verificationKey);
}
