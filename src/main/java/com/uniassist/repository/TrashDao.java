package com.uniassist.repository;

import com.uniassist.model.User;

import java.util.List;

public interface TrashDao {

    List<User> getUsers();
    void restoreUser(int userId);

    void deleteUser(Integer userId);
}
