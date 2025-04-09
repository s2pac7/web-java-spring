package org.airport.webjavaspring.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.AircraftDTO;
import org.airport.webjavaspring.model.Aircraft;
import org.airport.webjavaspring.repository.AircraftRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class AircraftServiceCRUD {

    private final AircraftRepository aircraftRepository;

    @Autowired
    public AircraftServiceCRUD(AircraftRepository aircraftRepository) {
        this.aircraftRepository = aircraftRepository;
    }

    public void saveAircraft(AircraftDTO dto) {
        log.info("Сохранение нового самолета: {}", dto.getNameAircraft());
        Aircraft aircraft = new Aircraft();
        aircraft.setNameAircraft(dto.getNameAircraft());
        aircraft.setTypeAircraft(dto.getTypeAircraft());

        aircraftRepository.save(aircraft);
        log.info("Самолет успешно сохранен: {}", dto.getNameAircraft());
    }

    public boolean deleteAircraft(Long id) {
        Optional<Aircraft> optional = aircraftRepository.findById(id);
        if (optional.isPresent()) {
            aircraftRepository.delete(optional.get());
            log.info("Самолет с ID {} удалён", id);
            return true;
        }
        return false;
    }

    public boolean updateAircraft(Long id, AircraftDTO dto) {
        try {
            Aircraft aircraft = aircraftRepository.findById(id)
                    .orElseThrow(() -> new EntityNotFoundException("Самолет не найден"));

            aircraft.setNameAircraft(dto.getNameAircraft());
            aircraft.setTypeAircraft(dto.getTypeAircraft());

            aircraftRepository.save(aircraft);
            log.info("Самолет с ID {} обновлен", id);
            return true;
        } catch (Exception e) {
            log.error("Ошибка при обновлении самолета", e);
            return false;
        }
    }

    public List<Aircraft> getAllAircraft() {
        log.info("Получение всех самолетов");
        return aircraftRepository.findAll();
    }

    public AircraftDTO getAircraft(Long id) {
        return aircraftRepository.findById(id)
                .map(aircraft -> {
                    AircraftDTO dto = new AircraftDTO();
                    dto.setId(aircraft.getId());
                    dto.setNameAircraft(aircraft.getNameAircraft());
                    dto.setTypeAircraft(aircraft.getTypeAircraft());
                    return dto;
                })
                .orElseThrow(() -> new IllegalArgumentException("Самолет с ID " + id + " не найден"));
    }
}
