<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход в систему | Аэропорт</title>
    <link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/auth.js" defer></script>
    <style>
        body {
            padding-top: 70px; /* Уменьшенный отступ для навигации */
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        main {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 40px 0;
        }
        .login-container {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<!-- Навигационная панель -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">✈ Аэропорт</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Главная</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/board">Онлайн-табло</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">О нас</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/signin">Вход</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Форма входа -->
<main class="container">
    <div class="login-container">
        <h2 class="login-title mb-4">Вход в систему</h2>
        <div class="mb-3">
            <input type="text" id="username" class="form-control" placeholder="Введите логин" required>
        </div>
        <div class="mb-3">
            <input type="password" id="password" class="form-control" placeholder="Введите пароль" required>
        </div>
        <button id="login-btn" class="btn btn-primary w-100 py-2 mb-3">Войти</button>
        <p class="text-center">Нет аккаунта? <a href="/signup" class="register-link">Зарегистрироваться</a></p>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>