package org.airport.webjavaspring.controller.general;

import org.airport.webjavaspring.model.Role;
import org.airport.webjavaspring.util.JWTCore;
import org.airport.webjavaspring.dto.SigninRequest;
import org.airport.webjavaspring.dto.SignupRequest;
import org.airport.webjavaspring.repository.UserRepository;
import org.airport.webjavaspring.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.HashMap;

import static com.fasterxml.jackson.databind.type.LogicalType.Map;

@RestController
@RequestMapping("/auth")
public class SecurityController {

    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private AuthenticationManager authenticationManager;
    private JWTCore jwtCore;

    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Autowired
    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Autowired
    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

    @Autowired
    public void setJWTCore(JWTCore jwtCore) {
        this.jwtCore = jwtCore;
    }

    @PostMapping("/signup")
    ResponseEntity<?> signup(@RequestBody SignupRequest signupRequest) {
        if(userRepository.existsUserByUsername(signupRequest.getUsername())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username already exists");
        }

        User user = new User();
        user.setUsername(signupRequest.getUsername());
        user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
        user.setRole(Role.USER);
        userRepository.save(user);
        return ResponseEntity.ok("User created");
    }


    @PostMapping("/signin")
    ResponseEntity<?> signin(@RequestBody SigninRequest signinRequest) {
        Authentication authentication;
        try {
            authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(signinRequest.getUsername(), signinRequest.getPassword())
            );
        } catch (BadCredentialsException e) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtCore.generateToken(authentication);

        // Получаем пользователя
        User user = userRepository.findUserByUsername(signinRequest.getUsername()).orElse(null);
        if (user == null) {
            return new ResponseEntity<>("Пользователь не найден", HttpStatus.NOT_FOUND);
        }

        // Определяем путь в зависимости от роли
        String redirectUrl = user.getRole() == Role.ADMIN ? "/admin/admin-dashboard" : "/user/user-dashboard";

        // Возвращаем токен и URL для редиректа
        Map<String, String> response = new HashMap<String, String>(); // <-- Явно указываем типы
        response.put("token", jwt);
        response.put("redirectUrl", redirectUrl);

        return ResponseEntity.ok(response);
    }


}
