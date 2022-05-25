package com.uniassist.repository;

import com.uniassist.model.Document;

import java.util.List;

public interface DocumentDao {

    List<Document> getDocumentsByUserId(int userId);
    void createDocument(Document document);
}
