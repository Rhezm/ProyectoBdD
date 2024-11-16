document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Proveedores</h1>
        <p>Aquí puedes administrar tus proveedores.</p>
        <div class="form-container">
            <div class="form-column">
                <div class="form-row">
                    <label for="proveedor">Proveedor:</label>
                    <input type="text" id="proveedor" name="proveedor">
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
                            <th>Proveedor</th>
                            <th>Apellido</th>
                            <th>Teléfono</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody id="tablaProveedores">
                        <tr>
                            <td>Reginella</td>
                            <td>123456789</td>
                            <td>Reginella@example.com</td>
                        </tr>
                        <tr>
                            <td>Exlin</td>
                            <td>987654321</td>
                            <td>Exlin@example.com</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    `;

    const proveedor = document.getElementById('proveedor');
    const telefono = document.getElementById('telefono');
    const email = document.getElementById('email');
    const botonAgregar = document.getElementById('agregar');

    // Función para verificar si todos los campos están llenos
    function verificarCampos() {
        if (proveedor.value && telefono.value && email.value) {
            botonAgregar.disabled = false; // Habilitar el botón
        } else {
            botonAgregar.disabled = true; // Deshabilitar el botón
        }
    }

    // Escuchar cambios en los campos para verificar si se llenan
    proveedor.addEventListener('input', verificarCampos);
    telefono.addEventListener('input', verificarCampos);
    email.addEventListener('input', verificarCampos);

    // Función para agregar cliente
    botonAgregar.addEventListener('click', function() {
        const nuevoProveedor = `
            <tr>
                <td>${proveedor.value}</td>
                <td>${telefono.value}</td>
                <td>${email.value}</td>
            </tr>
        `;
        const tablaProveedores = document.getElementById('tablaProveedores');
        tablaProveedores.insertAdjacentHTML('beforeend', nuevoProveedor);

        // Limpiar los campos después de agregar el cliente
        proveedor.value = '';
        telefono.value = '';
        email.value = '';
        verificarCampos(); // Verificar si los campos están vacíos para deshabilitar el botón
    });
});
