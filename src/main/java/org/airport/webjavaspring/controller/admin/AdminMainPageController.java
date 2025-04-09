package org.airport.webjavaspring.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.AircraftDTO;
import org.airport.webjavaspring.dto.PassengerDTO;
import org.airport.webjavaspring.dto.UserDTO;
import org.airport.webjavaspring.service.UserService;
import org.airport.webjavaspring.service.impl.AircraftServiceCRUD;
import org.airport.webjavaspring.service.impl.PassengerServiceCRUD;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminMainPageController {

    private final UserService userService;
    private final PassengerServiceCRUD passengerServiceCRUD;
    private final AircraftServiceCRUD aircraftServiceCRUD;

    @GetMapping("/users")
    public String showUsersPage(Model model) {
        log.info("Запрос на страницу управления пользователями.");
        try {
            List<UserDTO> userDTOs = userService.getAllUsers().stream()
                    .map(UserDTO::fromEntity)
                    .collect(Collectors.toList());
            log.info("Количество пользователей: {}", userDTOs.size());
            model.addAttribute("users", userDTOs); // Передаем данные в модель
            return "users"; // Возвращаем имя шаблона
        } catch (Exception e) {
            log.error("Ошибка при загрузке пользователей: {}", e.getMessage());
            return "error"; // Страница ошибки, если что-то пошло не так
        }
    }

    @GetMapping("/passengers")
    public String showPassengersPage(Model model) {
        log.info("Запрос на страницу управления пассажирами.");
        try {
            List<PassengerDTO> passengerDTOs = passengerServiceCRUD.getAllPassengers().stream()
                    .map(PassengerDTO::fromEntity)
                    .collect(Collectors.toList());
            log.info("Количество пассажиров: {}", passengerDTOs.size());
            model.addAttribute("passengers", passengerDTOs); // Передаем данные в модель
            return "passengers"; // Возвращаем имя шаблона
        } catch (Exception e) {
            log.error("Ошибка при загрузке пассажиров: {}", e.getMessage());
            return "error"; // Страница ошибки, если что-то пошло не так
        }
    }

    @GetMapping("/aircrafts")
    public String showAircraftsPage(Model model) {
        log.info("Запрос на страницу управления самолетами.");
        try {
            List<AircraftDTO> aircraftDTOs = aircraftServiceCRUD.getAllAircraft().stream()
                    .map(aircraft -> {
                        AircraftDTO dto = new AircraftDTO();
                        dto.setId(aircraft.getId());
                        dto.setNameAircraft(aircraft.getNameAircraft());
                        dto.setTypeAircraft(aircraft.getTypeAircraft());
                        return dto;
                    })
                    .collect(Collectors.toList());

            log.info("Количество самолетов: {}", aircraftDTOs.size());
            model.addAttribute("aircrafts", aircraftDTOs);
            return "aircrafts";
        } catch (Exception e) {
            log.error("Ошибка при загрузке самолетов: {}", e.getMessage(), e);
            return "error";
        }
    }

    @GetMapping("/admin-profile")
    public String showProfilePage() {
        return "admin-profile";
    }


}
