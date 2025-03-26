<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет</title>
    <link href="${pageContext.request.contextPath}/css/user.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            height: 100vh;
            background-color: #f5f5f5;
            color: #333;
        }
        .sidebar {
            width: 250px;
            background-color: #003366;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px;
            display: block;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background-color: #FFA500;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Меню</h2>
    <a href="#profile">Профиль</a>
    <a href="#flights">Мои рейсы</a>
    <a href="#settings">Настройки</a>
    <a href="#logout">Выход</a>
</div>
<div class="main-content">
    <h1>Добро пожаловать, ${username != null ? username : "Гость"}!</h1>
    <p>Выберите раздел в меню слева.</p>
</div>
</body>
</html>
