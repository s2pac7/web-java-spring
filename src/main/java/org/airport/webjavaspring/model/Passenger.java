package org.airport.webjavaspring.model;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "passengers")
@Data
public class Passenger {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "userID", nullable = false, unique = true)
    private User user;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "surname", nullable = false)
    private String surname;

    @Column(name = "passportNumber", unique = true, nullable = false)
    private String passportNumber;

    @Column(name = "dateOfBirth", nullable = false)
    private LocalDate dateOfBirth;

    @Column(name = "phoneNumber", nullable = false)
    private String phoneNumber;

    @Column(name = "hasDisability", nullable = false)
    private boolean hasDisability = false;

    @Column(name = "isStudent", nullable = false)
    private boolean isStudent = false;

    @Column(name = "balance", nullable = false)
    private BigDecimal balance = BigDecimal.ZERO;
}