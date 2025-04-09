package org.airport.webjavaspring.repository;

import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    boolean existsByPassportNumber(String passportNumber);
    Optional<Passenger> findByPassportNumber(String passportNumber);

    Optional<Passenger> findByUser(User user);

}
