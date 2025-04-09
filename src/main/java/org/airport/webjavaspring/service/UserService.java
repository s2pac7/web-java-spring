package org.airport.webjavaspring.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.UserDTO;
import org.airport.webjavaspring.dto.UserProfileDTO;
import org.airport.webjavaspring.model.Role;
import org.airport.webjavaspring.model.User;
import org.airport.webjavaspring.repository.UserRepository;
import org.airport.webjavaspring.service.impl.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("Загрузка пользователя с именем: {}", username);
        try {
            User user = findUserByUsername(username);
            log.info("Пользователь найден: {}", user.getUsername());
            return UserDetailsImpl.build(user);
        } catch (UsernameNotFoundException e) {
            log.error("Пользователь с именем {} не найден", username);
            throw e;
        }
    }

    public User findUserByUsername(String username) {
        log.info("Поиск пользователя по имени: {}", username);
        return userRepository.findUserByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(
                        String.format("User %s not found", username)
                ));
    }

    public List<User> getAllUsers() {
        log.info("Получение списка всех пользователей.");
        List<User> users = userRepository.findAll();
        log.info("Найдено {} пользователей.", users.size());
        return users;
    }

    public String getUsernameFromToken(String token) {
        // Логика для извлечения username из токена
        // Например, если токен JWT, то его можно распарсить
        // и извлечь username.

        // Это пример для JWT:
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey("secret") // ваш секретный ключ
                    .parseClaimsJws(token)
                    .getBody();

            return claims.getSubject();  // username в поле subject
        } catch (Exception e) {
            return null;
        }
    }
}
