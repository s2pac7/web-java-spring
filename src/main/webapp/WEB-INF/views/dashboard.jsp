<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Личный кабинет</title>
  <script>
    function checkAuth() {
      let token = localStorage.getItem("jwtToken");
      if (!token) {
        alert("Вы не авторизованы!");
        window.location.href = "/signin"; // ✅ Переход через контроллер
      }
    }

    function logout() {
      localStorage.removeItem("jwtToken");
      sessionStorage.removeItem("jwtToken"); // ✅ Очистка sessionStorage
      alert("Вы вышли из системы");
      window.location.href = "/signin";
    }

    window.onload = checkAuth;

    // ✅ Очистка токена при закрытии страницы
    window.addEventListener("beforeunload", function () {
      localStorage.removeItem("jwtToken");
      sessionStorage.removeItem("jwtToken");
    });
  </script>
</head>
<body>
<h2>Добро пожаловать в личный кабинет!</h2>
<button onclick="logout()">Выйти</button>
</body>
</html>
