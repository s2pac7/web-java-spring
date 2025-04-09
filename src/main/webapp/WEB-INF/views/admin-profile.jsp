<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль администратора</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin-dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin-profile.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                <li><a href="/admin"><i class="fas fa-tachometer-alt"></i> <span>Дашборд</span></a></li>
                <li class="active"><a href="/admin/profile"><i class="fas fa-user-cog"></i> <span>Профиль</span></a></li>

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
                <li><a href="#settings"><i class="fas fa-cogs"></i> <span>Настройки</span></a></li>
                <li><a href="#logs"><i class="fas fa-clipboard-list"></i> <span>Логи</span></a></li>

                <li class="logout"><a href="/logout"><i class="fas fa-sign-out-alt"></i> <span>Выход</span></a></li>
            </ul>
        </div>
    </nav>

    <!-- Основное содержимое -->
    <main class="admin-content admin-profile-container">
        <div class="profile-header">
            <h1><i class="fas fa-user-cog"></i> Профиль администратора</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
            </div>
        </div>

        <div class="profile-card">
            <div class="profile-info-grid">
                <div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Логин:</span>
                        <span class="profile-info-value" id="username"></span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Имя:</span>
                        <span class="profile-info-value" id="name"></span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Фамилия:</span>
                        <span class="profile-info-value" id="surname"></span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Телефон:</span>
                        <span class="profile-info-value" id="phoneNumber"></span>
                    </div>
                </div>
                <div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Паспорт:</span>
                        <span class="profile-info-value" id="passportNumber"></span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Дата рождения:</span>
                        <span class="profile-info-value" id="dateOfBirth"></span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label"><i class="fas fa-wallet"></i> Баланс:</span>
                        <span class="profile-info-value">
                        <span id="balance">0</span>
                        <span class="currency-symbol">₽</span>
                        </span>
                    </div>
                    <div class="profile-info-item">
                        <span class="profile-info-label">Статус:</span>
                        <span class="profile-info-value">
                            <span id="isStudent"></span>
                            <span id="hasDisability"></span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="profile-actions">
                <button class="btn btn-primary" onclick="openEditModal()">
                    <i class="fas fa-edit me-2"></i>Редактировать
                </button>
                <button class="btn btn-outline-secondary" onclick="openPasswordModal()">
                    <i class="fas fa-key me-2"></i>Сменить пароль
                </button>
                <button class="btn btn-success" onclick="openTopUpModal()">
                    <i class="fas fa-money-bill-wave me-2"></i>Пополнить баланс
                </button>
            </div>
        </div>
    </main>
</div>

<!-- Модальное окно пополнения баланса -->
<div class="modal fade" id="topUpModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Пополнение баланса</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="topUpForm" onsubmit="submitTopUpForm(event)">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Номер карты</label>
                        <input type="text" class="form-control" id="cardNumber"
                               placeholder="1234 5678 9012 3456"
                               pattern="\d{16}"
                               maxlength="16" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Срок действия (MM/YY)</label>
                        <input type="text" class="form-control" id="cardExpiry"
                               placeholder="MM/YY"
                               pattern="\d{2}/\d{2}"
                               maxlength="5" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Сумма пополнения</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="amount"
                                   min="100" step="100" required>
                            <span class="input-group-text">₽</span>
                        </div>
                        <small class="text-muted">Минимальная сумма: 100 ₽</small>
                    </div>
                    <div class="alert alert-info mt-3">
                        <i class="fas fa-info-circle me-2"></i>
                        Данные карты не сохраняются и используются только для текущей операции
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                    <button type="submit" class="btn btn-primary">Пополнить</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Модальное окно редактирования -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Редактирование профиля</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="editForm" onsubmit="submitEditForm(event)">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Логин</label>
                                <input type="text" class="form-control" id="editUsername" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Имя</label>
                                <input type="text" class="form-control" id="editName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Фамилия</label>
                                <input type="text" class="form-control" id="editSurname" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Телефон</label>
                                <input type="tel" class="form-control" id="editPhone" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Паспорт</label>
                                <input type="text" class="form-control" id="editPassport" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Дата рождения</label>
                                <input type="date" class="form-control" id="editBirthDate">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" id="editStudent">
                                <label class="form-check-label">Студент</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="editDisability">
                                <label class="form-check-label">Инвалидность</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                    <button type="submit" class="btn btn-primary">Сохранить изменения</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Модальное окно смены пароля -->
<div class="modal fade" id="passwordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Смена пароля</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="passwordForm" onsubmit="submitPasswordForm(event)">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Текущий пароль</label>
                        <input type="password" class="form-control" id="currentPass" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Новый пароль</label>
                        <input type="password" class="form-control" id="newPass" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Подтвердите пароль</label>
                        <input type="password" class="form-control" id="confirmPass" required>
                        <div class="password-error mt-2">Пароли не совпадают!</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                    <button type="submit" class="btn btn-primary">Изменить пароль</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const token = localStorage.getItem('jwtToken');

    // Проверка авторизации
    if (!token) {
        alert('Для доступа требуется авторизация');
        window.location.href = '/signin';
    } else {
        loadProfileData();
    }

    // Загрузка данных профиля
    function loadProfileData() {
        fetch('/api/user/profile', {
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка загрузки данных');
                return response.json();
            })
            .then(data => {
                updateProfileUI(data);
            })
            .catch(error => {
                showError(error);
            });
    }

    // Обновление интерфейса
    function updateProfileUI(data) {
        document.getElementById('username').textContent = data.user?.username || 'Не указан';
        document.getElementById('name').textContent = data.name || 'Не указано';
        document.getElementById('surname').textContent = data.surname || 'Не указано';
        document.getElementById('phoneNumber').textContent = data.phoneNumber || 'Не указано';
        document.getElementById('passportNumber').textContent = data.passportNumber || 'Не указано';
        document.getElementById('dateOfBirth').textContent = data.dateOfBirth || 'Не указано';
        document.getElementById('isStudent').textContent = data.isStudent ? 'Студент' : '';
        document.getElementById('hasDisability').textContent = data.hasDisability ? (data.isStudent ? ', Инвалидность' : 'Инвалидность') : '';

        const balance = data.balance ? parseFloat(data.balance) : 0;
        document.getElementById('balance').textContent = formatCurrency(balance);
    }

    function formatCurrency(amount) {
        return amount.toLocaleString('ru-RU', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    // Открытие модалки редактирования
    function openEditModal() {
        const modal = new bootstrap.Modal('#editModal');

        // Заполнение полей
        document.getElementById('editUsername').value = document.getElementById('username').textContent;
        document.getElementById('editName').value = document.getElementById('name').textContent;
        document.getElementById('editSurname').value = document.getElementById('surname').textContent;
        document.getElementById('editPhone').value = document.getElementById('phoneNumber').textContent;
        document.getElementById('editPassport').value = document.getElementById('passportNumber').textContent;
        document.getElementById('editBirthDate').value = document.getElementById('dateOfBirth').textContent;
        document.getElementById('editStudent').checked = document.getElementById('isStudent').textContent.includes('Студент');
        document.getElementById('editDisability').checked = document.getElementById('hasDisability').textContent.includes('Инвалидность');

        modal.show();
    }

    // Отправка формы редактирования
    function submitEditForm(event) {
        event.preventDefault();

        const updatedData = {
            username: document.getElementById('editUsername').value,
            name: document.getElementById('editName').value,
            surname: document.getElementById('editSurname').value,
            phoneNumber: document.getElementById('editPhone').value,
            passportNumber: document.getElementById('editPassport').value,
            dateOfBirth: document.getElementById('editBirthDate').value,
            isStudent: document.getElementById('editStudent').checked,
            hasDisability: document.getElementById('editDisability').checked
        };

        fetch('/api/user/profile', {
            method: 'PUT',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка обновления данных');
                location.reload();
            })
            .catch(error => {
                showError(error);
            });
    }

    // Открытие модалки смены пароля
    function openPasswordModal() {
        document.querySelector('.password-error').style.display = 'none';
        const modal = new bootstrap.Modal('#passwordModal');
        modal.show();
    }

    // Отправка формы смены пароля
    function submitPasswordForm(event) {
        event.preventDefault();

        const currentPassword = document.getElementById('currentPass').value;
        const newPassword = document.getElementById('newPass').value;
        const confirmPassword = document.getElementById('confirmPass').value;

        if (newPassword !== confirmPassword) {
            document.querySelector('.password-error').style.display = 'block';
            return;
        }

        fetch('/api/user/change-password', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                currentPassword: currentPassword,
                newPassword: newPassword
            })
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка смены пароля');
                alert('Пароль успешно изменён!');
                bootstrap.Modal.getInstance('#passwordModal').hide();
            })
            .catch(error => {
                showError(error);
            });
    }

    // Обработка ошибок
    function showError(error) {
        console.error('Ошибка:', error);
        alert(error.message || 'Произошла ошибка');
    }

    // Открытие модалки пополнения баланса
    function openTopUpModal() {
        const modal = new bootstrap.Modal('#topUpModal');
        document.getElementById('topUpForm').reset();
        modal.show();
    }

    // Отправка формы пополнения баланса
    function submitTopUpForm(event) {
        event.preventDefault();

        const amount = parseFloat(document.getElementById('amount').value);
        const cardNumber = document.getElementById('cardNumber').value;
        const cardExpiry = document.getElementById('cardExpiry').value;

        // Простая валидация карты (можно расширить)
        if (cardNumber.length !== 16 || !/^\d+$/.test(cardNumber)) {
            alert('Пожалуйста, введите корректный номер карты (16 цифр)');
            return;
        }

        if (!/^\d{2}\/\d{2}$/.test(cardExpiry)) {
            alert('Пожалуйста, введите срок действия в формате MM/YY');
            return;
        }

        if (amount < 100) {
            alert('Минимальная сумма пополнения - 100 ₽');
            return;
        }

        // Показываем индикатор загрузки
        const submitBtn = event.target.querySelector('button[type="submit"]');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Обработка...';

        fetch('/api/user/top-up', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(amount)
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка при пополнении баланса');
                return response.text();
            })
            .then(message => {
                alert(message);
                bootstrap.Modal.getInstance('#topUpModal').hide();
                loadProfileData(); // Обновляем данные профиля
            })
            .catch(error => {
                showError(error);
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.textContent = 'Пополнить';
            });
    }

</script>
</body>
</html>