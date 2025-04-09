package org.airport.webjavaspring.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="aircrafts")
public class Aircraft {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="nameAircraft")
    private String nameAircraft;

    @Enumerated(EnumType.STRING)
    @Column(name="typeAircraft")
    private TypeAircraft typeAircraft;
}
