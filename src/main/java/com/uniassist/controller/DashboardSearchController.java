package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.AgencyDao;
import com.uniassist.repository.ApplicationDao;
import com.uniassist.repository.ApplicationStateDao;
import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardSearchController extends BaseController {

    private final UserDao userDao;
    private final AgencyDao agencyDao;
    private final ApplicationStateDao applicationStateDao;

    @Autowired
    public DashboardSearchController(UserDao userDao, AgencyDao agencyDao, ApplicationStateDao applicationStateDao) {
        this.userDao = userDao;
        this.agencyDao = agencyDao;
        this.applicationStateDao = applicationStateDao;
    }

    @PostMapping("/dashboard/search/")
    public String search(Model model, HttpServletRequest request) {
        if (loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            String searchText = request.getParameter("searchText");
            List<User> users = null;
            if (searchText.contains("@")) {
                users = new ArrayList<>();
                User user = userDao.getUserByEmail(searchText);
                if (user != null) {
                    users.add(user);
                }
            } else if (validateNumber(searchText)) {
                users = new ArrayList<>();
                User user = userDao.getUserById(Integer.parseInt(searchText));
                if (user != null) {
                    users.add(user);
                }
            } else {
                users = userDao.getUsersByName(searchText);
            }
            if (users.size() == 0) {
                String referer = request.getHeader("Referer");
                model.addAttribute("notFound", true);
                return "redirect:" + referer;
            }
            model.addAttribute("agencyMap", agencyDao.getAgencyShortNames());
            model.addAttribute("users", users);
            model.addAttribute("applicationStates", applicationStateDao.getApplicationStatesByUsers(users));

            return "dashboarduserlist";
        }
        return "redirect:/";
    }

    @GetMapping("/dashboard/search")
    public String search(HttpServletRequest request) {
        if (loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            return "dashboardusernotfound";
        }
        return "redirect:/";
    }


    private boolean validateNumber(String text) {
        for (char c : text.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }
}
