package com.uniassist.repository;

import com.uniassist.model.User;

import java.util.List;

public interface UserDao {
    boolean checkUserExist(String email);
    int addUser(User user);
    User getUserByEmail(String email);

    void updateUserRequestAndApp(User user);

    void updateEmail(int userId, String email);

    void updateFirstName(int userId, String firstName);

    void updatePassword(int userId, String password);

    void updateRequestId(int userId, int requestId);

    void updateAppType(int userId, int appType);

    List<User> getRecentUsers(int limit);

    List<User> getUsers(int limit, int offset);

    void deleteUserById(int userId);

    User getUserById(int userId);

    void updateUser(User user);

    List<User> getUsersByAgencyId(int agencyId);

    void updateUsersByDeletedAgency(Integer agencyId);

    List<User> getRecentUsersByAgencyId(int limit, int agencyId);

    List<User> getUsers(int limit, int offset, int agencyId);

    List<User> getUsersByName(String searchText);

    List<User> getUsers(int limit, int offset, int agencyId, String filter);
    List<User> getUsers(int limit, int offset, String filter);

    void moveToTrash(Integer userId);

    void updateGenderLocationPhone(User user);
    void updateUserProfile(User user);

    int getUserCount();

    List<User> getUsersNotInRemind();
}
