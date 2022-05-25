package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.ApplicationType;
import com.uniassist.repository.ApplicationTypeDao;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ApplicationTypeDaoImpl implements ApplicationTypeDao {

    private DBHelper dbHelper;

    public ApplicationTypeDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public ApplicationType getApplicationTypeByID(int id) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM applicationtype WHERE ApplicationTypeID = \"" + id + "\"");
        try {
            if(resultSet.next()) {
                return new ApplicationType(id, resultSet.getString("TypeName"),
                        resultSet.getBigDecimal("Price"));
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
