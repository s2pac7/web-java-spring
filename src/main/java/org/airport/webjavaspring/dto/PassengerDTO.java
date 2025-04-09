package org.airport.webjavaspring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.model.User;
import org.hibernate.type.TrueFalseConverter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class PassengerDTO {
    private Long id;
    private User user;
    private String name;
    private String surname;
    private String passportNumber;
    private LocalDate dateOfBirth;
    private String phoneNumber;
    @JsonProperty("hasDisability") // аннотация для соответствия с JSON
    private boolean hasDisability;
    @JsonProperty("isStudent")
    private boolean isStudent;
    private BigDecimal balance;

    public static PassengerDTO fromEntity(Passenger passenger) {
        PassengerDTO dto = new PassengerDTO();
        dto.setId(passenger.getId());
        dto.setUser(passenger.getUser());
        dto.setName(passenger.getName());
        dto.setSurname(passenger.getSurname());
        dto.setPassportNumber(passenger.getPassportNumber());
        dto.setDateOfBirth(passenger.getDateOfBirth());
        dto.setPhoneNumber(passenger.getPhoneNumber());
        dto.setHasDisability(passenger.isHasDisability());
        dto.setStudent(passenger.isStudent());
        dto.setBalance(passenger.getBalance());
        return dto;
    }
}