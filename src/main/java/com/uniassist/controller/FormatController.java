package com.uniassist.controller;

import com.uniassist.model.ApplicationFormat;
import com.uniassist.repository.implementations.ApplicationDocDao;
import com.uniassist.repository.implementations.ApplicationFormatDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Controller
public class FormatController extends BaseController{

    private final ApplicationFormatDao applicationFormatDao;
    private final ApplicationDocDao applicationDocDao;

    @Autowired
    public FormatController(ApplicationFormatDao applicationFormatDao, ApplicationDocDao applicationDocDao) {
        this.applicationFormatDao = applicationFormatDao;
        this.applicationDocDao = applicationDocDao;
    }

    @GetMapping("/dashboard/formats")
    public String formats(Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            HashMap<String, List<ApplicationFormat>> listHashMap = new HashMap<>();
            List<String> countries = applicationDocDao.getCountries();
            for(String country : countries) {
                listHashMap.put(country, applicationDocDao.getApplicationFormats(country));
            }
            model.addAttribute("formats", listHashMap);
            return "dashboardformats";
        }
        return "redirect:/";
    }

    @GetMapping("/dashboard/addformats")
    public String addFormat(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) == ADMIN) {
            return "addformat";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/formats/save")
    public String formatSave(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) == ADMIN) {
            for (int i = 1; i <= Integer.valueOf(request.getParameter("counter")); i++) {
                if(request.getParameter("name"+i).equals("")) {
                    continue;
                }
                ApplicationFormat applicationFormat = new ApplicationFormat();
                applicationFormat.setCountry(request.getParameter("country"));
                applicationFormat.setName(request.getParameter("name" + i));
                List<Integer> types = new ArrayList<>();
                if(request.getParameter("studienkolleg"+i) != null && request.getParameter("studienkolleg"+i).equals("on")) {
                    types.add(1);
                }
                if(request.getParameter("bachelor"+i) != null && request.getParameter("bachelor"+i).equals("on")) {
                    types.add(2);
                }
                if(request.getParameter("master"+i) != null && request.getParameter("master"+i).equals("on")) {
                    types.add(3);
                }
                applicationFormat.setTypes(types);
                if(!applicationFormatDao.exist(applicationFormat)) {
                    applicationFormatDao.createApplicationFormat(applicationFormat);
                }
            }
            return "redirect:/dashboard/formats?added=true";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/formats/delete")
    public @ResponseBody String deleteFormat(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) == ADMIN) {
            applicationFormatDao.deleteApplicationFormat(request.getParameter("country"), request.getParameter("name"));
            return "OK";
        }
        return "BAD_REQUEST";
    }

    @GetMapping("/dashboard/formats/update/{formatId}")
    public String editformat(@PathVariable("formatId") Integer formatId, Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) == ADMIN) {
            model.addAttribute("formatId", formatId);
            model.addAttribute("applicationFormat", applicationDocDao.getApplicationFormatById(formatId));
            try {
                model.addAttribute("translations", applicationFormatDao.getApplicationFormatTranslations(formatId));
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return "dashboardeditformat";
        }
        return "redirect:/";
    }

    @PostMapping("/dashboard/formats/update")
    public String updateFormat(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) == ADMIN) {
            applicationFormatDao.updateFormat(Integer.parseInt(request.getParameter("formatId")), request.getParameter("country"),
                    request.getParameter("name"));
            applicationFormatDao.deleteApplicationFormaTypes(Integer.parseInt(request.getParameter("formatId")));
            if(request.getParameter("studienkolleg") != null && request.getParameter("studienkolleg").equals("on")) {
                applicationFormatDao.addType(Integer.parseInt(request.getParameter("formatId")), 1);
            }
            if(request.getParameter("bachelor") != null && request.getParameter("bachelor").equals("on")) {
                applicationFormatDao.addType(Integer.parseInt(request.getParameter("formatId")), 2);
            }
            if(request.getParameter("master") != null && request.getParameter("master").equals("on")) {
                applicationFormatDao.addType(Integer.parseInt(request.getParameter("formatId")), 3);
            }
            HashMap<String, String> translation = new HashMap<>();
            Arrays.asList("de", "en", "tr", "cn").forEach(lang -> {
                if(request.getParameter(lang) != null)
                    translation.put(lang, request.getParameter(lang));
            });
            applicationFormatDao.createUpdateTranslation(Integer.parseInt(request.getParameter("formatId")), translation);
            return "redirect:/dashboard/formats/update/"+request.getParameter("formatId")+"?added=true";
        }
        return "redirect:/";
    }
}
