package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.Document;
import com.uniassist.repository.DocumentDao;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentDaoImpl implements DocumentDao {

    private DBHelper dbHelper;

    public DocumentDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public List<Document> getDocumentsByUserId(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM document WHERE UserID = " + userId);
        List<Document> documents = new ArrayList<>();
        try {
            if (resultSet != null) {
                while (resultSet.next()) {
                    documents.add(new Document(
                                    resultSet.getInt("DocumentID"),
                                    resultSet.getString("DocumentName"),
                                    resultSet.getBinaryStream("DocumentFile"),
                                    resultSet.getString("DocumentFileName"),
                                    resultSet.getInt("UserID")
                            )
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    @Override
    public void createDocument(Document document) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("INSERT INTO document(DocumentName, DocumentFile, " +
                "DocumentFileName, UserID) VALUES(?, ?, ?, ?)");
        try {
            preparedStatement.setString(1, document.getDocumentName());
            preparedStatement.setBlob(2, document.getDocumentFile());
            preparedStatement.setString(3, document.getDocumentFileName());
            preparedStatement.setInt(4, document.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public InputStream getBinaryStream(int documentId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT DocumentFile FROM document WHERE DocumentID = " + documentId);
        try {
            if(resultSet.next()) {
                return resultSet.getBinaryStream("DocumentFile");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
