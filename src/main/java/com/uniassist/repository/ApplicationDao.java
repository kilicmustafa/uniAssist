package com.uniassist.repository;

import com.uniassist.model.Application;
import com.uniassist.model.User;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

public interface ApplicationDao {

    int createApplication(Application application);
    Application getApplicationByUserId(int userId);
    int getApplicationID(int userId);
    void updateAdditional(int userId, String additional);
}
