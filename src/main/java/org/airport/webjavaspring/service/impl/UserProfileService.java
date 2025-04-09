package org.airport.webjavaspring.service.impl;

import org.airport.webjavaspring.dto.PassengerDTO;
import org.airport.webjavaspring.dto.PasswordChangeRequest;
import org.airport.webjavaspring.dto.UserProfileDTO;
import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.model.User;
import org.airport.webjavaspring.repository.PassengerRepository;
import org.airport.webjavaspring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;

@Service
public class UserProfileService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PassengerRepository passengerRepository;

    @Autowired
    private PassengerServiceCRUD passengerService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserProfileDTO updateProfile(String username, UserProfileDTO updatedProfile) {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Passenger passenger = passengerRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("Passenger not found"));

        // Обновляем только данные пассажира
        PassengerDTO passengerDTO = convertToPassengerDTO(updatedProfile);
        passengerDTO.setId(passenger.getId());
        passengerService.updatePassenger(passenger.getId(), passengerDTO);

        return getUserProfile(username);
    }

    public void changePassword(String username, PasswordChangeRequest request) {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            throw new RuntimeException("Неверный текущий пароль");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    public void topUpBalance(String username, BigDecimal amount) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new RuntimeException("Сумма пополнения должна быть больше нуля");
        }

        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Passenger passenger = passengerRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("Passenger not found"));

        BigDecimal newBalance = passenger.getBalance().add(amount);
        passenger.setBalance(newBalance);

        passengerRepository.save(passenger);
    }


    private PassengerDTO convertToPassengerDTO(UserProfileDTO profile) {
        PassengerDTO dto = new PassengerDTO();
        dto.setName(profile.getName());
        dto.setSurname(profile.getSurname());
        dto.setPhoneNumber(profile.getPhoneNumber());
        dto.setPassportNumber(profile.getPassportNumber());
        dto.setDateOfBirth(profile.getDateOfBirth());
        dto.setStudent(profile.isStudent());
        dto.setHasDisability(profile.isHasDisability());
        return dto;
    }

    public UserProfileDTO getUserProfile(String username) {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Passenger passenger = passengerRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("Passenger not found"));

        UserProfileDTO dto = new UserProfileDTO();
        dto.setUser(user);
        dto.setName(passenger.getName());
        dto.setSurname(passenger.getSurname());
        dto.setPhoneNumber(passenger.getPhoneNumber());
        dto.setPassportNumber(passenger.getPassportNumber());
        dto.setDateOfBirth(passenger.getDateOfBirth());
        dto.setBalance(passenger.getBalance());
        dto.setStudent(passenger.isStudent());
        dto.setHasDisability(passenger.isHasDisability());

        return dto;
    }
}