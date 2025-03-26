package org.airport.webjavaspring.dto;

import lombok.Data;

@Data
public class SigninRequest {
    private String username;
    private String password;
}
