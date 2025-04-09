// ReportFlightService.java
package org.airport.webjavaspring.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.repository.FlightRepository;
import org.springframework.stereotype.Service;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReportFlightService {

    private final FlightRepository flightRepository;

    public Map<String, Object> generateFlightReport() {
        Map<String, Object> report = new HashMap<>();

        try {
            Double maxPrice = flightRepository.findMaxPrice();
            Double minPrice = flightRepository.findMinPrice();
            Double avgPrice = flightRepository.findAvgPrice();
            Long arrivalsCount = flightRepository.countArrivalsToAviasales();

            report.put("maxPrice", formatValue(maxPrice));
            report.put("minPrice", formatValue(minPrice));
            report.put("avgPrice", formatValue(avgPrice));
            report.put("arrivalsCount", arrivalsCount);
            report.put("success", true);

        } catch (Exception e) {
            report.put("success", false);
            report.put("error", "Ошибка генерации отчета: " + e.getMessage());
            log.error("Report generation failed", e);
        }

        return report;
    }

    private Double formatValue(Double value) {
        return Optional.ofNullable(value)
                .map(v -> Math.round(v * 100.0) / 100.0)
                .orElse(0.0);
    }
}