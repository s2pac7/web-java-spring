package org.airport.webjavaspring.repository;

import org.airport.webjavaspring.model.Aircraft;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AircraftRepository extends JpaRepository<Aircraft, Long> {
    boolean existsByNameAircraft(String nameAircraft);
}
