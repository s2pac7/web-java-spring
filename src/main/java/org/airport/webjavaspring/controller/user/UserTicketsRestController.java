package org.airport.webjavaspring.controller.user;

import lombok.RequiredArgsConstructor;
import org.airport.webjavaspring.dto.MyTicketsDTO;
import org.airport.webjavaspring.service.impl.TicketService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class TicketRestController {
    private final TicketService ticketService;

    @GetMapping("/tickets")
    public ResponseEntity<List<MyTicketsDTO>> getMyTickets(@RequestHeader("Authorization") String token) {
        List<MyTicketsDTO> tickets = ticketService.getMyTickets(token);
        return ResponseEntity.ok(tickets);
    }
}

