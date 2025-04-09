package org.airport.webjavaspring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import org.airport.webjavaspring.model.TypeAircraft;

@Data
public class AircraftDTO {

    private Long id;
    @JsonProperty("nameAircraft")
    private String nameAircraft;
    @JsonProperty("typeAircraft")
    private TypeAircraft typeAircraft;
}
