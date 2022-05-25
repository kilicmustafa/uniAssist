package com.uniassist.controller;

import com.uniassist.services.SessionData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController {

    @RequestMapping(value = {"/", "/defaultsite"})
    public String index(HttpServletRequest request, Model model) {
        SessionData.pageCounter.get("index").incrementAndGet();
        if(request.getSession().getAttribute("loginState") != null) {
            if((boolean) request.getSession().getAttribute("loginState")) {
                model.addAttribute("loginState", true);
            }
        } else {
            model.addAttribute("loginState", false);
        }
        return "index";
    }

}
