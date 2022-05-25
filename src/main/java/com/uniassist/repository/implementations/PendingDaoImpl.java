package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.repository.PendingDao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PendingDaoImpl implements PendingDao {

    private DBHelper dbHelper;

    public PendingDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public boolean isActivationExist(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM pending WHERE UserID = " + userId);
        try {
            if(resultSet != null && resultSet.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean isActivationExist(String verificationKey) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM pending WHERE VerificationKey = \"" + verificationKey + "\"");
        try {
            if(resultSet != null && resultSet.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void createActivation(int userId, String verificationKey) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO pending(UserID, VerificationKey) VALUES(?, ?)");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, verificationKey);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getUserIdByVerificationKey(String verificationKey) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT UserID FROM pending WHERE VerificationKey = \"" + verificationKey + "\"");
        try {
            if(resultSet != null && resultSet.next()) {
                return resultSet.getInt("UserID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void deleteActivation(String verificationKey) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM pending WHERE VerificationKey = ?");
        try {
            preparedStatement.setString(1, verificationKey);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
