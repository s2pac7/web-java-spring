package org.airport.webjavaspring.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.UserDTO;
import org.airport.webjavaspring.model.Role;
import org.airport.webjavaspring.model.User;
import org.airport.webjavaspring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
public class UserServiceCDRUD {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceCDRUD(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void saveUser(UserDTO userDTO) {
        log.info("Добавление нового пользователя: {}", userDTO.getUsername());

        // Преобразуем DTO в сущность User
        User user = new User();
        user.setUsername(userDTO.getUsername());

        // Шифруем пароль перед сохранением
        String encodedPassword = passwordEncoder.encode(userDTO.getPassword());
        user.setPassword(encodedPassword);

        // Присваиваем роль
        user.setRole(Role.USER);

        // Сохраняем пользователя в базе данных
        userRepository.save(user);
        log.info("Пользователь {} успешно добавлен", userDTO.getUsername());
    }

    public boolean deleteUser(Long userId) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            userRepository.delete(userOptional.get());
            return true;
        }
        return false;
    }

    public boolean updateUser(Long userId, UserDTO userDTO) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setUsername(userDTO.getUsername());
            user.setRole(userDTO.getRole());
            userRepository.save(user);
            return true;
        }
        return false;
    }
}
