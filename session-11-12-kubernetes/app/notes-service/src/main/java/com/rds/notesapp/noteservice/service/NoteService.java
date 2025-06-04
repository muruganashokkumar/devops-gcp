package com.rds.notesapp.noteservice.service;

import com.rds.notesapp.noteservice.model.Note;

import java.util.List;

public interface NoteService {

    public Note create(Note note);

    public Note update(long id, Note note);

    public Note findById(long id);

    public void delete(long id);

    public List<Note> findAll();

    public List<Note> findByUserId(long userId);

}
