package com.rds.notesapp.userservice.dto;

import java.time.LocalDate;

public record Note(long id, String title, String content, LocalDate createdAt) {
}
