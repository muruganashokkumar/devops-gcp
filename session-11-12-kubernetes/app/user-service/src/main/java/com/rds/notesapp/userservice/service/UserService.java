package com.rds.notesapp.userservice.service;

import com.rds.notesapp.userservice.dto.Note;
import com.rds.notesapp.userservice.model.User;

import java.util.List;

public interface UserService {

    public User create(User user);

    public User update(long id, User user);

    public User findById(long id);

    public void delete(long id);

    public List<User> findAll();

    public List<Note> getAllNotes(long userId);

}
