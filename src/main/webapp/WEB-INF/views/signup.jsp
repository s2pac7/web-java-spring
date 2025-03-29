<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Регистрация</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
</head>
<body>
<div class="auth-container">
  <div class="auth-card">
    <h2 class="auth-title">Регистрация</h2>

    <form id="registerForm" class="auth-form">
      <div class="form-group">
        <input type="text" id="username" placeholder="Логин" required>
      </div>
      <div class="form-group">
        <input type="password" id="password" placeholder="Пароль" required>
      </div>
      <div class="form-row">
        <div class="form-group half-width">
          <input type="text" id="name" placeholder="Имя" required>
        </div>
        <div class="form-group half-width">
          <input type="text" id="surname" placeholder="Фамилия" required>
        </div>
      </div>
      <div class="form-group">
        <input type="text" id="passportNumber" placeholder="Паспортные данные" required>
      </div>
      <div class="form-group">
        <label for="dateOfBirth">Дата рождения</label>
        <input type="date" id="dateOfBirth" required>
      </div>
      <div class="form-group">
        <input type="tel" id="phoneNumber" placeholder="Номер телефона" required>
      </div>

      <div class="radio-group">
        <span class="radio-label">Инвалидность:</span>
        <label class="radio-option">
          <input type="radio" name="has_disability" value="true">
          <span>Да</span>
        </label>
        <label class="radio-option">
          <input type="radio" name="has_disability" value="false" checked>
          <span>Нет</span>
        </label>
      </div>

      <div class="radio-group">
        <span class="radio-label">Студент:</span>
        <label class="radio-option">
          <input type="radio" name="is_student" value="true">
          <span>Да</span>
        </label>
        <label class="radio-option">
          <input type="radio" name="is_student" value="false" checked>
          <span>Нет</span>
        </label>
      </div>

      <button type="button" class="auth-button" onclick="signup()">Зарегистрироваться</button>
    </form>

    <div class="auth-footer">
      Уже есть аккаунт? <a href="/signin" class="auth-link">Войти</a>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/signup.js"></script>
</body>
</html>