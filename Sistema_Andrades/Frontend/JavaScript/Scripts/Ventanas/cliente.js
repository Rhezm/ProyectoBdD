document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Clientes</h1>
        <p>Aquí puedes administrar tus clientes.</p>
        <div class="form-container">
            <div class="form-column">
                <div class="form-row">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre">
                </div>
                <div class="form-row">
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido">
                </div>
                <div class="form-row">
                    <label for="telefono">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono">
                </div>
                <div class="form-row">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-row">
                    <button id="agregar" disabled>Agregar</button>
                </div>
            </div>
            <div class="table-column">
                <table>
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Teléfono</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody id="tablaClientes">
                        <tr>
                            <td>Juan</td>
                            <td>Pérez</td>
                            <td>123456789</td>
                            <td>juan@example.com</td>
                        </tr>
                        <tr>
                            <td>María</td>
                            <td>González</td>
                            <td>987654321</td>
                            <td>maria@example.com</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    `;

    const nombre = document.getElementById('nombre');
    const apellido = document.getElementById('apellido');
    const telefono = document.getElementById('telefono');
    const email = document.getElementById('email');
    const botonAgregar = document.getElementById('agregar');

    // Función para verificar si todos los campos están llenos
    function verificarCampos() {
        if (nombre.value && apellido.value && telefono.value && email.value) {
            botonAgregar.disabled = false; // Habilitar el botón
        } else {
            botonAgregar.disabled = true; // Deshabilitar el botón
        }
    }

    // Escuchar cambios en los campos para verificar si se llenan
    nombre.addEventListener('input', verificarCampos);
    apellido.addEventListener('input', verificarCampos);
    telefono.addEventListener('input', verificarCampos);
    email.addEventListener('input', verificarCampos);

    // Función para agregar cliente
    botonAgregar.addEventListener('click', function() {
        const nuevoCliente = `
            <tr>
                <td>${nombre.value}</td>
                <td>${apellido.value}</td>
                <td>${telefono.value}</td>
                <td>${email.value}</td>
            </tr>
        `;
        const tablaClientes = document.getElementById('tablaClientes');
        tablaClientes.insertAdjacentHTML('beforeend', nuevoCliente);

        // Limpiar los campos después de agregar el cliente
        nombre.value = '';
        apellido.value = '';
        telefono.value = '';
        email.value = '';
        verificarCampos(); // Verificar si los campos están vacíos para deshabilitar el botón
    });
});
