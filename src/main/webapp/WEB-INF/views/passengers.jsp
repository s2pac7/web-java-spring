<%@ page import="org.airport.webjavaspring.dto.PassengerDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление пассажирами | Админ-панель</title>
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
                <li><a href="/admin"><i class="fas fa-tachometer-alt"></i> <span>Дашборд</span></a></li>
                <li><a href="/admin/profile"><i class="fas fa-user-cog"></i> <span>Профиль</span></a></li>

                <li class="menu-section">Авиация</li>
                <li><a href="/admin/flights"><i class="fas fa-plane"></i> <span>Рейсы</span></a></li>
                <li><a href="/admin/aircrafts"><i class="fas fa-plane-departure"></i> <span>Самолёты</span></a></li>

                <li class="menu-section">Пользователи</li>
                <li><a href="/admin/users"><i class="fas fa-users"></i> <span>Пользователи</span></a></li>
                <li class="active"><a href="/admin/passengers"><i class="fas fa-user-tie"></i> <span>Пассажиры</span></a></li>

                <li class="menu-section">Финансы</li>
                <li><a href="/admin/payments"><i class="fas fa-money-bill-wave"></i> <span>Платежи</span></a></li>
                <li><a href="/admin/reports"><i class="fas fa-chart-bar"></i> <span>Отчёты</span></a></li>

                <li class="menu-section">Система</li>
                <li><a href="/admin/settings"><i class="fas fa-cogs"></i> <span>Настройки</span></a></li>
                <li><a href="/admin/logs"><i class="fas fa-clipboard-list"></i> <span>Логи</span></a></li>

                <li class="logout"><a href="/signin"><i class="fas fa-sign-out-alt"></i> <span>Выход</span></a></li>
            </ul>
        </div>
    </nav>

    <!-- Основное содержимое -->
    <main class="admin-content">
        <div class="content-header">
            <h1><i class="fas fa-user-tie"></i> Управление пассажирами</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="quick-search">
                    <input type="text" placeholder="Поиск по фамилии..." id="passengersSearch">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <!-- Основная таблица пассажиров -->
        <div class="card">
            <div class="card-body">
                <table id="passengersTable" class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Имя</th>
                        <th>Фамилия</th>
                        <th>Номер паспорта</th>
                        <th>Дата рождения</th>
                        <th>Телефон</th>
                        <th>Наличие инвалидности</th>
                        <th>Студент</th>
                        <th>Баланс</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<PassengerDTO> passengers = (List<PassengerDTO>) request.getAttribute("passengers");
                        for (PassengerDTO passenger : passengers) {
                    %>
                    <tr data-id="<%= passenger.getId() %>"
                        data-name="<%= passenger.getName() %>"
                        data-surname="<%= passenger.getSurname() %>"
                        data-passportNumber="<%= passenger.getPassportNumber() %>"
                        data-dateOfBirth="<%= passenger.getDateOfBirth() %>"
                        data-phoneNumber="<%= passenger.getPhoneNumber() %>"
                        data-hasDisability="<%= passenger.isHasDisability() %>"
                        data-isStudent="<%= passenger.isStudent() %>">
                        <td><%= passenger.getId() %></td>
                        <td><%= passenger.getUser().getId() %></td>
                        <td><%= passenger.getName() %></td>
                        <td><%= passenger.getSurname() %></td>
                        <td><%= passenger.getPassportNumber() %></td>
                        <td><%= passenger.getDateOfBirth() %></td>
                        <td><%= passenger.getPhoneNumber() %></td>
                        <td><span class="status <%= passenger.isHasDisability() ? "confirmed" : "" %>">
                            <%= passenger.isHasDisability() ? "Есть" : "Нет" %>
                        </span></td>
                        <td><span class="status <%= passenger.isStudent() ? "confirmed" : "" %>">
                            <%= passenger.isStudent() ? "Да" : "Нет" %>
                        </span></td>
                        <td><%= passenger.getBalance() %></td>
                        <td>
                            <button class="btn-action edit" data-id="<%= passenger.getId() %>" title="Редактировать">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-action delete" data-id="<%= passenger.getId() %>" title="Удалить">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<!-- Модальное окно для редактирования пассажира -->
<div class="modal fade" id="editPassengerModal" tabindex="-1" aria-labelledby="editPassengerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPassengerModalLabel">Редактировать пассажира</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editPassengerForm">
                    <input type="hidden" id="editPassengerId" name="id">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Имя</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editSurname" class="form-label">Фамилия</label>
                        <input type="text" class="form-control" id="editSurname" name="surname" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPassportNumber" class="form-label">Номер паспорта</label>
                        <input type="text" class="form-control" id="editPassportNumber" name="passportNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDateOfBirth" class="form-label">Дата рождения</label>
                        <input type="date" class="form-control" id="editDateOfBirth" name="dateOfBirth" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPhoneNumber" class="form-label">Телефон</label>
                        <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Наличие инвалидности</label><br>
                        <input type="radio" id="editHasDisabilityYes" name="hasDisability" value="true">
                        <label for="editHasDisabilityYes">Да</label>
                        <input type="radio" id="editHasDisabilityNo" name="hasDisability" value="false">
                        <label for="editHasDisabilityNo">Нет</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Студент</label><br>
                        <input type="radio" id="editIsStudentYes" name="isStudent" value="true">
                        <label for="editIsStudentYes">Да</label>
                        <input type="radio" id="editIsStudentNo" name="isStudent" value="false">
                        <label for="editIsStudentNo">Нет</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveEditedPassenger">Сохранить изменения</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function() {
        $('#passengersTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
            }
        });
    });

    // Обработчики событий для редактирования и удаления пассажиров
    document.addEventListener('DOMContentLoaded', () => {
        // Обработчик событий для кнопок редактирования
        document.querySelector('#passengersTable').addEventListener('click', function (event) {
            if (event.target.closest('.edit')) {
                const passengerId = event.target.closest('.edit').getAttribute('data-id');
                openEditPassengerModal(passengerId);
            }
        });

        // Обработчик событий для кнопок удаления
        document.querySelector('#passengersTable').addEventListener('click', function (event) {
            if (event.target.closest('.delete')) {
                const passengerId = event.target.closest('.delete').getAttribute('data-id');
                if (confirm('Вы уверены, что хотите удалить этого пассажира?')) {
                    deletePassenger(passengerId);
                }
            }
        });

        // Обработчик для кнопки сохранения
        document.getElementById('saveEditedPassenger').addEventListener('click', submitEditPassengerForm);
    });

    // Функция для открытия модального окна редактирования
    function openEditPassengerModal(passengerId) {
        fetch(`/admin/passengers/edit/` + passengerId)
            .then(response => {
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                return response.json();
            })
            .then(passengerData => {
                // Заполняем форму данными
                document.getElementById('editPassengerId').value = passengerData.id;
                document.getElementById('editName').value = passengerData.name || '';
                document.getElementById('editSurname').value = passengerData.surname || '';
                document.getElementById('editPassportNumber').value = passengerData.passportNumber || '';
                document.getElementById('editDateOfBirth').value = passengerData.dateOfBirth || '';
                document.getElementById('editPhoneNumber').value = passengerData.phoneNumber || '';

                // Устанавливаем радиокнопки
                document.getElementById('editHasDisabilityYes').checked = passengerData.hasDisability;
                document.getElementById('editHasDisabilityNo').checked = !passengerData.hasDisability;
                document.getElementById('editIsStudentYes').checked = passengerData.isStudent;
                document.getElementById('editIsStudentNo').checked = !passengerData.isStudent;

                // Открываем модальное окно
                new bootstrap.Modal(document.getElementById('editPassengerModal')).show();
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Не удалось загрузить данные пассажира');
            });
    }

    // Функция для отправки формы редактирования
    function submitEditPassengerForm() {
        const form = document.getElementById('editPassengerForm');
        const passengerId = form.id.value;

        const passengerData = {
            id: passengerId,
            name: form.name.value,
            surname: form.surname.value,
            passportNumber: form.passportNumber.value,
            dateOfBirth: form.dateOfBirth.value,
            phoneNumber: form.phoneNumber.value,
            hasDisability: document.querySelector('input[name="hasDisability"]:checked').value === 'true',
            isStudent: document.querySelector('input[name="isStudent"]:checked').value === 'true'
        };

        fetch(`/admin/passengers/edit/` + passengerId, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(passengerData)
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка сервера');
                return response.json();
            })
            .then(data => {
                alert('Пассажир успешно обновлен!');
                $('#editPassengerModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Ошибка при обновлении пассажира');
            });
    }

    // Функция для удаления пассажира
    function deletePassenger(passengerId) {
        fetch(`/admin/passengers/delete/` + passengerId, {
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) throw new Error('Ошибка сервера');
                return response.json();
            })
            .then(data => {
                alert('Пассажир успешно удален!');
                location.reload();
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Ошибка при удалении пассажира');
            });
    }
</script>
</body>
</html>