<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>О нас</title>
    <link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/about.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">✈ Аэропорт</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Главная</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/board">Реклама</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/about">О нас</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/signin">Вход</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    <div class="about-container">
        <h1>Добро пожаловать в наш аэропорт!</h1>
        <p>Мы — крупнейший транспортный хаб, объединяющий людей и города. Наш аэропорт славится высоким уровнем сервиса,
            надежностью и удобством для пассажиров.</p>
        <p>Каждый год мы обслуживаем миллионы пассажиров, обеспечивая комфортные рейсы, современные залы ожидания и первоклассный сервис.</p>
        <p>У нас работают лучшие специалисты, которые делают всё, чтобы ваш полет был безопасным, приятным и незабываемым!</p>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>