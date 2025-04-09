package org.airport.webjavaspring.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.PassengerDTO;
import org.airport.webjavaspring.service.impl.PassengerServiceCRUD;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/passengers")
@RequiredArgsConstructor
public class AdminPassengerController {

    private final PassengerServiceCRUD passengerServiceCRUD;

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, String>> addPassenger(@RequestBody PassengerDTO passengerDTO) {
        Map<String, String> response = new HashMap<>();
        try {
            if (passengerDTO.getName() == null || passengerDTO.getName().isEmpty()) {
                response.put("success", "false");
                response.put("message", "Имя пассажира не может быть пустым");
                return ResponseEntity.badRequest().body(response);
            }

            passengerServiceCRUD.savePassenger(passengerDTO);
            response.put("success", "true");
            response.put("message", "Пассажир успешно добавлен");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Ошибка при добавлении пассажира: {} {}", passengerDTO.getName(), passengerDTO.getSurname(), e);
            response.put("success", "false");
            response.put("message", "Произошла ошибка при добавлении пассажира");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @DeleteMapping("/delete/{passengerId}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deletePassenger(@PathVariable Long passengerId) {
        Map<String, String> response = new HashMap<>();
        try {
            boolean deleted = passengerServiceCRUD.deletePassenger(passengerId);
            if (deleted) {
                response.put("success", "true");
                response.put("message", "Пассажир успешно удален");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", "false");
                response.put("message", "Пассажир не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при удалении пассажира с ID: {}", passengerId, e);
            response.put("success", "false");
            response.put("message", "Произошла ошибка при удалении пассажира");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/edit/{passengerId}")
    @ResponseBody
    public ResponseEntity<?> getPassenger(@PathVariable Long passengerId) {
        try {
            PassengerDTO passenger = passengerServiceCRUD.getPassenger(passengerId);
            if (passenger == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("success", false, "message", "Пассажир не найден"));
            }

            // Убедимся, что ID установлен
            if (passenger.getId() == null) {
                passenger.setId(passengerId);
            }

            return ResponseEntity.ok(passenger);
        } catch (Exception e) {
            log.error("Ошибка при получении пассажира с ID: {}", passengerId, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "Ошибка сервера"));
        }
    }

    @PutMapping("/edit/{passengerId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editPassenger(
            @PathVariable Long passengerId,
            @RequestBody PassengerDTO passengerDTO) {

        Map<String, Object> response = new HashMap<>();
        try {
            // Устанавливаем ID из URL, если в DTO он не установлен
            if (passengerDTO.getId() == null) {
                passengerDTO.setId(passengerId);
            }

            boolean updated = passengerServiceCRUD.updatePassenger(passengerId, passengerDTO);
            if (updated) {
                response.put("success", true);
                response.put("message", "Пассажир успешно обновлен");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Пассажир не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при обновлении пассажира с ID: {}", passengerId, e);
            response.put("success", false);
            response.put("message", "Ошибка сервера при обновлении");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

}
