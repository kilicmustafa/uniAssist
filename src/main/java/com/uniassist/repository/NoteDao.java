package com.uniassist.repository;

import com.uniassist.model.Note;

public interface NoteDao {

    Note getNoteByUserId(int userId);
    void createUpdateNote(Note note);
}
