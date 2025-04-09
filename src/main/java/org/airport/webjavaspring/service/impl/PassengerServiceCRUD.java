package org.airport.webjavaspring.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.PassengerDTO;
import org.airport.webjavaspring.model.Passenger;
import org.airport.webjavaspring.repository.PassengerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class PassengerServiceCRUD {

    private final PassengerRepository passengerRepository;

    @Autowired
    public PassengerServiceCRUD(PassengerRepository passengerRepository) {
        this.passengerRepository = passengerRepository;
    }

    public void savePassenger(PassengerDTO passengerDTO) {
        log.info("Добавление нового пассажира: {} {}", passengerDTO.getName(), passengerDTO.getSurname());

        Passenger passenger = new Passenger();
        passenger.setUser(passengerDTO.getUser());
        passenger.setName(passengerDTO.getName());
        passenger.setSurname(passengerDTO.getSurname());
        passenger.setPassportNumber(passengerDTO.getPassportNumber());
        passenger.setDateOfBirth(passengerDTO.getDateOfBirth());
        passenger.setPhoneNumber(passengerDTO.getPhoneNumber());
        passenger.setHasDisability(passengerDTO.isHasDisability());
        passenger.setStudent(passengerDTO.isStudent());
        passenger.setBalance(passengerDTO.getBalance());

        passengerRepository.save(passenger);
        log.info("Пассажир {} {} успешно добавлен", passengerDTO.getName(), passengerDTO.getSurname());
    }

    public boolean deletePassenger(Long passengerId) {
        Optional<Passenger> passengerOptional = passengerRepository.findById(passengerId);
        if (passengerOptional.isPresent()) {
            passengerRepository.delete(passengerOptional.get());
            return true;
        }
        return false;
    }

    public boolean updatePassenger(Long passengerId, PassengerDTO passengerDTO) {
        try {
            Passenger passenger = passengerRepository.findById(passengerId)
                    .orElseThrow(() -> new EntityNotFoundException("Пассажир не найден"));

            // Обновляем только изменяемые поля
            passenger.setName(passengerDTO.getName());
            passenger.setSurname(passengerDTO.getSurname());
            passenger.setPassportNumber(passengerDTO.getPassportNumber());
            passenger.setDateOfBirth(passengerDTO.getDateOfBirth());
            passenger.setPhoneNumber(passengerDTO.getPhoneNumber());
            passenger.setHasDisability(passengerDTO.isHasDisability());
            passenger.setStudent(passengerDTO.isStudent());

            passengerRepository.save(passenger);
            return true;
        } catch (Exception e) {
            log.error("Ошибка при обновлении пассажира", e);
            return false;
        }
    }


    public List<Passenger> getAllPassengers() {
        log.info("Получение списка всех пассажиров");
        return passengerRepository.findAll();
    }

    public PassengerDTO getPassenger(Long passengerId) {
        Optional<Passenger> passengerOptional = passengerRepository.findById(passengerId);
        if (passengerOptional.isPresent()) {
            Passenger passenger = passengerOptional.get();
            PassengerDTO passengerDTO = new PassengerDTO();
            // Устанавливаем ID
            passengerDTO.setId(passenger.getId());
            passengerDTO.setUser(passenger.getUser());
            passengerDTO.setName(passenger.getName());
            passengerDTO.setSurname(passenger.getSurname());
            passengerDTO.setPassportNumber(passenger.getPassportNumber());
            passengerDTO.setDateOfBirth(passenger.getDateOfBirth());
            passengerDTO.setPhoneNumber(passenger.getPhoneNumber());
            passengerDTO.setHasDisability(passenger.isHasDisability());
            passengerDTO.setStudent(passenger.isStudent());
            passengerDTO.setBalance(passenger.getBalance());
            return passengerDTO;
        }
        throw new IllegalArgumentException("Пассажир с таким ID не найден");
    }
}
