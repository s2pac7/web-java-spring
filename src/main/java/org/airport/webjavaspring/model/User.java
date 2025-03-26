package org.airport.webjavaspring.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name="users")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column()
    private String username;

    @Column
    private String password;

    @Column
    @Enumerated(EnumType.STRING)
    private Role role;

}
