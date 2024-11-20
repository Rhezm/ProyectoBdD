document.addEventListener("DOMContentLoaded", function () {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Gestión Empleados</h1>
        <div class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
            <input type="text" id="idEmpleado" placeholder="ID Empleado" style="grid-column: 1 / 2;">
            <input type="text" id="idCargo" placeholder="ID Cargo" style="grid-column: 2 / 3;">
            <input type="text" id="nombre" placeholder="Nombre" style="grid-column: 3 / 4;">
            <input type="text" id="apellido1" placeholder="Apellido 1" style="grid-column: 4 / 5;">
            <input type="text" id="apellido2" placeholder="Apellido 2" style="grid-column: 1 / 2;">
            <input type="tel" id="telefono" placeholder="Teléfono" style="grid-column: 2 / 3;">
            <input type="email" id="email" placeholder="Email" style="grid-column: 3 / 4;">
            <button id="agregar" style="grid-column: 4 / 5; padding: 5px 10px; cursor: pointer;">Agregar</button>
        </div>
        <div class="table-container">
            <table style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">ID Empleado</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">ID Cargo</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Nombre</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido 1</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido 2</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Teléfono</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Email</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablagestion">
                    <tr>
                        <td style="padding: 10px; border: 1px solid #ddd;">1</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">101</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">Juan</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">Pérez</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">García</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">123456789</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">juan.perez@example.com</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">
                            <button onclick="editarFila(this)" style="background: none; border: none; cursor: pointer;">
                                ✏️
                            </button>
                            <button onclick="eliminarFila(this)" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                                🗑️
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    `;

    // Función para editar una fila
    window.editarFila = function (boton) {
        const fila = boton.closest('tr');
        const celdas = fila.querySelectorAll('td:not(:last-child)');
        celdas.forEach((celda) => {
            const valor = celda.textContent;
            celda.innerHTML = `<input type="text" value="${valor}" style="width: 100%; box-sizing: border-box;">`;
        });
        boton.textContent = "💾"; // Cambia el ícono del lápiz a un ícono de guardar
        boton.onclick = function () {
            celdas.forEach((celda) => {
                const input = celda.querySelector('input');
                if (input) celda.textContent = input.value; // Actualiza el contenido con el valor del input
            });
            boton.textContent = "✏️"; // Cambia el ícono de guardar a un ícono de lápiz
            boton.onclick = () => editarFila(boton); // Reasigna la función para editar
        };
    };

    // Función para eliminar una fila
    window.eliminarFila = function (boton) {
        const fila = boton.closest('tr');
        fila.remove();
    };

    // Función para agregar una nueva fila
    document.getElementById('agregar').addEventListener('click', function () {
        const idEmpleado = document.getElementById('idEmpleado').value.trim();
        const idCargo = document.getElementById('idCargo').value.trim();
        const nombre = document.getElementById('nombre').value.trim();
        const apellido1 = document.getElementById('apellido1').value.trim();
        const apellido2 = document.getElementById('apellido2').value.trim();
        const telefono = document.getElementById('telefono').value.trim();
        const email = document.getElementById('email').value.trim();

        if (idEmpleado && idCargo && nombre && apellido1 && apellido2 && telefono && email) {
            const nuevaFila = `
                <tr>
                    <td style="padding: 10px; border: 1px solid #ddd;">${idEmpleado}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${idCargo}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${nombre}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${apellido1}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${apellido2}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${telefono}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${email}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">
                        <button onclick="editarFila(this)" style="background: none; border: none; cursor: pointer;">
                            ✏️
                        </button>
                        <button onclick="eliminarFila(this)" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                            🗑️
                        </button>
                    </td>
                </tr>
            `;
            document.getElementById('tablagestion').insertAdjacentHTML('beforeend', nuevaFila);

            // Limpiar campos después de agregar
            document.getElementById('idEmpleado').value = '';
            document.getElementById('idCargo').value = '';
            document.getElementById('nombre').value = '';
            document.getElementById('apellido1').value = '';
            document.getElementById('apellido2').value = '';
            document.getElementById('telefono').value = '';
            document.getElementById('email').value = '';
        } else {
            alert('Por favor, completa todos los campos antes de agregar.');
        }
    });
});
