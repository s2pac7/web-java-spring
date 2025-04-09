package org.airport.webjavaspring.dto;

import jakarta.persistence.*;
import lombok.Data;
import org.airport.webjavaspring.model.Role;

@Data
public class UserDTO {
    private Long id;
    private String username;
    private Role role;
    private String password;

    public static UserDTO fromEntity(org.airport.webjavaspring.model.User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setRole(user.getRole());
        return dto;
    }
}
