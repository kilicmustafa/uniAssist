package com.uniassist.controller;

import javax.servlet.http.HttpServletRequest;

public class BaseController {

    static final int ADMIN = 1, STUDENT = 2, AGENT = 3;

    boolean loginStatement(HttpServletRequest request) {
        return request.getSession().getAttribute("loginState") != null && (boolean) request.getSession().getAttribute("loginState");
    }
}
