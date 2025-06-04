package com.rds.notesapp.noteservice.service;

import com.rds.notesapp.noteservice.dto.User;
import com.rds.notesapp.noteservice.model.Note;
import com.rds.notesapp.noteservice.repository.NoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.util.List;

@Service
public class NoteServiceImpl implements NoteService {

    @Autowired
    private NoteRepository noteRepository;

    @Autowired
    @Qualifier("restTemplate")
    private RestTemplate restTemplate;

    @Value("${user-service.url:}")
    private final String userServiceUrl = "http://user-service:8200/api/users/";


    @Override
    public Note create(Note note) {

        // check if the user exists

        String url = userServiceUrl + note.getUserId();
        User user = restTemplate.getForObject(url, User.class);
        if (user == null) {
           throw new RuntimeException("User not found");
        }
        note.setCreatedAt(LocalDate.now());
        return noteRepository.save(note);
    }

    @Override
    public Note update(long id, Note note) {
        Note existingNote = findById(id);
        if (existingNote == null) {
            return null;
        }
        if (note.getTitle() != null) {
            existingNote.setTitle(note.getTitle());
        }
        if (note.getContent() != null) {
            existingNote.setContent(note.getContent());
        }
        if (note.getCreatedAt() != null) {
            existingNote.setCreatedAt(note.getCreatedAt());
        }
        return noteRepository.save(existingNote);
    }

    @Override
    public Note findById(long id) {
        return noteRepository.findById(id).orElse(null);
    }

    @Override
    public void delete(long id) {
        noteRepository.deleteById(id);
    }

    @Override
    public List<Note> findAll() {
        return noteRepository.findAll();
    }

    @Override
    public List<Note> findByUserId(long userId) {
        return noteRepository.findByUserId(userId);
    }
}
