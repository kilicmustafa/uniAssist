package com.uniassist.services;

import com.sendgrid.Mail;
import com.uniassist.model.User;
import com.uniassist.repository.RemindDao;
import com.uniassist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import java.util.List;

public class ScheduleService {

    public UserDao userDao;
    private RemindDao remindDao;
    private MailService mailService;

    @Autowired
    public ScheduleService(UserDao userDao, RemindDao remindDao) {
        this.userDao = userDao;
        this.remindDao = remindDao;
        this.mailService = new MailService();
    }

    @Scheduled(fixedRate = 1000 * 60 * 60 * 10)
    public void sendMail() {
        List<User> users = userDao.getUsersNotInRemind();
        for(User u : users) {
            if(u.getEmail() != null && !u.getEmail().equals("")) {
                mailService.sendRemindMail(u.getEmail());
            }
            remindDao.insert(u);
        }
    }
}
