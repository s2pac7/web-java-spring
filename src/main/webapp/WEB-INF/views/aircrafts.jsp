<%@ page import="org.airport.webjavaspring.dto.AircraftDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление самолётами | Админ-панель</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/aircrafts.css" rel="stylesheet">
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
                <li class="active"><a href="/admin/aircrafts"><i class="fas fa-plane-departure"></i> <span>Самолёты</span></a></li>

                <li class="menu-section">Пользователи</li>
                <li><a href="/admin/users"><i class="fas fa-users"></i> <span>Пользователи</span></a></li>
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
            <h1><i class="fas fa-plane-departure"></i> Управление самолётами</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAircraftModal">
                    <i class="fas fa-plus"></i> Добавить самолёт
                </button>
                <div class="quick-search">
                    <input type="text" placeholder="Поиск самолётов..." id="aircraftsSearch">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <!-- Основная таблица самолётов -->
        <div class="card">
            <div class="card-body">
                <table id="aircraftsTable" class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Название</th>
                        <th>Тип</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<AircraftDTO> aircrafts = (List<AircraftDTO>) request.getAttribute("aircrafts");
                        for (AircraftDTO aircraft : aircrafts) {
                    %>
                    <tr>
                        <td><%= aircraft.getId() %></td>
                        <td><%= aircraft.getNameAircraft() %></td>
                        <td><span class="status <%= aircraft.getTypeAircraft() != null ? "confirmed" : "" %>">
                            <%= aircraft.getTypeAircraft() != null ? aircraft.getTypeAircraft() : "Не определён" %>
                        </span></td>
                        <td>
                            <button class="btn-action edit" data-id="<%= aircraft.getId() %>"
                                    data-name="<%= aircraft.getNameAircraft() %>"
                                    data-type="<%= aircraft.getTypeAircraft() %>"
                                    title="Редактировать">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-action delete" data-id="<%= aircraft.getId() %>" title="Удалить">
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
<!-- Модальное окно для добавления самолёта -->
<div class="modal fade" id="addAircraftModal" tabindex="-1" aria-labelledby="addAircraftModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAircraftModalLabel">Добавить новый самолёт</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addAircraftForm">
                    <div class="mb-3">
                        <label for="name" class="form-label">Название самолёта</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="type" class="form-label">Тип самолёта</label>
                        <select class="form-select" id="type" name="type" required>
                            <option value="PASSENGER_NARROW_BODY">Пассажирский узкофюзеляжный</option>
                            <option value="PASSENGER_WIDE_BODY">Пассажирский широкофюзеляжный</option>
                            <option value="REGIONAL_JET">Региональный реактивный</option>
                            <option value="TURBOPROP">Турбовинтовой</option>
                            <option value="FREIGHTER">Грузовой</option>
                            <option value="BUSINESS_JET">Бизнес-джет</option>
                            <option value="LIGHT_AIRCRAFT">Легкий самолет</option>
                            <option value="AMPHIBIAN">Амфибия</option>
                            <option value="FIREFIGHTING">Пожарный</option>
                            <option value="AGRICULTURAL">Сельскохозяйственный</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveAircraft">Сохранить</button>
            </div>
        </div>
    </div>
</div>

<!-- Модальное окно для редактирования самолёта -->
<div class="modal fade" id="editAircraftModal" tabindex="-1" aria-labelledby="editAircraftModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAircraftModalLabel">Редактировать самолёт</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editAircraftForm">
                    <input type="hidden" id="editAircraftId" name="aircraftId">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Название самолёта</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editType" class="form-label">Тип самолёта</label>
                        <select class="form-select" id="editType" name="type" required>
                            <option value="PASSENGER_NARROW_BODY">Пассажирский узкофюзеляжный</option>
                            <option value="PASSENGER_WIDE_BODY">Пассажирский широкофюзеляжный</option>
                            <option value="REGIONAL_JET">Региональный реактивный</option>
                            <option value="TURBOPROP">Турбовинтовой</option>
                            <option value="FREIGHTER">Грузовой</option>
                            <option value="BUSINESS_JET">Бизнес-джет</option>
                            <option value="LIGHT_AIRCRAFT">Легкий самолет</option>
                            <option value="AMPHIBIAN">Амфибия</option>
                            <option value="FIREFIGHTING">Пожарный</option>
                            <option value="AGRICULTURAL">Сельскохозяйственный</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveEditedAircraft">Сохранить</button>
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
        var aircraftsTable = $('#aircraftsTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
            },
            responsive: true
        });

        // Поиск по таблице
        $('#aircraftsSearch').keyup(function(){
            aircraftsTable.search($(this).val()).draw();
        });
    });

    // Функция для добавления самолёта
    function addAircraft() {
        const formData = new FormData(document.getElementById('addAircraftForm'));

        const aircraftData = {
            nameAircraft: formData.get('name'),
            typeAircraft: formData.get('type')
        };

        fetch('/admin/aircrafts/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(aircraftData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Самолёт успешно добавлен!');
                    $('#addAircraftModal').modal('hide');
                    location.reload();
                } else {
                    alert('Ошибка: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Произошла ошибка при добавлении самолёта');
            });
    }

    // Функция для обновления самолёта
    function updateAircraft() {
        const formData = new FormData(document.getElementById('editAircraftForm'));

        const aircraftData = {
            id: formData.get('aircraftId'),
            nameAircraft: formData.get('name'),
            typeAircraft: formData.get('type')
        };

        fetch(`/admin/aircrafts/edit/` + aircraftData.id, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(aircraftData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Данные самолёта обновлены!');
                    $('#editAircraftModal').modal('hide');
                    location.reload();
                } else {
                    alert('Ошибка: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Произошла ошибка при обновлении данных самолёта');
            });
    }

    // Функция для удаления самолёта
    function deleteAircraft(aircraftId) {
        if (confirm('Вы уверены, что хотите удалить этот самолёт?')) {
            fetch(`/admin/aircrafts/delete/` + aircraftId, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Самолёт успешно удален!');
                        location.reload();
                    } else {
                        alert('Ошибка: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Произошла ошибка при удалении самолёта');
                });
        }
    }

    // Обработчики событий
    document.addEventListener('DOMContentLoaded', () => {
        // Обработчик для кнопки сохранения в модальном окне добавления
        document.getElementById('saveAircraft').addEventListener('click', addAircraft);

        // Обработчик для кнопки сохранения в модальном окне редактирования
        document.getElementById('saveEditedAircraft').addEventListener('click', updateAircraft);

        // Обработчик для кнопок редактирования в таблице
        document.querySelector('#aircraftsTable').addEventListener('click', (event) => {
            if (event.target.closest('.edit')) {
                const button = event.target.closest('.edit');
                document.getElementById('editAircraftId').value = button.getAttribute('data-id');
                document.getElementById('editName').value = button.getAttribute('data-name');
                document.getElementById('editType').value = button.getAttribute('data-type');
                $('#editAircraftModal').modal('show');
            }

            if (event.target.closest('.delete')) {
                const aircraftId = event.target.closest('.delete').getAttribute('data-id');
                deleteAircraft(aircraftId);
            }
        });
    });
</script>
</body>
</html>