package org.airport.webjavaspring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.airport.webjavaspring.model.User;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class UserProfileDTO {
    private User user;
    private String name;
    private String surname;
    private String phoneNumber;
    private String passportNumber;
    private LocalDate dateOfBirth;
    private BigDecimal balance;
    @JsonProperty("hasDisability") // аннотация для соответствия с JSON
    private boolean hasDisability;
    @JsonProperty("isStudent")
    private boolean isStudent;

    public String getUsername() {
        return user != null ? user.getUsername() : null;
    }
}