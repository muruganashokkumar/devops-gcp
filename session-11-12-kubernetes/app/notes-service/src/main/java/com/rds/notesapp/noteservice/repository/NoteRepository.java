package com.rds.notesapp.noteservice.repository;

import com.rds.notesapp.noteservice.model.Note;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface NoteRepository extends JpaRepository<Note, Long> {

    List<Note> findByUserId(long userId);

}
