package com.uniassist.services;

import com.uniassist.helper.DBHelper;
import com.uniassist.repository.PendingDao;
import com.uniassist.repository.implementations.PendingDaoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthService {

    private DBHelper dbHelper;
    private PendingDao pendingDao;

    public AuthService() {
        dbHelper = DBHelper.getInstance();
        pendingDao = new PendingDaoImpl();
    }

    public boolean userAuth(String email, String password) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT UserID, Email, Password FROM user WHERE Email = \"" + email
                + "\" AND Password = \"" + password + "\"");
        try {
            return resultSet != null && resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isActivated(String email, String password) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT UserID, Email, Password FROM user WHERE Email = \"" + email
                + "\" AND Password = \"" + password + "\"");
        try {
            resultSet.next();
            return resultSet.getString("Email").equals(email) && resultSet.getString("Password").equals(password)
                    && !pendingDao.isActivationExist(resultSet.getInt("UserID"));
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getRoleIdByEmail(String email) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT RoleID FROM user WHERE Email = \"" + email + "\"");
        try {
            if (resultSet != null && resultSet.next()) {
                return resultSet.getInt("RoleID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getIdByEmail(String email) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT UserID FROM user WHERE Email = \"" + email + "\"");
        try {
            if (resultSet != null && resultSet.next()) {
                return resultSet.getInt("UserID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
