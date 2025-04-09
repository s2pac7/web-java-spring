<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Онлайн-табло</title>
    <link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #003366;
            --secondary-color: #FFA500;
            --bg-color: #e6f2ff;
            --card-bg: #ffffff;
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .navbar-nav .nav-link.active {
            background-color: var(--secondary-color);
            border-radius: 5px;
            color: white !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
        }

        .board-container {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2.5rem;
            margin: 2rem auto;
            max-width: 1200px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .board-header {
            margin-bottom: 2.5rem;
            text-align: center;
        }

        .board-header h1 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .board-header p {
            color: #6c757d;
            font-size: 1.1rem;
        }

        .video-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
            margin: 2.5rem 0;
        }

        .video-container {
            flex: 1;
            min-width: 300px;
            max-width: 480px;
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .video-container:hover {
            transform: translateY(-5px);
        }

        .tiktok-embed {
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
        }

        .footer-text {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .video-row {
                flex-direction: column;
                align-items: center;
                gap: 1.5rem;
            }

            .video-container {
                width: 100%;
                max-width: 100%;
            }

            .board-container {
                padding: 1.5rem;
                margin: 1rem;
            }
        }
    </style>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/board">Реклама</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">О нас</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/signin">Вход</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    <div class="board-container">
        <div class="board-header">
            <h1>Интересные видео от нас</h1>
        </div>

        <div class="video-row">
            <!-- Первое видео -->
            <div class="video-container">
                <blockquote class="tiktok-embed" cite="https://www.tiktok.com/@aviasales/video/7467551545404558600"
                            data-video-id="7467551545404558600">
                    <section>
                        <a target="_blank" title="@aviasales" href="https://www.tiktok.com/@aviasales">@aviasales</a>
                        <p>Авиасейлс показывает интересный контент ✈️</p>
                        <a target="_blank" title="♬ оригинальный звук - Aviasales"
                           href="https://www.tiktok.com/music/original-sound-7467551593588861702">♬ оригинальный звук - Aviasales</a>
                    </section>
                </blockquote>
            </div>

            <!-- Второе видео -->
            <div class="video-container">
                <blockquote class="tiktok-embed" cite="https://www.tiktok.com/@aviasales/video/7489956303855439112"
                            data-video-id="7489956303855439112">
                    <section>
                        <a target="_blank" title="@aviasales" href="https://www.tiktok.com/@aviasales">@aviasales</a>
                        <p>Еще один интересный ролик от Aviasales</p>
                        <a target="_blank" title="♬ оригинальный звук - Aviasales"
                           href="https://www.tiktok.com/music/original-sound-7489956303855439112">♬ оригинальный звук - Aviasales</a>
                    </section>
                </blockquote>
            </div>
        </div>

        <p class="footer-text text-center">Следите за нами в TikTok для получения интересного контента об авиаперелётах!</p>
    </div>
</main>

<script async src="https://www.tiktok.com/embed.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>