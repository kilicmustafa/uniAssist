package com.uniassist.controller;

import com.uniassist.model.User;
import com.uniassist.repository.PendingDao;
import com.uniassist.repository.UserDao;
import com.uniassist.services.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class ForgotPasswordController extends BaseController {

    private UserDao userDao;
    private PendingDao pendingDao;
    private MailService mailService;

    @Autowired
    public ForgotPasswordController(UserDao userDao, PendingDao pendingDao) {
        this.userDao = userDao;
        this.pendingDao = pendingDao;
        mailService = new MailService();
    }

    @GetMapping("/forgotpassword")
    public String forgotPassword(HttpServletRequest request) {
        if(!loginStatement(request)) {
            return "forgotpassword";
        }
        return "redirect:/";
    }

    @PostMapping("/forgotpassword")
    public String sendPasswordLink(HttpServletRequest request) {
        String email = request.getParameter("email");
        User user = userDao.getUserByEmail(email);
        if(user == null) {
            return "redirect:/forgotpassword";
        }

        String verificationKey = DigestUtils.md5DigestAsHex((user.getEmail() + String.valueOf(new Date().getTime())).getBytes());
        pendingDao.createActivation(user.getUserId(), verificationKey);
        mailService.sendActivationMail(user.getEmail(), "Uni-Assist, Forgot Password",
                "To reset your password click the link: " +
                        "http://uni-assist.com/forgotpassword/" + verificationKey);
        return "redirect:/forgotpassword?sendemail=done";
    }

    @GetMapping("/forgotpassword/{verificationKey}")
    public String verificate(@PathVariable("verificationKey") String verificationKey, Model model, HttpServletRequest request) {
        if(loginStatement(request) || !pendingDao.isActivationExist(verificationKey)) {
            return "redirect:/";
        } else {
            model.addAttribute("verificationKey", verificationKey);
            return "resetpassword";
        }
    }

    @PostMapping("/resetpassword")
    public String resetPassword(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        String password = request.getParameter("password");
        int userId = pendingDao.getUserIdByVerificationKey(request.getParameter("verificationKey"));
        if(userId == 0) {
            return "redirect:/login?resetpass=fail";
        }
        userDao.updatePassword(userId, password);
        pendingDao.deleteActivation(request.getParameter("verificationKey"));
        return "redirect:/login?resetpass=done";
    }
}
