<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мой профиль | Аэропорт</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="app-container">
    <!-- Боковая навигация -->
    <nav class="user-sidebar">
        <div class="sidebar-header">
            <div class="user-avatar">
                <i class="fas fa-user-circle"></i>
            </div>
            <h4>${user.name} ${user.surname}</h4>
            <p>Пассажир</p>
            <div class="user-status online">Online</div>
        </div>
        <ul class="sidebar-menu">
            <li class="menu-section">Мой профиль</li>
            <li class="active"><a href="#profile"><i class="fas fa-user"></i> <span>Профиль</span></a></li>
            <li><a href="#bookings"><i class="fas fa-ticket-alt"></i> <span>Мои билеты</span></a></li>
            <li><a href="#payments"><i class="fas fa-credit-card"></i> <span>Платежи</span></a></li>

            <li class="menu-section">Сервисы</li>
            <li><a href="#new-booking"><i class="fas fa-plane"></i> <span>Бронирование</span></a></li>
            <li><a href="#check-in"><i class="fas fa-check-circle"></i> <span>Онлайн-регистрация</span></a></li>
            <li><a href="#support"><i class="fas fa-headset"></i> <span>Поддержка</span></a></li>

            <li class="menu-section">Настройки</li>
            <li><a href="#settings"><i class="fas fa-cog"></i> <span>Настройки</span></a></li>
            <li class="logout"><a href="/logout"><i class="fas fa-sign-out-alt"></i> <span>Выход</span></a></li>
        </ul>
    </nav>

    <!-- Основное содержимое -->
    <main class="user-content">
        <div class="content-header">
            <h1><i class="fas fa-user"></i> Мой профиль</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">2</span>
                </div>
                <div class="last-login">
                    Последний вход: ${lastLogin}
                </div>
            </div>
        </div>

        <!-- Карточка профиля -->
        <div class="profile-card">
            <div class="info-row">
                <div class="info-group">
                    <label>Полное имя</label>
                    <p>${user.name} ${user.surname}</p>
                </div>
                <div class="info-group">
                    <label>Номер телефона</label>
                    <p>${user.phoneNumber}</p>
                </div>
            </div>

            <div class="info-row">
                <div class="info-group">
                    <label>Дата рождения</label>
                    <p>${user.dateOfBirth}</p>
                </div>
                <div class="info-group">
                    <label>Паспортные данные</label>
                    <p>${user.passportNumber}</p>
                </div>
            </div>

            <div class="action-buttons">
                <button class="btn btn-edit"><i class="fas fa-edit"></i> Редактировать</button>
                <button class="btn btn-change-password"><i class="fas fa-key"></i> Сменить пароль</button>
            </div>
        </div>

        <!-- Быстрые действия -->
        <div class="quick-actions">
            <h3><i class="fas fa-bolt"></i> Быстрые действия</h3>
            <div class="actions-grid">
                <a href="/booking" class="action-card">
                    <i class="fas fa-plane"></i>
                    <span>Забронировать рейс</span>
                </a>
                <a href="/my-tickets" class="action-card">
                    <i class="fas fa-ticket-alt"></i>
                    <span>Мои билеты</span>
                </a>
                <a href="/check-in" class="action-card">
                    <i class="fas fa-check-double"></i>
                    <span>Онлайн-регистрация</span>
                </a>
                <a href="/support" class="action-card">
                    <i class="fas fa-headset"></i>
                    <span>Поддержка</span>
                </a>
            </div>
        </div>

        <!-- Последние бронирования -->
        <div class="recent-bookings">
            <h3><i class="fas fa-history"></i> Последние бронирования</h3>
            <div class="booking-list">
                <div class="booking-item">
                    <div class="booking-info">
                        <div class="flight-number">SU-145</div>
                        <div class="route">Москва (SVO) → Сочи (AER)</div>
                        <div class="date">15 июня 2023, 14:30</div>
                    </div>
                    <div class="booking-status confirmed">Подтверждено</div>
                    <div class="booking-actions">
                        <button class="btn-action"><i class="fas fa-eye"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/user-profile.js"></script>
</body>
</html>