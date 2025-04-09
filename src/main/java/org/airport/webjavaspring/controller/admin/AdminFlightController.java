package org.airport.webjavaspring.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.AircraftDTO;
import org.airport.webjavaspring.dto.FlightDTO;
import org.airport.webjavaspring.model.Flight;
import org.airport.webjavaspring.repository.FlightRepository;
import org.airport.webjavaspring.service.impl.FlightServiceCRUD;
import org.airport.webjavaspring.service.impl.ReportFlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.NumberFormat;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/admin/flights")
@RequiredArgsConstructor
public class AdminFlightController {

    private final FlightServiceCRUD flightServiceCRUD;
    private final ReportFlightService reportFlightService;

    @GetMapping
    public String showFlightsPage(Model model) {
        List<FlightDTO> flights = flightServiceCRUD.getAllFlights().stream()
                .map(FlightDTO::fromEntity)
                .collect(Collectors.toList());
        model.addAttribute("flights", flights);
        return "flights";
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, String>> addFlight(@RequestBody FlightDTO dto) {
        Map<String, String> response = new HashMap<>();
        try {
            flightServiceCRUD.saveFlight(dto);
            response.put("success", "true");
            response.put("message", "Рейс добавлен");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Ошибка при добавлении рейса", e);
            response.put("success", "false");
            response.put("message", "Ошибка при добавлении рейса");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteFlight(@PathVariable Long id) {
        Map<String, String> response = new HashMap<>();
        try {
            boolean deleted = flightServiceCRUD.deleteFlight(id);
            if (deleted) {
                response.put("success", "true");
                response.put("message", "Рейс удален");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", "false");
                response.put("message", "Рейс не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при удалении рейса", e);
            response.put("success", "false");
            response.put("message", "Ошибка при удалении рейса");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/edit/{id}")
    @ResponseBody
    public ResponseEntity<?> getFlight(@PathVariable Long id) {
        try {
            FlightDTO dto = flightServiceCRUD.getFlight(id);
            return ResponseEntity.ok(dto);
        } catch (Exception e) {
            log.error("Ошибка при получении рейса", e);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("success", false, "message", "Рейс не найден"));
        }
    }

    @PutMapping("/edit/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editFlight(
            @PathVariable Long id,
            @RequestBody FlightDTO dto) {

        Map<String, Object> response = new HashMap<>();
        try {
            if (dto.getId() == null) {
                dto.setId(id);
            }

            boolean updated = flightServiceCRUD.updateFlight(id, dto);
            if (updated) {
                response.put("success", true);
                response.put("message", "Рейс обновлен");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Рейс не найден");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при обновлении рейса", e);
            response.put("success", false);
            response.put("message", "Ошибка сервера");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/report")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> generateReport() {
        Map<String, Object> report = reportFlightService.generateFlightReport();
        report.put("reportDate", new Date());
        log.info("Generated report: {}", report);
        return ResponseEntity.ok(report);
    }
}
