package com.rds.notesapp.noteservice.api;

import com.rds.notesapp.noteservice.model.Note;
import com.rds.notesapp.noteservice.repository.NoteRepository;
import com.rds.notesapp.noteservice.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @GetMapping("/{id}")
    public Note getNoteById(@PathVariable long id) {
        return noteService.findById(id);
    }

    @GetMapping("/user/{userId}")
    public List<Note> getNotesByUserId(@PathVariable long userId) {
        return noteService.findByUserId(userId);
    }

    @PostMapping
    public Note createNote(@RequestBody Note note) {
        return noteService.create(note);
    }

    @GetMapping
    public List<Note> getAllNotes() {
        return noteService.findAll();
    }

    @PatchMapping("/{id}")
    public Note updateNote(@PathVariable long id, @RequestBody Note note) {
        return noteService.update(id, note);
    }

    @DeleteMapping("/{id}")
    public void deleteNoteById(@PathVariable long id) {
        noteService.delete(id);
    }

}
