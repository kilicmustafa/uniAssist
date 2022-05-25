package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class AnalyticsDaoImpl {
    private DBHelper dbHelper;

    public AnalyticsDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    public HashMap<String, Integer> getRegistrationDateDistrubiton() throws SQLException {
        HashMap<String, Integer> hashMap = new HashMap<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT RegistrationDate, COUNT(*) AS 'Count' FROM user GROUP BY user.RegistrationDate ORDER BY " +
                "RegistrationDate ASC");

        while(resultSet.next()) {
            Date date = resultSet.getDate("RegistrationDate");
            hashMap.put(date.toLocalDate().getDayOfMonth() + "." + date.toLocalDate().getMonthValue() + "." + date.toLocalDate().getYear(),
                    resultSet.getInt("Count"));
        }

        return hashMap;
    }

    public HashMap<Integer, Integer> getApplicationStateCount() throws SQLException {
        HashMap<Integer, Integer> hashMap = new HashMap<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT ApplicationStateID, COUNT(*) AS 'Count' FROM userapplicationstate GROUP BY ApplicationStateID");
        while(resultSet.next()) {
            hashMap.put(resultSet.getInt("ApplicationStateID"), resultSet.getInt("Count"));
        }
        return hashMap;
    }
}
