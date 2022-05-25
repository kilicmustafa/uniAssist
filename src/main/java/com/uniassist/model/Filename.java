package com.uniassist.model;

public class Filename {

    private int FileNameID;
    private String photoName;
    private String osymSonucName;
    private String osymYerlesimName;
    private String liseDiplomaName;
    private String liseTranskriptName;
    private String universiteDiplomaName;
    private String universiteTranskriptName;
    private int applicationId;

    public Filename(String photoName, String osymSonucName, String osymYerlesimName, String liseDiplomaName, String liseTranskriptName, String universiteDiplomaName, String universiteTranskriptName, int applicationId) {
        this.photoName = photoName;
        this.osymSonucName = osymSonucName;
        this.osymYerlesimName = osymYerlesimName;
        this.liseDiplomaName = liseDiplomaName;
        this.liseTranskriptName = liseTranskriptName;
        this.universiteDiplomaName = universiteDiplomaName;
        this.universiteTranskriptName = universiteTranskriptName;
        this.applicationId = applicationId;
    }

    public Filename(String photoName, String osymSonucName, String osymYerlesimName, String liseDiplomaName, String liseTranskriptName) {
        this.photoName = photoName;
        this.osymSonucName = osymSonucName;
        this.osymYerlesimName = osymYerlesimName;
        this.liseDiplomaName = liseDiplomaName;
        this.liseTranskriptName = liseTranskriptName;
    }

    public int getFileNameID() {
        return FileNameID;
    }

    public void setFileNameID(int fileNameID) {
        FileNameID = fileNameID;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public String getOsymSonucName() {
        return osymSonucName;
    }

    public void setOsymSonucName(String osymSonucName) {
        this.osymSonucName = osymSonucName;
    }

    public String getOsymYerlesimName() {
        return osymYerlesimName;
    }

    public void setOsymYerlesimName(String osymYerlesimName) {
        this.osymYerlesimName = osymYerlesimName;
    }

    public String getLiseDiplomaName() {
        return liseDiplomaName;
    }

    public void setLiseDiplomaName(String liseDiplomaName) {
        this.liseDiplomaName = liseDiplomaName;
    }

    public String getLiseTranskriptName() {
        return liseTranskriptName;
    }

    public void setLiseTranskriptName(String liseTranskriptName) {
        this.liseTranskriptName = liseTranskriptName;
    }

    public String getUniversiteDiplomaName() {
        return universiteDiplomaName;
    }

    public void setUniversiteDiplomaName(String universiteDiplomaName) {
        this.universiteDiplomaName = universiteDiplomaName;
    }

    public String getUniversiteTranskriptName() {
        return universiteTranskriptName;
    }

    public void setUniversiteTranskriptName(String universiteTranskriptName) {
        this.universiteTranskriptName = universiteTranskriptName;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }
}
