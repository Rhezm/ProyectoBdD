<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comercial Andrades - Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body, html { height: 100%; display: flex; justify-content: center; align-items: center; }
        body {
            background: 
                radial-gradient(circle at 20% 30%, rgba(255,183,197,0.8), transparent 40%),
                radial-gradient(circle at 80% 20%, rgba(255,218,185,0.8), transparent 0%),
                radial-gradient(circle at 80% 80%, rgba(186,142,229,0.8), transparent 20%),
                radial-gradient(circle at 20% 80%, rgba(154,126,255,0.8), transparent 40%),
                linear-gradient(120deg, rgb(255,183,197), rgb(255,218,185), rgb(186,142,229), rgb(154,126,255));
        }
        .main-container {
            display: flex;
            width: 100%;
            max-width: 1200px;
            justify-content: space-between;
            align-items: center;
            padding: 2rem;
        }
        .title-container {
            flex: 1.6;
            text-align: left;
            color: #333;
        }
        .title-container h1 {
            font-size: 7rem;
            font-family: 'Pacifico', sans-serif;
            color: #ffffff;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }
        .login-container {
            background: rgba(255, 255, 255, 1);
            padding: 3rem;
            border-radius: 10px; 
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            width: 300px;
            text-align: center;
            flex: 1;
        }
        h1 { font-size: 2.5rem; color: #333; }
        h2 { color: #333; margin-bottom: 1.5rem; }
        form { display: flex; flex-direction: column; }
        input, button {
            padding: 0.8rem; border-radius: 6px; border: 1px solid rgba(0, 0, 0, 0.1);
            margin-top: 0.5rem; transition: 0.3s;
        }
        input:focus { border-color: rgb(154,126,255); box-shadow: 0 0 0 2px rgba(154,126,255, 0.2); }
        button {
            background: linear-gradient(45deg, rgb(186,142,229), rgb(154,126,255));
            color: white; border: none; cursor: pointer; margin-top: 1.5rem;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        button:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(154,126,255, 0.3); }
        .error { color: #ff4466; font-size: 0.8rem; }
        .welcome-text { margin-bottom: 1rem; font-size: 1rem; color: #333; }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="title-container">
            <h1>Comercial Andrades</h1>
        </div>
        <div class="login-container">
            <h2>Iniciar Sesión</h2>
            <p class="welcome-text">¡Bienvenido! Por favor, inicia sesión para continuar.</p>
            <form id="loginForm">
                <input type="text" id="id_empleado" name="id_empleado" placeholder="ID Empleado" maxlength="12" required>
                <div id="idEmpleadoError" class="error"></div>
                
                <input type="password" id="password" name="password" placeholder="Contraseña" required>
                <div id="passwordError" class="error"></div>
                
                <button type="submit">Iniciar sesión</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const idEmpleado = document.getElementById('id_empleado').value; // Eliminar puntos y guión
            const password = document.getElementById('password').value;
            const idEmpleadoError = document.getElementById('idEmpleadoError');
            const passwordError = document.getElementById('passwordError');
            
            idEmpleadoError.textContent = passwordError.textContent = '';
            
            if (!idEmpleado) idEmpleadoError.textContent = 'Por favor, ingrese su ID de empleado.';
            if (password.length < 3) passwordError.textContent = 'Mínimo 3 caracteres para la contraseña.';
            
            if (!idEmpleadoError.textContent && !passwordError.textContent) {
                fetch('Frontend/Dashboard/login_action.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        id_empleado: idEmpleado,
                        password: password
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = 'Frontend/Dashboard/nueva_venta.php';
                    } else {
                        idEmpleadoError.textContent = data.message;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    idEmpleadoError.textContent = 'Ocurrió un error inesperado.';
                });
            }
        });

        const idEmpleadoInput = document.getElementById("id_empleado");
        idEmpleadoInput.addEventListener("input", function(event) {
            let valor = event.target.value.replace(/\D/g, "").split("").reverse().join("");
            let idEmpleadoFormateado = "";

            for (let i = 0; i < valor.length; i++) {
                idEmpleadoFormateado = valor[i] + idEmpleadoFormateado;
            }

            event.target.value = idEmpleadoFormateado;
        });
    </script>
</body>
</html>
