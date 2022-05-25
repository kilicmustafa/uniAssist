package com.uniassist.controller;

import com.uniassist.model.Agency;
import com.uniassist.repository.AgencyDao;
import com.uniassist.repository.RoleDao;
import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AgencyController extends BaseController {

    private final UserDao userDao;
    private final AgencyDao agencyDao;
    private final RoleDao roleDao;

    @Autowired
    public AgencyController(UserDao userDao, AgencyDao agencyDao, RoleDao roleDao) {
        this.userDao = userDao;
        this.agencyDao = agencyDao;
        this.roleDao = roleDao;
    }

    /*
    public AgencyController() {
        userDao = new UserDaoImpl();
        agencyDao = new AgencyDaoImpl();
        roleDao = new RoleDaoImpl();
    }
     */

    @GetMapping("/dashboard/addagency")
    public String addAgency(HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            return "dashboardaddagency";
        } else {
            return "redirect:/";
        }
    }

    @PostMapping("/dashboard/addagency")
    public String createAgency(@ModelAttribute("agency") Agency agency, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            agencyDao.addAgency(agency);
            return "redirect:/dashboard/addagency";
        } else {
            return "redirect:/";
        }
    }

    @GetMapping("/dashboard/agencies")
    public String getAgencies(Model model, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            model.addAttribute("agencies", agencyDao.getAgencies());
            return "dashboardagencies";
        }
        return "redirect:/";
    }

    @GetMapping("/dashboard/agencies/users/{agencyId}")
    public String getAgencyUsers(@PathVariable("agencyId") int agencyId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            model.addAttribute("users", userDao.getUsersByAgencyId(agencyId));
            model.addAttribute("roles", roleDao.getRoles());
            return "dashboarduserlist";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/deleteAgency")
    public @ResponseBody
    String deleteAgency(@RequestParam("agencyId") Integer agencyId, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            agencyDao.deleteAgencyById(agencyId);
            return "OK";
        }
        return "BAD_REQUEST";
    }

    @GetMapping("/dashboard/agencies/settings/{agencyId}")
    public String agencySettings(@PathVariable("agencyId") int agencyId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            model.addAttribute("agency", agencyDao.getAgencyById(agencyId));
            return "dashboardsettingsagency";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/agencies/update")
    public String updateAgency(@ModelAttribute("agency") Agency agency, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() == ADMIN) {
            agencyDao.updateAgency(agency);
            return "redirect:/dashboard/agencies";
        }
        return "redirect:/";
    }
}
