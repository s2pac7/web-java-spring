async function signup() {
    const submitBtn = document.querySelector('.auth-button');

    try {
        submitBtn.disabled = true;
        submitBtn.textContent = "Регистрация...";

        // Получение данных формы
        const userData = {
            username: document.getElementById("username").value.trim(),
            password: document.getElementById("password").value.trim(),
            name: document.getElementById("name").value.trim(),
            surname: document.getElementById("surname").value.trim(),
            passportNumber: document.getElementById("passportNumber").value.trim(),
            dateOfBirth: document.getElementById("dateOfBirth").value,
            phoneNumber: document.getElementById("phoneNumber").value.trim(),
            hasDisability: document.querySelector('input[name="has_disability"]:checked')?.value === 'true',
            isStudent: document.querySelector('input[name="is_student"]:checked')?.value === 'true',
            balance: 0.0
        };

        // Валидация
        const requiredFields = ['username', 'password', 'name', 'surname', 'passportNumber', 'dateOfBirth', 'phoneNumber'];
        const missingFields = requiredFields.filter(field => !userData[field]);
        if (missingFields.length > 0) {
            throw new Error(`Заполните обязательные поля: ${missingFields.join(', ')}`);
        }

        // Отправка запроса
        const response = await fetch('http://localhost:8080/auth/signup', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(userData)
        });

        // Обработка ответа
        let responseData;
        try {
            responseData = await response.json();
        } catch (e) {
            throw new Error("Неверный формат ответа от сервера");
        }

        if (!response.ok) {
            throw new Error(responseData.message || "Ошибка при регистрации");
        }

        alert(responseData.message || "Регистрация успешна!");
        window.location.href = "/signin";

    } catch (error) {
        console.error("Ошибка регистрации:", error);
        alert("Ошибка: " + error.message);
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = "Зарегистрироваться";
    }
}