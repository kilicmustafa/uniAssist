package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.ApplicationStateDao;
import com.uniassist.repository.PendingDao;
import com.uniassist.repository.UserDao;
import com.uniassist.services.MailService;
import com.uniassist.services.SessionData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ConcurrentTaskScheduler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

@Controller
public class RegisterController extends BaseController{

    private final UserDao userDao;
    private MailService mailService;
    private final PendingDao pendingDao;
    private final ApplicationStateDao applicationStateDao;
    private TaskScheduler taskScheduler;

    @Autowired
    public RegisterController(UserDao userDao, PendingDao pendingDao, ApplicationStateDao applicationStateDao) {
        this.applicationStateDao = applicationStateDao;
        mailService = new MailService();

        this.userDao = userDao;
        this.pendingDao = pendingDao;
        taskScheduler = new ConcurrentTaskScheduler();
    }

    @GetMapping("/register")
    public String register(HttpServletRequest request) {
        SessionData.pageCounter.get("register").incrementAndGet();
        if(loginStatement(request)) {
            return "redirect:/";
        } else {
            return "register";
        }
    }

    @PostMapping("/register")
    public String register(@ModelAttribute("user") User user, HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        } else if(!userDao.checkUserExist(user.getEmail())) {
            int userId = userDao.addUser(user);
            String verificationKey = DigestUtils.md5DigestAsHex(user.getEmail().getBytes());
            pendingDao.createActivation(userId, verificationKey);
            mailService.sendActivationMail(user.getEmail(), "Uni-Assist, Account Verification",
                    "To confirm its your account click the link: " +
                            "http://uni-assist.com/verification/" + verificationKey);
            return "redirect:/login?registration=done";
        } else {
            return "redirect:/register?fail=mail";
        }
    }

    @GetMapping("/verification/{verificationKey}")
    public String verification(@PathVariable("verificationKey") String verificationKey, Model model) {
        if(pendingDao.isActivationExist(verificationKey)) {
            int userId = pendingDao.getUserIdByVerificationKey(verificationKey);
            pendingDao.deleteActivation(verificationKey);
            model.addAttribute("user", userDao.getUserById(userId));
            applicationStateDao.createApplicationState(userId, 1);
            model.addAttribute("verification", true);
            return "login";
        } else {
            return "redirect:/";
        }
    }
}
