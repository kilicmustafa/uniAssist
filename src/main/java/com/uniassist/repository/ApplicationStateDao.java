package com.uniassist.repository;

import com.uniassist.model.ApplicationState;
import com.uniassist.model.User;

import java.util.HashMap;
import java.util.List;

public interface ApplicationStateDao {

    List<ApplicationState> getApplicationStates();

    void createApplicationState(int userId, int i);
    void updateApplicationState(int userId, int i);
    HashMap<Integer, Integer> getApplicationStatesByUsers(List<User> recentUsers);

    int getApplicationStateIDByUserID(int userId);
}
