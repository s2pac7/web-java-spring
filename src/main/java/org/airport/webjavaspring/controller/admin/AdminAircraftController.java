package org.airport.webjavaspring.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.AircraftDTO;
import org.airport.webjavaspring.model.Aircraft;
import org.airport.webjavaspring.service.impl.AircraftServiceCRUD;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/aircrafts")
@RequiredArgsConstructor
public class AdminAircraftController {

    private final AircraftServiceCRUD aircraftService;

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addAircraft(@RequestBody AircraftDTO dto) {
        Map<String, Object> response = new HashMap<>();
        try {
            aircraftService.saveAircraft(dto);
            response.put("success", true);
            response.put("message", "Самолет успешно добавлен");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Ошибка при добавлении самолета", e);
            response.put("success", false);
            response.put("message", "Ошибка при добавлении самолета");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteAircraft(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean deleted = aircraftService.deleteAircraft(id);
            if (deleted) {
                response.put("success", true);
                response.put("message", "Самолет удалён");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Самолет не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при удалении самолета", e);
            response.put("success", false);
            response.put("message", "Ошибка сервера");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/edit/{id}")
    @ResponseBody
    public ResponseEntity<?> getAircraft(@PathVariable Long id) {
        try {
            AircraftDTO dto = aircraftService.getAircraft(id);
            if (dto.getId() == null) {
                dto.setId(id);
            }
            return ResponseEntity.ok(dto);
        } catch (Exception e) {
            log.error("Ошибка при получении самолета", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "Ошибка сервера"));
        }
    }

    @PutMapping("/edit/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editAircraft(@PathVariable Long id, @RequestBody AircraftDTO dto) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (dto.getId() == null) {
                dto.setId(id);
            }

            boolean updated = aircraftService.updateAircraft(id, dto);
            if (updated) {
                response.put("success", true);
                response.put("message", "Самолет обновлён");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Самолет не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при редактировании самолета", e);
            response.put("success", false);
            response.put("message", "Ошибка при редактировании");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<List<AircraftDTO>> getAllAircrafts() {
        List<Aircraft> aircraftList = aircraftService.getAllAircraft();
        List<AircraftDTO> dtos = aircraftList.stream().map(aircraft -> {
            AircraftDTO dto = new AircraftDTO();
            dto.setId(aircraft.getId());
            dto.setNameAircraft(aircraft.getNameAircraft());
            dto.setTypeAircraft(aircraft.getTypeAircraft());
            return dto;
        }).toList();

        return ResponseEntity.ok(dtos);
    }


}
