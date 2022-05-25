package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class DashboardTrashController extends BaseController {

    private final TrashDao trashDao;
    private final AgencyDao agencyDao;
    private final ApplicationStateDao applicationStateDao;

    @Autowired
    public DashboardTrashController(TrashDao trashDao, AgencyDao agencyDao, ApplicationStateDao applicationStateDao) {
        this.trashDao = trashDao;
        this.agencyDao = agencyDao;
        this.applicationStateDao = applicationStateDao;
    }


    @GetMapping("/dashboard/trash")
    public String getTrash(Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.parseInt(request.getSession().getAttribute("role").toString()) != STUDENT) {
            List<User> users = trashDao.getUsers();
            model.addAttribute("users", users);
            model.addAttribute("agencyMap", agencyDao.getAgencyShortNames());
            model.addAttribute("applicationStates", applicationStateDao.getApplicationStatesByUsers(users));
            return "trash";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/deleteFromTrash")
    public @ResponseBody
    String deleteUser(@RequestParam("userId") Integer userId, HttpServletRequest request) {
        if(loginStatement(request) && Integer.parseInt(request.getSession().getAttribute("role").toString()) != STUDENT) {
            trashDao.deleteUser(userId);
            return "OK";
        }
        return "BAD_REQUEST";
    }

    @PostMapping("/dashboard/restore")
    public @ResponseBody
    String restore(@RequestParam("userId") Integer userId, HttpServletRequest request) {
        if(loginStatement(request) && Integer.parseInt(request.getSession().getAttribute("role").toString()) != STUDENT) {
            trashDao.restoreUser(userId);
            return "OK";
        }
        return "BAD_REQUEST";
    }
}
