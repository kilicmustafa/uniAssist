package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class DashboardUserController extends BaseController {

    private final UserDao userDao;
    private final AgencyDao agencyDao;
    private final ApplicationStateDao applicationStateDao;

    private final int USER_LIST_LIMIT = 20;

    @Autowired
    public DashboardUserController(UserDao userDao, AgencyDao agencyDao, ApplicationStateDao applicationStateDao) {
        this.userDao = userDao;
        this.agencyDao = agencyDao;
        this.applicationStateDao = applicationStateDao;
    }


    /*
    ROLEID =>
    ADMIN = 1
    STUDENT = 2
    AGENT = 3
     */
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpServletRequest request) {
        if(loginStatement(request)) {
            User user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            if(user.getRoleId() == ADMIN) {
                List<User> recentUsers = userDao.getRecentUsers(10);
                model.addAttribute("users", recentUsers);
                model.addAttribute("agencies", agencyDao.getAgencies());
                request.getSession().setAttribute("role", ADMIN);
                return "dashboard";
            } else if(user.getRoleId() == AGENT) {
                model.addAttribute("users", userDao.getRecentUsersByAgencyId(10, user.getAgencyId()));
                model.addAttribute("agencies", agencyDao.getAgencies());
                return "dashboard";
            } else {
                return "redirect:/";
            }
        }
        return "redirect:/";
    }

    @GetMapping(value = {"/dashboard/users/{page}", "/dashboard/users"})
    public String dashboardUsers(Model model, @PathVariable(name = "page", required = false) String pageStr, HttpServletRequest request) {
        int page = (StringUtils.isEmpty(pageStr)) ? 0 : Integer.parseInt(pageStr);
        page = page - 1;
        if(loginStatement(request)) {
            User user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            if(user.getRoleId() == STUDENT) return "redirect:/";

            List<User> recentUsers = null;
            if(user.getRoleId() == ADMIN) {
                if(request.getParameter("filter") == null || request.getParameter("filter").equals("")) {
                    recentUsers = userDao.getUsers(USER_LIST_LIMIT, page * 20);
                } else {
                    recentUsers = userDao.getUsers(USER_LIST_LIMIT, page * 20, request.getParameter("filter"));
                }
            } else if(user.getRoleId() == AGENT) {
                if(request.getParameter("filter") == null || request.getParameter("filter").equals("")) {
                    recentUsers = userDao.getUsers(USER_LIST_LIMIT, page * 20, user.getAgencyId());
                } else {
                    recentUsers = userDao.getUsers(USER_LIST_LIMIT, page * 20, user.getAgencyId(), request.getParameter("filter"));
                }
            }



            model.addAttribute("agencyMap", agencyDao.getAgencyShortNames());
            model.addAttribute("users", recentUsers);
            model.addAttribute("applicationStates", applicationStateDao.getApplicationStatesByUsers(recentUsers));
            model.addAttribute("page", page);
            model.addAttribute("pageCount", getPageCount());
            return "dashboarduserlist";
        }
        return "redirect:/";
    }

    @GetMapping("/dashboard/adduser")
    public String addUser(Model model, HttpServletRequest request) {
        User authorizedUser = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
        if(loginStatement(request) && authorizedUser.getRoleId() != STUDENT) {
            model.addAttribute("agencies", agencyDao.getAgencies());
            model.addAttribute("authorizedAgencyId", authorizedUser.getAgencyId());
            return "dashboardadduser";
        } else {
            return "redirect:/";
        }
    }

    @PostMapping("/dashboard/deleteUser")
    public @ResponseBody
    String deleteUser(@RequestParam("userId") Integer userId, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() != STUDENT) {
            userDao.deleteUserById(userId);
            return "OK";
        }
        return "BAD_REQUEST";
    }

    @PostMapping("/dashboard/moveToTrash")
    public @ResponseBody
    String moveToTrash(@RequestParam("userId") Integer userId, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() != STUDENT) {
            userDao.moveToTrash(userId);
            return "OK";
        }
        return "BAD_REQUEST";
    }

    @PostMapping("/dashboard/adduser")
    public String addUser(@ModelAttribute("user") User user, MultipartHttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() != STUDENT) {
            if(!userDao.checkUserExist(user.getEmail())) {
                int userId = userDao.addUser(user);
                user.setUserId(userId);

                user.setBirthDate(Date.valueOf(LocalDate.of(Integer.parseInt(request.getParameter("year")),
                        Integer.parseInt(request.getParameter("month")),
                        Integer.parseInt(request.getParameter("day")))));
                userDao.updateUserProfile(user);
                return "redirect:/dashboard/adduser?registration=done";
            }
            return "redirect:/dashboard/adduser?fail=mail";

        } else {
            return "redirect:/";
        }
    }

    private int getPageCount() {
        int userCount = userDao.getUserCount();
        int pageCount = userCount / 20;
        if(userCount % 20 > 0) {
            pageCount = pageCount + 1;
        }
        return pageCount;
    }
}
