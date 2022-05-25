package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.ApplicationFormat;
import com.uniassist.model.Document;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDocDao {

    private DBHelper dbHelper;

    public ApplicationDocDao() {
        dbHelper = DBHelper.getInstance();
    }

    public List<String> getCountries() {
        List<String> countries = new ArrayList<>();

        ResultSet resultSet = dbHelper.executeQuery("SELECT Country FROM applicationformat GROUP BY Country");
        try {
            while (resultSet.next()) {
                countries.add(resultSet.getString("Country"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return countries;
    }

    public List<Document> getApplicationDocuments(int userId, int appType) {
        List<Document> documents = new ArrayList<>();
        ResultSet resultSet = dbHelper.executeQuery("SELECT DISTINCT DocumentID, DocumentName, DocumentFile, DocumentFileName, " +
                "applicationdocument.UserID, applicationformattype.ApplicationTypeID FROM applicationdocument INNER JOIN applicationformat ON DocumentName = Name INNER JOIN user ON applicationdocument.UserID = user.UserID INNER JOIN applicationformattype ON applicationformattype.ApplicationFormatID = applicationformat.ApplicationFormatID " +
                "WHERE applicationdocument.UserID = " + userId  + " AND applicationformattype.ApplicationTypeID = " + appType);
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

    public void createApplicationDocuments(List<Document> document) {
        for (Document document1 : document) {
            this.createApplicationDocument(document1);
        }
    }

    public InputStream getBinaryStream(int documentId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT DocumentFile FROM applicationdocument WHERE DocumentID = " + documentId);
        try {
            if (resultSet.next()) {
                return resultSet.getBinaryStream("DocumentFile");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateDocument(int documentId, String fileName, InputStream file) {
        PreparedStatement preparedStatement = dbHelper.getPreparedStatement("UPDATE applicationdocument SET " +
                "DocumentFileName = ?, DocumentFile = ? WHERE DocumentID = ?");
        try {
            preparedStatement.setString(1, fileName);
            preparedStatement.setBlob(2, file);
            preparedStatement.setInt(3, documentId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ApplicationFormat> getApplicationFormats(String country) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT ApplicationFormatID, Name, Country FROM applicationformat WHERE Country = \"" + country + "\"");
        List<ApplicationFormat> labels = new ArrayList<>();
        try {
            while (resultSet.next()) {
                ApplicationFormat applicationFormat = new ApplicationFormat();
                ResultSet types = dbHelper.executeQuery("SELECT * FROM applicationformattype WHERE ApplicationFormatID = "
                        + resultSet.getInt("ApplicationFormatID"));
                List<Integer> typeList = new ArrayList<>();
                while(types.next()) {
                    typeList.add(types.getInt("ApplicationTypeID"));
                }
                applicationFormat.setApplicationFormatId(resultSet.getInt("ApplicationFormatID"));
                applicationFormat.setName(resultSet.getString("Name"));
                applicationFormat.setCountry(country);
                applicationFormat.setTypes(typeList);
                labels.add(applicationFormat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return labels;
    }

    public void createApplicationDocument(Document document) {
        PreparedStatement preparedStatement;
        try {
            if (!documentExist(document)) {
                preparedStatement = dbHelper.getPreparedStatement("INSERT INTO applicationdocument(DocumentName, DocumentFile, " +
                        "DocumentFileName, UserID) VALUES(?, ?, ?, ?)");
                preparedStatement.setString(1, document.getDocumentName());
                preparedStatement.setBlob(2, document.getDocumentFile());
                preparedStatement.setString(3, document.getDocumentFileName());
                preparedStatement.setInt(4, document.getUserId());

            } else {
                preparedStatement = dbHelper.getPreparedStatement("UPDATE applicationdocument SET DocumentFile = ?, " +
                        "DocumentFileName = ? WHERE UserID = ? AND DocumentName = ?");
                preparedStatement.setBlob(1, document.getDocumentFile());
                preparedStatement.setString(2, document.getDocumentFileName());
                preparedStatement.setInt(3, document.getUserId());
                preparedStatement.setString(4, document.getDocumentName());
            }

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private boolean documentExist(Document document) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM applicationdocument WHERE UserID = " + document.getUserId() +
                " AND DocumentName = \"" + document.getDocumentName() + "\"");
        try {
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Document getPhoto(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM applicationdocument WHERE UserID = " + userId + " AND " +
                "DocumentName = 'Photo'");
        try {
            if (resultSet.next()) {
                return new Document(
                        resultSet.getInt("DocumentID"),
                        resultSet.getString("DocumentName"),
                        resultSet.getBinaryStream("DocumentFile"),
                        resultSet.getString("DocumentFileName"),
                        resultSet.getInt("UserID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ApplicationFormat getApplicationFormatById(Integer formatId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT Name, Country FROM applicationformat WHERE " +
                "ApplicationFormatID = " + formatId);
        try {
            if (resultSet.next()) {
                ApplicationFormat applicationFormat = new ApplicationFormat();
                ResultSet types = dbHelper.executeQuery("SELECT * FROM applicationformattype WHERE ApplicationFormatID = " + formatId);
                List<Integer> typeList = new ArrayList<>();
                while(types.next()) {
                    typeList.add(types.getInt("ApplicationTypeID"));
                }

                applicationFormat.setApplicationFormatId(formatId);
                applicationFormat.setName(resultSet.getString("Name"));
                applicationFormat.setCountry(resultSet.getString("Country"));
                applicationFormat.setTypes(typeList);
                return applicationFormat;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
