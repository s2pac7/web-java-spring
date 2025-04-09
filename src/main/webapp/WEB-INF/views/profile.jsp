<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль пользователя</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-card {
            max-width: 800px;
            margin: 30px auto;
            padding: 25px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .password-error { color: #dc3545; display: none; }
        .modal-content { padding: 20px; }
        .form-check-label { user-select: none; }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card">
        <h2 class="text-center mb-4">Профиль пользователя</h2>
        <div id="profile-data">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Логин:</strong> <span id="username"></span></p>
                    <p><strong>Имя:</strong> <span id="name"></span></p>
                    <p><strong>Фамилия:</strong> <span id="surname"></span></p>
                    <p><strong>Телефон:</strong> <span id="phoneNumber"></span></p>
                </div>
                <div class="col-md-6">
                    <p><strong>Паспорт:</strong> <span id="passportNumber"></span></p>
                    <p><strong>Дата рождения:</strong> <span id="dateOfBirth"></span></p>
                    <p><strong>Баланс:</strong> <span id="balance"></span></p>
                    <p><strong>Студент:</strong> <span id="isStudent"></span></p>
                    <p><strong>Инвалидность:</strong> <span id="hasDisability"></span></p>
                </div>
            </div>
        </div>
        <div class="mt-4 text-center">
            <button class="btn btn-primary me-3" onclick="openEditModal()">
                <i class="bi bi-pencil-square"></i> Редактировать
            </button>
            <button class="btn btn-warning" onclick="openPasswordModal()">
                <i class="bi bi-key"></i> Сменить пароль
            </button>
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
                            <div class="mb-3">
                                <label class="form-label">Телефон</label>
                                <input type="tel" class="form-control" id="editPhone" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Паспорт</label>
                                <input type="text" class="form-control" id="editPassport" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Дата рождения</label>
                                <input type="date" class="form-control" id="editBirthDate">
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="editStudent">
                                <label class="form-check-label">Студент</label>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="editDisability">
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
        document.getElementById('balance').textContent = data.balance ?
            `${data.balance.toLocaleString()} ₽` : '0 ₽';
        document.getElementById('isStudent').textContent = data.isStudent ? 'Да' : 'Нет';
        document.getElementById('hasDisability').textContent = data.hasDisability ? 'Да' : 'Нет';
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
        document.getElementById('editStudent').checked = document.getElementById('isStudent').textContent === 'Да';
        document.getElementById('editDisability').checked = document.getElementById('hasDisability').textContent === 'Да';

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
</script>
</body>
</html>