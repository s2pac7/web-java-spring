package org.airport.webjavaspring.controller.user;

import org.airport.webjavaspring.service.UserService;
import org.airport.webjavaspring.util.JWTCore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "http://localhost:8080") // или "*" для всех доменов
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JWTCore jwtCore;

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.replace("Bearer ", "").trim();
        String username = jwtCore.getNameFromJwt(token);

        if (username != null) {
            return ResponseEntity.ok(Map.of("username", username));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid token");
        }
    }
}