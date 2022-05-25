package com.uniassist.controller;

import com.uniassist.model.Document;
import com.uniassist.model.User;
import com.uniassist.repository.DocumentDao;
import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
public class DocumentController extends BaseController {

    private final DocumentDao documentDao;
    private final UserDao userDao;

    @Autowired
    public DocumentController(DocumentDao documentDao, UserDao userDao) {
        this.documentDao = documentDao;
        this.userDao = userDao;
    }

    @GetMapping("/dashboard/documents/{userId}")
    public String documents(@PathVariable("userId") int userId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            model.addAttribute("user", userDao.getUserById(userId));
            model.addAttribute("userId", userId);
            return "dashboarduploaddocuments";
        }
        return "redirect:/";
    }


    @PostMapping("/dashboard/documents/save")
    public String saveDocuments(@RequestParam("userId") int userId, MultipartHttpServletRequest request) {
        User authorizedUser = userDao.getUserByEmail(request.getSession().getAttribute("email").toString());
        if(loginStatement(request) && authorizedUser.getRoleId() != STUDENT) {
            if(authorizedUser.getRoleId() == AGENT && userDao.getUserById(userId).getAgencyId() != authorizedUser.getAgencyId()) {
                return "redirect:/dashboard/users";
            }
            int counter = 1;
            for(MultipartFile multipartFile : request.getFiles("files")) {
                if(!multipartFile.getOriginalFilename().equals("") && request.getParameter("file-headline" + counter) != null
                        && !request.getParameter("file-headline" + counter).equals("")) {
                    try {
                        documentDao.createDocument(
                                new Document(
                                        request.getParameter("file-headline" + counter),
                                        multipartFile.getInputStream(),
                                        multipartFile.getOriginalFilename(),
                                        userId
                                )
                        );
                        counter++;
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            return "redirect:/viewProfile/" + request.getParameter("userId");
        }
        return "redirect:/";
    }
}
