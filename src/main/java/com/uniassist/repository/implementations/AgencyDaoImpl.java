package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.Agency;
import com.uniassist.repository.AgencyDao;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class AgencyDaoImpl implements AgencyDao {

    private DBHelper dbHelper;

    public AgencyDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public List<Agency> getAgencies() {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM agency");
        List<Agency> agencies = new ArrayList<>();
        try {
            if(resultSet != null) {
                while (resultSet.next()) {
                    agencies.add(new Agency(
                            resultSet.getInt("AgencyID"),
                            resultSet.getString("AgencyName"),
                            resultSet.getString("AgencyAddress"),
                            resultSet.getString("AgencyPhone"),
                            resultSet.getString("AgencyEmail"),
                            resultSet.getString("AgencyShortName")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return agencies;
    }

    @Override
    public void addAgency(Agency agency) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO agency(AgencyName, AgencyAddress, AgencyPhone" +
                ", AgencyEmail, AgencyShortName) " +
                "VALUES(?, ?, ?, ?, ?)");
        try {
            preparedStatement.setString(1, agency.getAgencyName());
            preparedStatement.setString(2, agency.getAgencyAddress());
            preparedStatement.setString(3, agency.getAgencyPhone());
            preparedStatement.setString(4, agency.getAgencyEmail());
            preparedStatement.setString(5, agency.getAgencyShortName());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteAgencyById(Integer agencyId) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("DELETE FROM agency WHERE AgencyID = ?");
        try {
            preparedStatement.setInt(1, agencyId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Agency getAgencyById(int agencyId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM agency WHERE AgencyID = " + agencyId);
        try {
            if(resultSet.next()) {
                return new Agency(
                        resultSet.getInt("AgencyID"),
                        resultSet.getString("AgencyName"),
                        resultSet.getString("AgencyAddress"),
                        resultSet.getString("AgencyPhone"),
                        resultSet.getString("AgencyEmail"),
                        resultSet.getString("AgencyShortName")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateAgency(Agency agency) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE agency SET AgencyName = ?, " +
                "AgencyAddress = ?, AgencyPhone = ?, AgencyEmail = ?, AgencyShortName = ? WHERE AgencyID = ?");
        try {
            preparedStatement.setString(1, agency.getAgencyName());
            preparedStatement.setString(2, agency.getAgencyAddress());
            preparedStatement.setString(3, agency.getAgencyPhone());
            preparedStatement.setString(4, agency.getAgencyEmail());
            preparedStatement.setString(5, agency.getAgencyShortName());
            preparedStatement.setInt(6, agency.getAgencyId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public HashMap<Integer, String> getAgencyShortNames() {
        HashMap<Integer, String> agencies = new HashMap<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT AgencyID, AgencyShortName FROM agency");
        try {
            while(resultSet.next()) {
                agencies.put(resultSet.getInt("AgencyID"), resultSet.getString("AgencyShortName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return agencies;
    }


}
