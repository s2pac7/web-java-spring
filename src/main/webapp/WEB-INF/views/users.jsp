<%@ page import="org.airport.webjavaspring.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление пользователями | Админ-панель</title>
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
                <li class="active"><a href="/admin/users"><i class="fas fa-users"></i> <span>Пользователи</span></a></li>
                <li><a href="/admin/passengers"><i class="fas fa-user-tie"></i> <span>Пассажиры</span></a></li>

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
            <h1><i class="fas fa-users"></i> Управление пользователями</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="fas fa-plus"></i> Добавить пользователя
                </button>
                <div class="quick-search">
                    <input type="text" placeholder="Поиск пользователей..." id="usersSearch">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <!-- Основная таблица пользователей -->
        <div class="card">
            <div class="card-body">
                <table id="usersTable" class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Имя пользователя</th>
                        <th>Роль</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
                        for (UserDTO user : users) {
                    %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><span class="status <%= "ADMIN".equals(user.getRole()) ? "confirmed" : "" %>">
                            <%= user.getRole() == null ? "Не определена" : user.getRole() %>
                        </span></td>
                        <td>
                            <button class="btn-action edit" data-id="<%= user.getId() %>"
                                    data-username="<%= user.getUsername() %>"
                                    data-role="<%= user.getRole() %>"
                                    title="Редактировать">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-action delete" data-id="<%= user.getId() %>" title="Удалить">
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

<!-- Модальное окно для редактирования пользователя -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Редактировать пользователя</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" id="editUserId" name="userId">
                    <div class="mb-3">
                        <label for="editUsername" class="form-label">Имя пользователя</label>
                        <input type="text" class="form-control" id="editUsername" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="editRole" class="form-label">Роль</label>
                        <select class="form-select" id="editRole" name="role" required>
                            <option value="ADMIN">Администратор</option>
                            <option value="USER">Пользователь</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveEditedUser">Сохранить</button>
            </div>
        </div>
    </div>
</div>

<!-- Модальное окно для добавления пользователя -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Добавить нового пользователя</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addUserForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">Имя пользователя</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Пароль</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Роль</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="ADMIN">Администратор</option>
                            <option value="USER" selected>Пользователь</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveUser">Сохранить</button>
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
        // Инициализация DataTable
        var usersTable = $('#usersTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
            },
            responsive: true
        });

        // Поиск по таблице
        $('#usersSearch').keyup(function(){
            usersTable.search($(this).val()).draw();
        });
    });

    // Функция для добавления пользователя
    function addUser() {
        const formData = new FormData(document.getElementById('addUserForm'));

        const userData = {
            username: formData.get('username'),
            password: formData.get('password'),
            role: formData.get('role')
        };

        fetch('/admin/users/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(userData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Пользователь успешно добавлен!');
                    $('#addUserModal').modal('hide');
                    location.reload();
                } else {
                    alert('Ошибка: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Произошла ошибка при добавлении пользователя');
            });
    }

    // Функция для обновления пользователя
    function updateUser() {
        const formData = new FormData(document.getElementById('editUserForm'));

        const userData = {
            id: formData.get('userId'),
            username: formData.get('username'),
            role: formData.get('role')
        };

        fetch(`/admin/users/edit/` + userData.id, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(userData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Данные пользователя обновлены!');
                    $('#editUserModal').modal('hide');
                    location.reload();
                } else {
                    alert('Ошибка: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Произошла ошибка при обновлении данных пользователя');
            });
    }

    // Функция для удаления пользователя
    function deleteUser(userId) {
        if (confirm('Вы уверены, что хотите удалить этого пользователя?')) {
            fetch(`/admin/users/delete/` + userId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Пользователь успешно удален!');
                        location.reload();
                    } else {
                        alert('Ошибка: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Произошла ошибка при удалении пользователя');
                });
        }
    }

    // Обработчики событий
    document.addEventListener('DOMContentLoaded', () => {
        // Обработчик для кнопки сохранения в модальном окне добавления
        document.getElementById('saveUser').addEventListener('click', addUser);

        // Обработчик для кнопки сохранения в модальном окне редактирования
        document.getElementById('saveEditedUser').addEventListener('click', updateUser);

        // Обработчик для кнопок редактирования в таблице
        document.querySelector('#usersTable').addEventListener('click', (event) => {
            if (event.target.closest('.edit')) {
                const button = event.target.closest('.edit');
                document.getElementById('editUserId').value = button.getAttribute('data-id');
                document.getElementById('editUsername').value = button.getAttribute('data-username');
                document.getElementById('editRole').value = button.getAttribute('data-role');
                $('#editUserModal').modal('show');
            }

            if (event.target.closest('.delete')) {
                const userId = event.target.closest('.delete').getAttribute('data-id');
                deleteUser(userId);
            }
        });
    });
</script>
</body>
</html>