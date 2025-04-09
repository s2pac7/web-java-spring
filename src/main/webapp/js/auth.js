document.addEventListener('DOMContentLoaded', function() {
    const loginBtn = document.getElementById('login-btn');

    loginBtn.addEventListener('click', async function() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (!username || !password) {
            alert('Пожалуйста, введите логин и пароль');
            return;
        }

        try {
            const response = await fetch('/auth/signin', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    password: password
                })
            });

            if (response.ok) {
                const data = await response.json();
                localStorage.setItem('jwtToken', data.token);
                window.location.href = data.redirectUrl;
            } else {
                const errorData = await response.json();
                alert(errorData.message || 'Произошла ошибка при входе');
            }
        } catch (error) {
            console.error('Ошибка:', error);
            alert('Сервер недоступен');
        }
    });
});