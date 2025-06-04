package com.rds.notesapp.userservice.service;

import com.rds.notesapp.userservice.dto.Note;
import com.rds.notesapp.userservice.model.User;
import com.rds.notesapp.userservice.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Override
    public User create(User user) {
        return userRepository.save(user);
    }

    @Override
    public User update(long id, User user) {
        User existingUser = findById(id);
        if (existingUser == null) {
            return null;
        }
        if (user.getUsername() != null) {
            existingUser.setUsername(user.getUsername());
        }
        if (user.getEmail() != null) {
            existingUser.setEmail(user.getEmail());
        }
        return userRepository.save(existingUser);
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public void delete(long id) {
        userRepository.deleteById(id);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    public List<Note> getAllNotes(long userId) {
        User user = findById(userId);
        if (user == null) {
            return null;
        }

        List<Note> notes = Arrays.asList(restTemplate.getForObject("http://notes-service:8100/api/notes/user/" + userId, Note[].class));

        return notes;
    }


}
