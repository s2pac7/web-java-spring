package org.airport.webjavaspring.controller.general;

import org.airport.webjavaspring.dto.PasswordChangeRequest;
import org.airport.webjavaspring.dto.UserProfileDTO;
import org.airport.webjavaspring.service.impl.UserProfileService;
import org.airport.webjavaspring.util.JWTCore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@CrossOrigin(origins = "http://localhost:8080")
@RestController
@RequestMapping("/api/user")
public class MyAdminProfileController {

    @Autowired
    private JWTCore jwtCore;

    @Autowired
    private UserProfileService userProfileService;

    @GetMapping("/profile")
    public ResponseEntity<UserProfileDTO> getProfile(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.replace("Bearer ", "").trim();
        String username = jwtCore.getNameFromJwt(token);

        if (username == null) {
            return ResponseEntity.status(401).build();
        }

        UserProfileDTO profile = userProfileService.getUserProfile(username);
        return ResponseEntity.ok(profile);
    }

    @PutMapping("/profile")
    public ResponseEntity<?> updateProfile(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody UserProfileDTO updatedProfile
    ) {
        String token = authHeader.replace("Bearer ", "").trim();
        String username = jwtCore.getNameFromJwt(token);

        if (username == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        try {
            UserProfileDTO updated = userProfileService.updateProfile(username, updatedProfile);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody PasswordChangeRequest request
    ) {
        String token = authHeader.replace("Bearer ", "").trim();
        String username = jwtCore.getNameFromJwt(token);

        if (username == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        try {
            userProfileService.changePassword(username, request);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/top-up")
    public ResponseEntity<?> topUpBalance(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody BigDecimal amount
    ) {
        String token = authHeader.replace("Bearer ", "").trim();
        String username = jwtCore.getNameFromJwt(token);

        if (username == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        try {
            userProfileService.topUpBalance(username, amount);
            return ResponseEntity.ok("Баланс успешно пополнен");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }



}