package com.uniassist.controller;

import com.uniassist.services.SessionData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StaticPagesController {

    @GetMapping(value = {"/hakkimizda", "/about"})
    public String about() {
        SessionData.pageCounter.get("about").incrementAndGet();
        return "about";
    }

    @GetMapping(value = {"/faq", "/sss"})
    public String faq() {
        SessionData.pageCounter.get("faq").incrementAndGet();
        return "faq";
    }

    @GetMapping(value = {"/how-to-apply", "/nasil-basvururum"})
    public String howToApply() {
        SessionData.pageCounter.get("how-to-apply").incrementAndGet();
        return "howtoapply";
    }
}
