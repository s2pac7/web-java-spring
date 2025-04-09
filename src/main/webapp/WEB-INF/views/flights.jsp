<%@ page import="org.airport.webjavaspring.dto.FlightDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление рейсами | Админ-панель</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin-dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/flights.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <!-- В разделе head добавьте -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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
                <li class="active"><a href="/admin/flights"><i class="fas fa-plane"></i> <span>Рейсы</span></a></li>
                <li><a href="/admin/aircrafts"><i class="fas fa-plane-departure"></i> <span>Самолёты</span></a></li>

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
            <h1><i class="fas fa-plane"></i> Управление рейсами</h1>
            <div class="header-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <button class="btn btn-info" id="generateReport">
                    <i class="fas fa-file-alt"></i> Создать отчет
                </button>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFlightModal">
                    <i class="fas fa-plus"></i> Добавить рейс
                </button>
                <div class="quick-search">
                    <input type="text" placeholder="Поиск рейсов..." id="flightsSearch">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <!-- Основная таблица рейсов -->
        <div class="card">
            <div class="card-body">
                <table id="flightsTable" class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Номер рейса</th>
                        <th>Самолёт (ID)</th>
                        <th>Время отправления</th>
                        <th>Время прибытия</th>
                        <th>Аэропорт вылета</th>
                        <th>Аэропорт прилёта</th>
                        <th>Цена (₽)</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
                        List<FlightDTO> flights = (List<FlightDTO>) request.getAttribute("flights");
                        for (FlightDTO flight : flights) {
                    %>
                    <tr>
                        <td><%= flight.getId() %></td>
                        <td><%= flight.getFlightNumber() %></td>
                        <td><%= flight.getAircraftId() != null ? flight.getAircraftId() : "Не назначен" %></td>
                        <td><%= flight.getDepartureTime() != null ? flight.getDepartureTime().format(formatter) : "" %></td>
                        <td><%= flight.getArrivalTime() != null ? flight.getArrivalTime().format(formatter) : "" %></td>
                        <td><%= flight.getDepartureAirport() %></td>
                        <td><%= flight.getArrivalAirport() %></td>
                        <td><%= flight.getPrice() != null ? String.format("%,.2f", flight.getPrice()) : "—" %></td>
                        <td>
                            <button class="btn-action edit" data-id="<%= flight.getId() %>"
                                    data-flight-number="<%= flight.getFlightNumber() %>"
                                    data-aircraft-id="<%= flight.getAircraftId() %>"
                                    data-departure-airport="<%= flight.getDepartureAirport() %>"
                                    data-arrival-airport="<%= flight.getArrivalAirport() %>"
                                    data-departure-time="<%= flight.getDepartureTime() != null ? flight.getDepartureTime().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) : "" %>"
                                    data-arrival-time="<%= flight.getArrivalTime() != null ? flight.getArrivalTime().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) : "" %>"
                                    data-price="<%= flight.getPrice() != null ? flight.getPrice().toString() : "" %>"
                                    title="Редактировать">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-action delete" data-id="<%= flight.getId() %>" title="Удалить">
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

<!-- Замените существующий отчетный раздел -->
<div class="card mt-4" id="reportSection" style="display: none;">
    <div class="card-body">
        <h5 class="card-title">Отчет о рейсах</h5>
        <div id="reportContent" class="mb-3"></div>
        <div class="text-muted small" id="reportDate"></div>
        <button class="btn btn-success mt-3" id="downloadReport">
            <i class="fas fa-file-pdf"></i> Скачать PDF
        </button>
    </div>
</div>

<!-- Модальное окно для редактирования рейса -->
<div class="modal fade" id="editFlightModal" tabindex="-1" aria-labelledby="editFlightModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editFlightModalLabel">Редактировать рейс</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editFlightForm">
                    <input type="hidden" id="editFlightId" name="flightId">
                    <div class="flight-direction-group mb-4">
                        <div class="flight-direction-item">
                            <input type="radio" id="editDirectionDeparture" name="editFlightDirection" value="departure">
                            <label for="editDirectionDeparture">Туда (Aviasales →)</label>
                        </div>
                        <div class="flight-direction-item">
                            <input type="radio" id="editDirectionArrival" name="editFlightDirection" value="arrival">
                            <label for="editDirectionArrival">Обратно (← Aviasales)</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editFlightNumber" class="form-label">Номер рейса</label>
                                <input type="text" class="form-control" id="editFlightNumber" name="flightNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="editAircraftId" class="form-label">ID самолёта</label>
                                <input type="number" class="form-control" id="editAircraftId" name="aircraftId">
                            </div>
                            <div class="mb-3">
                                <label for="editDepartureAirport" class="form-label">Аэропорт вылета</label>
                                <input type="text" class="form-control airport-field" id="editDepartureAirport" name="departureAirport" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editArrivalAirport" class="form-label">Аэропорт прилёта</label>
                                <input type="text" class="form-control airport-field" id="editArrivalAirport" name="arrivalAirport" required>
                            </div>
                            <div class="mb-3">
                                <label for="editDepartureTime" class="form-label">Время вылета</label>
                                <input type="datetime-local" class="form-control" id="editDepartureTime" name="departureTime" required>
                            </div>
                            <div class="mb-3">
                                <label for="editArrivalTime" class="form-label">Время прилёта</label>
                                <input type="datetime-local" class="form-control" id="editArrivalTime" name="arrivalTime" required>
                            </div>
                            <div class="mb-3">
                                <label for="editPrice" class="form-label">Цена (₽)</label>
                                <input type="number" step="0.01" min="0" class="form-control" id="editPrice" name="price" required>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveEditedFlight">Сохранить</button>
            </div>
        </div>
    </div>
</div>

<!-- Модальное окно для добавления рейса -->
<div class="modal fade" id="addFlightModal" tabindex="-1" aria-labelledby="addFlightModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addFlightModalLabel">Добавить новый рейс</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addFlightForm">
                    <div class="flight-direction-group mb-4">
                        <div class="flight-direction-item">
                            <input type="radio" id="directionDeparture" name="flightDirection" value="departure" checked>
                            <label for="directionDeparture">Туда (Aviasales →)</label>
                        </div>
                        <div class="flight-direction-item">
                            <input type="radio" id="directionArrival" name="flightDirection" value="arrival">
                            <label for="directionArrival">Обратно (← Aviasales)</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="flightNumber" class="form-label">Номер рейса</label>
                                <input type="text" class="form-control" id="flightNumber" name="flightNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="aircraftId" class="form-label">ID самолёта</label>
                                <input type="number" class="form-control" id="aircraftId" name="aircraftId">
                            </div>
                            <div class="mb-3">
                                <label for="departureAirport" class="form-label">Аэропорт вылета</label>
                                <input type="text" class="form-control airport-field" id="departureAirport" name="departureAirport" value="Aviasales" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="arrivalAirport" class="form-label">Аэропорт прилёта</label>
                                <input type="text" class="form-control airport-field" id="arrivalAirport" name="arrivalAirport" required>
                            </div>
                            <div class="mb-3">
                                <label for="departureTime" class="form-label">Время вылета</label>
                                <input type="datetime-local" class="form-control" id="departureTime" name="departureTime" required>
                            </div>
                            <div class="mb-3">
                                <label for="arrivalTime" class="form-label">Время прилёта</label>
                                <input type="datetime-local" class="form-control" id="arrivalTime" name="arrivalTime" required>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Цена (₽)</label>
                                <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" required>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="button" class="btn btn-primary" id="saveFlight">Сохранить</button>
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
        var flightsTable = $('#flightsTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
            },
            responsive: true,
            columnDefs: [
                { targets: [2, 3, 4, 7], orderable: true },
                { targets: [0, 1, 5, 6, 8], orderable: true }
            ]
        });

        // Поиск по таблице
        $('#flightsSearch').keyup(function(){
            flightsTable.search($(this).val()).draw();
        });

        // Общая функция для обработки изменения направления рейса
        function handleDirectionChange(direction, departureFieldId, arrivalFieldId) {
            const isDeparture = direction === 'departure';
            const departureField = document.getElementById(departureFieldId);
            const arrivalField = document.getElementById(arrivalFieldId);

            if (isDeparture) {
                departureField.value = 'Aviasales';
                departureField.readOnly = true;
                arrivalField.readOnly = false;
                if (departureFieldId === 'departureAirport') {
                    arrivalField.value = '';
                }
            } else {
                arrivalField.value = 'Aviasales';
                arrivalField.readOnly = true;
                departureField.readOnly = false;
                if (departureFieldId === 'departureAirport') {
                    departureField.value = '';
                }
            }
        }

        // Функция для заполнения формы редактирования
        function fillEditForm(button) {
            const flightId = button.getAttribute('data-id');
            const flightNumber = button.getAttribute('data-flight-number');
            const aircraftId = button.getAttribute('data-aircraft-id');
            const departureAirport = button.getAttribute('data-departure-airport');
            const arrivalAirport = button.getAttribute('data-arrival-airport');
            const departureTime = button.getAttribute('data-departure-time');
            const arrivalTime = button.getAttribute('data-arrival-time');
            const price = button.getAttribute('data-price');

            // Заполняем основные поля
            $('#editFlightId').val(flightId);
            $('#editFlightNumber').val(flightNumber);
            $('#editAircraftId').val(aircraftId || '');
            $('#editDepartureAirport').val(departureAirport);
            $('#editArrivalAirport').val(arrivalAirport);
            $('#editPrice').val(price || '');

            // Устанавливаем время
            if (departureTime) {
                $('#editDepartureTime').val(departureTime.substring(0, 16));
            }
            if (arrivalTime) {
                $('#editArrivalTime').val(arrivalTime.substring(0, 16));
            }

            // Устанавливаем направление
            if (departureAirport === 'Aviasales') {
                $('#editDirectionDeparture').prop('checked', true);
                handleDirectionChange('departure', 'editDepartureAirport', 'editArrivalAirport');
            } else if (arrivalAirport === 'Aviasales') {
                $('#editDirectionArrival').prop('checked', true);
                handleDirectionChange('arrival', 'editDepartureAirport', 'editArrivalAirport');
            }
        }

        // Обработчик для кнопок редактирования в таблице
        $(document).on('click', '.edit', function() {
            fillEditForm(this);
            $('#editFlightModal').modal('show');
        });

        // Функция для добавления рейса
        function addFlight() {
            const formData = new FormData(document.getElementById('addFlightForm'));

            const flightData = {
                flightNumber: formData.get('flightNumber'),
                aircraftId: formData.get('aircraftId') ? parseInt(formData.get('aircraftId')) : null,
                departureAirport: formData.get('departureAirport'),
                arrivalAirport: formData.get('arrivalAirport'),
                departureTime: formData.get('departureTime'),
                arrivalTime: formData.get('arrivalTime'),
                price: parseFloat(formData.get('price'))
            };

            fetch('/admin/flights/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(flightData)
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(err => { throw err; });
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        alert('Рейс успешно добавлен!');
                        $('#addFlightModal').modal('hide');
                        location.reload();
                    } else {
                        alert('Ошибка: ' + (data.message || 'Неизвестная ошибка'));
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Произошла ошибка при добавлении рейса: ' + (error.message || error));
                });
        }

        // Функция для обновления рейса
        function updateFlight() {
            const formData = new FormData(document.getElementById('editFlightForm'));

            const flightData = {
                id: formData.get('flightId'),
                flightNumber: formData.get('flightNumber'),
                aircraftId: formData.get('aircraftId') ? parseInt(formData.get('aircraftId')) : null,
                departureAirport: formData.get('departureAirport'),
                arrivalAirport: formData.get('arrivalAirport'),
                departureTime: formData.get('departureTime'),
                arrivalTime: formData.get('arrivalTime'),
                price: parseFloat(formData.get('price'))
            };

            fetch(`/admin/flights/edit/` + flightData.id, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(flightData)
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(err => { throw err; });
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        alert('Данные рейса обновлены!');
                        $('#editFlightModal').modal('hide');
                        location.reload();
                    } else {
                        alert('Ошибка: ' + (data.message || 'Неизвестная ошибка'));
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Произошла ошибка при обновлении данных рейса: ' + (error.message || error));
                });
        }

        // Функция для удаления рейса
        function deleteFlight(flightId) {
            if (confirm('Вы уверены, что хотите удалить этот рейс?')) {
                fetch(`/admin/flights/delete/` + flightId, {
                    method: 'DELETE'
                })
                    .then(response => {
                        if (!response.ok) {
                            return response.json().then(err => { throw err; });
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.success) {
                            alert('Рейс успешно удален!');
                            location.reload();
                        } else {
                            alert('Ошибка: ' + (data.message || 'Неизвестная ошибка'));
                        }
                    })
                    .catch(error => {
                        console.error('Ошибка:', error);
                        alert('Произошла ошибка при удалении рейса: ' + (error.message || error));
                    });
            }
        }

        // Инициализация при открытии модального окна добавления
        $('#addFlightModal').on('show.bs.modal', function() {
            handleDirectionChange('departure', 'departureAirport', 'arrivalAirport');
        });

        // Обработчики изменения направления для добавления рейса
        $('input[name="flightDirection"]').change(function() {
            handleDirectionChange($(this).val(), 'departureAirport', 'arrivalAirport');
        });

        // Обработчики изменения направления для редактирования рейса
        $('input[name="editFlightDirection"]').change(function() {
            handleDirectionChange($(this).val(), 'editDepartureAirport', 'editArrivalAirport');
        });

        // Обработчик для кнопки сохранения в модальном окне добавления
        document.getElementById('saveFlight').addEventListener('click', addFlight);

        // Обработчик для кнопки сохранения в модальном окне редактирования
        document.getElementById('saveEditedFlight').addEventListener('click', updateFlight);

        // Обработчик для кнопок удаления в таблице
        $(document).on('click', '.delete', function() {
            const flightId = $(this).data('id');
            deleteFlight(flightId);
        });
    });

    // Report generation
    const { jsPDF } = window.jspdf;

    document.getElementById('generateReport').addEventListener('click', generateAndDownloadReport);

    async function generateAndDownloadReport() {
        try {
            const response = await fetch('/admin/flights/report');
            if (!response.ok) throw new Error('Server error: ' + response.status);

            const data = await response.json();
            if (!data?.success) throw new Error(data?.message || 'Invalid data format');

            // Initialize PDF with proper font support
            const doc = new jsPDF({
                orientation: 'portrait',
                unit: 'mm'
            });

            // Set default font (Helvetica supports basic Latin and Cyrillic)
            doc.setFont('helvetica', 'normal');

            // Add title
            doc.setFontSize(16);
            doc.setTextColor(40);
            doc.text('Flight Report', 105, 15, { align: 'center' });

            // Add divider line
            doc.setDrawColor(200);
            doc.setLineWidth(0.3);
            doc.line(15, 20, 195, 20);

            // Set body font
            doc.setFontSize(12);
            let y = 30;

            // Format price values
            const formatPrice = (price) => {
                if (typeof price !== 'number' || isNaN(price)) return '0.00 ₽';
                return price.toFixed(2) + ' ₽';
            };

            // Add report data with proper spacing
            const addReportLine = (label, value) => {
                doc.setTextColor(80);
                doc.setFont('helvetica', 'bold');
                doc.text(label + ':', 15, y);

                doc.setTextColor(0);
                doc.setFont('helvetica', 'normal');
                doc.text(value, 60, y);

                y += 7;
            };

            // Add report content
            addReportLine('Generated', new Date().toLocaleString('en-US', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            }).replace(/,/, ''));

            addReportLine('Max price', formatPrice(data.maxPrice));
            addReportLine('Min price', formatPrice(data.minPrice));
            addReportLine('Average price', formatPrice(data.avgPrice));
            addReportLine('Arrivals count', (data.arrivalsCount || 0).toString());

            // Add footer
            doc.setFontSize(10);
            doc.setTextColor(150);
            doc.text('Aviasales Flight Report', 105, 285, { align: 'center' });

            // Save PDF
            doc.save(`flight-report.pdf`);

        } catch (error) {
            console.error('Report generation error:', error);
            alert('Error generating report: ' + error.message);
        }
    }
</script>
</body>
</html>