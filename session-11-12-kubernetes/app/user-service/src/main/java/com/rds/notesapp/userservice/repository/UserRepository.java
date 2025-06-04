package com.rds.notesapp.userservice.repository;

import com.rds.notesapp.userservice.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

}
