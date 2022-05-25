package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.ApplicationStateDao;
import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class PaymentController extends BaseController {

    private final UserDao userDao;
    private final ApplicationStateDao applicationStateDao;


    @Autowired
    public PaymentController(UserDao userDao, ApplicationStateDao applicationStateDao) {
        this.userDao = userDao;
        this.applicationStateDao = applicationStateDao;
    }


    @GetMapping("/payment")
    public String payment(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            User user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            if(applicationStateDao.getApplicationStateIDByUserID(user.getUserId()) == 2) {
                model.addAttribute("user", user);
                return "payment";
            }

        }
        return "redirect:/login";
    }
}
