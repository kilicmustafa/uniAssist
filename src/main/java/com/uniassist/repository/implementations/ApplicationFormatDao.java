package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.ApplicationFormat;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

public class ApplicationFormatDao {

    private DBHelper dbHelper;

    public ApplicationFormatDao() {
        dbHelper = DBHelper.getInstance();
    }

    public void createApplicationFormat(ApplicationFormat applicationFormat) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO applicationformat(Country, Name) " +
                "VALUES(?, ?)", Statement.RETURN_GENERATED_KEYS);

        try {
            preparedStatement.setString(1, applicationFormat.getCountry());
            preparedStatement.setString(2, applicationFormat.getName());
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                int id =  rs.getInt(1);
                for (Integer type : applicationFormat.getTypes()) {
                    PreparedStatement preparedStatement1 = dbHelper.getPreparedStatement("INSERT INTO applicationformattype(" +
                            "ApplicationFormatID, ApplicationTypeID) VALUES(?, ?)");
                    preparedStatement1.setInt(1, id);
                    preparedStatement1.setInt(2, type);
                    preparedStatement1.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean exist(ApplicationFormat applicationFormat) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM applicationformat WHERE Country = \"" + applicationFormat.getCountry()
        + "\" AND Name = \"" + applicationFormat.getName() + "\"");
        try {
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getFormatId(String country, String name) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT ApplicationFormatID FROM applicationformat WHERE Country = \"" + country
                + "\" AND Name = \"" + name + "\"");
        try {
            if(resultSet.next()) {
                return resultSet.getInt("ApplicationFormatID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deleteApplicationFormat(String country, String name) {
        int id = this.getFormatId(country, name);
        this.deleteApplicationFormat(id);
        deleteApplicationFormaTypes(id);
    }

    private void deleteApplicationFormat(int id) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM applicationformat WHERE ApplicationFormatID = ?");
        try {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteApplicationFormaTypes(int id) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM applicationformattype WHERE ApplicationFormatID = ?");
        try {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFormat(int formatId, String country, String name) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE applicationformat " +
                "SET Country = ?, Name = ? WHERE ApplicationFormatID = ?");
        try {
            preparedStatement.setString(1, country);
            preparedStatement.setString(2, name);
            preparedStatement.setInt(3, formatId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addType(int formatId, int i) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO applicationformattype(ApplicationFormatID, " +
                "ApplicationTypeID) VALUES(?, ?)");
        try {
            preparedStatement.setInt(1, formatId);
            preparedStatement.setInt(2, i);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createUpdateTranslation(int formatId, HashMap<String, String> translation) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("CALL createOrUpdate(?, ?, ?);");
        translation.forEach((k, v) -> {
            try {
                preparedStatement.setInt(1, formatId);
                preparedStatement.setString(2, k);
                preparedStatement.setString(3, v);
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
    }

    public HashMap<String, String> getApplicationFormatTranslations(Integer formatId) throws SQLException {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM formattranslation WHERE ApplicationFormatID = " + formatId);
        HashMap<String, String> translation = new HashMap<>();
        while(resultSet.next()) {
            translation.put(resultSet.getString("TranslationType"), resultSet.getString("Translation"));
        }
        return translation;
    }
}

