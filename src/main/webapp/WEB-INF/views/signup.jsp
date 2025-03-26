<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Регистрация</title>
  <script>
    async function signup() {
      let username = document.getElementById("username").value;
      let password = document.getElementById("password").value;

      let response = await fetch('/auth/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, password })
      });

      let result = await response.text();
      alert(result);
      if (response.ok) {
        window.location.href = "/signin"; // ✅ Переход через контроллер
      }
    }
  </script>
</head>
<body>
<h2>Регистрация</h2>
<input type="text" id="username" placeholder="Введите логин" required><br>
<input type="password" id="password" placeholder="Введите пароль" required><br>
<button onclick="signup()">Зарегистрироваться</button>
<p>Уже есть аккаунт? <a href="/signin">Войти</a></p> <!-- ✅ Исправлено -->
</body>
</html>
