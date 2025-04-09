package org.airport.webjavaspring.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.airport.webjavaspring.dto.UserDTO;
import org.airport.webjavaspring.service.impl.UserServiceCDRUD;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/users")
@RequiredArgsConstructor
public class AdminUserController {

    private final UserServiceCDRUD userServiceCDRUD;

    @PostMapping("/add")
    @ResponseBody  // Возвращаем JSON
    public ResponseEntity<Map<String, String>> addUser(@RequestBody UserDTO userDTO) {
        Map<String, String> response = new HashMap<>();
        try {
            if (userDTO.getUsername() == null || userDTO.getUsername().isEmpty()) {
                log.warn("Попытка добавить пользователя с пустым именем: {}", userDTO);
                response.put("success", "false");
                response.put("message", "Имя пользователя не может быть пустым");
                return ResponseEntity.badRequest().body(response);
            }

            log.info("Добавление пользователя: {}", userDTO.getUsername());
            userServiceCDRUD.saveUser(userDTO);  // Сохраняем пользователя
            response.put("success", "true");
            response.put("message", "Пользователь успешно добавлен");
            log.info("Пользователь успешно добавлен: {}", userDTO.getUsername());
            return ResponseEntity.ok(response);  // Отправляем успешный ответ
        } catch (Exception e) {
            log.error("Ошибка при добавлении пользователя: {}", userDTO.getUsername(), e);
            response.put("success", "false");
            response.put("message", "Произошла ошибка при добавлении пользователя");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @DeleteMapping("/delete/{userId}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteUser(@PathVariable Long userId) {
        Map<String, String> response = new HashMap<>();
        try {
            log.info("Попытка удаления пользователя с ID: {}", userId);
            boolean deleted = userServiceCDRUD.deleteUser(userId);  // Удаляем пользователя по ID
            if (deleted) {
                response.put("success", "true");
                response.put("message", "Пользователь успешно удален");
                log.info("Пользователь с ID: {} успешно удален", userId);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", "false");
                response.put("message", "Пользователь не найден");
                log.warn("Пользователь с ID: {} не найден для удаления", userId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при удалении пользователя с ID: {}", userId, e);
            response.put("success", "false");
            response.put("message", "Произошла ошибка при удалении пользователя");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PutMapping("/edit/{userId}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> editUser(@PathVariable Long userId, @RequestBody UserDTO userDTO) {
        Map<String, String> response = new HashMap<>();
        try {
            log.info("Попытка редактирования пользователя с ID: {}", userId);
            boolean updated = userServiceCDRUD.updateUser(userId, userDTO);  // Обновляем данные пользователя
            if (updated) {
                response.put("success", "true");
                response.put("message", "Пользователь успешно обновлен");
                log.info("Пользователь с ID: {} успешно обновлен", userId);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", "false");
                response.put("message", "Пользователь не найден");
                log.warn("Пользователь с ID: {} не найден для редактирования", userId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            log.error("Ошибка при редактировании пользователя с ID: {}", userId, e);
            response.put("success", "false");
            response.put("message", "Произошла ошибка при редактировании пользователя");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

}
