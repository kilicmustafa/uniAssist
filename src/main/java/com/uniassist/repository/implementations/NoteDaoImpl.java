package com.uniassist.repository.implementations;

import com.uniassist.helper.DBHelper;
import com.uniassist.model.Note;
import com.uniassist.repository.NoteDao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class NoteDaoImpl implements NoteDao{

    private DBHelper dbHelper;

    public NoteDaoImpl() {
        dbHelper = DBHelper.getInstance();
    }

    @Override
    public Note getNoteByUserId(int userId) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM note WHERE UserID = " + userId);
        try {
            if(resultSet != null && resultSet.next()) {
                return new Note(
                        resultSet.getString("ForUser"),
                        resultSet.getString("ForUs"),
                        resultSet.getInt("UserID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void createUpdateNote(Note note) {
        ResultSet resultSet = dbHelper.executeQuery("SELECT * FROM note WHERE UserID = " + note.getUserId());
        try {
            PreparedStatement preparedStatement = null;
            if(resultSet != null && resultSet.next()) {
                preparedStatement = dbHelper.getPreparedStatement("UPDATE note SET ForUser = ?, ForUs = ? WHERE" +
                        " UserID = ?");
            } else {
                preparedStatement = dbHelper.getPreparedStatement("INSERT INTO note(ForUser, ForUs, UserID) VALUES" +
                        "(?, ?, ?)");
            }
            preparedStatement.setString(1, note.getForUser());
            preparedStatement.setString(2, note.getForUs());
            preparedStatement.setInt(3, note.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
