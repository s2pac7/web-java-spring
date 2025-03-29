package org.airport.webjavaspring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class UserPassengerDTO {
    private String username;
    private String password;
    private String name;
    private String surname;
    @JsonProperty("passportNumber")
    private String passportNumber;

    @JsonProperty("dateOfBirth")
    private LocalDate dateOfBirth;

    @JsonProperty("phoneNumber")
    private String phoneNumber;
    @JsonProperty("hasDisability") // аннотация для соответствия с JSON
    private boolean hasDisability;
    @JsonProperty("isStudent")
    private boolean isStudent;
    private double balance;
}
