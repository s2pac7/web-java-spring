package org.airport.webjavaspring.dto;

import lombok.Data;

@Data
public class SignupRequest {
    private String username;
    private String password;
}
