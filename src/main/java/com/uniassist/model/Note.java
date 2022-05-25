package com.uniassist.model;

public class Note {

    private int noteId;
    private String forUser;
    private String forUs;
    private int userId;

    public Note(String forUser, String forUs, int userId) {
        this.forUser = forUser;
        this.forUs = forUs;
        this.userId = userId;
    }

    public int getNoteId() {
        return noteId;
    }

    public void setNoteId(int noteId) {
        this.noteId = noteId;
    }

    public String getForUser() {
        return forUser;
    }

    public void setForUser(String forUser) {
        this.forUser = forUser;
    }

    public String getForUs() {
        return forUs;
    }

    public void setForUs(String forUs) {
        this.forUs = forUs;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
