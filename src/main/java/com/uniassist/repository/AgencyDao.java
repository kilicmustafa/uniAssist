package com.uniassist.repository;

import com.uniassist.model.Agency;

import java.util.HashMap;
import java.util.List;

public interface AgencyDao {

    List<Agency> getAgencies();

    void addAgency(Agency agency);

    void deleteAgencyById(Integer agencyId);

    Agency getAgencyById(int agencyId);

    void updateAgency(Agency agency);

    HashMap<Integer, String> getAgencyShortNames();
}
