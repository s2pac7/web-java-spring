package org.airport.webjavaspring.repository;

import org.airport.webjavaspring.model.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    boolean existsByPassportNumber(String passportNumber);
}
