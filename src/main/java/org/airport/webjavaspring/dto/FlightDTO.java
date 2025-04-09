package org.airport.webjavaspring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.airport.webjavaspring.model.Flight;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class FlightDTO {
    private Long id;
    @JsonProperty("aircraftId")
    private Long aircraftId;
    @JsonProperty("flightNumber")
    private String flightNumber;
    @JsonProperty("departureAirport")
    private String departureAirport;
    @JsonProperty("arrivalAirport")
    private String arrivalAirport;
    @JsonProperty("departureTime")
    private LocalDateTime departureTime;
    @JsonProperty("arrivalTime")
    private LocalDateTime arrivalTime;
    @JsonProperty("price")
    private BigDecimal price;

    public static FlightDTO fromEntity(Flight flight) {
        FlightDTO dto = new FlightDTO();
        dto.setId(flight.getId());
        dto.setAircraftId(flight.getAircraft() != null ? flight.getAircraft().getId() : null);
        dto.setFlightNumber(flight.getFlightNumber());
        dto.setDepartureAirport(flight.getDepartureAirport());
        dto.setArrivalAirport(flight.getArrivalAirport());
        dto.setDepartureTime(flight.getDepartureTime());
        dto.setArrivalTime(flight.getArrivalTime());
        dto.setPrice(flight.getPrice());
        return dto;
    }
}