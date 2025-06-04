package com.rds.notesapp.userservice.api;

import com.rds.notesapp.userservice.dto.Note;
import com.rds.notesapp.userservice.model.User;
import com.rds.notesapp.userservice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping
    public User createUser(@RequestBody User user) {
        return userService.create(user);
    }

    @GetMapping("/{id}")
    public User getUserById(@PathVariable long id) {
        return userService.findById(id);
    }

    @GetMapping("/notes/{userId}")
    public List<Note> getNotesByUserId(@PathVariable long userId) {
        return userService.getAllNotes(userId);
    }

}
