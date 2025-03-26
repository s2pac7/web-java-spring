<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Онлайн-табло</title>
    <link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/board.css" rel="stylesheet">
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/board">Онлайн-табло</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">О нас</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/signin">Вход</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    <div class="board-container text-center">
        <h1>Онлайн-табло</h1>
        <p>Тут будет расписание рейсов.</p>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>