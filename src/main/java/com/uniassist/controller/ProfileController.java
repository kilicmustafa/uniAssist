package com.uniassist.controller;

import com.uniassist.model.*;
import com.uniassist.repository.*;
import com.uniassist.repository.implementations.ApplicationDocDao;
import com.uniassist.services.SessionData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@Controller
public class ProfileController extends BaseController{

    private final UserDao userDao;
    private final ApplicationTypeDao applicationTypeDao;
    private final ApplicationStateDao applicationStateDao;
    private final NoteDao noteDao;
    private final DocumentDao documentDao;
    private final ApplicationDocDao applicationDocDao;
    private final ApplicationDao applicationDao;

    @Autowired
    public ProfileController(UserDao userDao, ApplicationDocDao applicationDocDao, ApplicationTypeDao applicationTypeDao, ApplicationStateDao applicationStateDao, NoteDao noteDao, DocumentDao documentDao, ApplicationDao applicationDao) {
        this.userDao = userDao;
        this.applicationDocDao = applicationDocDao;
        this.applicationTypeDao = applicationTypeDao;
        this.applicationStateDao = applicationStateDao;
        this.noteDao = noteDao;
        this.documentDao = documentDao;
        this.applicationDao = applicationDao;
    }


    @GetMapping(value = "/profile")
    public String profile(Model model, HttpServletRequest request) {
        SessionData.pageCounter.get("profile").incrementAndGet();
        if(loginStatement(request)) {
            User user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            ApplicationType applicationType = applicationTypeDao.getApplicationTypeByID(user.getAppType());
            model.addAttribute("user", user);

            model.addAttribute("applicationComplete", true);
            model.addAttribute("applicationType", applicationType);
            model.addAttribute("applicationState", applicationStateDao.getApplicationStates());
            model.addAttribute("applicationStateId", applicationStateDao.getApplicationStateIDByUserID(user.getUserId()));
            model.addAttribute("note", noteDao.getNoteByUserId(user.getUserId()));
            model.addAttribute("applicationDocuments", applicationDocDao.getApplicationDocuments(user.getUserId(), user.getAppType()));
            model.addAttribute("photoDocument", applicationDocDao.getPhoto(user.getUserId()));
            model.addAttribute("documents", documentDao.getDocumentsByUserId(user.getUserId()));
            model.addAttribute("additional", applicationDao.getApplicationByUserId(user.getUserId()));
            return "profile";
        }


        return "redirect:/login";
    }

    @PostMapping(value = "/profile/update")
    public String userUpdate(@ModelAttribute("user") User user, MultipartHttpServletRequest request) throws IOException {
        if(loginStatement(request)) {

            user.setBirthDate(Date.valueOf(LocalDate.of(Integer.parseInt(request.getParameter("year")),
                    Integer.parseInt(request.getParameter("month")),
                    Integer.parseInt(request.getParameter("day")))));

            if(!request.getFile("photo").getOriginalFilename().equals("")) {
                applicationDocDao.createApplicationDocument(new Document(
                        "Photo",
                        request.getFile("photo").getInputStream(),
                        request.getFile("photo").getOriginalFilename(),
                        user.getUserId()
                ));
            }

            userDao.updateUserProfile(user);
            return "redirect:/profile";
        }
        return "redirect:/";
    }

    @GetMapping(value =  "/profile/changepassword")
    public String getChangePassword(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "changepassword";
        }
        return "redirect:/";
    }

    @PostMapping(value = "/profile/changepassword")
    public @ResponseBody
    String changePassword(HttpServletRequest request) {
        if(loginStatement(request)) {
            User user;
            if(request.getParameter("dashboard") != null && request.getParameter("dashboard").equals("true")) {
                user = userDao.getUserById(Integer.parseInt(request.getParameter("userId")));
            } else {
                user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            }
            if(user.getPassword().equals(request.getParameter("oldPassword"))) {
                userDao.updatePassword(user.getUserId(), request.getParameter("newPassword"));
                return "OK";
            } else {
                return "BAD_REQUEST";
            }
        }
        return "BAD_REQUEST";
    }

    @GetMapping("/viewProfile/{userId}")
    public String viewProfile(@PathVariable("userId") int userId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && (int) request.getSession().getAttribute("role") != STUDENT) {
            User user = userDao.getUserById(userId);
            model.addAttribute("user", user);
            ApplicationType applicationType = applicationTypeDao.getApplicationTypeByID(user.getAppType());
            model.addAttribute("applicationComplete", true);
            model.addAttribute("applicationType", applicationType);
            model.addAttribute("applicationState", applicationStateDao.getApplicationStates());
            model.addAttribute("applicationStateId", applicationStateDao.getApplicationStateIDByUserID(user.getUserId()));
            model.addAttribute("note", noteDao.getNoteByUserId(user.getUserId()));
            model.addAttribute("applicationDocuments", applicationDocDao.getApplicationDocuments(user.getUserId(), user.getAppType()));
            model.addAttribute("photoDocument", applicationDocDao.getPhoto(user.getUserId()));
            model.addAttribute("documents", documentDao.getDocumentsByUserId(user.getUserId()));
            model.addAttribute("additional", applicationDao.getApplicationByUserId(user.getUserId()));

            return "profile";
        }
        return "redirect:/";
    }

    @GetMapping("/edit")
    public String edit(Model model, HttpServletRequest request) {
        SessionData.pageCounter.get("edit").incrementAndGet();
        if(loginStatement(request)) {
            User user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            model.addAttribute("user", user);
            model.addAttribute("photoDocument", applicationDocDao.getPhoto(user.getUserId()));
            model.addAttribute("application", applicationDao.getApplicationByUserId(user.getUserId()));
            model.addAttribute("countries", applicationDocDao.getCountries());
            return "edit";
        }

        return "redirect:/";
    }

    @PostMapping("/profile/getfilelist")
    public String getApplicationFormat(Model model, HttpServletRequest request) {
        model.addAttribute("labels", applicationDocDao.getApplicationFormats(request.getParameter("country")));
        return "include/applicationtemplatebycountry";
    }

    @PostMapping("/edit")
    public String edit(MultipartHttpServletRequest request) throws IOException {

        if(loginStatement(request)) {
            User user;
            if(request.getParameter("dashboard") != null && request.getParameter("dashboard").equals("true") &&
                    Integer.parseInt(request.getSession().getAttribute("role").toString()) != STUDENT) {
                user = userDao.getUserById(Integer.parseInt(request.getParameter("userId")));
                if(!request.getFile("photo").getOriginalFilename().equals("")) {
                    applicationDocDao.createApplicationDocument(new Document(
                            "Photo",
                            request.getFile("photo").getInputStream(),
                            request.getFile("photo").getOriginalFilename(),
                            user.getUserId()
                    ));
                }
            } else {
                user = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
            }
            userDao.updateAppType(user.getUserId(), Integer.parseInt(request.getParameter("appType")));
            userDao.updateRequestId(user.getUserId(), Integer.parseInt(request.getParameter("requestId")));

            List<String> parameterNames = new ArrayList<>(request.getParameterMap().keySet());
            Collections.sort(parameterNames);

            int counter = 0;
            int pass = 0;

            for(MultipartFile multipartFile : request.getFiles("files")) {
                if(!multipartFile.getOriginalFilename().equals("")) {
                    String name = "";
                    for(int i = counter; i < parameterNames.size(); i++) {
                        if(parameterNames.get(i).startsWith("file-headline") && pass == 0) {
                            name = parameterNames.get(i);
                            counter = i+1;
                            break;
                        } else if(parameterNames.get(i).startsWith("file-headline")) {
                            pass--;
                            counter = i+1;
                            break;
                        }
                    }
                    try {
                        applicationDocDao.createApplicationDocument(
                                new Document(
                                        request.getParameter(name),
                                        multipartFile.getInputStream(),
                                        multipartFile.getOriginalFilename(),
                                        user.getUserId()
                                )
                        );
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    pass++;
                }
            }

            if(!request.getParameter("additional").equals("")) {
                applicationDao.updateAdditional(user.getUserId(), request.getParameter("additional"));
            }
            return "redirect:/profile";
        }

        return "redirect:/";
    }

}
