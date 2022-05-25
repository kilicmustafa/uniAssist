package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.ApplicationState;
import com.uniassist.model.User;
import com.uniassist.repository.ApplicationStateDao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ApplicationStateDaoImpl implements ApplicationStateDao {

    private DBHelper dbHelper;

    public ApplicationStateDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public List<ApplicationState> getApplicationStates() {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM applicationstate");
        List<ApplicationState> applicationStates = new ArrayList<>();
        try {
            if(resultSet != null) {
                while(resultSet.next()) {
                    applicationStates.add(
                      new ApplicationState(resultSet.getInt("ApplicationStateID"), resultSet.getString("Name"),
                              resultSet.getString("Information"))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applicationStates;
    }

    @Override
    public void createApplicationState(int userId, int i) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO userapplicationstate(UserID, ApplicationStateID) " +
                "VALUES(?, ?)");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, i);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateApplicationState(int userId, int i) {
        if(getApplicationStateIDByUserID(userId) == 0) {
            createApplicationState(userId, i);
            return;
        }
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE userapplicationstate SET ApplicationStateID = ? " +
                "WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, i);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getApplicationStateIDByUserID(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT ApplicationStateID FROM userapplicationstate WHERE UserID = " + userId);
        try {
            if(resultSet.next()) {
                return resultSet.getInt("ApplicationStateID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public HashMap<Integer, Integer> getApplicationStatesByUsers(List<User> recentUsers) {
        HashMap<Integer, Integer> hashMap = new HashMap<>();
        for(User user : recentUsers) {
            hashMap.put(user.getUserId(), this.getApplicationStateIDByUserID(user.getUserId()));
        }
        return hashMap;
    }
}
