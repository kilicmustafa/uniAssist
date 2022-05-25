package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.User;
import com.uniassist.repository.RemindDao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class RemindDaoImpl implements RemindDao {

    private DBHelper dbHelper;

    public RemindDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public void insert(User user) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO remind(UserID, RemindDate) VALUES(?, ?)");
        try {
            preparedStatement.setInt(1, user.getUserId());
            preparedStatement.setDate(2, Date.valueOf(LocalDate.now()));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
