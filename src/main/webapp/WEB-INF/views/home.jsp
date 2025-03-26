<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Аэропорт</title>
    <link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .content-wrapper {
            display: flex;
            align-items: center;
            min-height: 70vh;
            padding: 40px 0;
        }
        .text-section {
            flex: 1;
            padding-right: 40px;
            text-align: center;
        }
        .image-section {
            flex: 1;
            text-align: center;
        }
        .image-section img {
            max-width: 80%;
            max-height: 400px; /* Уменьшенная высота картинки */
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }
        .image-section img:hover {
            transform: scale(1.03);
        }

        /* Анимация текста */
        .welcome-title {
            font-size: 2.5rem;
            margin-bottom: 20px;
            background: linear-gradient(90deg, #003366, #FFA500, #003366);
            background-size: 200% auto;
            color: transparent;
            -webkit-background-clip: text;
            background-clip: text;
            animation: shine 3s linear infinite;
        }
        @keyframes shine {
            0% { background-position: 0% center; }
            100% { background-position: 200% center; }
        }

        .welcome-text {
            font-size: 1.2rem;
            position: relative;
            display: inline-block;
        }
        .welcome-text::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: -5px;
            left: 0;
            background: linear-gradient(90deg, transparent, #FFA500, transparent);
            animation: underline 2s infinite;
        }
        @keyframes underline {
            0%, 100% { transform: scaleX(0); }
            50% { transform: scaleX(1); }
        }

        @media (max-width: 768px) {
            .content-wrapper {
                flex-direction: column;
            }
            .text-section {
                padding-right: 0;
                margin-bottom: 30px;
            }
            .image-section img {
                max-height: 300px;
            }
        }
    </style>
</head>
<body>

<!-- Навигационная панель -->
<nav class="navbar navbar-expand-lg navbar-dark">
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/signin">Вход</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    <div class="content-wrapper">
        <div class="text-section">
            <h1 class="welcome-title">Добро пожаловать, ${username != null ? username : "Гость"}!</h1>
            <p class="welcome-text">Выберите действие в меню сверху.</p>
        </div>
        <div class="image-section">
            <img src="${pageContext.request.contextPath}/images/cat.png" alt="Кот в аэропорту">
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>