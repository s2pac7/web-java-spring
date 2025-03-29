package org.airport.webjavaspring.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class UserProfileDTO {
    private String username;
    private String fullName;
    private LocalDate birthDate;
    private String phoneNumber;
    private String passportData;

}