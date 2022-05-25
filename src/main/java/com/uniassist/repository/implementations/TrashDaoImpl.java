package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.User;
import com.uniassist.repository.TrashDao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TrashDaoImpl implements TrashDao {

    private DBHelper dbHelper;

    public TrashDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public List<User> getUsers() {
        List<User> users = new ArrayList<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM trash");
        try {
            while(resultSet.next()) {
                users.add(bindResultSetToUser(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public void restoreUser(int userId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO user SELECT * FROM trash WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
            this.deleteUser(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(Integer userId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM trash WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private User bindResultSetToUser(ResultSet resultSet) {
        try {
            return new User(
                    resultSet.getInt("UserID"),
                    resultSet.getString("FirstName"),
                    resultSet.getString("LastName"),
                    resultSet.getString("Email"),
                    resultSet.getString("Password"),
                    resultSet.getInt("RoleID"),
                    resultSet.getInt("RequestStateID"),
                    resultSet.getInt("ApplicationTypeID"),
                    resultSet.getDate("RegistrationDate"),
                    resultSet.getDate("BirthDate"),
                    resultSet.getInt("AgencyID"),
                    resultSet.getString("Gender"),
                    resultSet.getString("Country"),
                    resultSet.getString("City"),
                    resultSet.getString("PhoneNumber"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
