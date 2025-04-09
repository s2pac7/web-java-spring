package org.airport.webjavaspring.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.FlightDTO;
import org.airport.webjavaspring.model.Aircraft;
import org.airport.webjavaspring.model.Flight;
import org.airport.webjavaspring.repository.AircraftRepository;
import org.airport.webjavaspring.repository.FlightRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FlightServiceCRUD {

    private final FlightRepository flightRepository;
    private final AircraftRepository aircraftRepository;

    public void saveFlight(FlightDTO dto) {
        Aircraft aircraft = null;
        if (dto.getAircraftId() != null) {
            aircraft = aircraftRepository.findById(dto.getAircraftId())
                    .orElseThrow(() -> new EntityNotFoundException("Самолет не найден"));
        }

        Flight flight = new Flight();
        flight.setAircraft(aircraft);
        flight.setFlightNumber(dto.getFlightNumber());
        flight.setDepartureAirport(dto.getDepartureAirport());
        flight.setArrivalAirport(dto.getArrivalAirport());
        flight.setDepartureTime(dto.getDepartureTime());
        flight.setArrivalTime(dto.getArrivalTime());
        flight.setPrice(dto.getPrice());

        flightRepository.save(flight);
        log.info("Рейс {} сохранен", dto.getFlightNumber());
    }

    public boolean deleteFlight(Long id) {
        Optional<Flight> flight = flightRepository.findById(id);
        if (flight.isPresent()) {
            flightRepository.delete(flight.get());
            log.info("Рейс с ID {} удалён", id);
            return true;
        }
        return false;
    }

    public boolean updateFlight(Long id, FlightDTO dto) {
        try {
            Flight flight = flightRepository.findById(id)
                    .orElseThrow(() -> new EntityNotFoundException("Рейс не найден"));

            if (dto.getAircraftId() != null) {
                Aircraft aircraft = aircraftRepository.findById(dto.getAircraftId())
                        .orElseThrow(() -> new EntityNotFoundException("Самолет не найден"));
                flight.setAircraft(aircraft);
            }

            flight.setFlightNumber(dto.getFlightNumber());
            flight.setDepartureAirport(dto.getDepartureAirport());
            flight.setArrivalAirport(dto.getArrivalAirport());
            flight.setDepartureTime(dto.getDepartureTime());
            flight.setArrivalTime(dto.getArrivalTime());
            flight.setPrice(dto.getPrice());

            flightRepository.save(flight);
            log.info("Рейс {} обновлен", dto.getFlightNumber());
            return true;
        } catch (Exception e) {
            log.error("Ошибка при обновлении рейса", e);
            return false;
        }
    }

    public List<Flight> getAllFlights() {
        return flightRepository.findAll();
    }

    public FlightDTO getFlight(Long id) {
        return flightRepository.findById(id)
                .map(FlightDTO::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException("Рейс с ID " + id + " не найден"));
    }
}