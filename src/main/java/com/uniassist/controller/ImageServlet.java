package com.uniassist.controller;

import com.uniassist.repository.implementations.ApplicationDaoImpl;
import com.uniassist.repository.implementations.ApplicationDocDao;
import com.uniassist.repository.implementations.DocumentDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.IOException;

//@WebServlet("/imageSource")
@Controller
public class ImageServlet {

    private final DocumentDaoImpl documentDao;
    private final ApplicationDocDao applicationDocDao;

    @Autowired
    public ImageServlet(DocumentDaoImpl documentDao, ApplicationDocDao applicationDocDao) {
        this.documentDao = documentDao;
        this.applicationDocDao = applicationDocDao;
    }

    /*@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if(req.getSession().getAttribute("loginState") != null && (boolean) req.getSession().getAttribute("loginState")) {
            Integer userId = Integer.valueOf(req.getParameter("userId"));
            String column = req.getParameter("source");

            BufferedOutputStream bos = new BufferedOutputStream( resp.getOutputStream( ) );
            bos.write(StreamUtils.copyToByteArray(applicationDao.getBinaryStream(userId, column)));
            bos.flush();
            bos.close();
        }
    }*/

    @RequestMapping(value = "/source/{name}", method = RequestMethod.GET)
    public void source(@PathVariable("name") String name, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if(req.getSession().getAttribute("loginState") != null && (boolean) req.getSession().getAttribute("loginState")) {
            Integer documentId = Integer.valueOf(req.getParameter("documentId"));

            BufferedOutputStream bos = new BufferedOutputStream( resp.getOutputStream( ) );
            bos.write(StreamUtils.copyToByteArray(applicationDocDao.getBinaryStream(documentId)));
            bos.flush();
            bos.close();
        }
    }

    @RequestMapping(value = "/document/{name}", method = RequestMethod.GET)
    public void document(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if(req.getSession().getAttribute("loginState") != null && (boolean) req.getSession().getAttribute("loginState")) {
            Integer documentId = Integer.valueOf(req.getParameter("documentId"));

            BufferedOutputStream bos = new BufferedOutputStream( resp.getOutputStream( ) );
            bos.write(StreamUtils.copyToByteArray(documentDao.getBinaryStream(documentId)));
            bos.flush();
            bos.close();
        }
    }
}
