package org.airport.webjavaspring.service.impl;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.UserPassengerDTO;
import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.model.Role;
import org.airport.webjavaspring.model.User;
import org.airport.webjavaspring.repository.PassengerRepository;
import org.airport.webjavaspring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Slf4j
@Service
@Transactional
public class UserPassengerService {

    private final PassengerRepository passengerRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserPassengerService(PassengerRepository passengerRepository,
                                UserRepository userRepository,
                                PasswordEncoder passwordEncoder) {
        this.passengerRepository = passengerRepository;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Passenger registerUserAndPassenger(UserPassengerDTO dto) {
        log.info("Starting registration for username: {}", dto.getUsername());

        try {
            // 1. Проверка уникальности
            log.debug("Checking username uniqueness");
            if (userRepository.existsUserByUsername(dto.getUsername())) {
                throw new RuntimeException("Username exists");
            }

            log.debug("Checking passport uniqueness");
            if (passengerRepository.existsByPassportNumber(dto.getPassportNumber())) {
                throw new RuntimeException("Passport exists");
            }

            // 2. Создание User
            log.debug("Creating user entity");
            User user = new User();
            user.setUsername(dto.getUsername());
            user.setPassword(passwordEncoder.encode(dto.getPassword()));
            user.setRole(Role.USER);

            log.debug("Saving user: {}", user);
            user = userRepository.save(user);
            log.info("User saved with ID: {}", user.getId());

            // 3. Создание Passenger
            log.debug("Creating passenger entity");
            Passenger passenger = new Passenger();
            passenger.setUser(user);
            passenger.setName(dto.getName());
            passenger.setSurname(dto.getSurname());
            passenger.setPassportNumber(dto.getPassportNumber());
            passenger.setDateOfBirth(dto.getDateOfBirth());
            passenger.setPhoneNumber(dto.getPhoneNumber());
            passenger.setHasDisability(dto.isHasDisability());
            passenger.setStudent(dto.isStudent());
            passenger.setBalance(BigDecimal.valueOf(dto.getBalance()));

            log.debug("Saving passenger: {}", passenger);
            passenger = passengerRepository.save(passenger);
            log.info("Passenger saved with ID: {}", passenger.getId());

            return passenger;

        } catch (Exception e) {
            log.error("Registration failed for DTO: {}", dto, e);
            throw e;
        }
    }
}

