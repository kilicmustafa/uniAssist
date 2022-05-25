package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.Role;
import com.uniassist.repository.RoleDao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDaoImpl implements RoleDao {

    private DBHelper dbHelper;

    public RoleDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public List<Role> getRoles() {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM role");
        List<Role> roleList = new ArrayList<>();
        try {
            while(resultSet.next()) {
                roleList.add(
                        new Role(
                                resultSet.getInt("RoleID"),
                                resultSet.getString("Name")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roleList;
    }
}
