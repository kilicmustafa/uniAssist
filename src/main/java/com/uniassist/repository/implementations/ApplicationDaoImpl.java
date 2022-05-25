package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.Application;
import com.uniassist.model.User;
import com.uniassist.repository.ApplicationDao;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;

public class ApplicationDaoImpl implements ApplicationDao {

    private DBHelper dbHelper;

    public ApplicationDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public int createApplication(Application application) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO application(UserID, Additional) " +
                "VALUES(?, ?)", Statement.RETURN_GENERATED_KEYS);
        try {
            preparedStatement.setInt(1, application.getUserId());
            preparedStatement.setString(2, application.getAdditional());
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
        return 0;
    }

    @Override
    public Application getApplicationByUserId(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM application WHERE UserID = " + userId);
        try {
            if (resultSet.next()) {

                return new Application(
                        resultSet.getInt("ApplicationID"),
                        userId,
                        resultSet.getString("Additional")
                );
            } else {
                return null;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int getApplicationID(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT ApplicationID FROM application WHERE UserID = " + userId);
        try {
            if(resultSet != null && resultSet.next()) {
                return resultSet.getInt("ApplicationID");
            } else {
                PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO application(UserID) VALUES(?)",
                        Statement.RETURN_GENERATED_KEYS);
                preparedStatement.setInt(1, userId);
                preparedStatement.executeUpdate();

                ResultSet rs = preparedStatement.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private boolean applicationExist(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM application WHERE UserID = " + userId);
        try {
            if(resultSet != null) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void updateAdditional(int userId, String additional) {
        if(!applicationExist(userId)) {
            createApplication(new Application(
                    userId,
                    additional
            ));
            return;
        }
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE application SET Additional = ? WHERE UserID = ?");
        try {
            preparedStatement.setString(1, additional);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
