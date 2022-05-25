package com.uniassist.model;

import java.io.InputStream;

public class Document {

    private int documentId;
    private String documentName;
    private InputStream documentFile;
    private String documentFileName;
    private int userId;

    public Document(int documentId, String documentName, InputStream documentFile, String documentFileName, int userId) {
        this.documentId = documentId;
        this.documentName = documentName;
        this.documentFile = documentFile;
        this.documentFileName = documentFileName;
        this.userId = userId;
    }

    public Document(String documentName, InputStream documentFile, String documentFileName, int userId) {
        this.documentName = documentName;
        this.documentFile = documentFile;
        this.documentFileName = documentFileName;
        this.userId = userId;
    }

    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public InputStream getDocumentFile() {
        return documentFile;
    }

    public void setDocumentFile(InputStream documentFile) {
        this.documentFile = documentFile;
    }

    public String getDocumentFileName() {
        return documentFileName;
    }

    public void setDocumentFileName(String documentFileName) {
        this.documentFileName = documentFileName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
