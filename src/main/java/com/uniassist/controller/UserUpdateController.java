package com.uniassist.controller;

import com.uniassist.model.*;
import com.uniassist.repository.*;
import com.uniassist.repository.implementations.ApplicationDocDao;
import com.uniassist.services.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@Controller
public class UserUpdateController extends BaseController {

    private final UserDao userDao;
    private final AgencyDao agencyDao;
    private final RoleDao roleDao;
    private final ApplicationStateDao applicationStateDao;
    private final ApplicationDao applicationDao;
    private final NoteDao noteDao;
    private ApplicationDocDao applicationDocDao;
    private MailService mailService;

    @Autowired
    public UserUpdateController(UserDao userDao, AgencyDao agencyDao, RoleDao roleDao, ApplicationStateDao applicationStateDao, ApplicationDao applicationDao, NoteDao noteDao, ApplicationDocDao applicationDocDao) {
        this.userDao = userDao;
        this.agencyDao = agencyDao;
        this.roleDao = roleDao;
        this.applicationStateDao = applicationStateDao;
        this.applicationDao = applicationDao;
        this.noteDao = noteDao;
        this.applicationDocDao = applicationDocDao;
        this.mailService = new MailService();
    }

    @GetMapping("/dashboard/users/settings/{userId}")
    public String userSettings(@PathVariable("userId") Integer userId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && userDao.getUserByEmail(request.getSession().getAttribute("email").toString()).getRoleId() != STUDENT) {
            User user = userDao.getUserById(userId);
            if(user != null) {
                List<Agency> agencies = agencyDao.getAgencies();
                List<ApplicationState> applicationStates = applicationStateDao.getApplicationStates();
                List<Role> roleList = roleDao.getRoles();
                Application application = applicationDao.getApplicationByUserId(user.getUserId());

                model.addAttribute("appStateId", applicationStateDao.getApplicationStateIDByUserID(userId));

                model.addAttribute("user", user);
                model.addAttribute("agencies", agencies);
                model.addAttribute("applicationStates", applicationStates);
                model.addAttribute("roleList", roleList);
                model.addAttribute("application", application);
                model.addAttribute("note", noteDao.getNoteByUserId(userId));
                model.addAttribute("countries", applicationDocDao.getCountries());
            } else {
                return "redirect:/dashboard/users";
            }
            return "dashboardsettings";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/users/update")
    public String updateUser(@ModelAttribute("user") User user, HttpServletRequest request) throws IOException {
        User authorizedUser = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
        if(loginStatement(request) && authorizedUser.getRoleId() != STUDENT) {
            if(authorizedUser.getRoleId() == AGENT && user.getAgencyId() != authorizedUser.getAgencyId()) {
                return "redirect:/dashboard/users/settings/"+user.getUserId();
            }
            userDao.updateUser(user);
            if(user.getAppType() != 0) {
                userDao.updateAppType(user.getUserId(), user.getAppType());
            }
            if(user.getRequestId() != 0) {
                userDao.updateRequestId(user.getUserId(), user.getRequestId());
            }
            return "redirect:/dashboard/users/settings/"+user.getUserId();
        } else {
            return "redirect:/";
        }
    }

    @PostMapping("/dashboard/applicationstates/update")
    public String uppdateAppStates(HttpServletRequest request) {
        User authorizedUser = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
        User user = userDao.getUserById(Integer.parseInt(request.getParameter("userId")));
        if(loginStatement(request) && authorizedUser.getRoleId() != STUDENT) {
            if(authorizedUser.getRoleId() == AGENT && user.getAgencyId() != authorizedUser.getAgencyId()) {
                return "redirect:/dashboard/users/settings/"+user.getUserId();
            }
            applicationStateDao.updateApplicationState(user.getUserId(), Integer.parseInt(request.getParameter("appStateId")));
            noteDao.createUpdateNote(new Note(
                    request.getParameter("forUser"),
                    request.getParameter("forUs"),
                    user.getUserId()
            ));
            if(request.getParameter("sendNoteEmail") != null && request.getParameter("sendNoteEmail").equals("on")
                    && request.getParameter("forUser") != null && !request.getParameter("forUser").equals("")) {
                mailService.sendMail(user.getEmail(), "Uni-Assist, You have a new message", "text/plain", request.getParameter("forUser"));
            }
            return "redirect:/dashboard/users/settings/"+user.getUserId();
        } else {
            return "redirect:/";
        }
    }

    @PostMapping("/dashboard/applicationstates/updatefromprofile")
    public String updateAppStatesFromProfile(HttpServletRequest request) {
        User authorizedUser = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
        User user = userDao.getUserById(Integer.parseInt(request.getParameter("userId")));
        if(loginStatement(request) && authorizedUser.getRoleId() != STUDENT) {
            if (authorizedUser.getRoleId() == AGENT && user.getAgencyId() != authorizedUser.getAgencyId()) {
                return "redirect:/viewProfile/" + user.getUserId();
            }
            applicationStateDao.updateApplicationState(user.getUserId(), Integer.parseInt(request.getParameter("appStateId")));
        }
        return "redirect:/viewProfile/"+user.getUserId();
    }
}
