package com.uniassist.controller;

import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DashboardAppController extends BaseController {

    private final UserDao userDao;

    @Autowired
    public DashboardAppController(UserDao userDao) {
        this.userDao = userDao;
    }

    @GetMapping("/dashboard/application/{userId}")
    public String setApplication(@PathVariable("userId")int userId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            model.addAttribute("userId", userId);
            model.addAttribute("user", userDao.getUserById(userId));
            return "dashboardsetapplication";
        }
        return "redirect:/";
    }
}
