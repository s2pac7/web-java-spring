document.addEventListener('DOMContentLoaded', () => {
    const loginBtn = document.getElementById('login-btn');

    loginBtn.addEventListener('click', async () => {
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;

        try {
            const response = await fetch('/auth/signin', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password })
            });

            if (!response.ok) {
                throw new Error('Ошибка авторизации');
            }

            // Парсим JSON-ответ (token + redirectUrl)
            const data = await response.json();
            localStorage.setItem("jwtToken", data.token);

            alert("Вход успешен!");
            window.location.href = data.redirectUrl; // Теперь это "/user/user-dashboard" или "/admin/admin-dashboard"

        } catch (error) {
            alert("Ошибка входа! Проверьте логин и пароль.");
            console.error('Login error:', error);
        }
    });
});
