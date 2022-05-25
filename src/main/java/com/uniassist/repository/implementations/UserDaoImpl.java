package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.User;
import com.uniassist.repository.UserDao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    private DBHelper dbHelper;

    public UserDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public boolean checkUserExist(String email) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE Email=\"" + email + "\"");
        try {
            return resultSet != null && resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }

    @Override
    public int addUser(User user) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO user(FirstName, LastName" +
                ", Email, Password, RoleID, RegistrationDate, AgencyID) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
        try {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setInt(5, user.getRoleId());
            preparedStatement.setDate(6, Date.valueOf(LocalDate.now()));
            if(user.getAgencyId() != 0) {
                preparedStatement.setInt(7, user.getAgencyId());
            } else {
                preparedStatement.setInt(7, 1);
            }
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
    public User getUserByEmail(String email) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE Email = \"" + email + "\"");
        try {
            if(resultSet.next()) {
                return bindResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateUserRequestAndApp(User user) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE user SET RequestStateID = ?, ApplicationTypeID = ? " +
                "WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, user.getRequestId());
            preparedStatement.setInt(2, user.getAppType());
            preparedStatement.setInt(3, user.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void updateEmail(int userId, String email) {
        updateOneStringColumn(userId, email, "Email");
    }

    @Override
    public void updateFirstName(int userId, String firstName) {
        updateOneStringColumn(userId, firstName, "FirstName");
    }

    private void updateOneStringColumn(int userId, String data, String column) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE user SET " + column + " = ? " +
                "WHERE UserID = ?");
        try {
            preparedStatement.setString(1, data);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updatePassword(int userId, String password) {
        updateOneStringColumn(userId, password, "Password");
    }

    @Override
    public void updateRequestId(int userId, int requestId) {
        updateOneIntColumn(userId, requestId, "RequestStateID");
    }

    @Override
    public void updateAppType(int userId, int appType) {
        updateOneIntColumn(userId, appType, "ApplicationTypeID");
    }

    private void updateOneIntColumn(int userId, int data, String column) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE user SET " + column + " = ? " +
                "WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, data);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> getRecentUsers(int limit) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user ORDER BY RegistrationDate DESC LIMIT " + limit);
        return getUsersByResultSet(resultSet);
    }

    @Override
    public List<User> getRecentUsersByAgencyId(int limit, int agencyId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE AgencyID = " + agencyId + " ORDER BY RegistrationDate DESC LIMIT " + limit);
        return getUsersByResultSet(resultSet);
    }

    @Override
    public List<User> getUsers(int limit, int offset, int agencyId) {
        // TODO: pagination yap
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE RoleID = 2 AND AgencyID = "+ agencyId + " ORDER BY RegistrationDate DESC" +
                " LIMIT " + limit + " OFFSET " + offset);
        return getUsersByResultSet(resultSet);
    }

    @Override
    public List<User> getUsersByName(String searchText) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE CONCAT(FirstName, ' ', LastName) LIKE '%" + searchText + "%'");
        List<User> users = new ArrayList<>();

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
    public void moveToTrash(Integer userId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT trash SELECT * FROM user WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
            this.deleteUserById(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateGenderLocationPhone(User user) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE user SET Gender = ?, City = ?, Country = ?, " +
                "PhoneNumber = ? WHERE UserID = ?");
        try {
            preparedStatement.setString(1, user.getGender());
            preparedStatement.setString(2, user.getCity());
            preparedStatement.setString(3, user.getCountry());
            preparedStatement.setString(4, user.getPhoneNumber());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> getUsers(int limit, int offset, String filter) {
        ResultSet resultSet = null;
        switch (filter) {
            case "completed":
                resultSet = dbHelper.executeQuery("SELECT * FROM user INNER JOIN userapplicationstate ON user.UserID = " +
                        "userapplicationstate.UserID WHERE ApplicationStateID = 5 ORDER BY RegistrationDate DESC");
                break;
            case "active":
                resultSet = dbHelper.executeQuery("SELECT user.* FROM user LEFT JOIN pending ON user.UserID = pending.UserID " +
                        "WHERE pending.PendingID is NULL ORDER BY RegistrationDate DESC");
                break;
            case "passive":
                resultSet = dbHelper.executeQuery("SELECT user.* FROM user INNER JOIN pending ON user.UserID = pending.UserID " +
                        "ORDER BY RegistrationDate DESC");
                break;
            case "authorizedusers":
                resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE RoleID = 1 OR RoleID = 3 ORDER BY RegistrationDate DESC");
                break;
        }
        return getUsersByResultSet(resultSet);
    }

    @Override
    public List<User> getUsers(int limit, int offset, int agencyId, String filter) {
        ResultSet resultSet = null;
        switch (filter) {
            case "completed":
                resultSet = dbHelper.executeQuery("SELECT * FROM user INNER JOIN userapplicationstate ON user.UserID = " +
                        "userapplicationstate.UserID WHERE ApplicationStateID = 5 AND RoleID = 2 AND AgencyID = " + agencyId  + " ORDER BY RegistrationDate DESC");
                break;
            case "active":
                resultSet = dbHelper.executeQuery("SELECT user.* FROM user LEFT JOIN pending ON user.UserID = pending.UserID " +
                        "WHERE pending.PendingID is NULL AND RoleID = 2 AND AgencyID = " + agencyId +" ORDER BY RegistrationDate DESC");
                break;
            case "passive":
                resultSet = dbHelper.executeQuery("SELECT user.* FROM user INNER JOIN pending ON user.UserID = pending.UserID " +
                        "WHERE RoleID = 2 AND AgencyID = " + agencyId +" ORDER BY RegistrationDate DESC");
                break;
        }

        return getUsersByResultSet(resultSet);
    }

    @Override
    public List<User> getUsers(int limit, int offset) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user ORDER BY RegistrationDate DESC LIMIT " + limit + " OFFSET " + offset);
        return getUsersByResultSet(resultSet);
    }

    private List<User> getUsersByResultSet(ResultSet resultSet) {
        List<User> users = new ArrayList<>();
        if (resultSet != null) {

            try {
                while (resultSet.next()) {
                    users.add(bindResultSetToUser(resultSet));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return users;
    }

    @Override
    public void deleteUserById(int userId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM user WHERE UserID = ?");
        try {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUserById(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE UserID = \"" + userId + "\"");
        try {
            if(resultSet.next()) {
                return bindResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateUser(User user) {
        String query = "UPDATE user SET FirstName = ?, LastName = ?, Email = ?, RoleID = ?, AgencyID = ?";
        query += " WHERE UserID = ?";

        PreparedStatement preparedStatement = dbHelper.getPreparedStatement(query);
        try {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setInt(4, user.getRoleId());
            preparedStatement.setInt(5, user.getAgencyId());
            preparedStatement.setInt(6, user.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateUserProfile(User user) {
        String query = "UPDATE user SET FirstName = ?, LastName = ?, BirthDate = ?, Gender = ?, Country = ?, City = ?, PhoneNumber = ?";
        query += " WHERE UserID = ?";

        PreparedStatement preparedStatement = dbHelper.getPreparedStatement(query);
        try {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setDate(3, user.getBirthDate());
            preparedStatement.setString(4, user.getGender());
            preparedStatement.setString(5, user.getCountry());
            preparedStatement.setString(6, user.getCity());
            preparedStatement.setString(7, user.getPhoneNumber());
            preparedStatement.setInt(8, user.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getUserCount() {
        ResultSet resultSet = dbHelper.executeQuery("SELECT COUNT(*) AS 'Count' FROM user");
        try {
            resultSet.next();
            return resultSet.getInt("Count");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<User> getUsersNotInRemind() {
        List<User> users = new ArrayList<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user LEFT JOIN remind ON user.UserID = remind.UserID WHERE remind.UserID IS NULL");
        try {
            while(resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user.UserID"));
                user.setEmail(resultSet.getString("user.Email"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public List<User> getUsersByAgencyId(int agencyId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM user WHERE AgencyID = " + agencyId);
        List<User> users = new ArrayList<>();
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
    public void updateUsersByDeletedAgency(Integer agencyId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE user SET AgencyID = 1 WHERE AgencyID = ?");
        try {
            preparedStatement.setInt(1, agencyId);
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
