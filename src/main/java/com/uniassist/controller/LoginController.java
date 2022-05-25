package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.ApplicationStateDao;
import com.uniassist.services.AuthService;
import com.uniassist.services.SessionData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController extends BaseController {

    private AuthService authService;
    private final ApplicationStateDao applicationStateDao;

    @Autowired
    public LoginController(ApplicationStateDao applicationStateDao) {
        authService = new AuthService();
        this.applicationStateDao = applicationStateDao;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(HttpServletRequest request) {
        SessionData.pageCounter.get("login").incrementAndGet();
        if (loginStatement(request)) {
            return "redirect:/";
        }
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginAuth(@ModelAttribute("user") User user, HttpServletRequest request) {

        String email = user.getEmail();
        String password = user.getPassword();

        if (email == null || password == null) {
            return "login?fail=true";
        } else if (!authService.userAuth(email, password)) {
            return "redirect:/login?fail=true";
        } else if (!authService.isActivated(email, password)) {
            return "redirect:/login?verification=true";
        }
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("loginState", true);
        httpSession.setAttribute("email", email);
        httpSession.setAttribute("role", authService.getRoleIdByEmail(email));
        httpSession.setAttribute("appState", applicationStateDao.getApplicationStateIDByUserID(authService.getIdByEmail(email)));
        return "redirect:/profile";

    }

    @GetMapping("/exit")
    public String exit(HttpServletRequest request) {
        if (request.getSession().getAttribute("loginState") != null) {
            request.getSession().setAttribute("loginState", false);
        }
        return "redirect:/";
    }
}
