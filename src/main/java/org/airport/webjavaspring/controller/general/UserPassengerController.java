package org.airport.webjavaspring.controller.general;

import org.airport.webjavaspring.dto.UserPassengerDTO;
import org.airport.webjavaspring.exception.PassportNumberExistsException;
import org.airport.webjavaspring.exception.UsernameExistsException;
import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.service.impl.UserPassengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class UserPassengerController {

    private final UserPassengerService userPassengerService;

    @Autowired
    public UserPassengerController(UserPassengerService userPassengerService) {
        this.userPassengerService = userPassengerService;
    }

    @PostMapping("/signup")
    public ResponseEntity<Map<String, Object>> signup(@RequestBody UserPassengerDTO userPassengerDTO) {
        try {
            Passenger passenger = userPassengerService.registerUserAndPassenger(userPassengerDTO);
            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "message", "User and Passenger registered successfully",
                    "data", Map.of(
                            "userId", passenger.getUser().getId(),
                            "passengerId", passenger.getId()
                    ),
                    "timestamp", LocalDateTime.now()
            ));
        } catch (UsernameExistsException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(
                    "status", "error",
                    "message", "Username already exists",
                    "timestamp", LocalDateTime.now()
            ));
        } catch (PassportNumberExistsException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(
                    "status", "error",
                    "message", "Passport number already registered",
                    "timestamp", LocalDateTime.now()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                    "status", "error",
                    "message", "Registration failed: " + e.getMessage(),
                    "timestamp", LocalDateTime.now()
            ));
        }
    }
}

