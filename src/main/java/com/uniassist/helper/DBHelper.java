package com.uniassist.helper;


import java.sql.*;

public class DBHelper {

    private static DBHelper dbHelper = null;
    private Connection connection;

    private final String dbName = "dbuniassist";
    private final String dbUserName = "root";
    private final String dbPassword = "";
    private final String connectionString = "jdbc:mysql://localhost:3306/" + dbName + "?user=" + dbUserName + "&password=" + dbPassword +
            "&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true";

    public DBHelper() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        } catch (IllegalAccessException | InstantiationException e) {
            e.printStackTrace();
        }
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuniassist?socket=/var/lib/mysql/mysql.sock&autoReconnect=true&characterEncoding=UTF-8",
                    "uniassist", "Sude2015");
            //connection = DriverManager.getConnection(connectionString);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static DBHelper getInstance() {
        if(dbHelper == null) {
            dbHelper = new DBHelper();
        }
        return dbHelper;
    }

    public ResultSet executeQuery(String query) {
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public PreparedStatement getPreparedStatement(String sql) {
        try {
            return connection.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public PreparedStatement getPreparedStatement(String sql, int request) {
        try {
            return connection.prepareStatement(sql, request);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
