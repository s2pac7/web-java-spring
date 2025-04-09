<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ-панель | Аэропорт</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin-dashboard.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
</head>
<body>
<div class="app-container">
    <!-- Боковая навигация -->
    <nav class="admin-sidebar">
        <div class="sidebar-header">
            <div class="admin-avatar">
                <i class="fas fa-user-shield"></i>
            </div>
            <h4>${admin.name}</h4>
            <p>Администратор</p>
            <div class="admin-status online">Online</div>
        </div>
        <div class="sidebar-menu-container">
            <ul class="sidebar-menu">
                <li class="menu-section">Управление</li>
                <li class="active"><a href="/admin"><i class="fas fa-tachometer-alt"></i> <span>Дашборд</span></a></li>
                <li><a href="/admin/admin-profile"><i class="fas fa-user-cog"></i> <span>Профиль</span></a></li>

                <li class="menu-section">Авиация</li>
                <li><a href="/admin/flights"><i class="fas fa-plane"></i> <span>Рейсы</span></a></li>
                <li><a href="/admin/aircrafts"><i class="fas fa-plane-departure"></i> <span>Самолёты</span></a></li>

                <li class="menu-section">Пользователи</li>
                <li><a href="/admin/users"><i class="fas fa-users"></i> <span>Пользователи</span></a></li>
                <li><a href="/admin/passengers"><i class="fas fa-user-tie"></i> <span>Пассажиры</span></a></li>

                <li class="menu-section">Финансы</li>
                <li><a href="#payments"><i class="fas fa-money-bill-wave"></i> <span>Платежи</span></a></li>
                <li><a href="#reports"><i class="fas fa-chart-bar"></i> <span>Отчёты</span></a></li>

                <li class="menu-section">Система</li>
                <li><a href="/admin/admin-profile"><i class="fas fa-cogs"></i> <span>Настройки</span></a></li>
                <li><a href="#logs"><i class="fas fa-clipboard-list"></i> <span>Логи</span></a></li>

                <li class="logout"><a href="/signin"><i class="fas fa-sign-out-alt"></i> <span>Выход</span></a></li>
            </ul>
        </div>
    </nav>

    <!-- Основное содержимое -->
    <main class="admin-content">
        <div class="content-header">
            <h1><i class="fas fa-tachometer-alt"></i> Административная панель</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="quick-search">
                    <input type="text" placeholder="Быстрый поиск...">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <!-- Статистика -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon bg-primary">
                    <i class="fas fa-plane"></i>
                </div>
                <div class="stat-info">
                    <h3>24</h3>
                    <p>Рейсов сегодня</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-success">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>156</h3>
                    <p>Новых клиентов</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-warning">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="stat-info">
                    <h3>342</h3>
                    <p>Броней за день</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-danger">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="stat-info">
                    <h3>$12,540</h3>
                    <p>Доход за день</p>
                </div>
            </div>
        </div>

        <!-- Таблица последних бронирований -->
        <div class="card recent-bookings">
            <div class="card-header">
                <h3><i class="fas fa-clock"></i> Последние бронирования</h3>
                <a href="#" class="btn-view-all">Просмотреть все</a>
            </div>
            <div class="card-body">
                <table id="bookingsTable" class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Клиент</th>
                        <th>Рейс</th>
                        <th>Дата</th>
                        <th>Статус</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#BK-1001</td>
                        <td>Иванов И.</td>
                        <td>SU-145 (MOW-SIP)</td>
                        <td>15.06.2023</td>
                        <td><span class="status confirmed">Подтверждено</span></td>
                        <td>
                            <button class="btn-action view"><i class="fas fa-eye"></i></button>
                            <button class="btn-action edit"><i class="fas fa-edit"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Быстрые действия -->
        <div class="quick-actions">
            <h3><i class="fas fa-bolt"></i> Быстрые действия</h3>
            <div class="actions-grid">
                <a href="/admin/add-flight" class="action-card">
                    <i class="fas fa-plus-circle"></i>
                    <span>Добавить рейс</span>
                </a>
                <a href="/admin/check-in" class="action-card">
                    <i class="fas fa-check-double"></i>
                    <span>Регистрация</span>
                </a>
                <a href="/admin/boarding" class="action-card">
                    <i class="fas fa-users"></i>
                    <span>Посадка</span>
                </a>
                <a href="/admin/reports" class="action-card">
                    <i class="fas fa-file-export"></i>
                    <span>Генерация отчёта</span>
                </a>
            </div>
        </div>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function() {
        $('#bookingsTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
            }
        });
    });
</script>
</body>
</html>