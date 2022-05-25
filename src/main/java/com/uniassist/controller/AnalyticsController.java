package com.uniassist.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uniassist.repository.implementations.AnalyticsDaoImpl;
import com.uniassist.services.SessionData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;

@Controller
public class AnalyticsController extends BaseController {

    private AnalyticsDaoImpl analyticsDao;

    @Autowired
    public AnalyticsController(AnalyticsDaoImpl analyticsDao) {
        this.analyticsDao = analyticsDao;
    }

    @GetMapping("/dashboard/analytics")
    public String analytics(Model model, HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            model.addAttribute("count", SessionData.count);
            model.addAttribute("pagesCount", SessionData.pageCounter);
            return "analytics";
        }
        return "redirect:/";
    }

    @GetMapping("/dashboard/analytics/pagecounter")
    public @ResponseBody  String pagecounter(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            try {
                return new ObjectMapper().writeValueAsString(SessionData.pageCounter);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }
        return "null";
    }

    @GetMapping("/dashboard/analytics/registrationdistrubition")
    public @ResponseBody  String registrationDistrubition(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            try {
                return new ObjectMapper().writeValueAsString(analyticsDao.getRegistrationDateDistrubiton());
            } catch (JsonProcessingException | SQLException e) {
                e.printStackTrace();
            }
        }
        return "null";
    }

    @GetMapping("/dashboard/analytics/applicationstatedistrubition")
    public @ResponseBody  String applicationStateDistrubition(HttpServletRequest request) {
        if(loginStatement(request) && Integer.valueOf(request.getSession().getAttribute("role").toString()) != STUDENT) {
            try {
                return new ObjectMapper().writeValueAsString(analyticsDao.getApplicationStateCount());
            } catch (JsonProcessingException | SQLException e) {
                e.printStackTrace();
            }
        }
        return "null";
    }
}
