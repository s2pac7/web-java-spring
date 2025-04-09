package org.airport.webjavaspring.controller.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.service.UserService;
import org.airport.webjavaspring.service.impl.AircraftServiceCRUD;
import org.airport.webjavaspring.service.impl.PassengerServiceCRUD;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserMainPageController {
    private final UserService userService;
    private final PassengerServiceCRUD passengerServiceCRUD;
    private final AircraftServiceCRUD aircraftServiceCRUD;

    @GetMapping("/profile")
    public String showProfilePage() {
        return "profile";
    }
}
