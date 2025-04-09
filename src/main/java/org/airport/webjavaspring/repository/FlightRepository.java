package org.airport.webjavaspring.repository;

import org.airport.webjavaspring.model.Flight;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {

    @Query("SELECT COALESCE(MAX(f.price), 0.0) FROM Flight f")
    Double findMaxPrice();

    @Query("SELECT COALESCE(MIN(f.price), 0.0) FROM Flight f")
    Double findMinPrice();

    @Query("SELECT COALESCE(AVG(f.price), 0.0) FROM Flight f")
    Double findAvgPrice();

    @Query("SELECT COUNT(f) FROM Flight f WHERE f.arrivalAirport = 'Aviasales'")
    Long countArrivalsToAviasales(); // Переименуем метод
}
